import 'package:cubic_flame/game/hud/score.widget.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'normal.bloc.dart';
import 'normal.level.dart';

class NormalGameState extends StatefulWidget {
  final bool demo;
  NormalGameState({this.demo = false});

  @override
  _NormalGameState createState() => _NormalGameState();
}

class _NormalGameState extends State<NormalGameState>
    with WidgetsBindingObserver {
  NormalGameBloc _bloc;

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addObserver(this);
    Flame.util.fullScreen();
    _bloc = Provider.of(context);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Size>(
      future: Flame.util.initialDimensions(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Size screenSize = snapshot.data;
          NormalLevel game = NormalLevel(
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
