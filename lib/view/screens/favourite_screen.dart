import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrit_task/view/export_view.dart';
import 'package:vrit_task/view_model/providers/basepage_provider.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});
  static const String routeName = "/favouritescreen";

  @override
  Widget build(BuildContext context) {
    return Consumer<BasepageProvider>(builder: (context, prov, child) {
      return Expanded(
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Favorite Screen",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            prov.favouriteList.isEmpty
                ? Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.4),
                    child: const Center(
                        child: Text(
                      "Add to favorites",
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.normal),
                    )),
                  )
                : CustomGridView(
                    list: prov.favouriteList,
                    showFav: false,
                  )
          ],
        ),
      );
    });
  }
}
