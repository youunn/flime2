import 'package:flutter/material.dart';

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final messages = <String>[];
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('输入测试'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                for (final m in messages)
                  ListTile(
                    title: Text(m),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),

            // BottomInsets not working for Q with small keyboard. Just take it
            // easy.
            // See also:
            //   FlutterView.guessBottomKeyboardInset(WindowInsets insets): int
            child: TextField(
              controller: controller,
              textInputAction: TextInputAction.go,
              decoration: const InputDecoration(
                hintText: '试试你的输入法...',
                border: InputBorder.none,
              ),
              onSubmitted: (text) {
                setState(() {
                  messages.add(text);
                });
                controller.clear();
              },
            ),
          ),
        ],
      ),
    );
  }
}
