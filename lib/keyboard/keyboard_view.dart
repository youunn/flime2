import 'package:flime/keyboard/router/router.dart';
import 'package:flime/keyboard/stores/constraint.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KeyboardView extends StatelessWidget {
  KeyboardView({Key? key}) : super(key: key);

  final _keyboardRouter = KeyboardRouter();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Constraint>(
          create: (_) => Constraint()..setupReactions(),
        )
      ],
      child: MaterialApp.router(
        theme: ThemeData(
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        routerDelegate: _keyboardRouter.delegate(),
        routeInformationParser: _keyboardRouter.defaultRouteParser(),
      ),
    );
  }
}
