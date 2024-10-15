import 'package:auto_route/auto_route.dart';

import '../features/favorites/favorites.dart';
import '../features/history/history.dart';
import '../features/home/home.dart';
import '../features/search/search.dart';
import '../features/settings/settings.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
        page: HomeRoute.page,
        path: '/',
        children: [
          AutoRoute(
              page: FavoritesRoute.page,
              path: 'favorites'
          ),
          AutoRoute(
              page: HistoryRoute.page,
              path: 'history'
          ),
          AutoRoute(
              page: SearchRoute.page,
              path: 'search',
              initial: true,
          ),
          AutoRoute(
              page: SettingsRoute.page,
              path: 'settings'
          )
        ]
    ),
  ];
}