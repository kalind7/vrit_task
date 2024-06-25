import 'package:isar/isar.dart';
part 'local_image_model.g.dart';

@Collection()
class LocalImageModel {
  Id id = Isar.autoIncrement;
  String imagePath;

  LocalImageModel({required this.imagePath});
}
