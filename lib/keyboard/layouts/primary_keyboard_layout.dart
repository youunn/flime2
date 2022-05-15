import 'package:flutter/material.dart';

class PrimaryKeyboardLayout extends StatelessWidget {
  const PrimaryKeyboardLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: SizedBox(
        width: 300,
        height: 300,
        child: Center(
          child: Text('Primary'),
        ),
      ),
    );
  }
}
