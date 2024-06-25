import 'package:flutter/material.dart';
import 'package:vrit_task/model/export_models.dart';

class AuthProvider extends ChangeNotifier {
  String? errorOfGoogleLogin;

  Future<bool> googleSignIn() async {
    final response = await AppRepo().logInWithGoogle();

    response.fold((onLeft) => errorOfGoogleLogin = onLeft, (onRight) => null);

    notifyListeners();

    if (errorOfGoogleLogin != null) {
      return false;
    }
    return true;
  }
}
