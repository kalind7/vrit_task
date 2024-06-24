import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:vrit_task/model/export_models.dart';
import 'package:vrit_task/view/components/export_components.dart';
import 'package:vrit_task/view/screens/export_screen.dart';
import 'package:vrit_task/view_model/export_viewmodel.dart';
import 'package:vrit_task/view_model/utils/export_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = "/loginscreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  String? googleSignInError;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SvgPicture.asset(MyImages.logo),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 4,
                  ),
                  const CustomFormField(
                    label: 'Email',
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const CustomFormField(label: 'Password'),
                  CustomButton(
                    buttonTitle: 'Login',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                      }
                    },
                  ),
                  CustomButton(
                    buttonTitle: 'Sign in with Google',
                    btnColor: Colors.red,
                    rowWidgetForButton: const Wrap(
                      children: [
                        Icon(
                          FontAwesomeIcons.google,
                        ),
                        SizedBox(
                          width: 20,
                        )
                      ],
                    ),
                    onTap: () async {
                      // if (_formKey.currentState!.validate()) {
                      //   _formKey.currentState!.save();
                      // }
                      final response = await AppRepo().logInWithGoogle();

                      setState(() {
                        response.fold(((onLeft) => googleSignInError = onLeft),
                            ((onRight) => null));
                      });

                      log("the error is $googleSignInError");

                      if (googleSignInError == null) {
                        context.pushReplacementNamed(BasePage.routeName);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
