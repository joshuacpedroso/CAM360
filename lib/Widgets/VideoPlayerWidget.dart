import 'dart:io';
import 'package:cam360/Controllers/app_controler.dart';
import 'package:cam360/Widgets/VideoPreviewPage.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

import 'CameraScreen.dart';

class VideoPlayerWidget extends StatefulWidget {
  final File videoFile;

  const VideoPlayerWidget({Key? key, required this.videoFile})
      : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.file(widget.videoFile);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoInitialize: true,
      autoPlay: false,
      showControls: false,
      looping: false,

      aspectRatio: 9 / 9, // defina a proporção do vídeo aqui
    );
  }

  @override
  void dispose() {
    _chewieController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {
              app_controle.instance.changeWidget(
                  VideoPreviewPage(videoFile: widget.videoFile.path))
            },
        child: Container(
          child: Chewie(controller: _chewieController),
          padding: EdgeInsets.only(bottom: 13),
        ));
  }
}
