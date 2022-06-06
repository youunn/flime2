import 'package:auto_route/auto_route.dart';
import 'package:flime/keyboard/layouts/extended_layout.dart';
import 'package:flime/keyboard/layouts/full_keyboard_layout.dart';
import 'package:flime/keyboard/layouts/functional_keyboard_layout.dart';
import 'package:flime/keyboard/layouts/main_layout.dart';
import 'package:flime/keyboard/layouts/number_keyboard_layout.dart';
import 'package:flime/keyboard/layouts/primary_keyboard_layout.dart';
import 'package:flime/keyboard/layouts/symbol_keyboard_layout.dart';
import 'package:flutter/material.dart';

part 'router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Layout,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: MainLayout,
      path: '/main',
      initial: true,
      children: <AutoRoute>[
        AutoRoute(path: 'primary', page: PrimaryKeyboardLayout, initial: true),
        AutoRoute(path: 'symbol', page: SymbolKeyboardLayout),
        AutoRoute(path: 'number', page: NumberKeyboardLayout),
      ],
    ),
    AutoRoute(
      page: ExtendedLayout,
      path: '/extended',
      children: <AutoRoute>[
        AutoRoute(path: 'full', page: FullKeyboardLayout),
        AutoRoute(path: 'functional', page: FunctionalKeyboardLayout),
      ],
    ),
  ],
)
class KeyboardRouter extends _$KeyboardRouter {}
