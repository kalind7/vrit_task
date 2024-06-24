import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onTap,
    required this.buttonTitle,
    this.rowWidgetForButton,
    this.btnColor,
  });

  final Function? onTap;
  final String buttonTitle;
  final Widget? rowWidgetForButton;
  final Color? btnColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        decoration: BoxDecoration(
          color: btnColor ?? Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            rowWidgetForButton ?? const SizedBox.shrink(),
            Text(
              buttonTitle,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
