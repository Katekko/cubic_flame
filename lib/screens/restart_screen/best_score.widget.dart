import 'package:flutter/material.dart';

class BestScoreWidget extends StatelessWidget {
  final int bestScore;
  const BestScoreWidget({@required this.bestScore});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          flex: 4,
          child: Text(
            'Your best score:',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
        Flexible(
          flex: 3,
          child: Text(
            ' $bestScore',
            style: TextStyle(fontSize: 30, color: Colors.pinkAccent),
          ),
        ),
        SizedBox(width: 20),
      ],
    );
  }
}
