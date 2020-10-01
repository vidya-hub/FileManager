import 'dart:io';
// import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:vidfiles/components/filewidget.dart';
import 'package:vidfiles/components/folderwidget.dart';

class SubDirs extends StatefulWidget {
  final String dirName;
  SubDirs({@required this.dirName});
  @override
  _SubDirsState createState() => _SubDirsState();
}

class _SubDirsState extends State<SubDirs> {
  int dirnum;
  List<Widget> directories = [];
  List<Widget> files = [];
  // List<Widget> wids = [];

  @override
  void initState() {
    super.initState();
    setdirnum();
    getdata();
  }

  setdirnum() {
    if (widget.dirName.split("/").contains("emulated")) {
      setState(() {
        dirnum = 4;
        print(dirnum);
      });
    } else {
      dirnum = 3;
      print(dirnum);
    }
  }

  getdata() {
    setState(() {
      directories.clear();
      files.clear();
    });

    for (var item in Directory(widget.dirName).listSync()) {
      // print(item.runtimeType.toString());
      if (item.runtimeType.toString() == "_Directory") {
        setState(() {
          directories.add(
            ListTileWidFolder(
                item: item, dirnum: dirnum, context: context, widget: widget),
          );
        });
      } else if (item.runtimeType.toString() == "_File") {
        setState(() {
          directories.add(
            ListTileWidFile(item: item, dirnum: dirnum),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        title: Text(
          widget.dirName.split("/")[widget.dirName.split("/").length - 2],
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: Center(
          child: new GridView.builder(
            itemCount: directories.length,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              return directories[index];
            },
          ),
        ),
      ),
    );
  }
}
