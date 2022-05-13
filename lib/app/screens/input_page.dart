import 'package:fluent_ui/fluent_ui.dart';

class InputPage extends StatelessWidget {
  const InputPage({Key? key}) : super(key: key);

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
        children: const [
          TextBox(
              placeholder: '试试你的输入法...',
            ),
        ],
      ),
    );
  }
}
