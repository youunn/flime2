import 'dart:ffi';
import 'dart:io' as io;

import 'input_api.g.dart';

export 'input_api.g.dart';

const _base = 'flime';

final _dylib = io.Platform.isWindows ? '$_base.dll' : 'lib$_base.so';

// late final Flime flime = FlimeImpl(
//     io.Platform.isIOS || io.Platform.isMacOS
//         ? DynamicLibrary.executable()
//         : DynamicLibrary.open(_dylib));
