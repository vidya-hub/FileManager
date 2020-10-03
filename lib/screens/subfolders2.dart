import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
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

  var dirTextController = TextEditingController();
  changeButtonState() async {
    return Alert(
        context: context,
        title: "New Folder",
        content: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: dirTextController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    gapPadding: MediaQuery.of(context).size.width * 0.08,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  icon: Icon(Icons.folder),
                  labelText: 'Folder Name',
                ),
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () async {
              var directory = Directory(
                  widget.dirName + "/" + dirTextController.text.trim());
              print(directory);
              if (await directory.exists()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => SubFolder2(
                      dirnum: widget.dirnum,
                      dirName: widget.dirName,
                    ),
                  ),
                );
                showToast("Folder is There");
                showToast(directory.path);
              } else {
                final Directory _appDocDirNewFolder =
                    await directory.create(recursive: false);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => SubFolder2(
                      dirnum: widget.dirnum,
                      dirName: widget.dirName,
                    ),
                  ),
                );
                showToast("Folder Created");
                showToast(_appDocDirNewFolder.path);
              }
            },
            child: Text(
              "Create",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                print(widget.dirName);
                // var directory=Dire
                changeButtonState();
                // Directory().
              },
              child: Icon(
                Icons.create_new_folder,
                size: 40,
              ),
            ),
          )
        ],
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
