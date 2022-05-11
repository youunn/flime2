set dotenv-load

rust-input := "rust/src/api.rs"
rust-output := "rust/src/g.rs"
dart-output := "lib/api/input_api.g.dart"
c-output := "android/app/src/main/jni/include/bridge.h"

pigeon-input := "pigeons/api.dart"
pigeon-dart-output := "lib/api/platform_api.g.dart"
pigeon-java-output-dir := "android/app/src/main/java/im/nue/flime"
pigeon-java-output-file := "Pigeon.java"
pigeon-java-package := "im.nue.flime"

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

build-boost:
    # TODO: clone in temp directory
    cd {{boost-dir}} && \
    ./build-android.sh {{ndk-root}} --boost={{boost-version}}

    cp {{boost-dir}}/build/out/arm64-v8a/lib/libboost_filesystem* android/app/src/main/jniLibs/arm64-v8a/libboost_filesystem.a
    cp {{boost-dir}}/build/out/arm64-v8a/lib/libboost_regex* android/app/src/main/jniLibs/arm64-v8a/libboost_regex.a
    cp {{boost-dir}}/build/out/arm64-v8a/lib/libboost_system* android/app/src/main/jniLibs/arm64-v8a/libboost_system.a

    cp {{boost-dir}}/build/out/armeabi-v7a/lib/libboost_filesystem* android/app/src/main/jniLibs/armeabi-v7a/libboost_filesystem.a
    cp {{boost-dir}}/build/out/armeabi-v7a/lib/libboost_regex* android/app/src/main/jniLibs/armeabi-v7a/libboost_regex.a
    cp {{boost-dir}}/build/out/armeabi-v7a/lib/libboost_system* android/app/src/main/jniLibs/armeabi-v7a/libboost_system.a

    cp {{boost-dir}}/build/out/x86/lib/libboost_filesystem* android/app/src/main/jniLibs/x86/libboost_filesystem.a
    cp {{boost-dir}}/build/out/x86/lib/libboost_regex* android/app/src/main/jniLibs/x86/libboost_regex.a
    cp {{boost-dir}}/build/out/x86/lib/libboost_system* android/app/src/main/jniLibs/x86/libboost_system.a

    cp {{boost-dir}}/build/out/x86_64/lib/libboost_filesystem* android/app/src/main/jniLibs/x86_64/libboost_filesystem.a
    cp {{boost-dir}}/build/out/x86_64/lib/libboost_regex* android/app/src/main/jniLibs/x86_64/libboost_regex.a
    cp {{boost-dir}}/build/out/x86_64/lib/libboost_system* android/app/src/main/jniLibs/x86_64/libboost_system.a

cp-boost:
    cp {{boost-dir}}/build/out/arm64-v8a/lib/libboost_filesystem* android/app/src/main/jniLibs/arm64-v8a/libboost_filesystem.a
    cp {{boost-dir}}/build/out/arm64-v8a/lib/libboost_regex* android/app/src/main/jniLibs/arm64-v8a/libboost_regex.a
    cp {{boost-dir}}/build/out/arm64-v8a/lib/libboost_system* android/app/src/main/jniLibs/arm64-v8a/libboost_system.a

    cp {{boost-dir}}/build/out/armeabi-v7a/lib/libboost_filesystem* android/app/src/main/jniLibs/armeabi-v7a/libboost_filesystem.a
    cp {{boost-dir}}/build/out/armeabi-v7a/lib/libboost_regex* android/app/src/main/jniLibs/armeabi-v7a/libboost_regex.a
    cp {{boost-dir}}/build/out/armeabi-v7a/lib/libboost_system* android/app/src/main/jniLibs/armeabi-v7a/libboost_system.a

    cp {{boost-dir}}/build/out/x86/lib/libboost_filesystem* android/app/src/main/jniLibs/x86/libboost_filesystem.a
    cp {{boost-dir}}/build/out/x86/lib/libboost_regex* android/app/src/main/jniLibs/x86/libboost_regex.a
    cp {{boost-dir}}/build/out/x86/lib/libboost_system* android/app/src/main/jniLibs/x86/libboost_system.a

    cp {{boost-dir}}/build/out/x86_64/lib/libboost_filesystem* android/app/src/main/jniLibs/x86_64/libboost_filesystem.a
    cp {{boost-dir}}/build/out/x86_64/lib/libboost_regex* android/app/src/main/jniLibs/x86_64/libboost_regex.a
    cp {{boost-dir}}/build/out/x86_64/lib/libboost_system* android/app/src/main/jniLibs/x86_64/libboost_system.a
