import 'package:fluent_ui/fluent_ui.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScaffoldPage(
      content: Center(
        child: Text('自定义控件测试页面'),
      ),
    );
  }
}
