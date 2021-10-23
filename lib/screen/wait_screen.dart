import 'package:flutter/material.dart';
import 'package:harry_potter_app/components/loader_component.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:harry_potter_app/components/loader_component.dart';
import 'package:harry_potter_app/screen/error_screen.dart';
import 'package:harry_potter_app/screen/list_character_screen.dart';
import 'package:harry_potter_app/screen/wait_screen.dart';

class WaitScreen extends StatefulWidget {
  const WaitScreen({Key? key}) : super(key: key);

  @override
  _WaitScreenState createState() => _WaitScreenState();
}

class _WaitScreenState extends State<WaitScreen> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    _isLoading ? loaderComponents(text: "Por favor espere") : Container();
    return _getConnection() == true ? ListCharacterScreen() : ErrorScreen();
  }

  Future<bool> _getConnection() async {
    var cocnectcityResult = await Connectivity().checkConnectivity();

    if (cocnectcityResult == ConnectivityResult.none) {
      return false;
    }
    return true;
  }
}
