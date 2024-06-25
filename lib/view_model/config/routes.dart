import 'package:bot_toast/bot_toast.dart';
import 'package:go_router/go_router.dart';
import 'package:vrit_task/model/app_models/image_model.dart';

import 'package:vrit_task/view/screens/export_screen.dart';

class GoRouteNavigation {
  static final GoRouter _router =
      GoRouter(initialLocation: SplashScreen.routeName, observers: [
    BotToastNavigatorObserver()
  ], routes: [
    GoRoute(
      path: SplashScreen.routeName,
      name: SplashScreen.routeName,
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: LoginScreen.routeName,
      name: LoginScreen.routeName,
      builder: (context, state) {
        return LoginScreen();
      },
    ),
    GoRoute(
      path: BasePage.routeName,
      name: BasePage.routeName,
      builder: (context, state) {
        return const BasePage();
      },
    ),
    GoRoute(
      path: ProfileScreen.routeName,
      name: ProfileScreen.routeName,
      builder: (context, state) {
        return const ProfileScreen();
      },
    ),
    GoRoute(
      path: HomePage.routeName,
      name: HomePage.routeName,
      builder: (context, state) {
        return HomePage();
      },
    ),
    GoRoute(
      path: FavouriteScreen.routeName,
      name: FavouriteScreen.routeName,
      builder: (context, state) {
        return const FavouriteScreen();
      },
    ),
    GoRoute(
      path: DetailPage.routeName,
      name: DetailPage.routeName,
      builder: (context, state) {
        return DetailPage(
          imageDatas: state.extra as Hit,
        );
      },
    ),
  ]);

  GoRouter get goRouter => _router;
}
