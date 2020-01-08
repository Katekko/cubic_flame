import 'package:cubic_flame/core/blocs/level_1.bloc.dart';
import 'package:cubic_flame/core/blocs/rank.bloc.dart';
import 'package:flutter/foundation.dart';

class RestartGameModel {
  final Level1Bloc bloc;
  final RankBloc rankBloc;
  final bool turbo;
  RestartGameModel({
    @required this.bloc,
    @required this.rankBloc,
    @required this.turbo,
  });
}
