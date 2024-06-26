import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrit_task/firebase_options.dart';
import 'package:vrit_task/model/controller/export_controller.dart';
import 'package:vrit_task/view_model/config/export_config.dart';
import 'package:vrit_task/view_model/providers/export_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await NotificationController().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(
            create: (_) => BasepageProvider()..fetchImageDatas()),
        ChangeNotifierProvider(create: (_) => DatePickerProvider()),
        ChangeNotifierProvider(create: (_) => IsarProvider()..initIsar()),
      ],
      child: MaterialApp.router(
        title: 'Search Image',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerDelegate: GoRouteNavigation().goRouter.routerDelegate,
        routeInformationProvider:
            GoRouteNavigation().goRouter.routeInformationProvider,
        routeInformationParser:
            GoRouteNavigation().goRouter.routeInformationParser,
        builder: (context, widget) {
          widget = BotToastInit()(context, widget);

          return widget;
        },
      ),
    );
  }
}
