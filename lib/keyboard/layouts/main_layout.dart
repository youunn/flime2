import 'package:auto_route/auto_route.dart';
import 'package:flime/keyboard/components/keyboard_wrapper.dart';
import 'package:flime/keyboard/components/observer.dart';
import 'package:flime/keyboard/stores/constraint.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // TODO: Candidates view
        SingleChildObserver(
          builder: (context, child) {
            return SizedBox(
              height: context.read<Constraint>().height,
              child: child,
            );
          },
          child: AutoRouter(
            builder: (context, child) {
              return KeyboardWrapper(
                child: child,
              );
            },
          ),
        ),
      ],
    );
  }
}
