import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vidfiles/components/filewidget.dart';
import 'package:vidfiles/components/folderwidget.dart';

class SubFolder2 extends StatefulWidget {
  final String dirName;
  int dirnum;
  SubFolder2({@required this.dirName, @required this.dirnum});

  @override
  _SubFolder2State createState() => _SubFolder2State();
}

class _SubFolder2State extends State<SubFolder2> {
  // int dirnum;
  List<Widget> directories = [];
  @override
  void initState() {
    super.initState();
    setdirnum();
    getdata();
    print(widget.dirName);
  }

  setdirnum() {
    if (widget.dirName.split("/").contains("emulated")) {
      setState(() {
        widget.dirnum = widget.dirnum + 1;
        print(widget.dirnum);
      });
    } else {
      widget.dirnum = widget.dirnum + 1;
      print(widget.dirnum);
    }
  }

  getdata() {
    setState(() {
      directories.clear();
    });
    for (var item in Directory(widget.dirName).listSync()) {
      print(item.runtimeType.toString());
      if (item.runtimeType.toString() == "_Directory") {
        setState(() {
          // directories.add(item.path.split("/")[dirnum]);
          directories.add(
            ListTileWidFolder(
                item: item,
                dirnum: widget.dirnum,
                context: context,
                widget: widget),
          );
        });
      } else if (item.runtimeType.toString() == "_File") {
        setState(() {
          directories.add(
            ListTileWidFile(item: item, dirnum: widget.dirnum),
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
            widget.dirName.split("/")[widget.dirName.split("/").length - 1]),
      ),
      body: Container(
        child: directories.length != 0
            ? new GridView.builder(
                itemCount: directories.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return directories[index];
                },
              )
            : Container(
                child: Center(
                  child: Text(
                    "Folder is Empty",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
      ),
    );
  }
}
