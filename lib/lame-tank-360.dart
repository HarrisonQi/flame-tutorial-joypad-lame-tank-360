import 'dart:ui';
import 'package:flame/game.dart';
import 'package:lame_tank_360/components/tank.dart';
import 'package:lame_tank_360/components/bullet.dart';

class LameTank360 extends Game {
  Size screenSize;
  Tank tank;
  List<Bullet> bullets;

  @override
  void render(Canvas c) {
    if (screenSize == null) {
      // 如果screenSize为null, 直接结束执行即可.
      return;
    }

    // 绘制草坪
    c.drawRect(
      Rect.fromLTWH(
        0,
        0,
        screenSize.width,
        screenSize.height,
      ),
      Paint()..color = Color(0xff27ae60),
    );

    // 绘制坦克
    tank.render(c);

    // 绘制子弹
    bullets.forEach((Bullet b) {
      b.render(c);
    });
  }

  @override
  void update(double t) {
    if (screenSize == null) {
      // 如果screenSize为null, 直接结束执行即可.
      return;
    }

    tank.update(t);

    // 让子弹飞
    bullets.forEach((Bullet b) {
      b.update(t);
    });

    // 移除飞出屏幕的子弹
    bullets.removeWhere((Bullet b) {
      return b.isOffscreen;
    });
  }

  void onLeftJoypadChange(Offset offset) {
    if (offset == Offset.zero) {
      tank.targetBodyAngle = null;
    } else {
      tank.targetBodyAngle = offset.direction;
    }
  }

  void onRightJoypadChange(Offset offset) {
    if (offset == Offset.zero) {
      tank.targetTurretAngle = null;
    } else {
      tank.targetTurretAngle = offset.direction;
    }
  }

  @override
  void resize(Size size) {
    screenSize = size;

    if (tank == null) {
      tank = Tank(
        this,
        position: Offset(
          screenSize.width / 2,
          screenSize.height / 2,
        ),
      );
    }

    if (bullets == null) {
      bullets = List();
    }
  }

  void onButtonTap() {
    bullets.add(
      Bullet(
        this,
        position: tank.getBulletOffset(),
        angle: tank.getBulletAngle(),
      ),
    );
  }
}