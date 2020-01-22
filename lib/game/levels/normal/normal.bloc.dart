import 'package:cubic_flame/game/levels/normal/normal.level.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'normal.bloc.g.dart';

class NormalGameBloc = _NormalGameBloc with _$NormalGameBloc;

abstract class _NormalGameBloc with Store {
  ReactionDisposer disposeUpdateDifficult;
  int auxDifficult = 0;
  ReactionDisposer disposePause;

  @observable
  bool pause = false;

  @observable
  int score = 0;

  @observable
  bool updateDifficult;

  @action
  void pauseGame({@required bool pause}) => this.pause = pause;

  @action
  void updateScore({@required int score}) {
    this.score += score;
    if (auxDifficult == 10) {
      updateDifficult = true;
      auxDifficult = 0;
    }
    auxDifficult++;
  }

  void updateDifficultRegister(NormalLevel level) {
    disposeUpdateDifficult = reaction(
      (_) => updateDifficult,
      (update) {
        if (update) {
          level.updateDifficult();
          updateDifficult = false;
        }
      },
    );
  }

  void pauseGameRegister(NormalLevel level) {
    disposePause = reaction(
      (_) => pause,
      (pause) {
        level.pause(pause);
      },
    );
  }

  void dispose() {
    disposeUpdateDifficult();
    disposePause();
  }
}
