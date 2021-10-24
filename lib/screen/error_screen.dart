import 'dart:ffi';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:harry_potter_app/components/loader_component.dart';
import 'package:harry_potter_app/main.dart';
import 'package:harry_potter_app/screen/error_screen.dart';
import 'package:harry_potter_app/screen/list_character_screen.dart';
import 'package:harry_potter_app/screen/wait_screen.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  _ErrorScreenState createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          body: Container(
        child: Container(
          child: Stack(children: <Widget>[
            Image(
              image: AssetImage('assets/error.gif'),
            ),
            Center(
              child: Text(
                'No hay conexion a internet',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          ]),
        ),
      )),
    );
  }
}
