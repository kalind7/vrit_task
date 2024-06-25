import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrit_task/view_model/providers/basepage_provider.dart';

class BasePage extends StatelessWidget {
  const BasePage({super.key});

  static const String routeName = "/basepage";

  @override
  Widget build(BuildContext context) {
    return Consumer<BasepageProvider>(builder: (context, baseProv, child) {
      return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: baseProv.currentIndex,
              backgroundColor: Colors.white,
              onTap: (index) {
                baseProv.changeCurrentIndex(index);
              },
              items: baseProv.bottomNavBarItems(context)),
          body: SafeArea(
            child: Column(
              children: [baseProv.bottomNavbarScreens[baseProv.currentIndex]],
            ),
          ));
    });
  }
}
