import 'dart:io';
import 'package:cam360/Widgets/VideoPlayerWidget.dart';
import 'package:cam360/Widgets/VideoPreviewPage.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class galery extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return galeryState();
  }
}

class galeryState extends State<galery> {
  @override
  Widget build(BuildContext context) {
    Future<dynamic> getData() async {
      final dir = await getApplicationDocumentsDirectory();
      final mp4Files = dir
          .listSync()
          .whereType<File>()
          .where((file) => path.extension(file.path) == '.mp4')
          .toList();
      return mp4Files;
    }

    return Scaffold(
        body: Center(
      child: FutureBuilder<dynamic>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            final videoFiles = snapshot.data!;

            return GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.only(
                  top: 50.0, left: 8.0, right: 8.0, bottom: 8.0),
              children: [
                for (final videoFile in videoFiles)
                  VideoPlayerWidget(
                    videoFile: videoFile,
                  ),
              ],
            );
          } else {
            print(snapshot.hasData);
            return CircularProgressIndicator();
          }
        },
      ),
    ));
  }
}

class pegar {
  pegar2() async {
    final dir = Directory("${await getApplicationDocumentsDirectory()}/");
    final mp4Files = dir
        .listSync()
        .whereType<File>()
        .where((file) => path.extension(file.path) == '.mp4');
    for (final file in mp4Files) {
      print(file.path);
    }
  }
}
