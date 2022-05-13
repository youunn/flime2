int get_keycode(const char* name);
int get_modifier(const char* name);

int init();
int start(const char* dir);
int process_key_name(const char* name);
int process_key(int code, int mask);
char* get_commit();
int finalize();
