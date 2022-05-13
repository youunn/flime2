#include "api.h"

#include <rime_api.h>
#include <stdbool.h>
#include <stdlib.h>

#include "cxxapi.h"

static RimeSessionId session_id;
static RimeApi* rime;

int get_modifier(const char* name) { return get_modifier_by_name(name); }

int get_keycode(const char* name) { return get_keycode_by_name(name); }

int init() {
    rime = rime_get_api();

    return !!rime;
}

int start(const char* dir) {
    RIME_STRUCT(RimeTraits, traits);
    traits.shared_data_dir = dir;
    traits.user_data_dir = dir;
    traits.app_name = "flime";
    rime->setup(&traits);
    rime->initialize(&traits);
    // rime->set_notification_handler();
    rime->start_maintenance(true);
    rime->join_maintenance_thread();
    session_id = rime->create_session();

    return 0;
}

int process_key_name(const char* name) {
    int code = get_keycode_by_name(name);
    return rime->process_key(session_id, code, 0);
}

int process_key(int code, int mask) { return rime->process_key(session_id, code, mask); }

char* get_commit() {
    RIME_STRUCT(RimeCommit, commit);
    rime->get_commit(session_id, &commit);
    return commit.text;
}

int finalize() {
    rime->destroy_session(session_id);
    session_id = 0;
    rime->finalize();
    return 0;
}

