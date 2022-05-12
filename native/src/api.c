#include <rime_api.h>

int hello() {
    static RimeApi s_api = {0};
    return 5; 
}
