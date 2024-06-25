import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:provider/provider.dart';
import 'package:vrit_task/model/app_models/export_app_models.dart';
import 'package:vrit_task/view/components/custom_button.dart';
import 'package:vrit_task/view/components/export_components.dart';
import 'package:vrit_task/view_model/providers/basepage_provider.dart';
import 'package:vrit_task/view_model/utils/asset_images.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.imageDatas});

  final Hit imageDatas;

  static const String routeName = "/detailpage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text("Detail Page"),
      ),
      body: Consumer<BasepageProvider>(builder: (context, homeProv, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imageDatas.userImageUrl!,
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return SvgPicture.asset(MyImages.logo);
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Expanded(
                      child: CustomButton(
                    buttonTitle: homeProv.favouriteList.contains(imageDatas)
                        ? 'Remove From Favorites'
                        : 'Add to Favorite',
                    onTap: () {
                      if (homeProv.favouriteList.contains(imageDatas)) {
                        homeProv.removeFavourite(imageDatas);
                        showBotToast(
                            text: "Removed From Favorites", isError: true);
                      } else {
                        homeProv.addFavouriteDatas(imageDatas);
                        showBotToast(
                          text: "Added to Favorites",
                        );
                      }
                    },
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: CustomButton(
                    buttonTitle: 'Set as Wallpaper',
                    onTap: () async {
                      loading();
                      int location = WallpaperManager
                          .BOTH_SCREEN; // or location = WallpaperManager.LOCK_SCREEN;
                      var file = await DefaultCacheManager()
                          .getSingleFile(imageDatas.userImageUrl!);

                      await WallpaperManager.setWallpaperFromFile(
                          file.path, location);
                      BotToast.closeAllLoading();
                    },
                  )),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
