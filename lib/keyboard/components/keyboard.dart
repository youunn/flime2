import 'package:flime/keyboard/base/preset.dart';
import 'package:flutter/material.dart';

class MainKeyboard extends StatelessWidget {
  final Preset preset;

  const MainKeyboard({Key? key, required this.preset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        for (final r in preset)
          SizedBox(
            height: r.height,
            child: Row(
              children: [
                for (final k in r)
                  SizedBox(
                    height: k.height,
                    width: k.width * width,
                    child: Center(
                      child: Text(k.label),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
