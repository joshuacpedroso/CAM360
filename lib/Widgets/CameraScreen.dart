import 'dart:async';
import 'dart:io';

import 'package:cam360/Class/VideoEditor.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

import '../Controllers/app_controler.dart';
import 'VideoPreviewPage.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late XFile _videoFile;
  late bool _isRecording = false;

  @override
  void initState() {
    super.initState();

    _initializeControllerFuture = _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    List<CameraDescription> cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.veryHigh);
    _initializeControllerFuture = _controller.initialize();
  }

  Future<void> _startRecording() async {
    try {
      await _initializeControllerFuture;

      await _controller.startVideoRecording();
      setState(() {
        _isRecording = true;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _stopRecording() async {
    try {
      XFile file = await _controller.stopVideoRecording();
      setState(() {
        _isRecording = false;
      });
      VideoEditor()
          .addImageToVideo(file.path,
              'https://www.tailorbrands.com/wp-content/uploads/2020/07/mcdonalds-logo.jpg')
          .then((outputFilePath) {
        app_controle.instance
            .changeWidget(VideoPreviewPage(videoFile: outputFilePath));
      }).catchError((error) {
        // Tratar o erro
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                CameraPreview(_controller),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: FloatingActionButton(
                      onPressed:
                          _isRecording ? _stopRecording : _startRecording,
                      child: Icon(_isRecording
                          ? Icons.stop
                          : Icons.fiber_manual_record),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
