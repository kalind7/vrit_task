import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vrit_task/model/app_models/export_app_models.dart';
import 'package:vrit_task/view/components/custom_dialog.dart';
import 'package:vrit_task/view/screens/export_screen.dart';
import 'package:vrit_task/view_model/providers/basepage_provider.dart';
import 'package:vrit_task/view_model/utils/asset_images.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({
    super.key,
    required this.list,
    this.showFav = true,
  });

  final List<Hit> list;
  final bool showFav;

  @override
  Widget build(BuildContext context) {
    return Consumer<BasepageProvider>(builder: (context, homeProv, child) {
      return GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 260,
            crossAxisSpacing: 10,
          ),
          shrinkWrap: true,
          primary: false,
          itemCount: list.length,
          itemBuilder: (context, index) {
            Hit imageDatas = list[index];

            return InkWell(
              onTap: () {
                context.pushNamed(DetailPage.routeName, extra: imageDatas);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(7.5),
                        child: Image.network(
                          '${imageDatas.userImageUrl}',
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return SvgPicture.asset(MyImages.logo);
                          },
                        ),
                      ),
                      if (showFav) ...[
                        InkWell(
                          onTap: () {
                            if (homeProv.favouriteList.contains(imageDatas)) {
                              homeProv.removeFavourite(imageDatas);
                            } else {
                              homeProv.addFavouriteDatas(imageDatas);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Icon(
                              homeProv.favouriteList.contains(imageDatas)
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_outline_sharp,
                              color: homeProv.favouriteList.contains(imageDatas)
                                  ? Colors.red
                                  : Colors.black,
                            ),
                          ),
                        )
                      ] else ...[
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => CustomDialog.normalPopUp(
                                      context,
                                      title: 'Remove Favorites ??',
                                      content: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Are you sure you to remove ${imageDatas.tags} from your wishlist',
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                      'No',
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    )),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      homeProv.removeFavourite(
                                                          imageDatas);
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                      'Yes',
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    )),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.black54,
                            ),
                          ),
                        )
                      ],
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Tags :- ${imageDatas.tags}',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54),
                  ),
                ],
              ),
            );
          });
    });
  }
}
