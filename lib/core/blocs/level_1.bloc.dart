import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:cubic_flame/config.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Level1Bloc {
  final ConfigEnvironments _config = ConfigEnvironments();

  final _playerDeadController = BehaviorSubject<bool>();
  Observable<bool> get playerDeadStream => _playerDeadController.stream;

  final _playerScoreController = BehaviorSubject<int>.seeded(1);
  Observable<int> get playerScoreStream => _playerScoreController.stream;
  int get playerScore => _playerScoreController.value;

  final _upgradeDifficultyController = BehaviorSubject<bool>.seeded(false);
  Observable<bool> get upgradeDifficultyStream =>
      _upgradeDifficultyController.stream;

  final _nameController = BehaviorSubject<String>();
  Observable<String> get nameStream => _nameController.stream;

  final _pauseController = BehaviorSubject<bool>.seeded(false);
  Observable<bool> get pauseStream => _pauseController.stream;

  int bestScore = 0;
  String hashScore = '';

  void fillBestScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('bestScoreRight4')) {
      bestScore = prefs.getInt('bestScoreRight4');
    } else {
      bestScore = 0;
    }
  }

  void setPlayerDead(bool dead) async {
    if (dead) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey('bestScoreRight4') ||
          playerScore > prefs.getInt('bestScoreRight4')) {
        prefs.setInt('bestScoreRight4', playerScore);
        bestScore = playerScore;
      }

      final ambiente = _config.getEnvironments();
      hashScore = md5
          .convert(utf8.encode(bestScore.toString() + ambiente['secret']))
          .toString();
    }
    _playerDeadController.add(dead);
  }

  void updateScore(int score) {
    _playerScoreController.add(_playerScoreController.value + score);
    if (_playerScoreController.value % 10 == 0) {
      _updateDificult();
    }
  }

  void _updateDificult() {
    _upgradeDifficultyController.add(true);
  }

  void resetPlayer() {
    _playerScoreController.add(0);
    _upgradeDifficultyController.add(false);
    _playerDeadController.add(false);
  }

  void pauseGame({@required bool pause}) {
    _pauseController.add(pause);
  }

  void tooglePause() {
    if (_pauseController.value) {
      _pauseController.add(false);
    } else {
      _pauseController.add(true);
    }
  }

  void dispose() {
    _playerDeadController.close();
    _playerScoreController.close();
    _upgradeDifficultyController.close();
    _nameController.close();
  }
}
