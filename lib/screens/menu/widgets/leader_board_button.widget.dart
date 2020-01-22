import 'package:flutter/material.dart';

class LeaderBoardButtonWidget extends StatelessWidget {
  const LeaderBoardButtonWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () => Navigator.of(context).pushNamed('/rank'),
      color: Colors.yellowAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text('LEADERBOARD'),
    );
  }
}
