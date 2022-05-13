import 'package:auto_route/auto_route.dart';
import 'package:flime/app/screens/gallery_page.dart';
import 'package:flime/app/screens/home_page.dart';
import 'package:flime/app/screens/input_page.dart';
import 'package:fluent_ui/fluent_ui.dart';

part 'router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: HomePage,
      path: '/',
      initial: true,
    ),
    AutoRoute(
      page: InputPage,
      path: '/input',
    ),
    AutoRoute(
      page: GalleryPage,
      path: '/gallery',
    ),
  ],
)
class AppRouter extends _$AppRouter {}
