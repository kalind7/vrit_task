import 'package:flutter/material.dart';

class CustomDialog {
  static AlertDialog normalPopUp(BuildContext context,
      {required String title,
      required Widget content,
      bool scrollable = false}) {
    return AlertDialog(
        scrollable: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        titlePadding: EdgeInsets.zero,
        title: Container(
          margin: const EdgeInsets.only(bottom: 11),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.all(2.5),
                  decoration: const BoxDecoration(
                      color: Colors.yellow, shape: BoxShape.circle),
                  child: const Icon(
                    Icons.clear,
                    color: Colors.black,
                    size: 12,
                  ),
                ),
              )
            ],
          ),
        ),
        contentPadding: EdgeInsets.zero,
        content: content);
  }
}
