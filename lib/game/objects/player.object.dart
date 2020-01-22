import 'package:flutter/material.dart';

import 'enemy.object.dart';

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

  void move({@required Size screenSize, @required delta}) {
    if (body.left > .1 &&
        body.right < screenSize.width &&
        body.top > .1 &&
        body.bottom < screenSize.height) {
      body = body.shift(delta);
    } else if (body.left <= .1) {
      body = body.translate(5, 0);
    } else if (body.right >= screenSize.width) {
      body = body.translate(-5, 0);
    } else if (body.top <= .1) {
      body = body.translate(0, 5);
    } else if (body.bottom >= screenSize.height) {
      body = body.translate(0, -5);
    }
  }

  void checkMapLimit({@required Size screenSize}) {
    if (body.left > .1 &&
        body.right < screenSize.width &&
        body.top > .1 &&
        body.bottom < screenSize.height) {
    } else if (body.left <= .1) {
      body = body.translate(5, 0);
    } else if (body.right >= screenSize.width) {
      body = body.translate(-5, 0);
    } else if (body.top <= .1) {
      body = body.translate(0, 5);
    } else if (body.bottom >= screenSize.height) {
      body = body.translate(0, -5);
    }
  }

  bool checkColision(EnemyObject enemy) {
    if (body.overlaps(enemy.body)) {
      dead = true;
      return true;
    }
    return false;
  }

  /// Função para desenhar o player no canvas
  void render(Canvas canvas) {
    canvas.drawRect(body, playerColor);
  }
}
