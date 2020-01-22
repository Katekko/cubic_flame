import 'package:cubic_flame/game/levels/turbo/turbo.level.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'turbo.bloc.g.dart';

class TurboGameBloc = _TurboGameBloc with _$TurboGameBloc;

abstract class _TurboGameBloc with Store {
  ReactionDisposer disposeUpdateDifficult;
  int auxDifficult = 0;
  ReactionDisposer disposePause;


  @observable
  bool pause = false;

  @observable
  int score = 0;

  @observable
  bool updateDifficult;

  @observable
  bool playerDead;

  @action
  void pauseGame({@required bool pause}) => this.pause = pause;

  @action
  void updateScore({@required int score}) {
    this.score += score;
    if (auxDifficult == 10) {
      updateDifficult = true;
    }
    auxDifficult++;
  }

  void updateDifficultRegister(TurboLevel level) {
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

  void pauseGameRegister(TurboLevel level) {
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
