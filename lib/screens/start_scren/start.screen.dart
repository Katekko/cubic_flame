import 'package:cubic_flame/core/blocs/level_1.bloc.dart';
import 'package:cubic_flame/core/blocs/rank.bloc.dart';
import 'package:cubic_flame/game/levels/game_level_1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Opacity(
            opacity: 1,
            child: Level1Provider(
              bloc: Level1Bloc(),
              rankBloc: RankBloc(),
              child: Level1State(turbo: false, player: false),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Cubic Flame',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 42, color: Colors.white),
                ),
                SizedBox(height: 90),
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(
                      '/game',
                      arguments: false,
                    );
                  },
                  color: Colors.greenAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Text('NORMAL GAME'),
                ),
                SizedBox(height: 20),
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(
                      '/game',
                      arguments: true,
                    );
                  },
                  color: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Text('TURBO GAME'),
                ),
                SizedBox(height: 20),
                RaisedButton(
                  onPressed: () => Navigator.of(context).pushNamed('/rank'),
                  color: Colors.yellowAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Text('LEADERBOARD'),
                ),
                SizedBox(height: 20),
                RaisedButton(
                  onPressed: () => Navigator.of(context).pushNamed('/store'),
                  color: Colors.deepOrangeAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: 'GameFont',
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'STORE\n',
                        ),
                        TextSpan(
                          text: 'comming soon',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black.withOpacity(.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
