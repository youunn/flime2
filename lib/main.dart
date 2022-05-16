import 'package:flime/app/app.dart';
import 'package:flutter/material.dart';

import 'keyboard/keyboard_view.dart';

void main() {
  runApp(App());
}

@pragma('vm:entry-point')
void showKeyboard() {
  runApp(KeyboardView());
}
