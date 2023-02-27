import 'package:cam360/Controllers/app_controler.dart';
import 'package:cam360/Widgets/CameraScreen.dart';
import 'package:cam360/Widgets/galery.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) => {
            if (value == 0) {app_controle.instance.changeWidget(galery())},
            if (value == 1)
              {app_controle.instance.changeWidget(CameraScreen())},
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.browse_gallery), label: "Galeria"),
            BottomNavigationBarItem(icon: Icon(Icons.camera), label: "Camera"),
          ],
        ),
        body: Container(
          child: Navigator(
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) => app_controle.instance.tela,
              );
            },
          ),
        ));
  }
}
