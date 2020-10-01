import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vidfiles/screens/subfolders1.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String directory;
  List file = new List();
  List listofStorages = [];
  var systemTempDir = Directory.systemTemp;

  @override
  void initState() {
    super.initState();
    permissionstatus();
    getlistofdirs();
  }

  permissionstatus() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
  }

  getlistofdirs() {
    getExternalStorageDirectories().then((value) {
      List pathInternal = value[0].path.split("/");
      print(value);
      setState(() {
        listofStorages.clear();
      });

      String internalStoragepath = "/" +
          pathInternal[0] +
          pathInternal[1] +
          "/" +
          pathInternal[2] +
          "/" +
          pathInternal[3] +
          "/";

      List pathSdcard = value[1].path.split("/");
      String externalPath =
          "/" + pathSdcard[0] + pathSdcard[1] + "/" + pathSdcard[2] + "/";
      print(internalStoragepath);
      print(externalPath);

      setState(() {
        listofStorages.add(internalStoragepath);
        listofStorages.add(externalPath);
      });
    });
    print(listofStorages);
  }

  getlistofdirsInternal() {
    getExternalStorageDirectories().then((value) {
      print(value);
      List path = value[0].path.split("/");
      print(path);
      String internalStoragepath =
          "/" + path[0] + path[1] + "/" + path[2] + "/" + path[3] + "/";
      print(internalStoragepath);
      Directory dir = Directory(internalStoragepath);
      print(dir.listSync());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          centerTitle: true,
          title: Text("File Manager"),
        ),
        body: Container(
          child: Center(
            child: new GridView.builder(
              itemCount: listofStorages.length,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                // String type=
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => SubDirs(
                          dirName: listofStorages[index],
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Image.asset("images/folder.png"),
                    subtitle: Text(listofStorages[index]),
                  ),
                );
              },
            ),
          ),
        ));
  }
}
