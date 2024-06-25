import 'package:flutter/material.dart';

class DialogContents extends StatelessWidget {
  const DialogContents({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  final String title;
  final IconData icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: title,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black)),
        const WidgetSpan(
            child: SizedBox(
          width: 20,
        )),
        WidgetSpan(
            child: Icon(
          icon,
          color: Colors.black,
        ))
      ])),
    );
  }
}
