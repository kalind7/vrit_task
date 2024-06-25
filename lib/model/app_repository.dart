import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vrit_task/view/components/export_components.dart';
import 'package:vrit_task/view_model/export_viewmodel.dart';

typedef EitherFunction<T> = Future<Either<String, T>>;

class AppRepo {
  EitherFunction<void> logInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    loading();
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        log("${googleSignInAuthentication.accessToken}");

        if (googleSignInAuthentication.accessToken != null) {
          final AuthCredential authCredential = GoogleAuthProvider.credential(
              accessToken: googleSignInAuthentication.accessToken,
              idToken: googleSignInAuthentication.idToken);
          SecureStorage.setData(
              googleLoginToken, googleSignInAuthentication.accessToken!);

          SecureStorage.setData(username, googleSignInAccount.displayName!);
          await firebaseAuth.signInWithCredential(authCredential);

          BotToast.closeAllLoading();
          showBotToast(
              text:
                  "Signed in successfully as ${googleSignInAccount.displayName}");
        }
      }
      return right(null);
    } catch (e) {
      BotToast.closeAllLoading();

      log("$e");
      showBotToast(text: "Error occurred $e", isError: true);
      return left(e.toString());
    }
  }
}
