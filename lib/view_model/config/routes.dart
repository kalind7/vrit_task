import 'package:bot_toast/bot_toast.dart';
import 'package:go_router/go_router.dart';

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
  ]);

  GoRouter get goRouter => _router;
}
