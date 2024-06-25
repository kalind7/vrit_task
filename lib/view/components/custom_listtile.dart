import 'package:flutter/material.dart';

class CustomListtile extends StatelessWidget {
  const CustomListtile(
      {super.key,
      required this.title,
      required this.icon,
      this.onTap,
      this.subtitle});

  final String title;
  final IconData icon;
  final Widget? subtitle;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTap?.call();
      },
      leading: Icon(
        icon,
        color: Colors.black,
      ),
      title: Text(title,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black)),
      subtitle: subtitle,
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
