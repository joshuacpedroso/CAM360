import 'dart:io';

import 'package:cam360/Class/SaveGallery.dart';
import 'package:cam360/Class/Share.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:path/path.dart' as path;

class VideoPreviewPage extends StatefulWidget {
  final String videoFile;

  VideoPreviewPage({required this.videoFile});

  @override
  _VideoPreviewPageState createState() => _VideoPreviewPageState();
}

class _VideoPreviewPageState extends State<VideoPreviewPage> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoFile));

    _controller.initialize().then((_) => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    File file;
    String nome;
    return Scaffold(
      body: _controller.value.isInitialized
          ? Stack(
              alignment: Alignment.center,
              children: [
                VideoPlayer(_controller),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _isPlaying = !_isPlaying;
                        if (_isPlaying) {
                          _controller.play();
                        } else {
                          _controller.pause();
                        }
                      });
                    },
                    icon: Container(
                      height: double.infinity,
                      alignment: AlignmentDirectional.center,
                      child: Icon(
                        _isPlaying ? Icons.pause : Icons.play_arrow,
                        size: 32.0,
                        color: Colors.white,
                      ),
                    )),
              ],
            )
          : Container(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        onTap: (value) => {
          if (value == 0)
            {
              file = File(widget.videoFile),
              nome = path.basename(file.path),
              SaveGalerry().Save(widget.videoFile, nome)
            },
          if (value == 1) {Share().shareFile(widget.videoFile)},
        },
        iconSize: 40,
        unselectedFontSize: 20,
        selectedFontSize: 20,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.save_alt,
              ),
              label: "Salvar"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.share,
              ),
              label: "Compartilhar")
        ],
      ),
    );
  }
}
