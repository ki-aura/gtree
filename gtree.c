#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <dirent.h>     // For DIR, struct dirent, opendir, readdir, closedir (POSIX)
#include <string.h>     // For strncpy, strcmp, strrchr, memset, memcpy, snprintf
#include <sys/stat.h>   // For struct stat, lstat, stat, S_ISDIR, S_ISLNK (POSIX)
#include <libgen.h>     // For basename if needed (not used here)
#include <unistd.h>     // For readlink (POSIX)
#include <inttypes.h>   // For intmax_t
#include "gtree.h"
#include "visit_hash.h"
#include "option_parsing.h"
#include "memsafe.h"
#include "print.h"

// ----------------- Helper function -----------------
// Update the maximum depth reached during traversal
static inline void track_max_depth(ActivityReport *report, int current_depth) {
    if (report->TOTAL_depth < current_depth) {
        report->TOTAL_depth = current_depth;
    }
}

// ----------------- Create a new directory frame -----------------
// Allocates and initializes a new DirFrame, simulating a push onto an explicit stack
DirFrame *Create_Frame(const char *dirPath, int dirDepth, const DirFrame *parent, bool is_last) {
    DirFrame *framePtr = xmalloc(sizeof(DirFrame));

    // Copy directory path into frame
    snprintf(framePtr->path, PATH_MAX, "%s", dirPath);
    framePtr->depth = dirDepth;
    framePtr->is_last = is_last;

    // Copy ancestor_siblings from parent for correct tree formatting
    if (parent)
        memcpy(framePtr->ancestor_siblings, parent->ancestor_siblings, sizeof(parent->ancestor_siblings));
    else // Root node initialization
        memset(framePtr->ancestor_siblings, 0, sizeof(framePtr->ancestor_siblings));

    // Attempt to open the directory for reading entries
    framePtr->dir = opendir(dirPath);
    if (!framePtr->dir) { 
        perror("opendir"); 
        free(framePtr); 
        return NULL; 
    }

    // Initialize Phase 1 (scanning) variables
    framePtr->subdirs = NULL;
    framePtr->current = NULL;
    framePtr->subfiles = NULL;
    framePtr->dir_file_count = 0;
    framePtr->dir_file_size = 0;

    return framePtr;
}

// ----------------- Add a subdirectory node -----------------
// Appends a new SubDirNode to the linked list, updating head and tail pointers
void add_subdir(bool is_symdir, char *sub_path, SubDirNode **head_ptr, SubDirNode **tail_ptr) {
    // Allocate a new node and populate its path
    SubDirNode *n = xmalloc(sizeof(SubDirNode));
    snprintf(n->path, PATH_MAX, "%s", sub_path);
    n->is_symlink = is_symdir;

    // If it's a symlink, read its target path
    if (is_symdir) {
        ssize_t len = readlink(sub_path, n->sym_path, PATH_MAX - 1);
        if (len != -1) n->sym_path[len] = '\0'; // readlink does not null-terminate
        else n->sym_path[0] = '\0'; // readlink failed
    } else {
        n->sym_path[0] = '\0';
    }

    n->next = NULL;

    // Append node to linked list
    if (!*head_ptr) {
        *head_ptr = n;
        *tail_ptr = n; // first node: tail points here too
    } else {
        (*tail_ptr)->next = n;
        *tail_ptr = n;
    }
}

// ----------------- Free linked list of subdirectories -----------------
void free_subdirs(SubDirNode *head) {
    SubDirNode *cur = head, *next;
    while (cur) { 
        next = cur->next;
        free(cur);
        cur = next;
    }
}

// ------------------------- Main function -------------------------
int main(int argc, char *argv[]) {
    Options opts;
    int first_file_index;

    // Parse command line options
    parse_options(argc, argv, &opts, MAX_DEPTH, &first_file_index);
	fprintf(stderr, "ffi %d\n",first_file_index);
	// Handle -v & -h options 
	if (opts.show_version){show_version(); return EXIT_SUCCESS;}
	if (opts.show_help){show_help(); return EXIT_SUCCESS;}

    // Handle missing starting directory
    if (first_file_index == - 1) {
		fprintf(stderr, "No starting directory specified\n"); return EXIT_FAILURE;
    }

	// check directory is valid
	DIR *valid_start = opendir(argv[first_file_index]);
	if(valid_start == NULL){
		fprintf(stderr, "Invalid starting directory specified\n"); return EXIT_FAILURE;
	}
	closedir(valid_start);
	
	// show version (helps with debugs!)
	show_version();
    // Initialize all counters to 0
    ActivityReport final_report = {0};

    // Explicit stack for DirFrame pointers (simulate recursion)
    DirFrame *stack[MAX_DEPTH + 2];
    int sp = 0; // stack pointer: next free slot

    // Hash table to track visited directories to prevent infinite recursion via symlinks
    create_visited_node_hash();

    // Create root frame & push onto stack
    DirFrame *root = Create_Frame(argv[first_file_index], 0, NULL, false);
    stack[sp++] = root;

    // Record root directory's unique device/inode ID in case symlinks loop back to it
    struct stat st_root;
	if (stat(root->path, &st_root) == 0) {
		add_visited(st_root.st_dev, st_root.st_ino);
	}

    // ------------------ Main traversal loop ------------------
    // Loop continues while there are frames (directories) on the stack
    while (sp > 0) {
        DirFrame *frame = stack[sp - 1]; // peek at top of stack

        // ------------------ Phase 1: Scan current directory ------------------
        if (!frame->subdirs) {
            struct dirent *entry;
            struct stat st, lst;
            char buf[PATH_MAX];
            SubDirNode *head = NULL, *tail = NULL;

            frame->dir_file_count = 0;
            frame->dir_file_size = 0;

            // Read each entry in the directory
            while ((entry = readdir(frame->dir)) != NULL) {
                // skip any directory starting with a . unless we're showing hidden directores
                if(!opts.show_hidden && entry->d_name[0] == '.')
                	continue;

            	// always skip . and .. directories 
                if (!strcmp(entry->d_name, ".") || !strcmp(entry->d_name, ".."))
                    continue;
                
                // Build full path
                if (snprintf(buf, PATH_MAX, "%s/%s", frame->path, entry->d_name) >= PATH_MAX)
                    continue;

                if (lstat(buf, &lst) == -1) continue;
                if (stat(buf, &st) == -1) st.st_mode = 0;

                // Handle files (update stats, print if needed)
                HandleFiles(buf, frame, &st, &lst, &final_report, opts.show_files);

                bool is_symdir = S_ISLNK(lst.st_mode) && S_ISDIR(st.st_mode);

                // Add subdirectory to list (regardless of if visited - this is checked in phase 2)
                if (S_ISDIR(st.st_mode) || is_symdir)
                    add_subdir(is_symdir, buf, &head, &tail);
            }

            // Save list to frame
            frame->subdirs = head;
            frame->current = head;

            // Print current directory line
            print_entry_line(frame, frame->is_last,
                            	false, NULL, false, NULL, true, &opts);
			
            // Print files if requested
            if (opts.show_files) {
                SubDirFile *cur = frame->subfiles, *prev;
                while (cur != NULL) {
                    prev = cur->prev;
                    print_entry_line(frame, frame->is_last,
                            	cur->is_symlink, NULL, false, cur->name, false, &opts);
                    cur = prev;
                }
                free_subfiles(frame->subfiles);
            }
        }

        // ----------------- Phase 2: Process the next subdirectory -----------------
        if (frame->current) {
            SubDirNode *cur = frame->current;
            frame->current = cur->next;        // advance iterator
            bool is_last_child = (frame->current == NULL);

            // Update ancestor_siblings array for next depth
            if (frame->depth + 1 < opts.max_depth)
                frame->ancestor_siblings[frame->depth + 1] = !is_last_child;

            struct stat st_target;
            bool stat_ok = (stat(cur->path, &st_target) == 0); // follow symlink

			// ---------------- Symlinked directories ----------------
			if (cur->is_symlink) {
				bool already_visited = stat_ok && visited_before(st_target.st_dev, st_target.st_ino);
			
				// Prepare temporary frame for printing
				DirFrame temp = {0};
				snprintf(temp.path, PATH_MAX, "%s", cur->path);
				temp.depth = frame->depth + 1;
				memcpy(temp.ancestor_siblings, frame->ancestor_siblings, sizeof(temp.ancestor_siblings));
			
				print_entry_line(&temp, is_last_child, true, cur->sym_path,
								 already_visited, NULL, true, &opts);
			
				// increment total linked directories even if not traversed
				if (stat_ok) final_report.TOTAL_linked_directories++;
			
				// Only traverse symlink if not visited, option allows, stat ok, AND depth limit not hit
				bool depth_limit_hit = (frame->depth + 1 >= opts.max_depth);
				if (!already_visited && opts.follow_links && stat_ok && !depth_limit_hit) {
					DirFrame *child = Create_Frame(cur->path, frame->depth + 1, frame, is_last_child);
					if (child) {
						if (add_visited(st_target.st_dev, st_target.st_ino)) {
							final_report.TOTAL_directories++;
						}
						stack[sp++] = child;
						track_max_depth(&final_report, child->depth);
					}
				} else {
					// If we couldn't traverse because of depth limit but it's not a visit loop,
					// still update the reported max depth if you want consistent "max reached" accounting:
					if (!already_visited && depth_limit_hit) {
						track_max_depth(&final_report, frame->depth + 1);
					}
				}
			
				continue; // move to next subdirectory
			}

            // ---------------- Normal directories ----------------
			if (stat_ok && S_ISDIR(st_target.st_mode)) {
				bool already_visited = visited_before(st_target.st_dev, st_target.st_ino);
				bool depth_limit_hit = (frame->depth + 1 >= opts.max_depth);
			
				if (!already_visited && !depth_limit_hit) {
					// normal traversal
					DirFrame *child = Create_Frame(cur->path, frame->depth + 1, frame, is_last_child);
					if (child) {
						if (add_visited(st_target.st_dev, st_target.st_ino)) {
							final_report.TOTAL_directories++;
						}
						stack[sp++] = child;
						track_max_depth(&final_report, child->depth);
					}
				} else {
					// only mark recursive if actually already visited
					DirFrame temp = {0};
					snprintf(temp.path, PATH_MAX, "%s", cur->path);
					temp.depth = frame->depth + 1;
					memcpy(temp.ancestor_siblings, frame->ancestor_siblings, sizeof(temp.ancestor_siblings));
			
					print_entry_line(&temp, is_last_child, false, cur->path,
									 already_visited, NULL, true, &opts);
					if (add_visited(st_target.st_dev, st_target.st_ino)) {
						final_report.TOTAL_directories++;
					}
					track_max_depth(&final_report, frame->depth + 1);
				}
			}

        } else {
            // Directory fully processed: pop and clean up
            closedir(frame->dir);
            free_subdirs(frame->subdirs);
            free(frame);
            sp--;
        }
    }

    // ----------------- Clean up -----------------
    free_visited_node_hash(); // free memory for loop-detection hash

    // ----------------- Print summary -----------------
    char hsize[32];
    human_size(final_report.TOTAL_file_size, hsize, sizeof(hsize));
    printf("\nTotal Number of Directories traversed %zu (containing %zu links)\n"
           "Maximum depth descended: %d\n", 
           final_report.TOTAL_directories, final_report.TOTAL_linked_directories, 
           final_report.TOTAL_depth);

    if (opts.show_file_stats || opts.show_files)
        printf("Total Number of Files: %zu (of which %zu are linked)\n"
               "Total File Size: %s\n",
               final_report.TOTAL_file_count, final_report.TOTAL_linked_files, hsize);

    return 0;
}
