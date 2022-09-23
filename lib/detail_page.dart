import "dart:io";
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'package:wave_addiction/audio/hundle.dart';
import 'package:wave_addiction/general/general.dart';


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
  List<bool> isPlayings = [];
  List<FileSystemEntity> files = [];
  List<FileSystemEntity> musics = [];

  @override
  void initState() {
    super.initState();
    path = widget.path;
    files = Directory(path).listSync();
    files.sort((a,b) => a.path.compareTo(b.path));
    for (var f in files) {
      if (f.path.endsWith("mp3")) {
        musics.add(f);
        isPlayings.add(false);
      }
    }
    _player = AudioPlayer();
    List l = searchImage(path);
    imageFlag = l[0];
    imagePath = l[1];
  }

  Widget imageArea() {
    if (imageFlag) {
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
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

  Widget playStopButton(int index, String path) {
    Widget button;
    if (!isPlayings[index]) {
      button = IconButton(
        icon: const Icon(
          Icons.play_arrow,
          color: Colors.grey,
        ),
        onPressed: () async {
          playAudio(_player, path, isPlayings, index, setState);
        },
      );
    } else {
      button = IconButton(
        icon: const Icon(
          Icons.pause_circle_outline,
          color: Colors.grey,
        ),
        onPressed: () async {
          stopAudio(_player, isPlayings, index, setState);
        },
      );
    }
    return button;
  }

  Widget musicArea() {
    List<Widget> widgetList = [];
    for (var i=0; i<musics.length; i++) {
      if (musics[i].path.endsWith("mp3")) {
        isPlayings = isPlayings.sublist(0, files.length-1);
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
                  playStopButton(i, musics[i].path),
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
              title: Text(musics[i].path.split("/")[path.split("/").length],
                style: const TextStyle(color: Colors.greenAccent),
              ),
                subtitle: const Text("subtitle",
                  style: TextStyle(color: Colors.grey),
                ),
              onTap: () async {
                if (!isPlayings[i]) {
                  playAudio(_player, path, isPlayings, i, setState);
                } else {
                  stopAudio(_player, isPlayings, i, setState);
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