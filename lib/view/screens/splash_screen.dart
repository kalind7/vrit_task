import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vrit_task/view/screens/export_screen.dart';

import 'package:vrit_task/view_model/export_viewmodel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = "/splashscreen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  Future<void> splashFunction() async {
    final accessToken = await SecureStorage.getData(googleLoginToken);

    _timer = Timer(const Duration(seconds: 3), () async {
      if (accessToken != null) {
        Provider.of<IsarProvider>(context, listen: false).readFromDb();
        if (!mounted) return;
        context.pushReplacementNamed(BasePage.routeName);
      } else {
        context.pushReplacementNamed(LoginScreen.routeName);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    splashFunction();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Center(child: SvgPicture.asset(MyImages.logo))],
      ),
    );
  }
}
