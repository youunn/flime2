import 'dart:ffi';
import 'package:ffi/ffi.dart';
// import 'package:flutter/material.dart';

extension NativeCast on String {
  Pointer<Char> cast() {
    return toNativeUtf8().cast();
  }
}

extension StringCast on Pointer<Char> {
  String? toDartString() {
    final p = cast<Utf8>();
    return p == nullptr ? null : p.toDartString();
  }
}

extension StringPointerCast on Pointer<Pointer<Char>> {
  Iterable<String?> toDartString(int count) sync* {
    if (this == nullptr) return;
    for (var i = 0; i < count; i++) {
      final p = this[i];
      if (p == nullptr) yield null;
      final s = p.toDartString();
      yield s;
      // free in native library
    }
  }
}

// final debugPrintNativeFunctionPointer =
//     Pointer.fromFunction<Void Function(Pointer<Int8>)>(debugPrintNative);
//
// void debugPrintNative(Pointer<Int8> message) {
//   debugPrint(message.toDartString() ?? '');
// }
