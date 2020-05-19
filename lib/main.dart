import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lame_tank_360/lame-tank-360.dart';
import 'package:lame_tank_360/widgets/button.dart';
import 'package:lame_tank_360/widgets/joypad.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 设置屏幕方向(设置屏幕方向为横向)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // 禁止所有UI层(设置全屏)
  await SystemChrome.setEnabledSystemUIOverlays([]);

  // 先初始化game
  final LameTank360 game = LameTank360();

  // 运行APP
  runApp(
    Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          // 为游戏提供占位符
          game.widget,
          // 摇杆层
          Column(
            children: [
              Spacer(),
              Row(
                children: [
                  SizedBox(width: 48),
                  Button(
                    onTap: game.onButtonTap,
                  ),
                  Spacer(),
                  Button(
                    onTap: game.onButtonTap,
                  ),
                  SizedBox(width: 48),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 48),
                  Joypad(
                    onChange: game.onLeftJoypadChange,
                  ),
                  Spacer(),
                  Joypad(
                    onChange: game.onRightJoypadChange,
                  ),
                  SizedBox(width: 48),
                ],
              ),
              SizedBox(height: 24),
            ],
          ),
        ],
      ),
    ),
  );
}
