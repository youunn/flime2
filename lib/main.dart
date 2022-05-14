import 'package:flime/api/native.dart';
import 'package:flime/app/app.dart';
import 'package:flime/utils/ffi.dart';
import 'package:flime/utils/path.dart';
import 'package:fluent_ui/fluent_ui.dart';

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
  final dataPath = (await getRimeDirectory()).path;
  rimeBridge
    ..init()
    ..start(dataPath.cast());
}
