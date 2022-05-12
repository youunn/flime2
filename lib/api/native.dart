import 'dart:ffi';
import 'dart:io' as io;
import 'package:ffi/ffi.dart';

import 'rime_bridge.g.dart';

// import 'input_api.g.dart';

// export 'input_api.g.dart';

// final _flimeDylib = io.Platform.isWindows ? 'flime.dll' : 'libflime.so';

// late final Flime flime = FlimeImpl(
//     io.Platform.isIOS || io.Platform.isMacOS
//         ? DynamicLibrary.executable()
//         : DynamicLibrary.open(_flimeDylib));

final _rimeBridgeDylib =
    io.Platform.isWindows ? 'rime_bridge.dll' : 'librime_bridge.so';

late final RimeBridge rimeBridge = RimeBridge(
  io.Platform.isIOS || io.Platform.isMacOS
      ? DynamicLibrary.executable()
      : DynamicLibrary.open(_rimeBridgeDylib),
);

extension NativeCast on String {
  Pointer<Int8> cast() {
    return toNativeUtf8().cast();
  }
}

extension StringCast on Pointer<Int8> {
  String? toDartString() {
   final p = cast<Utf8>();
   return p == nullptr ? null : p .toDartString();
  }
}
