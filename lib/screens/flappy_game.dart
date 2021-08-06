import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';

class FlappyGame extends BaseGame with TapDetector {
  late Vector2 screenSize;
  final bg = SpriteComponent();
  final bg2 = SpriteComponent();
  final bird = SpriteComponent();
  double velocityY = 0.5;



  Future<void> onLoad() async {
    bg
      ..sprite = await loadSprite('bg.png')
        ..size  = screenSize
        ..position = Vector2(0.0, 0.0);
    add(bg);

    bg2
      ..sprite = await loadSprite('bg.png')
        ..size  = screenSize
        ..position = Vector2(screenSize.x, 0.0);
    add(bg2);

    bird
      ..sprite = await loadSprite('bird.png')
      ..size  = Vector2(20.0, 20.0)
      ..position = Vector2(150.0, screenSize.y / 2)
      ..anchor = Anchor.center;
    add(bird);
  }

  @override
  void onResize(Vector2 size) {
    print(size);
    screenSize = size;
    super.onResize(size);
  }


  @override
  void onTapDown(TapDownInfo info) {
    velocityY -= 3.0;
  }

  @override
  void update(double t) {
    super.update(t);
    bg.position.x -= 1;
    bg2.position.x -= 1;
    if(bg.position.x <= -screenSize.x) {
      bg.position.x = 0.0;
      bg2.position.x = screenSize.x;
    }

    bird.position.y += velocityY;
    velocityY += 0.1;
  }
}