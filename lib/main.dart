import 'package:flime/api/native.dart';
import 'package:flime/app/app.dart';
import 'package:flime/utils/ffi.dart';
import 'package:flime/utils/path.dart';
import 'package:flutter/material.dart';

import 'keyboard/keyboard_view.dart';

void main() {
  runApp(App());
}

@pragma('vm:entry-point')
void showKeyboard() {
  init();
  runApp(KeyboardView());
}

Future init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await copyAssets();
  rimeBridge
    ..init()
    ..start((await getRimeDirectory()).path.cast());
}
