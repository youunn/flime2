import 'package:flime/api/platform_api.g.dart';
import 'package:flime/keyboard/base/preset.dart';
import 'package:flime/keyboard/services/input_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                    child: InkWell(
                      child: Center(
                        child: Text(k.label),
                      ),
                      onTap: () {
                        final inputService = context.read<InputService>();
                        final inputConnectionApi =
                            context.read<InputConnectionApi>();
                        if (k.click.code != null) {
                          if (inputService.processKey(
                            k.click.code!,
                            k.click.mask,
                          )) {
                            final commit = inputService.getCommit();
                            if (commit != '') {
                              inputConnectionApi.commit(commit);
                            }
                          } else {
                            inputConnectionApi.send(
                                k.click.androidCode!, k.click.androidMask);
                          }
                        }
                      },
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}
