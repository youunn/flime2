import 'dart:ffi';

import 'package:flime/api/native.dart';
import 'package:flime/api/platform_api.g.dart';
import 'package:flime/keyboard/base/event.dart';
import 'package:flime/keyboard/stores/keyboard_status.dart';
import 'package:flime/utils/ffi.dart';
import 'package:flime/utils/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class InputService {
  Future init();

  bool processKey(int code, int mask);

  Future<void> handleEvent(KEvent event, BuildContext context, InputConnectionApi inputConnectionApi);

  String getCommit();

  void getContext();

  Future restart();

  void finalize();
}

class RimeService implements InputService {
  final KeyboardStatus _keyboardStatus;

  RimeService(this._keyboardStatus) {
    InputServiceApi.setup(RimeInputServiceApi(this));
  }

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
  Future<void> handleEvent(KEvent event, BuildContext context, InputConnectionApi inputConnectionApi) async {
    final code = event.code;
    if (code != null) {
      if (processKey(code, event.mask | _keyboardStatus.modifierState)) {
        final commit = getCommit();
        getContext();
        if (commit != '') {
          await inputConnectionApi.commit(commit);
        }
      } else {
        final code = event.androidCode;
        final androidMask = event.androidMask;
        if (code != null) {
          final mask = androidMask | KEvent.getAndroidMask(_keyboardStatus.modifierState);
          if (kAndroidToLogicalKey[code] == LogicalKeyboardKey.enter && mask == 0) {
            await inputConnectionApi.performEnter();
          } else {
            await inputConnectionApi.send(code, mask);
          }
        }
      }
    } else {
      final command = event.command;
      if (command != null) {
        command(context, _keyboardStatus);
      }
    }
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

  @override
  void getContext() {
    final isComposing = rimeBridge.is_composing() > 0;
    if (_keyboardStatus.isComposing != isComposing) {
      _keyboardStatus.isComposing = isComposing;
    }

    final context = rimeBridge.get_context();
    if (context == nullptr) return;
    _keyboardStatus
      ..candidates = context.ref.candidates.toDartString(context.ref.count).toList()
      ..comments = context.ref.comments.toDartString(context.ref.count).toList()
      ..preedit = context.ref.preedit.toDartString();

    rimeBridge.free_context(context);
  }

  @override
  Future restart() async {
    finalize();
    await init();
  }

  @override
  void finalize() {
    rimeBridge.finalize();
  }
}

class RimeInputServiceApi extends InputServiceApi {
  final RimeService _service;

  RimeInputServiceApi(this._service);

  @override
  void finalize() {
    _service.finalize();
  }
}
