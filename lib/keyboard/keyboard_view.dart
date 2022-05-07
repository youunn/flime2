import 'package:flime/keyboard/api/api.dart';
import 'package:flime/keyboard/widgets/keyboard_wrapper.dart';
import 'package:fluent_ui/fluent_ui.dart';

class KeyboardView extends StatelessWidget {
  const KeyboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      debugShowCheckedModeBanner: false,
      home:
      Align(
        alignment: Alignment.bottomCenter,
        child: KeyboardWrapper(
          child: Column(
            children: [
              const Text(
                'Hello world',
              ),
              Button(
                child: const Text(
                  'update height',
                ),
                onPressed: () {
                  scopedLayoutApi.updateHeight(1000);
                },
              ),
              Button(
                child: const Text(
                  'update height',
                ),
                onPressed: () {
                  scopedLayoutApi.updateHeight(500);
                },
              ),
              Button(
                child: const Text(
                  'update height',
                ),
                onPressed: () {
                  scopedLayoutApi.updateHeight(300);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
