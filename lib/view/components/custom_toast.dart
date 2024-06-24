import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:vrit_task/view/components/export_components.dart';

loading() {
  BotToast.showCustomLoading(toastBuilder: (func) {
    return const CustomLoader();
  });
}

showBotToast({
  required String text,
  bool isError = false,
}) {
  return BotToast.showText(
      text: text,
      clickClose: true,
      contentColor: isError
          ? Colors.red.withOpacity(0.75)
          : Colors.green.withOpacity(0.75),
      textStyle: const TextStyle(
          fontWeight: FontWeight.w600, color: Colors.white, fontSize: 14),
      duration: const Duration(seconds: 3));
}
