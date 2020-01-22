import 'package:cubic_flame/game/levels/normal/normal.bloc.dart';
import 'package:cubic_flame/game/levels/normal/normal.state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameDemoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => NormalGameBloc(),
      child: NormalGameState(demo: true),
    );
  }
}
