#include "cxxapi.h"

#include <rime/key_table.h>

int get_keycode_by_name(const char* name) { return RimeGetKeycodeByName(name); }
