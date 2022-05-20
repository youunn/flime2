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
#    define LOG_VERBOSE(...) __android_log_print(ANDROID_LOG_VERBOSE, "rime_bridge", __VA_ARGS__);
#    define LOG_DEBUG(...) __android_log_print(ANDROID_LOG_DEBUG, "rime_bridge", __VA_ARGS__);
#    define LOG_INFO(...) __android_log_print(ANDROID_LOG_INFO, "rime_bridge", __VA_ARGS__);
#    define LOG_WARN(...) __android_log_print(ANDROID_LOG_WARN, "rime_bridge", __VA_ARGS__);
#    define LOG_ERROR(...) __android_log_print(ANDROID_LOG_ERROR, "rime_bridge", __VA_ARGS__);
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
    // LOG_INFO("processing: code, %d, mask, %d", code, mask);
    int result = rime->process_key(session_id, code, mask);
    return result;
}

char* get_commit() {
    RIME_STRUCT(RimeCommit, commit);
    if (!rime->get_commit(session_id, &commit)) return NULL;
    char* result = strdup(commit.text);
    RimeFreeCommit(&commit);
    return result;
}

int finalize() {
    if (!rime) return 1;
    rime->destroy_session(session_id);
    session_id = 0;
    rime->finalize();
    return 0;
}

void free_string(char* string) { free(string); }

void free_context(SimpleContext* context) {
    for (int i = 0; i < context->count; i++) {
        free(context->candidates[i]);
        free(context->comments[i]);
    }
    free(context->candidates);
    free(context->comments);
    free(context->preedit);
    free(context);
}

int is_composing() {
    RIME_STRUCT(RimeStatus, status);
    if (!rime->get_status(session_id, &status)) return false;
    int result = status.is_composing;
    rime->free_status(&status);
    return result;
}

SimpleContext* get_context() {
    RIME_STRUCT(RimeContext, context);
    if (!rime->get_context(session_id, &context)) return NULL;
    int count = context.menu.num_candidates;
    if (count <= 0) {
        rime->free_context(&context);
        return NULL;
    }

    char* preedit;
    if (!context.composition.preedit)
        preedit = NULL;
    else
        preedit = strdup(context.composition.preedit);

    char** candidates = malloc(count * sizeof(char*));
    char** comments = malloc(count * sizeof(char*));

    for (int i = 0; i < count; i++) {
        RimeCandidate* rime_candidates = &context.menu.candidates[i];
        if (!rime_candidates) {
            candidates[i] = NULL;
            comments[i] = NULL;
        } else {
            if (!rime_candidates->text)
                candidates[i] = NULL;
            else
                candidates[i] = strdup(rime_candidates->text);

            if (!rime_candidates->comment)
                comments[i] = NULL;
            else
                comments[i] = strdup(rime_candidates->comment);
        }
    }

    SimpleContext* result = malloc(sizeof(SimpleContext));
    result->preedit = preedit;
    result->candidates = candidates;
    result->comments = comments;
    result->count = count;

    rime->free_context(&context);

    return result;
}
