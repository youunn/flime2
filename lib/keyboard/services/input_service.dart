import 'dart:ffi';

import 'package:flime/api/native.dart';
import 'package:flime/api/platform_api.g.dart';
import 'package:flime/keyboard/base/event.dart';
import 'package:flime/keyboard/stores/keyboard_status.dart';
import 'package:flime/utils/ffi.dart';
import 'package:flime/utils/keyboard_maps.dart';
import 'package:flime/utils/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class InputService {
  Future init();

  bool processKey(int code, int mask);

  Future<void> handleEvent(KEvent event, BuildContext context);

  String getCommit();

  void getContext();

  Future restart();

  void finalize();
}

class RimeService implements InputService {
  final KeyboardStatus _keyboardStatus;
  final InputConnectionApi _inputConnectionApi;

  RimeService(this._keyboardStatus, this._inputConnectionApi) {
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
    // convert letter case
    if (code >= lowerACode && code <= lowerZCode && mask == KEvent.modifierShift) {
      code -= caseDiff;
      mask = 0;
    }
    final result = rimeBridge.process_key(code, mask);
    return result > 0;
  }

  @override
  Future<void> handleEvent(KEvent event, BuildContext context) async {
    final code = event.code;
    final androidCode = event.androidCode;
    if (code != null) {
      if (processKey(code, event.mask | _keyboardStatus.modifierState)) {
        final commit = getCommit();
        getContext();
        if (commit != '') {
          await _inputConnectionApi.commit(commit);
        }
      } else {
        if (androidCode != null) {
          final androidMask = event.androidMask;
          final mask = androidMask | KEvent.getAndroidMask(_keyboardStatus.modifierState);
          if (kAndroidToLogicalKey[androidCode] == LogicalKeyboardKey.enter && mask == 0) {
            await _inputConnectionApi.performEnter();
          } else if (kAndroidToLogicalKey[androidCode] == LogicalKeyboardKey.goBack && mask == 0) {
            await _inputConnectionApi.handleBack();
          } else {
            await _inputConnectionApi.send(androidCode, mask);
          }
        }
      }
      if (_keyboardStatus.shiftLock == false) {
        _keyboardStatus
          ..setModifier(KEvent.modifierShift, state: false)
          ..shiftLock = null;
      }
      if (_keyboardStatus.controlLock == false) {
        _keyboardStatus
          ..setModifier(KEvent.modifierControl, state: false)
          ..controlLock = null;
      }
      if (_keyboardStatus.metaLock == false) {
        _keyboardStatus
          ..setModifier(KEvent.modifierMeta, state: false)
          ..metaLock = null;
      }
      if (_keyboardStatus.altLock == false) {
        _keyboardStatus
          ..setModifier(KEvent.modifierAlt, state: false)
          ..altLock = null;
      }
    } else {
      final command = event.command;
      if (command != null) {
        command(context, _keyboardStatus);
      } else if (androidCode != null) {
        final androidMask = event.androidMask;
        final mask = androidMask | KEvent.getAndroidMask(_keyboardStatus.modifierState);
        if (kAndroidToLogicalKey[androidCode] == LogicalKeyboardKey.enter && mask == 0) {
          await _inputConnectionApi.performEnter();
        } else if (kAndroidToLogicalKey[androidCode] == LogicalKeyboardKey.goBack && mask == 0) {
          await _inputConnectionApi.handleBack();
        } else {
          await _inputConnectionApi.send(androidCode, mask);
        }
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
    final status = rimeBridge.get_status();
    if (status == nullptr) return;
    _keyboardStatus
      ..schemaId = status.ref.schema_id.toDartString()
      ..schemaName = status.ref.schema_name.toDartString()
      ..isAsciiMode = status.ref.is_ascii_mode > 0
      ..isComposing = status.ref.is_composing > 0;

    final context = rimeBridge.get_context();
    if (context == nullptr) return;
    _keyboardStatus
      ..candidates = context.ref.candidates.toDartString(context.ref.count).toList()
      ..comments = context.ref.comments.toDartString(context.ref.count).toList()
      ..preedit = context.ref.preedit.toDartString()
      ..preview = context.ref.preview.toDartString();

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
  void startInputView() {
    _service._inputConnectionApi.getActionId().then((value) {
      // TODO: can't update immediately
      _service._keyboardStatus.editorAction = value;
    });
  }

  @override
  void finalize() {
    _service.finalize();
  }
}
