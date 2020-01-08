import 'package:flutter/material.dart';

class InfoMatchWidget extends StatelessWidget {
  final int score;
  const InfoMatchWidget({@required this.score});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          flex: 4,
          child: Text(
            'Your score now: ',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
        Flexible(
          flex: 3,
          child: Text(
            ' $score',
            style: TextStyle(fontSize: 30, color: Colors.purpleAccent),
          ),
        ),
      ],
    );
  }
}
