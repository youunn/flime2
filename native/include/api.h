// int get_keycode(const char* name);
// int get_modifier(const char* name);

// TODO: pass all useful properties
typedef struct SimpleContext {
    char* preedit;
    char** candidates;
    char** comments;
    int count;
} SimpleContext;

int init();
int start(const char* dir);
int process_key(int code, int mask);
char* get_commit();
int finalize();

void free_string(char* string);
void free_context(SimpleContext* context);

int is_composing();
SimpleContext* get_context();
