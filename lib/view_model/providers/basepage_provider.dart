import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vrit_task/model/export_models.dart';
import 'package:vrit_task/view/components/export_components.dart';
import 'package:vrit_task/view/screens/export_screen.dart';

class BasepageProvider extends ChangeNotifier {
  BasepageProvider() {
    fetchImageDatas();
  }

// Base Page Datas
  int currentIndex = 0;

  changeCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  List<Widget> bottomNavbarScreens = [
    HomePage(),
    const Center(
      child: Text('Liked Page'),
    ),
    const ProfileScreen()
  ];

  List<BottomNavigationBarItem> bottomNavBarItems(BuildContext context) => [
        BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: Icon(
              Icons.home,
              color: Theme.of(context).primaryColor,
            ),
            label: 'Home',
            tooltip: 'Home'),
        BottomNavigationBarItem(
            icon: const Icon(Icons.favorite_border_outlined),
            activeIcon: Icon(
              Icons.favorite,
              color: Theme.of(context).primaryColor,
            ),
            label: 'Favorite',
            tooltip: 'Favorite'),
        BottomNavigationBarItem(
            icon: const Icon(Icons.person_2_outlined),
            activeIcon: Icon(
              Icons.person,
              color: Theme.of(context).primaryColor,
            ),
            label: 'Profile',
            tooltip: 'Profile'),
      ];

// BASE PAGE ENDS//

// PROFILE PAGE DATAS//
  XFile? profileImage;
  String? errorImageText;

  Future<void> selectAndCompressImage(ImageSource imageSource) async {
    const maxSizeInBytes = 1 * 1024 * 1024;

    try {
      XFile? pickedProfileImage =
          await ImagePicker().pickImage(source: imageSource);

      if (pickedProfileImage != null) {
        final file = File(pickedProfileImage.path);
        final outputFile = File('${file.path}.compressed.jpg');

        final result = await FlutterImageCompress.compressAndGetFile(
            file.path, outputFile.path);

        final resultInt = await result?.length();

        if (result != null && resultInt! <= maxSizeInBytes) {
          profileImage = result;
          errorImageText = null;
        } else {
          errorImageText = 'Image size exceeds 2MB';
          showBotToast(text: "Image size exceeds 2MB", isError: true);
        }
      }
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    } catch (e) {
      debugPrint('***************');
      debugPrint(e.toString());
    }
    notifyListeners();
  }

// FUNCTION TO GET LIST OF IMAGES//

  ImageModel? imageModel;
  List<Hit> hitList = [];

  String? errorOfApiCall;
  bool isLoading = false;
  int initialPage = 1;
  final TextEditingController searchController = TextEditingController();
  toggleLoading(bool newLoading) {
    isLoading = newLoading;
    notifyListeners();
  }

  Future<ImageModel?> fetchImageDatas({
    String? searchQuery,
    int defaultInitialPage = 1,
    bool showLoading = true,
  }) async {
    showLoading ? toggleLoading(true) : toggleLoading(false);

    final response = await AppRepo().getImages(
        searchQuery: searchQuery, page: defaultInitialPage, limit: 10);

    toggleLoading(false);

    response.fold(
        (error) => errorOfApiCall, (imageDatas) => imageModel = imageDatas);
    notifyListeners();

    if (imageModel != null) {
      hitList = imageModel!.hits!;
    }

    notifyListeners();

    return imageModel;
  }
}
