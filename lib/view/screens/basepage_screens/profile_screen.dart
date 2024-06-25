import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:vrit_task/model/app_models/local_image_model.dart';
import 'package:vrit_task/model/controller/export_controller.dart';
import 'package:vrit_task/view/components/export_components.dart';
import 'package:vrit_task/view/screens/export_screen.dart';
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

  final userModel = FirebaseAuth.instance.currentUser;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Consumer3<BasepageProvider, IsarProvider, DatePickerProvider>(
        builder: (context, baseProv, isarProv, pickerProv, child) {
      return Column(
        children: [
          pickProfileImage(context, baseProv, isarProv),
          CustomListtile(
            title: 'Calendar',
            icon: Icons.calendar_month,
            subtitle: pickerProv.currentDateTime != null
                ? Text(
                    DateFormat.yMMMMd().format(pickerProv.currentDateTime!),
                  )
                : null,
            onTap: () {
              pickerProv
                  .mainPicker(
                context,
              )
                  .then((selectedDate) {
                pickerProv.changeDate(selectedDate);
                log("${pickerProv.currentDateTime}");

                if (pickerProv.currentDateTime ==
                    DateTime(DateTime.now().year, DateTime.now().month,
                        DateTime.now().day)) {
                  NotificationController()
                      .showNotification(username: userModel?.displayName);
                }
              });
            },
          ),
          CustomListtile(
            title: 'Logout',
            icon: Icons.logout,
            onTap: () async {
              showDialog(
                  context: context,
                  builder: (context) => CustomDialog.buildWillPopUp(context,
                          title: 'Do you want to Logout ?', onTapOk: () async {
                        await _googleSignIn.signOut();
                        await _firebaseAuth.signOut();
                        await SecureStorage.deleteAll();
                        context.pushReplacementNamed(LoginScreen.routeName);
                      }));
            },
          )
        ],
      );
    });
  }

  Widget pickProfileImage(
      BuildContext context, BasepageProvider baseProv, IsarProvider isarProv) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Row(
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
                  const SizedBox(
                    width: 10,
                  ),
                  if (userModel != null) ...[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (userModel?.displayName != null) ...[
                            const Text(
                              "User Details",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            Text(userModel!.displayName!),
                          ],
                          if (userModel?.email != null) ...[
                            Text(userModel!.email!),
                          ],
                          if (userModel?.phoneNumber != null) ...[
                            Text(userModel!.phoneNumber!),
                          ]
                        ],
                      ),
                    ),
                  ]
                ],
              )
            ],
          ),
        ),

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
        builder: (context) => CustomDialog.normalPopUp(context,
            title: "Upload Profile Picture",
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomListtile(
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
                CustomListtile(
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
            )));
  }
}
