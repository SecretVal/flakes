#define STC_IMPLEMENTATION
#define STC_STRIP_PREFIX
#include <stc.h> 
#include <stdbool.h> 

#define project_name "c"
#define project_exe "./c"

int main(int argc, char **argv) {
  rebuild_file(argv, argc);

  (void*)shift(argv, argc);
  Cmd cmd = {0};
  cmd_push(&cmd, STC_COMPILER);
  cmd_push(&cmd, "-o", project_name);
  cmd_push(&cmd, "-Wall", "-Wextra", "-ggdb");
  cmd_push(&cmd, "main.c");
  int res = cmd_exec(&cmd);
  if (res != 0) return res;
  if (argc > 0) {
    bool valid_cmd = false;
    char *sub_cmd = shift(argv, argc);
    if (strcmp(sub_cmd, "run") == 0) {
      Cmd cmd = {0};
      cmd_push(&cmd, project_exe);
      int res = cmd_exec(&cmd);
      if (res != 0) return res;
      valid_cmd = true;
    }
    if (!valid_cmd) {
     log(STC_ERROR, " %s is not a known command", sub_cmd);
    }
  }
  return 0;
}
