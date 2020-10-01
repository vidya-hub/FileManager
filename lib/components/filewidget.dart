import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:vidfiles/constants/fileimages.dart';

class ListTileWidFile extends StatelessWidget {
  const ListTileWidFile({
    @required this.item,
    @required this.dirnum,
  });

  final FileSystemEntity item;
  final int dirnum;

  @override
  Widget build(BuildContext context) {
    String type = item.path
        .split(".")[item.path.split(".").length - 1]
        .toString()
        .toLowerCase();
    // FileImages().imagesMap
    bool imagPath = FileImages().imagesMap.containsKey(type);
    return GestureDetector(
      onTap: () {
        // print(item);
        // OpenFile.open(item.toString());
      },
      child: Card(
        child: ListTile(
          title: !imagPath
              ? Image.asset(
                  "images/file.png",
                  scale: 6,
                )
              : Image.asset(
                  FileImages().imagesMap[type],
                  scale: 6,
                ),
          subtitle: Text(item.path.split("/")[item.path.split("/").length - 1],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ),
      ),
    );
  }
}
