// int get_keycode(const char* name);
// int get_modifier(const char* name);

void free_string(char* string);
int init();
int start(const char* dir);
int process_key(int code, int mask);
char* get_commit();
int finalize();
