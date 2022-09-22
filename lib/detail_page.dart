import "dart:io";
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
// import 'package:audioplayers/audioplayers.dart';

import 'general/general.dart';


class DetailPage extends StatefulWidget {
  // define variable
  final String path;
  // constructor
  const DetailPage({Key? key, required this.path}) : super(key: key);

  @override
  _StateDetailPage createState() => _StateDetailPage();
}

class _StateDetailPage extends State<DetailPage> {
  late String path;
  late bool imageFlag;
  late String imagePath;
  late AudioPlayer _player;


  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    path = widget.path;
    List l = searchImage(path);
    imageFlag = l[0];
    imagePath = l[1];
  }

  Widget imageArea() {
    if (imageFlag) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            // boxShadow: [
            //   const BoxShadow(
            //     color: Colors.grey,
            //     spreadRadius: 4,
            //     blurRadius: 4,
            //     offset: Offset(1, 1),
            //   ),
            // ],
            image: DecorationImage(
              image: Image.file(File(imagePath)).image,
              fit: BoxFit.fill,
            )
        ),
        height: 300,
        width: 300,
        margin: const EdgeInsets.only(top:10, left: 10, right: 10, bottom:20),
      );
    } else {
      return Text(path);
    }
  }

  Widget musicArea() {
    List<Widget> widgetList = [];
    List<FileSystemEntity> files = Directory(path).listSync();
    files.sort((a,b) => a.path.compareTo(b.path));
    for (FileSystemEntity f in files) {
      if (f.path.endsWith("mp3")) {
        bool isPlaying = false;
        widgetList.add(
          Card(
            color: Colors.transparent,
            child: ListTile(
              leading: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: Image.file(File(imagePath)).image,
                      fit: BoxFit.fill,
                    )
                ),
                height: 40,
                width: 40,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.play_arrow,
                      color: Colors.grey,
                    ),
                    onPressed: () {

                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.grey,
                    ),
                    onPressed: () {

                    },
                  ),
                ]
              ),
              title: Text(f.path.split("/")[path.split("/").length],
                style: const TextStyle(color: Colors.greenAccent),
              ),
                subtitle: const Text("subtitle",
                  style: TextStyle(color: Colors.grey),
                ),
              onTap: () async {
                if (!isPlaying) {
                  await _player.setFilePath(f.path);
                  await _player.play();
                  isPlaying = true;
                } else {
                  _player.stop();
                  isPlaying = false;
                }
              }
            ),
          ),
        );
      }
    }
    return Expanded(child: ListView(
        children: widgetList,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(path.split("/")[path.split("/").length-1]),
        backgroundColor: Colors.purpleAccent,
      ),
      backgroundColor: Colors.grey[900],
      body: Column(
        children: <Widget>[
          Center(child: imageArea()),
          musicArea(),
        ]
      )
    );
  }
}