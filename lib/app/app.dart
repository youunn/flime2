import 'package:fluent_ui/fluent_ui.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      home: Center(
        child: Text(
          'Hello World!',
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
