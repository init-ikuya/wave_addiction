import 'dart:io';

List searchImage(String path) {
  List<FileSystemEntity> files = Directory(path).listSync();
  String imagePath = "";
  bool flag = false;
  for (FileSystemEntity f in files) {
    if (f.path.contains(".png") || f.path.contains(".jpg") || f.path.contains(".jpeg")) {
      imagePath = f.path;
      flag = true;
    }
  }
  return [flag, imagePath];
}