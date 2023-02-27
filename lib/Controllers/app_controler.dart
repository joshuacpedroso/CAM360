import 'package:cam360/Widgets/CameraScreen.dart';
import 'package:cam360/Widgets/galery.dart';
import 'package:flutter/material.dart';

class app_controle extends ChangeNotifier {
  static app_controle instance = app_controle();
  Widget tela = galery();

  changeWidget(Widget tela) {
    this.tela = tela;
    Future.delayed(Duration.zero, () {
      notifyListeners();
    });
  }
}
