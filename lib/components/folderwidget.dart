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
        child: ListTile(
          title: Image.asset("images/folder.png"),
          subtitle: Text(item.path.split("/")[item.path.split("/").length - 1]),
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
