import 'package:cubic_flame/game/levels/normal/normal.bloc.dart';
import 'package:flutter/material.dart';

class EnemyObject {
  Rect body;
  Paint enemyColor;
  double speed;

  EnemyObject({
    @required double positionX,
    @required double positionY,
    @required Color color,
    @required Size size,
    @required this.speed,
  }) {
    body = Rect.fromLTWH(positionX, positionY, size.width, size.height);
    enemyColor = Paint()..color = color;
  }

  void move({@required double delta}) {
    body = body.translate(
      0,
      speed * delta,
    );
  }

  // TODO: Usando dynamic por conta de dar update no score do bloc que vier
  bool checkDeath({@required Size screenSize, @required bloc}) {
    if (body.top >= screenSize.height) {
      bloc.updateScore(score: 1);
      return true;
    }
    return false;
  }

  /// Função para desenhar o inimigo no canvas
  void render(Canvas canvas) {
    canvas.drawRect(body, enemyColor);
  }
}
