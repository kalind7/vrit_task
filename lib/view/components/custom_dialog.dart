import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../view_model/utils/asset_images.dart';

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

  static AlertDialog buildWillPopUp(
    BuildContext context, {
    String? title,
    String? subtext,
    FontWeight? weight,
    Color? tcolor,
    Color? scolor,
    Color? backgroundColor,
    Function()? onTapOk,
    Function()? onTapCancel,
    CrossAxisAlignment? crossAxisAlignment,
  }) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 4,
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                MyImages.logoPng,
                height: 50,
              ),
              const SizedBox(
                width: 20,
              ),
              const Text("Vrit Tech")
            ],
          ),
          const Divider(
            thickness: 1,
            color: Color(0xffC5BFBF),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
        children: [
          Text(
            title ?? 'Are you sure want to exit ?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: weight ?? FontWeight.bold,
              color: tcolor ?? Colors.black,
            ),
          ),
          Visibility(
            visible: subtext != null,
            child: Container(
              margin: const EdgeInsets.only(top: 15),
              child: Center(
                child: Text(
                  subtext ?? '',
                  style: TextStyle(
                    fontSize: 12,
                    color: scolor ?? Colors.black,
                    fontWeight: FontWeight.w400,
                    wordSpacing: 2.0,
                  ),
                  // textAlign: TextAlign.justify,
                ),
              ),
            ),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onPressed: onTapCancel ??
              () {
                context.pop();
              },
          child: Text(
            'CANCEL',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onPressed: onTapOk ??
              () {
                exit(0);
              },
          child: Text(
            'Yes'.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12.0,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
