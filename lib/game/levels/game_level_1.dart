import 'dart:async';
import 'dart:math';

import 'package:cubic_flame/core/blocs/level_1.bloc.dart';
import 'package:cubic_flame/core/blocs/rank.bloc.dart';
import 'package:cubic_flame/core/models/restart_game.model.dart';
import 'package:cubic_flame/game/hud/score/score.widget.dart';
import 'package:cubic_flame/game/objects/enemy/enemy.object.dart';
import 'package:cubic_flame/game/objects/player/player.object.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/time.dart';
import 'package:flutter/material.dart';

class Level1Provider extends InheritedWidget {
  final Level1Bloc bloc;
  final RankBloc rankBloc;

  Level1Provider({
    @required Widget child,
    @required this.bloc,
    @required this.rankBloc,
  }) : super(child: child);

  @override
  bool updateShouldNotify(Level1Provider oldWidget) => bloc != oldWidget.bloc;

  static Level1Provider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType();
}

class Level1State extends StatefulWidget {
  final bool turbo;
  final bool player;
  Level1State({@required this.turbo, this.player = true});

  @override
  _Level1StateState createState() => _Level1StateState();
}

class _Level1StateState extends State<Level1State> with WidgetsBindingObserver {
  Level1Bloc _level1Bloc;
  RankBloc _rankBloc;

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addObserver(this);
    Flame.util.fullScreen();
    _level1Bloc = Level1Provider.of(context).bloc;
    _rankBloc = Level1Provider.of(context).rankBloc;

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
        _level1Bloc.pauseGame(pause: true);
        break;
      case AppLifecycleState.resumed:
        _level1Bloc.pauseGame(pause: false);
        break;
      default:
        _level1Bloc.pauseGame(pause: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    _level1Bloc.fillBestScore();
    _level1Bloc.playerDeadStream.listen((dead) {
      if (dead)
        Navigator.of(context).pushReplacementNamed(
          '/dead-screen',
          arguments: RestartGameModel(
            bloc: _level1Bloc,
            rankBloc: _rankBloc,
            turbo: widget.turbo,
          ),
        );
    });

    return FutureBuilder<Size>(
      future: Flame.util.initialDimensions(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Size screenSize = snapshot.data;
          _Level1Game game = _Level1Game(
            screenSize: screenSize,
            bloc: _level1Bloc,
            turbo: widget.turbo,
            playerGame: widget.player,
          );
          return GestureDetector(
            onPanUpdate: (details) {
              game.onPlayerMove(details.delta);
            },
            child: Stack(
              children: <Widget>[
                game.widget,
                widget.player
                    ? Positioned(
                        top: 20,
                        left: 20,
                        child: ScoreWidget(),
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

class _Level1Game extends BaseGame {
  final Level1Bloc bloc;
  final Size screenSize;
  Random random;
  Timer enemyCreator;
  bool turbo;
  bool playerGame;

  /// Player
  PlayerObject player;

  /// Lista de inimigos
  List<EnemyObject> enemies = List();
  double enemySpeed = 400;
  double spawnCount = 1;

  bool pauseGame = false;
  bool justResumed = false;

  _Level1Game({
    @required this.screenSize,
    @required this.bloc,
    @required this.turbo,
    @required this.playerGame,
  }) {
    random = Random();

    enemyCreator =
        Timer(spawnCount, repeat: true, callback: () => createEnemy());

    enemyCreator.start();

    bloc.upgradeDifficultyStream.listen((upgrade) {
      if (upgrade) {
        if (turbo) {
          enemySpeed = 500;
          spawnCount = 0.17;
          enemyCreator =
              Timer(spawnCount, repeat: true, callback: () => createEnemy());

          enemyCreator.start();
        } else {
          enemySpeed *= 1.01;
          if (spawnCount >= .3) {
            /// Startando o timer para criar os inimigos
            enemyCreator = Timer(
              spawnCount,
              repeat: true,
              callback: () => createEnemy(),
            );

            spawnCount -= .1;

            enemyCreator.start();
          }
        }
      } else {
        enemySpeed = 400;
        spawnCount = 1;
        enemies = List();
      }
    });

    bloc.pauseStream.listen((pause) {
      if (pause) {
        enemyCreator.stop();
      } else {
        enemyCreator =
            Timer(spawnCount, repeat: true, callback: () => createEnemy());
        enemyCreator.start();
        justResumed = true;
      }
      pauseGame = pause;
    });

    /// Instanciando o player

    if (playerGame) {
      player = PlayerObject(
        positionX: screenSize.width / 2,
        positionY: screenSize.height / 2,
        size: Size(screenSize.width * .1, screenSize.height * .057),
        color: Colors.white,
      );
    }
  }

  /// Função para criar um inimigo
  void createEnemy() {
    enemies.add(
      EnemyObject(
        positionX: (screenSize.width - 70) * random.nextDouble(),
        positionY: 0,
        size: Size(screenSize.width * .12, screenSize.height * .067),
        color: Colors.red,
        speed: enemySpeed,
      ),
    );
  }

  /// Função para mover o player quando chamada
  void onPlayerMove(Offset delta) {
    if (player.body.left > .1 &&
        player.body.right < screenSize.width &&
        player.body.top > .1 &&
        player.body.bottom < screenSize.height) {
      player.body = player.body.shift(delta);
    } else if (player.body.left <= .1) {
      player.body = player.body.translate(5, 0);
    } else if (player.body.right >= screenSize.width) {
      player.body = player.body.translate(-5, 0);
    } else if (player.body.top <= .1) {
      player.body = player.body.translate(0, 5);
    } else if (player.body.bottom >= screenSize.height) {
      player.body = player.body.translate(0, -5);
    }
  }

  void checkPlayerColision() {
    enemies.forEach((enemy) {
      if (player.body.overlaps(enemy.body)) {
        player.dead = true;
        enemies = List();
      }
    });
  }

  @override
  void update(double dt) async {
    if (!pauseGame) {
      if (!playerGame || !player.dead) {
        if (justResumed) {
          dt = 0;
          justResumed = false;
        }

        enemyCreator.update(dt);

        /// Movendo o inimigo
        enemies.forEach((enemy) {
          enemy.body = enemy.body.translate(
            0,
            enemy.speed * dt,
          );
        });

        /// Removendo o inimigo quando sai da tela
        enemies.removeWhere((enemy) {
          if (enemy.body.top >= screenSize.height) {
            bloc.updateScore(1);
            return true;
          }
          return false;
        });

        if (playerGame) {
          if (player.body.left > .1 &&
              player.body.right < screenSize.width &&
              player.body.top > .1 &&
              player.body.bottom < screenSize.height) {
          } else if (player.body.left <= .1) {
            player.body = player.body.translate(5, 0);
          } else if (player.body.right >= screenSize.width) {
            player.body = player.body.translate(-5, 0);
          } else if (player.body.top <= .1) {
            player.body = player.body.translate(0, 5);
          } else if (player.body.bottom >= screenSize.height) {
            player.body = player.body.translate(0, -5);
          }

          checkPlayerColision();

          if (player.dead) {
            bloc.setPlayerDead(true);
            player.dead = false;
            await Future.delayed(Duration(seconds: 3), () => '1');
          }
        }
      }
    }
  }

  /// Função para renderizar os objetos na tela
  @override
  void render(Canvas canvas) {
    if (playerGame) {
      player.render(canvas);
    }

    enemies.forEach((enemy) {
      enemy.render(canvas);
    });
  }
}
