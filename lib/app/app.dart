import 'package:flime/api/native.dart';
import 'package:fluent_ui/fluent_ui.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const FluentApp(
      home: Center(
        child: NativeDemo(),
      ),
    );
  }
}

class NativeDemo extends StatelessWidget {
  const NativeDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = rimeBridge.hello().toString();
    return Text(
      text,
      style: TextStyle(color: Colors.blue),
    );
  }
}
