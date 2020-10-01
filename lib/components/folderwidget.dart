import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vidfiles/screens/subfolders2.dart';

class ListTileWidFolder extends StatelessWidget {
  const ListTileWidFolder({
    Key key,
    @required this.item,
    @required this.dirnum,
    @required this.context,
    @required this.widget,
  }) : super(key: key);

  final FileSystemEntity item;
  final int dirnum;
  final BuildContext context;
  final widget;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Card(
          child: ListTile(
            // shape: ShapeBorder.lerp(ShapeBorder(, b, t),
            title: Image.asset(
              "images/folder2.png",
              scale: 6,
            ),
            subtitle: Text(
                item.path.split("/")[item.path.split("/").length - 1],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => SubFolder2(
                dirnum: dirnum,
                dirName: widget.dirName +
                    "/" +
                    item.path.split("/")[item.path.split("/").length - 1],
              ),
            ),
          );
        });
  }
}
