import 'package:cubic_flame/core/blocs/level_1.bloc.dart';
import 'package:cubic_flame/game/levels/game_level_1.dart';
import 'package:flutter/material.dart';

class PauseButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Level1Bloc _level1Bloc = Level1Provider.of(context).bloc;

    return FlatButton(
      onPressed: () => _level1Bloc.tooglePause(),
      child: Container(
        height: MediaQuery.of(context).size.height * .04,
        width: MediaQuery.of(context).size.width * .06,
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Container(
                color: Colors.cyanAccent,
              ),
            ),
            SizedBox(width: 10),
            Flexible(
              flex: 1,
              child: Container(
                color: Colors.cyanAccent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
