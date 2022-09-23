import "dart:io";
import 'package:flutter/material.dart';

import 'package:wave_addiction/detail_page.dart';
import 'package:wave_addiction/general/general.dart';


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
    dirs.sort((a,b) => a.path.compareTo(b.path));
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.purpleAccent,
      ),

      drawer: Drawer(
        backgroundColor: Colors.lightGreenAccent,
        child: ListView(
          children: const <Widget>[
            ListTile(title: Text("Music")),
            ListTile(title: Text("Item")),
            ListTile(title: Text("Config")),
          ]
        ),
      ),

      backgroundColor: Colors.grey[900],
      body: Container(
        margin: const EdgeInsets.all(4),
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

  Widget musicCard(String path) {
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
    return GestureDetector(
      onTap:() {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => DetailPage(path: path)
        ));
      },
      child: Card(
        color: Colors.yellowAccent,
        child: child,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
