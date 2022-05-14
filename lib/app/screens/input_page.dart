import 'package:fluent_ui/fluent_ui.dart';

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
    return ScaffoldPage.withPadding(
      header: Column(
        children: const [
          SizedBox(
            height: 20,
          ),
          PageHeader(
            title: Text('输入测试'),
          ),
        ],
      ),
      content: Column(
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
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: TextBox(
              controller: controller,
              textInputAction: TextInputAction.go,
              placeholder: '试试你的输入法...',
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
