import 'package:cubic_flame/core/blocs/level_1.bloc.dart';
import 'package:cubic_flame/game/levels/game_level_1.dart';
import 'package:flutter/material.dart';

class ScoreWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Level1Bloc _level1Bloc = Level1Provider.of(context).bloc;

    return StreamBuilder<int>(
      stream: _level1Bloc.playerScoreStream,
      initialData: 0,
      builder: (context, AsyncSnapshot<int> snapshot) {
        return Container(
          child: Text(
            snapshot.data.toString(),
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
