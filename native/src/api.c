#include "api.h"

#ifdef __ANDROID_API__
#    include <android/log.h>
#endif

#include <rime_api.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

// #include "cxxapi.h"

#ifdef __ANDROID_API__
#    define LOG_VERBOSE(...) __android_log_print(ANDROID_LOG_VERBOSE, "native", __VA_ARGS__);
#    define LOG_DEBUG(...) __android_log_print(ANDROID_LOG_DEBUG, "native", __VA_ARGS__);
#    define LOG_INFO(...) __android_log_print(ANDROID_LOG_INFO, "native", __VA_ARGS__);
#    define LOG_WARN(...) __android_log_print(ANDROID_LOG_WARN, "native", __VA_ARGS__);
#    define LOG_ERROR(...) __android_log_print(ANDROID_LOG_ERROR, "native", __VA_ARGS__);
#else
#    define LOG_VERBOSE
#    define LOG_DEBUG
#    define LOG_INFO
#    define LOG_WARN
#    define LOG_ERROR
#endif

static RimeSessionId session_id;
static RimeApi* rime;

// int get_modifier(const char* name) { return get_modifier_by_name(name); }
//
// int get_keycode(const char* name) { return get_keycode_by_name(name); }

void free_string(char* string) { free(string); }

int init() {
    rime = rime_get_api();

    return rime != NULL;
}

static void on_message(void* context, RimeSessionId id, const char* type, const char* value) {
    char* message;
    asprintf(&message, "message: [%s] %s", type, value);
    LOG_INFO("%s", message);
}

int start(const char* dir) {
    RIME_STRUCT(RimeTraits, traits);
    traits.shared_data_dir = dir;
    traits.user_data_dir = dir;
    traits.app_name = "flime";

    rime->setup(&traits);
    rime->initialize(&traits);
    rime->set_notification_handler(&on_message, NULL);
    rime->start_maintenance(true);
    rime->join_maintenance_thread();
    session_id = rime->create_session();

    return 0;
}

int process_key(int code, int mask) {
    if (rime == NULL) return 0;
    return rime->process_key(session_id, code, mask);
}

char* get_commit() {
    RIME_STRUCT(RimeCommit, commit);
    if (!rime->get_commit(session_id, &commit)) return NULL;
    char* result = strdup(commit.text);
    LOG_INFO("commit result: %s", result);
    RimeFreeCommit(&commit);
    return result;
}

int finalize() {
    rime->destroy_session(session_id);
    session_id = 0;
    rime->finalize();
    return 0;
}
