import 'package:flime/keyboard/stores/constraint.dart';
import 'package:flime/keyboard/stores/keyboard_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class KeyboardWrapper extends StatelessWidget {
  final Widget? child;

  const KeyboardWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<ConstraintStore, KeyboardStatus>(
      builder: (context, constraint, status, _) {
        return LayoutBuilder(
          builder: (context, _) {
            final boxKey = GlobalKey();
            SchedulerBinding.instance.addPostFrameCallback(
              (_) {
                final box = boxKey.currentContext!.findRenderObject() as RenderBox;
                final w = box.getMaxIntrinsicWidth(double.infinity);
                final height = box.getMaxIntrinsicHeight(w);

                constraint
                  ..height = height
                  ..dpr = MediaQuery.of(context).devicePixelRatio
                  ..updatePlatformHeight();
              },
            );

            return Container(
              key: boxKey,
              child: child,
            );
          },
        );
      },
    );
  }
}

class ToolbarWrapper extends StatelessWidget {
  final Widget? child;

  const ToolbarWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ConstraintStore>(
      builder: (context, constraint, _) {
        return LayoutBuilder(
          builder: (context, _) {
            final boxKey = GlobalKey();
            SchedulerBinding.instance.addPostFrameCallback((_) {
              final box = boxKey.currentContext!.findRenderObject() as RenderBox;
              final w = box.getMaxIntrinsicWidth(double.infinity);
              constraint
                ..toolbarHeight = box.getMaxIntrinsicHeight(w)
                ..dpr = MediaQuery.of(context).devicePixelRatio;
            });

            return Container(
              key: boxKey,
              child: child,
            );
          },
        );
      },
    );
  }
}
