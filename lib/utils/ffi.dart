import 'dart:ffi';
import 'package:ffi/ffi.dart';
// import 'package:flutter/material.dart';

extension NativeCast on String {
  Pointer<Char> cast() {
    return toNativeUtf8().cast();
  }
}

extension StringCast on Pointer<Int8> {
  String? toDartString() {
    final p = cast<Utf8>();
    return p == nullptr ? null : p.toDartString();
  }
}

// final debugPrintNativeFunctionPointer =
//     Pointer.fromFunction<Void Function(Pointer<Int8>)>(debugPrintNative);
//
// void debugPrintNative(Pointer<Int8> message) {
//   debugPrint(message.toDartString() ?? '');
// }
