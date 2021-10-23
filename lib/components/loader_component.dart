import 'package:flutter/material.dart';

class loaderComponents extends StatelessWidget {
  final String text;
  loaderComponents({this.text = ""});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 300,
        decoration: BoxDecoration(
          color: Colors.red[100],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/loader.gif'),
            Text(
              text,
              style: TextStyle(
                fontSize: 20,
                decorationColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
