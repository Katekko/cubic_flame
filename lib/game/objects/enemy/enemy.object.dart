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

  /// Função para desenhar o inimigo no canvas
  void render(Canvas canvas) {
    canvas.drawRect(body, enemyColor);
  }
}
