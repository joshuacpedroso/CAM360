import 'dart:io';
import 'package:flutter_share/flutter_share.dart';
import 'package:permission_handler/permission_handler.dart';

// ...
class Share {
  void shareFile(String filePath) async {
    PermissionStatus permissionStatus = await Permission.storage.request();
    if (permissionStatus.isGranted) {
      print(filePath);
      await FlutterShare.shareFile(
        title: 'Compartilhar vídeo',
        filePath: filePath,
      );
    }
  }
}
