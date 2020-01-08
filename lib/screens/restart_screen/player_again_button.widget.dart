import 'package:cubic_flame/core/blocs/level_1.bloc.dart';
import 'package:flutter/material.dart';

class PlayAgainButtonWidget extends StatelessWidget {
  final Level1Bloc bloc;
  final bool turbo;
  const PlayAgainButtonWidget({@required this.bloc, @required this.turbo});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        bloc.resetPlayer();
        Navigator.of(context).popAndPushNamed(
          '/game',
          arguments: turbo,
        );
      },
      color: Colors.blue[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * .6,
        height: 30,
        child: Center(
          child: Text(
            'PLAY AGAIN',
            style: TextStyle(fontSize: 22),
          ),
        ),
      ),
    );
  }
}
