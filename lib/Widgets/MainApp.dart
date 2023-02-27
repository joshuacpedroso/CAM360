import 'package:cam360/Controllers/app_controler.dart';
import 'package:cam360/Widgets/CameraScreen.dart';
import 'package:cam360/Widgets/LoginPage.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData.dark(),
          initialRoute: "/",
          routes: {
            "/": (context) => LoginPage(),
            "/home": (context) => HomePage(),
            "/camera": (context) => CameraScreen(),
          },
        );
      },
      animation: app_controle.instance,
    );
  }
}
