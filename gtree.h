#ifndef GTREE_H
#define GTREE_H  

#include <stdbool.h>
#include <dirent.h>     // For DIR, struct dirent, opendir, readdir, closedir (POSIX)


// Fallback maximum path length if PATH_MAX is not defined by the system
#ifndef PATH_MAX
#define PATH_MAX 1024   
#endif

#define GTREE_VERSION "2.3.2"

// -----------------------------------------------------
// ------------------ Definitions ------------------
// -----------------------------------------------------
// Defines the maximum depth and also the size of the explicit stack array
#define MAX_DEPTH 1024   

// Node structure to hold subdirectory info in a linked list.
// Used to store subdirectories discovered in a directory *before* traversing them.
// This decouples the scanning phase from the descending phase.
typedef struct SubDirNode {
    char path[PATH_MAX];       // Full path of the subdirectory (e.g., "/home/user/dir/subdir")
    bool is_symlink;           // True if this directory entry itself is a symbolic link
    char sym_path[PATH_MAX];   // Target path if symlink (e.g., "../../otherdir")
    struct SubDirNode *next;   // Pointer to next subdirectory (linked list for children)
} SubDirNode;

typedef struct SubDirFile {
    char name[PATH_MAX];       // File Name 
    bool is_symlink;           // True if this file is a symbolic link
    struct SubDirFile *prev;  // Pointer to previous file (linked list for children)
} SubDirFile;

// Frame structure representing one directory level in the explicit stack.
// This structure replaces the 'stack frame' of a recursive function call.
typedef struct DirFrame {
	// these are the basic frame components to manage the traversal
    char path[PATH_MAX];         // Path of this directory
    DIR *dir;                    // DIR* stream for reading entries with readdir
    SubDirNode *subdirs;         // Head of the linked list of subdirectories found (Phase 1 result)
    SubDirNode *current;         // Pointer to the current subdir being processed (iterator for Phase 2)
    int depth;                   // Depth in the directory tree (0 = starting directory)
	// additional file stats for this directory only 
    size_t dir_file_count;       // Number of non-directory files in this specific directory
    off_t dir_file_size;         // Cumulative size of regular files in this specific directory
    SubDirFile *subfiles;		 // Tail of linked list for files 
	// these are purely for print formatting
    bool ancestor_siblings[MAX_DEPTH+2]; // Used to track tree branches for formatted output (│/└/├)
    bool is_last;                // True if this directory is the last among its siblings (for print formatting)
} DirFrame;

// -------------------------------- Final Report -------------------------------
// Holds summary stats accumulated during the entire traversal.
typedef struct ActivityReport {
	size_t TOTAL_file_count;           // Total number of regular files
	size_t TOTAL_linked_files;         // Number of regular files that are symbolic links
	off_t TOTAL_file_size;             // Total size of all regular files
	size_t TOTAL_directories;          // Total directories successfully traversed
	size_t TOTAL_linked_directories;   // Symlinked directories encountered
	int TOTAL_depth;				   // max number of levels we descended
} ActivityReport;


#endif

/*
================================================================================
gtree Traversal Logic (Explicit Stack Version)
================================================================================
This diagram explains how the gtree program simulates recursive directory 
traversal using an explicit stack of DirFrame pointers

Legend:
  [DirFrame]   : Represents a directory currently being traversed.
  stack[sp]    : Explicit stack holding DirFrame pointers.
  subdirs      : Linked list of subdirectories inside current directory.
  current      : Pointer to the next subdirectory to process in subdirs.
  sp           : Stack pointer; points to the next free slot in the stack.
  is_symlink   : Indicates whether a directory entry is a symlink.
  ancestor_siblings[] : Array used for drawing tree structure correctly.

================================================================================
Notes for Understanding:
- The explicit stack simulates the call stack used in a recursive implementation.
- Phase 1 = "Scan": build the list of subdirectories to traverse.
- Phase 2 = "Process": traverse subdirectories using the stack.
- This approach avoids actual recursion, giving better control over stack size.
- Symlink handling and visited hash prevent infinite loops caused by recursive links.
- ancestor_siblings[] ensures proper tree drawing even with deep nested directories.

================================================================================
High-level Algorithm:

1. Initialize
   - Parse command line options.
   - Create a hash table for visited directories to avoid infinite loops via symlinks.
   - Create root DirFrame for starting directory.
   - Push root onto stack.
   - Initialize ActivityReport counters.

2. Main Traversal Loop (while sp > 0)
   a) Peek at top frame on stack:
        DirFrame *frame = stack[sp - 1];

- We are "peeking" at the top of the stack to see which directory we should process 
	next without removing it yet.
- The stack contains DirFrame* pointers, with the next free slot always indicated by sp.
- sp is the index of the next available slot, not the current top element. Therefore, 
	the current top frame is at sp - 1.
- Peeking allows us to examine the current directory (its entries, subdirectories, and 
	files) while still keeping it on the stack. We only pop it after all its subdirectories 
	have been fully processed.
- This is essential for simulating recursion explicitly: in a normal recursive call, the 
	function’s local variables remain on the call stack until the function returns. Here, 
	the stack array and DirFrame pointers play the same role.
        

   b) Phase 1: Scan Current Directory (only if subdirs == NULL)
        - Read entries with readdir().
        - Skip "." and "..".
        - Build full path for each entry.
        - lstat() for symlink info, stat() for actual file type.
        - Handle files (update file count/size, print if requested).
        - For directories or symlinked directories:
            * Check if already visited (loop prevention).
            * If not visited, create SubDirNode and append to subdirs list.
        - Set frame->subdirs = head of SubDirNode list.
        - Set frame->current = head.
        - Print current directory line.
        - Print files if requested.

   c) Phase 2: Process Next Subdirectory
        - If frame->current != NULL:
            * Take current SubDirNode.
            * Advance frame->current to next node.
            * Determine if this is the last child.
            * Update ancestor_siblings[] for correct tree drawing.
            * Perform stat() to get directory info.
            * If symlink:
                - Print entry line with target path.
                - Traverse if not already visited and follow_links enabled:
                    + Create new DirFrame for child directory.
                    + Push onto stack.
                    + Increment TOTAL_directories.
                    + Track max depth.
                - Increment TOTAL_linked_directories.
            * If normal directory and not visited:
                - Create DirFrame.
                - Push onto stack.
                - Increment TOTAL_directories.
                - Track max depth.
        - Else (frame->current == NULL):
            * Directory fully processed.
            * Pop frame from stack.
            * Close directory and free memory (subdirs list + frame).

3. Loop ends when stack is empty.
4. Cleanup:
    - Free visited node hash table.
5. Print summary statistics:
    - Total directories, linked directories, files, total file size, max depth.

================================================================================
Example Stack Visualization (simplified):
================================================================================

Initial:
sp = 0
stack = []

Push root:
sp = 1
stack = [ root ]

Phase 1: scan root
  stack[0].subdirs = [subdir1, subdir2]
  stack[0].current = subdir1

Phase 2: process subdir1
  create child frame for subdir1
  sp = 2
  stack = [root, subdir1]

Pop subdir1 after processing all its children:
  sp = 1
  stack = [root]

Continue with subdir2...
================================================================================
*/


