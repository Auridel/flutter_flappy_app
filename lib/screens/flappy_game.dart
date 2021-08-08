import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter_flappy_app/bloc/tap_bloc.dart';
import 'package:flutter_flappy_app/components/bird.dart';

class FlappyGame extends BaseGame with TapDetector, HasCollidables {
  final bg = SpriteComponent();
  final bg2 = SpriteComponent();
  final _tapStream = TapBloc.getInstance();

  Future<void> onLoad() async {
    bg
      ..sprite = await loadSprite('bg.png')
      ..size = size
      ..position = Vector2(0.0, 0.0);
    add(bg);

    bg2
      ..sprite = await loadSprite('bg.png')
      ..size = size
      ..position = Vector2(size.x, 0.0);
    add(bg2);
    add(Bird(await loadSprite('bird.png'), size));
  }

  @override
  void onResize(Vector2 size) {
    print(size);
    bg.size = size;
    bg.position = Vector2(0.0, 0.0);
    bg2.size = size;
    bg2.position = Vector2(size.x, 0.0);
    super.onResize(size);
  }

  @override
  void onTapDown(TapDownInfo info) {
    _tapStream.tapStreamSink.add(null);
  }

  @override
  void update(double t) {
    super.update(t);
    bg.position.x -= 1;
    bg2.position.x -= 1;
    if (bg.position.x <= -size.x) {
      bg.position.x = 0.0;
      bg2.position.x = size.x;
    }
  }
}
