import 'dart:io';
import 'package:image/image.dart';

List searchImage(String path) {
  List<FileSystemEntity> files = Directory(path).listSync();
  String imagePath = "";
  bool flag = false;
  int length = 0;
  for (FileSystemEntity f in files) {
    if (f.path.contains(".png") || f.path.contains(".jpg") || f.path.contains(".jpeg")) {
      flag = true;
      Image image = decodeImage(File(f.path).readAsBytesSync())!;
      if (length < image.length) {
        length = image.length;
        imagePath = f.path;
      }
    }
  }
  return [flag, imagePath];
}