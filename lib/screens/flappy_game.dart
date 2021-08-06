import 'dart:async';
import 'dart:ui' as UI;

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/material.dart';

class FlappyGame extends BaseGame with TapDetector {
  late Size screenSize;
  late List<UI.Image> imagesList;
  final bg = SpriteComponent();
  final bird = SpriteComponent();



  Future<void> onLoad() async {
    bg
      ..sprite = await loadSprite('bg.png')
        ..size  = size
        ..position = Vector2(0.0, 0.0);
    add(bg);

    bird
      ..sprite = await loadSprite('bird.png')
      ..size  = Vector2(40.0, 40.0)
      ..position = Vector2(50.0, 50.0)
      ..anchor = Anchor.center;
    add(bird);
  }

  @override
  void onResize(Vector2 size) {
    screenSize = size.toSize();
    super.onResize(size);
  }

  @override
  void onTap() {
    print('tapped');
  }

  // @override
  // void render(Canvas canvas) async {
  //   // Rect testRect = Rect.fromLTWH(10, 20, 300, 400);
  //   // Paint bgPaint = Paint();
  //   // bgPaint.color = Colors.lightBlue;
  //   // canvas.drawRect(testRect, bgPaint);
  //   UI.Image bgImage = await loadUiImage('assets/images/bg.png');
  //   // var bgImage = await Sprite.load('assets/images/bg.png');
  //   Paint bgImagePaint = Paint();
  //   canvas.drawImage(bgImage, Offset(0.0, 0.0), bgImagePaint);
  //   super.render(canvas);
  // }

  @override
  void update(double t) {
    super.update(t);
  }
}