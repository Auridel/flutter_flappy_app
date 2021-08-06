import 'dart:ui' as UI;
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flappy_app/screens/flappy_game.dart';

void main() async {
  FlappyGame game = FlappyGame();
  Flame.device.fullScreen();
  Flame.device.setOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  final images = await Flame.images.loadAll(<String>[
    'assets/images/bg.png',
    'assets/images/bird.png',
    'assets/images/fbPipeBottom.png',
    'assets/images/fbPipeTop.png',
  ]);
  game.imagesList = images;
  runApp(GameWidget(game: game));

}

