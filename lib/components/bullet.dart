import 'dart:ui';
import 'package:lame_tank_360/lame-tank-360.dart';

class Bullet {
  final LameTank360 game;
  final double speed = 300;
  Offset position;
  double angle = 0;
  bool isOffscreen = false;

  Bullet(this.game, {this.position, this.angle});

  void render(Canvas c) {
    c.save();
    c.translate(position.dx, position.dy);

    // rotate the canvas
    c.rotate(angle);

    c.drawRect(
      Rect.fromLTWH(-10, -3, 16, 6),
      Paint()..color = Color(0xffff0000),
    );

    c.restore();
  }

  void update(double t) {
    if (isOffscreen) {
      return;
    }

    position = position + Offset.fromDirection(angle, speed * t);
    if (position.dx < -50) {
      isOffscreen = true;
    }
    if (position.dx > game.screenSize.width + 50) {
      isOffscreen = true;
    }
    if (position.dy < -50) {
      isOffscreen = true;
    }
    if (position.dy > game.screenSize.height + 50) {
      isOffscreen = true;
    }
  }
}