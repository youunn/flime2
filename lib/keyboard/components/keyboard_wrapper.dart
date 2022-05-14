import 'package:flime/keyboard/stores/constraint.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class KeyboardWrapper extends StatelessWidget {
  final Widget child;

  const KeyboardWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final constraint = context.watch<Constraint>();
    return LayoutBuilder(
      builder: (context, _) {
        final boxKey = GlobalKey();
        SchedulerBinding.instance.addPostFrameCallback((_) {
          final box = boxKey.currentContext!.findRenderObject() as RenderBox;
          final w = box.getMaxIntrinsicWidth(double.infinity);
          final h = box.getMaxIntrinsicHeight(w);
          final dpr = MediaQuery.of(context).devicePixelRatio;
          constraint.setHeightAndDpr(h, dpr);
        });

        return Container(
          key: boxKey,
          child: child,
        );
      },
    );
  }
}
