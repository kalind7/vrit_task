import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vrit_task/view/components/export_components.dart';
import 'package:vrit_task/view/screens/export_screen.dart';
import 'package:vrit_task/view_model/export_viewmodel.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  static const String routeName = "/loginscreen";

  final _formKey = GlobalKey<FormState>();

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
          child: Consumer<AuthProvider>(builder: (context, authProv, child) {
            return Form(
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

                          showBotToast(text: "Google Login Only Available");
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
                        authProv.googleSignIn().then((value) {
                          if (value) {
                            context.pushReplacementNamed(BasePage.routeName);
                          }
                        });
                      },
                    ),
                    if (authProv.errorOfGoogleLogin != null) ...[
                      const SizedBox(
                        height: 15,
                      ),
                      RichText(
                          text: TextSpan(children: [
                        const TextSpan(
                            text: 'Google Sign In Error :',
                            style:
                                TextStyle(fontSize: 16, color: Colors.black)),
                        TextSpan(
                          text: authProv.errorOfGoogleLogin,
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ]))
                    ]
                  ],
                ),
              ),
            );
          }),
        ),
      )),
    );
  }
}
