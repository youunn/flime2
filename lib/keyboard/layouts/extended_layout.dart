import 'package:auto_route/auto_route.dart';
import 'package:flime/keyboard/components/keyboard_wrapper.dart';
import 'package:flime/keyboard/layouts/main_layout.dart';
import 'package:flime/keyboard/stores/constraint.dart';
import 'package:flime/keyboard/stores/keyboard_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ExtendedLayout extends StatelessWidget {
  const ExtendedLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Consumer<ConstraintStore>(
          builder: (context, constraint, child) {
            return Observer(
              builder: (context) {
                return SizedBox(
                  height: constraint.totalHeight,
                  child: Material(
                    color: Colors.black,
                    child: child,
                  ),
                );
              },
            );
          },
          child: Consumer2<KeyboardStatus, ConstraintStore>(
            builder: (_, status, constraint, __) {
              return Builder(
                builder: (context) {
                  final orientation = MediaQuery.of(context).orientation;
                  if (constraint.orientation != orientation) {
                    constraint.orientation = orientation;
                  }

                  return Column(
                    children: [
                      ToolbarWrapper(
                        child: Observer(
                          builder: (context) {
                            final width = MediaQuery.of(context).size.width;
                            final orientationFactor =
                                orientation == Orientation.landscape ? constraint.orientationFactor : 1;
                            return SizedBox(
                              height: constraint.toolbarHeightFactor * width * orientationFactor,
                              // TODO: different toolbar
                              child: status.isComposing ? const Candidates() : const Toolbar(),
                            );
                          },
                        ),
                      ),
                      const Expanded(
                        child: AutoRouter(),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}
