import 'package:flutter/material.dart';

class PlayerObject {
  Rect body;
  Paint playerColor;
  bool dead = false;

  PlayerObject({
    @required double positionX,
    @required double positionY,
    @required Color color,
    @required Size size,
  }) {
    body = Rect.fromLTWH(positionX, positionY, size.width, size.height);
    playerColor = Paint()..color = color;
  }

  /// Função para desenhar o player no canvas
  void render(Canvas canvas) {
    canvas.drawRect(body, playerColor);
  }
}
