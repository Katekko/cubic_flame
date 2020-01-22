import 'package:flutter/material.dart';

class HeaderTextWidget extends StatelessWidget {
  const HeaderTextWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'To submit your score to leaderboard, please do the login first!',
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white),
    );
  }
}
