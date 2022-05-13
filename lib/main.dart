import 'package:flime/app/app.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'keyboard/keyboard_view.dart';

void main() {
  runApp(App());
}

@pragma('vm:entry-point')
void showKeyboard() {
  // init();
  runApp(KeyboardView());
}

Future init() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO: MissingPluginException
  // rimeBridge.start((await getRimeDirectory()).path.cast());
}
