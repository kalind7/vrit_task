import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vrit_task/model/app_models/local_image_model.dart';

class IsarProvider extends ChangeNotifier {
  IsarProvider() {
    initIsar();
  }

  Isar? isar;

  List<LocalImageModel> locallySavedImagePath = [];

  Future<void> initIsar() async {
    log("Isarr initializedd");
    final dir = await getApplicationDocumentsDirectory();

    isar = await Isar.open([LocalImageModelSchema], directory: dir.path);
  }

  Future<void> writeToDb(LocalImageModel imageModel) async {
    try {
      if (isar != null) {
        log("Insidee write to db");

        await isar!.writeTxn(() async {
          await isar!.localImageModels.put(imageModel);
        });

        await readFromDb();
      }
    } catch (e) {
      log("Isarr write error");
      log(e.toString());
    }
  }

  Future<void> readFromDb() async {
    log('read initiate');

    try {
      if (isar != null) {
        log('Insideeeeeee read db');
        locallySavedImagePath = await isar!.localImageModels.where().findAll();

        log('ADDED HOUSE LEMGTH');
        log(locallySavedImagePath.last.imagePath);
        notifyListeners();
      }
    } catch (e) {
      log('Readingggggggg erorrrrrrrr');
      log(locallySavedImagePath.last.imagePath);

      log(e.toString());
    }
  }
}
