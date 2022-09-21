import "dart:io";
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wave Addiction',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Wave Addiction'),
    );
  }
}

List searchImage(String path) {
  print("===== searchImage =====");
  print(path);
  List<FileSystemEntity> files = Directory(path).listSync();
  print(files);
  String imagePath = "";
  bool flag = false;
  for (FileSystemEntity f in files) {
    print(f.path);
    if (f.path.contains(".png") || f.path.contains(".jpg") || f.path.contains(".jpeg")) {
      imagePath = f.path;
      flag = true;
      print(imagePath);
    }
  }
  return [flag, imagePath];
}

Widget musicCard(String path) {
  print("===== musicCard =====");
  List l = searchImage(path);
  bool imageFlag = l[0];
  String imagePath = l[1];
  Widget child;
  if (imageFlag) {
    child = Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
          image: Image.file(File(imagePath)).image,
          fit: BoxFit.fill,
        )
      ),
    );
  } else {
    child = Center(child: Text(path));
  }
  return Card(
    color: Colors.yellowAccent,
    child: child,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String where = "/storage/emulated/0/Music";
  List<FileSystemEntity> dirs = [];

  void init() {
    dirs = Directory("/storage/emulated/0/Music").listSync();
    dirs.removeWhere((element) => element.path.contains(".thumbnails"));
    print(dirs);
  }

  @override
  Widget build(BuildContext context) {
    print("===== build =====");
    init();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.purpleAccent,
      ),

      drawer: Drawer(
        backgroundColor: Colors.lightGreenAccent,
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(title: Text("Item $index"),
            );
          }
        )
      ),

      backgroundColor: Colors.grey[900],
      body: Container(
        margin: EdgeInsets.all(4),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: dirs.length,
          itemBuilder: (BuildContext context, int index) {
            return musicCard(dirs[index].path);
          },
        )
      )
    );
  }
}
