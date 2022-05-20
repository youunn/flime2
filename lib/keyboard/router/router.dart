import 'package:auto_route/auto_route.dart';
import 'package:flime/keyboard/layouts/main_layout.dart';
import 'package:flime/keyboard/layouts/number_keyboard_layout.dart';
import 'package:flime/keyboard/layouts/primary_keyboard_layout.dart';
import 'package:flutter/material.dart';

part 'router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Layout,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: MainLayout,
      path: '/',
      children: <AutoRoute>[
        AutoRoute(path: 'primary', page: PrimaryKeyboardLayout, initial: true),
        // AutoRoute(path: 'symbol', page: SymbolKeyboardLayout),
        AutoRoute(path: 'number', page: NumberKeyboardLayout),
      ],
    ),
  ],
)
class KeyboardRouter extends _$KeyboardRouter {}
