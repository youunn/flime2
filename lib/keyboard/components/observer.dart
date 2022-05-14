import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nested/nested.dart';

class SingleChildObserver extends StatelessWidget {
  const SingleChildObserver({
    Key? key,
    required this.builder,
    this.child,
  }) : super(key: key);

  final Widget Function(BuildContext context, Widget? child) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    // 好像多套了一层
    return SingleChildBuilder(
      builder: (context, child) {
        return Observer(
          builder: (context) => builder(context, child),
        );
      },
      child: child,
    );
  }
}
