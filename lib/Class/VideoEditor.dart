import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:flutter_ffmpeg/media_information.dart';
import 'package:path_provider/path_provider.dart';

class VideoEditor {
  FlutterFFmpeg _flutterFFmpeg = FlutterFFmpeg();

  Future<String> addImageToVideo(String videoPath, String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final now = DateTime.now();
    final random = Random();
    final randomName =
        '${now.year}_${now.month}_${now.day}_${now.hour}_${now.minute}_${now.second}_${random.nextInt(1000)}';
    final outputFilePath = '${directory.path}/$randomName.mp4';

    final command =
        '-i $videoPath -i $imagePath -filter_complex "overlay=W-w-10:H-h-10" $outputFilePath';

    final result = await _flutterFFmpeg.execute(command);

    if (result == 0) {
      return outputFilePath;
    } else {
      throw Exception('falhou');
    }
  }
}
