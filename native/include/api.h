// int get_keycode(const char* name);
// int get_modifier(const char* name);

// TODO: pass all useful properties
typedef struct SimpleStatus {
    char* schema_id;
    char* schema_name;
    int is_composing;
    int is_ascii_mode;
} SimpleStatus;

typedef struct SimpleContext {
    char* preview;
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

SimpleStatus* get_status();
void free_status(SimpleStatus* status);
SimpleContext* get_context();
void free_context(SimpleContext* context);
