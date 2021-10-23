import 'package:flutter/material.dart';
import 'package:harry_potter_app/components/loader_component.dart';

class WaitScreen extends StatelessWidget {
  const WaitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: loaderComponents(
      text: 'Por favor espere....',
    ));
  }
}
