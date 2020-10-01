import 'dart:io';

import 'package:flutter/material.dart';

class ListTileWidFile extends StatelessWidget {
  const ListTileWidFile({
    Key key,
    @required this.item,
    @required this.dirnum,
  }) : super(key: key);

  final FileSystemEntity item;
  final int dirnum;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Image.asset("images/file.png"),
      subtitle: Text(item.path.split("/")[item.path.split("/").length - 1]),
    );
  }
}
