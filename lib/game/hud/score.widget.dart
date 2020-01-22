import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ScoreWidget extends StatelessWidget {
  final bloc;
  ScoreWidget({@required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return Container(
          child: Text(
            bloc.score.toString(),
            style: TextStyle(
              fontSize: 33,
              color: Colors.white,
              fontFamily: 'GameFont',
              decoration: TextDecoration.none,
            ),
          ),
        );
      },
    );
  }
}
