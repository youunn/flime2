import 'package:flime/app/app.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'keyboard/keyboard_view.dart';

void main() {
  runApp(const App());
}

@pragma('vm:entry-point')
void showKeyboard() => runApp(const KeyboardView());
