import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vrit_task/view/components/custom_button.dart';
import 'package:vrit_task/view/screens/export_screen.dart';

class BasePage extends StatelessWidget {
  BasePage({super.key});

  static const String routeName = "/basepage";
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: const Text('Base Page'),
          ),
          CustomButton(
            buttonTitle: 'Logout',
            onTap: () async {
              await _googleSignIn.signOut().then((onValue) {
                log("$onValue");
                context.pushReplacementNamed(LoginScreen.routeName);
              });
            },
          )
        ],
      ),
    );
  }
}
