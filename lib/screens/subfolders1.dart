import 'dart:io';
// import 'dart:io' as io;

// import 'package:alert/alert.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
// import 'package:flutter_alert/flutter_alert.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
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
  bool buttonTapped = true;
  // List<Widget> wids = [];
  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
        color: Colors.white, border: Border(left: BorderSide(width: 100)));
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
                    builder: (context) => SubDirs(
                      dirName: widget.dirName,
                    ),
                  ),
                );
                showToast("Folder is There");
                showToast(directory.path);
              } else {
                print("new");
                final Directory _appDocDirNewFolder = await directory
                    .create(recursive: true)
                    .catchError((onError) {
                  print(onError);
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => SubDirs(
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                print(widget.dirName);
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
        title: GestureDetector(
          onTap: () async {
            // await Directory(widget.dirName).
            await Directory(widget.dirName)
                .list(recursive: false)
                .toList()
                .then((value) {
              for (var item in value) {
                print(item.path);
              }
            });
          },
          child: Text(
            widget.dirName.split("/")[widget.dirName.split("/").length - 2],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
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
