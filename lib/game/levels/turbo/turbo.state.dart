import 'package:cubic_flame/game/hud/score.widget.dart';
import 'package:cubic_flame/infra/navigation/routes.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import 'turbo.bloc.dart';
import 'turbo.level.dart';

class TurboGameState extends StatefulWidget {
  final bool demo;
  TurboGameState({this.demo = false});

  @override
  _TurboGameState createState() => _TurboGameState();
}

class _TurboGameState extends State<TurboGameState>
    with WidgetsBindingObserver {
  ReactionDisposer disposePlayerDead;
  TurboGameBloc _bloc;

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addObserver(this);
    Flame.util.fullScreen();
    _bloc = Provider.of(context);

    disposePlayerDead = reaction(
      (_) => _bloc.playerDead,
      (dead) {
        if (dead) {
          Navigator.of(context).pushReplacementNamed(Routes.GAME_OVER);
        }
      },
    );

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    disposePlayerDead();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
        _bloc.pauseGame(pause: true);
        break;
      case AppLifecycleState.resumed:
        _bloc.pauseGame(pause: false);
        break;
      default:
        _bloc.pauseGame(pause: true);
    }
  }

  void gameOver() {}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Size>(
      future: Flame.util.initialDimensions(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Size screenSize = snapshot.data;
          TurboLevel game = TurboLevel(
            screenSize: screenSize,
            bloc: _bloc,
            demo: !widget.demo,
          );
          return GestureDetector(
            onPanUpdate: (details) {
              game.onPlayerMove(details.delta);
            },
            child: Stack(
              children: <Widget>[
                game.widget,
                !widget.demo
                    ? Positioned(
                        top: 20,
                        left: 20,
                        child: ScoreWidget(bloc: _bloc),
                      )
                    : SizedBox(),
              ],
            ),
          );
        }
        return Center();
      },
    );
  }
}
