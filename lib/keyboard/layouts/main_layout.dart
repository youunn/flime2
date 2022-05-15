import 'package:auto_route/auto_route.dart';
import 'package:flime/keyboard/components/keyboard_wrapper.dart';
import 'package:flime/keyboard/stores/constraint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // TODO: Candidates view
        Consumer<ConstraintStore>(
          builder: (context, constraint, child) {
            return Observer(
              builder: (context) {
                return SizedBox(
                  height: context.read<ConstraintStore>().height,
                  child: Material(
                    color: Colors.black,
                    child: child,
                  ),
                );
              },
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
