import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';
import 'package:vrit_task/model/app_models/local_image_model.dart';
import 'package:vrit_task/view/components/export_components.dart';
import 'package:vrit_task/view/features/export_features.dart';
import 'package:vrit_task/view_model/export_viewmodel.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const String routeName = "/profilescreen";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<IsarProvider>(context, listen: false).readFromDb();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<BasepageProvider, IsarProvider>(
        builder: (context, baseProv, isarProv, child) {
      return Column(
        children: [pickProfileImage(context, baseProv, isarProv)],
      );
    });
  }

  Widget pickProfileImage(
      BuildContext context, BasepageProvider baseProv, IsarProvider isarProv) {
    return Column(
      children: [
        if (baseProv.profileImage?.path != null) ...[
          Center(
            child: ClipOval(
              child: Image.file(
                File(baseProv.profileImage!.path),
                height: 100,
                width: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return ClipOval(
                    child: SvgPicture.asset(
                      MyImages.logo,
                      fit: BoxFit.contain,
                    ),
                  );
                },
              ),
            ),
          )
        ] else if (isarProv.locallySavedImagePath.isNotEmpty) ...[
          Center(
            child: ClipOval(
              child: Image.file(
                File(isarProv.locallySavedImagePath.last.imagePath),
                fit: BoxFit.cover,
                height: 100,
                width: 100,
                errorBuilder: (context, error, stackTrace) {
                  return ClipOval(
                    child: SvgPicture.asset(
                      MyImages.logo,
                      fit: BoxFit.contain,
                    ),
                  );
                },
              ),
            ),
          )
        ] else ...[
          Center(
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black)),
              child: SvgPicture.asset(
                MyImages.logo,
                fit: BoxFit.contain,
              ),
            ),
          )
        ],
        TextButton(
          onPressed: () {
            showPopUpDialog(context, baseProv, isarProv);
          },
          child: const Text("Change Profile Picture"),
        ),
        // if (isarProv.locallySavedImagePath.isNotEmpty) ...[
        //   Text(isarProv.locallySavedImagePath.last.imagePath),
        // ] else ...[
        //   const Text("nullll")
        // ]
      ],
    );
  }

  Future<dynamic> showPopUpDialog(
      BuildContext context, BasepageProvider baseProv, IsarProvider isarProv) {
    return showDialog(
        context: context,
        builder: (context) =>
            CustomDialog.normalPopUp(context, title: "Upload Profile Picture",
                content: StatefulBuilder(builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DialogContents(
                    title: 'Select Image from Gallery',
                    icon: Icons.photo,
                    onTap: () {
                      baseProv
                          .selectAndCompressImage(ImageSource.gallery)
                          .then((value) {
                        if (baseProv.profileImage?.path != null) {
                          log("I am herrrr inside picker ${baseProv.profileImage!.path}");
                          isarProv.writeToDb(LocalImageModel(
                              imagePath: baseProv.profileImage!.path));
                        }
                        context.pop();
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DialogContents(
                    title: 'Select Image from Camera',
                    icon: Icons.camera_alt,
                    onTap: () {
                      baseProv
                          .selectAndCompressImage(ImageSource.camera)
                          .then((value) {
                        if (baseProv.profileImage?.path != null) {
                          log("I am herrrr inside picker ${baseProv.profileImage!.path}");
                          isarProv.writeToDb(LocalImageModel(
                              imagePath: baseProv.profileImage!.path));
                        }
                        context.pop();
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              );
            })));
  }
}
