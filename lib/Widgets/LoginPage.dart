import 'dart:ffi';

import 'package:cam360/Widgets/HomePage.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  String email = "";
  String senha = "";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(15),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextField(
          onChanged: (value) {
            email = value;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Email',
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        Container(
          height: 30,
        ),
        TextField(
          obscureText: true,
          onChanged: (value) {
            senha = value;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Senha',
          ),
          keyboardType: TextInputType.visiblePassword,
        ),
        ElevatedButton(
            onPressed: () {
              login(context);
            },
            child: Text("Entrar"))
      ]),
    ));
  }

  login(BuildContext context) {
    print(email + senha);
    Navigator.of(context).pushReplacementNamed("/home");
  }
}
