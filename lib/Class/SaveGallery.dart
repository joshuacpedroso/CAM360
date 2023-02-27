import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class SaveGalerry {
  Save(String videoPath, String nome) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    if (await Permission.storage.isGranted) {
      print("Foi");
      final String videoDir = '${directory.path}/${nome}.mp4';

      await File(videoPath).copy(videoDir);

      await GallerySaver.saveVideo(videoDir);
    } else {
      Permission.storage.request();
    }
  }
}
