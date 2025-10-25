#ifndef PRINT_H
#define PRINT_H  
#include <stdbool.h>
#include "option_parsing.h"

void human_size(off_t bytes, char *out, size_t outsz);
void print_entry_line(const DirFrame *frame,
                      bool is_last,
                      bool is_symdir,
                      const char *symPath,
                      bool is_recursive,
                      const char *entry_name,
                      bool is_dir,
                      Options *opts);
void free_subfiles(SubDirFile *tail);
void HandleFiles(char *fname, DirFrame *frame, struct stat *st, struct stat *lst, 
			ActivityReport *report, bool show_files);

#endif
