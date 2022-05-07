import 'package:flime/keyboard/api/api.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/scheduler.dart';

class KeyboardWrapper extends StatelessWidget {
  final Widget child;

  const KeyboardWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, _) {
        final boxKey = GlobalKey();
        SchedulerBinding.instance!.addPostFrameCallback((_) {
          final box = boxKey.currentContext!.findRenderObject() as RenderBox;
          final w = box.getMaxIntrinsicWidth(double.infinity);
          final h = box.getMaxIntrinsicHeight(w);
          final dpr = MediaQuery.of(context).devicePixelRatio;
          scopedLayoutApi.updateHeight((h * dpr).toInt());
        });

        return Container(
          clipBehavior: Clip.none,
          key: boxKey,
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            child: child,
          ),
        );
      },
    );
  }
}
