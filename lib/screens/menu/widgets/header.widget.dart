import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Cubic Flame',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 42, color: Colors.white),
    );
  }
}
