import 'dart:ffi';

import 'package:flime/api/native.dart';
import 'package:flime/utils/ffi.dart';
import 'package:flime/utils/path.dart';

abstract class InputService {
  Future init();
  bool processKey(int code, int mask);
  String getCommit();
}

class RimeService implements InputService {
  @override
  Future init() async {
    await copyAssets();
    rimeBridge
      ..init()
      ..start((await getRimeDirectory()).path.cast());
  }

  @override
  bool processKey(int code, int mask) {
    final result = rimeBridge.process_key(code, mask);
    return result > 0;
  }

  @override
  String getCommit() {
    final resultPointer = rimeBridge.get_commit();
    if (resultPointer != nullptr) {
      final result = resultPointer.toDartString();
      rimeBridge.free_string(resultPointer);
      return result ?? '';
    }
    return '';
  }
}
