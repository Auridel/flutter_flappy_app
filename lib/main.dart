import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flappy_app/screens/flappy_game.dart';

void main() async {
  FlappyGame game = FlappyGame();
  // await Flame.device.fullScreen();
  // await Flame.device.setLandscapeLeftOnly();
  runApp(GameWidget(game: game));

}

