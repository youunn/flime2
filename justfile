set dotenv-load

rust-input := "rust/src/api.rs"
rust-output := "rust/src/g.rs"
dart-output := "lib/api/input_api.g.dart"
c-output := "native/include/bridge.h"

pigeon-input := "pigeons/api.dart"
pigeon-dart-output := "lib/api/platform_api.g.dart"
pigeon-java-output-dir := "android/app/src/main/java/im/nue/flime"
pigeon-java-output-file := "Pigeon.java"
pigeon-java-package := "im.nue.flime"

ffi-output-dir := "lib/api"

boost-dir := "~/Projects/thirdParty/Boost-for-Android"
ndk-root := "~/.local/share/android/sdk/ndk/23.0.7599858"
boost-version := "1.78.0"

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
    [[ -d {{pigeon-java-output-dir}} ]] || mkdir -p {{pigeon-java-output-dir}}
    flutter pub run pigeon \
        --input {{pigeon-input}} \
        --dart_out {{pigeon-dart-output}} \
        --java_out {{pigeon-java-output-dir}}/{{pigeon-java-output-file}} \
        --java_package {{pigeon-java-package}}

gen-ffi:
    [[ -d {{ffi-output-dir}} ]] || mkdir -p {{ffi-output-dir}}
    flutter pub run ffigen

# TODO: clone and build in temp directory
build-boost:
    cd {{boost-dir}}; \
    ./build-android.sh {{ndk-root}} --boost={{boost-version}}
    just cp-boost

cp-boost:
    libs=( filesystem regex system ); \
    abis=( arm64-v8a armeabi-v7a x86 x86_64 ); \
    for a in "${abis[@]}"; do \
        [[ -d android/app/src/main/jniLibs/$a ]] || mkdir -p android/app/src/main/jniLibs/$a; \
        for l in "${libs[@]}"; do \
            cp {{boost-dir}}/build/out/$a/lib/libboost_$l* android/app/src/main/jniLibs/$a/libboost_$l.a; \
        done; \
    done

release:
    flutter build apk --split-per-abi --release --verbose
