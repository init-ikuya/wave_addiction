import 'package:flutter/material.dart';
import 'dart:io';

enum Menu {first, second, third}

class ConfigPage extends StatefulWidget {
  const ConfigPage({Key? key}) : super(key: key);

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
   String _themeColor = "third";

  Widget themeConfig() {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.color_lens),
        title: const Text("Theme Color Config"),
        trailing: PopupMenuButton<Menu>(
          child: Text(
            _themeColor,
            style: const TextStyle(
              decoration: TextDecoration.underline,
              decorationColor: Colors.blueAccent,
              decorationThickness: 2.0,
            )
          ),
          onSelected: (Menu item) {
            setState(() {
              _themeColor = item.name;
            });
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>> [
            const PopupMenuItem<Menu>(
              value: Menu.first,
              child: Text("first"),
            ),
            const PopupMenuItem<Menu>(
              value: Menu.second,
              child: Text("second"),
            ),
            const PopupMenuItem<Menu>(
              value: Menu.third,
              child: Text("third"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Config Page"),
        backgroundColor: Colors.purpleAccent,
      ),

      backgroundColor: Colors.grey[900],
      body: ListView(
        children: <Widget>[
          themeConfig(),
        ],
      ),
    );
  }
}