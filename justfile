set dotenv-load

rust-input := "rust/src/api.rs"
rust-output := "rust/src/g.rs"
dart-output := "lib/input_api.g.dart"
c-output := "android/app/src/main/jni/include/bridge.h"

pigeon-input := "pigeons/api.dart"
pigeon-dart-output := "lib/platform_api.g.dart"
pigeon-java-output := "android/app/src/main/java/im/nue/flime/Pigeon.java"
pigeon-java-package := "im.nue.flime"

default: gen-br

add-deps:
    cargo install flutter_rust_bridge_codegen cbindgen
    dart pub global activate ffigen

gen-frb:
    [[ -f {{rust-output}} ]] || touch {{rust-output}}
    CPATH="$(clang -v 2>&1 | grep "Selected GCC installation" | rev | cut -d' ' -f1 | rev)/include" \
    flutter_rust_bridge_codegen \
        --rust-input  {{rust-input}} \
        --rust-output {{rust-output}} \
        --dart-output {{dart-output}} \
        --c-output {{c-output}}
    flutter pub run build_runner build

gen-br:
    flutter pub run build_runner build

gen-p:
    flutter pub run pigeon \
        --input {{pigeon-input}} \
        --dart_out {{pigeon-dart-output}} \
        --java_out {{pigeon-java-output}} \
        --java_package {{pigeon-java-package}}
