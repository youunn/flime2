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

gen-pigeon:
    [[ -d {{pigeon-java-output-dir}} ]] || mkdir -p {{pigeon-java-output-dir}}
    flutter pub run pigeon \
        --input {{pigeon-input}} \
        --dart_out {{pigeon-dart-output}} \
        --java_out {{pigeon-java-output-dir}}/{{pigeon-java-output-file}} \
        --java_package {{pigeon-java-package}}

gen-ffi:
    [[ -d {{ffi-output-dir}} ]] || mkdir -p {{ffi-output-dir}}
    flutter pub run ffigen

gen-all:
    just gen-ffi
    just gen-pigeon
    just gen-br

clangd:
    cd native; fd -p "x86_64/compile_commands.json$" -I -H .. --exec ln -sf {} ./compile_commands.json

build-boost:
    #!/usr/bin/env bash
    if [[ ! -z "${BOOST_FOR_ANDROID_DIR}" && ! -z "${NDK_ROOT_DIR}" ]]; then
        p=$(pwd)
        [[ ! -d "${BOOST_FOR_ANDROID_DIR}" ]] && mkdir -p ${BOOST_FOR_ANDROID_DIR}
        [[ -z $(ls -A ${BOOST_FOR_ANDROID_DIR}) ]] && cd ${BOOST_FOR_ANDROID_DIR} && git clone https://github.com/moritz-wundke/Boost-for-Android .
        cd ${BOOST_FOR_ANDROID_DIR}
        ./build-android.sh ${NDK_ROOT_DIR} --boost=${BOOST_PREBUILD_VERSION_NUMBER}
        cd $p
        just cp-boost
    else
        echo "Please add BOOST_FOR_ANDROID_DIR and NDK_ROOT_DIR environment variable in .env file."
        false
    fi

cp-boost:
    #!/usr/bin/env bash
    if [[ ! -z "${BOOST_FOR_ANDROID_DIR}" ]]; then
        libs=( filesystem regex system )
        abis=( arm64-v8a armeabi-v7a x86 x86_64 )
        for a in "${abis[@]}"; do
            [[ -d android/app/src/main/jniLibs/$a ]] || mkdir -p android/app/src/main/jniLibs/$a
            for l in "${libs[@]}"; do
                source=${BOOST_FOR_ANDROID_DIR}"/build/out/"$a"/lib/libboost_"$l
                target="android/app/src/main/jniLibs/$a/libboost_"$l".a"
                # cannot run directly. don't know why
                bash -c "cp $source* $target"
            done
        done
    else
        echo "Please add BOOST_FOR_ANDROID_DIR environment variable in .env file."
        false
    fi

run:
    flutter run

install-apk:
    adb -d install build/app/outputs/flutter-apk/app-arm64-v8a-release.apk

release:
    flutter build apk --split-per-abi --release --verbose
