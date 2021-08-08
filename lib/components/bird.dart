import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flappy_app/bloc/tap_bloc.dart';

class Bird extends SpriteComponent with Hitbox, Collidable {
  final _tapBloc = TapBloc.getInstance();
  final Function() _onCollide;
  final double birdSize = 20.0;
  final double gravity = 0.1;
  final double maxVelocityY = 5.0;
  final Vector2 screenSize;
  late final StreamSubscription<void> _subscription;
  bool _collision = false;
  bool _hasEffect = false;
  double velocityY = 0;

  Bird(Sprite sprite, double birdX, this.screenSize, this._onCollide) {
    this.sprite = sprite;
    size = Vector2(birdSize, birdSize);
    position = Vector2(birdX, screenSize.y / 2);
    debugMode = true;
    addShape(HitboxCircle());
    _subscription = _tapBloc.tapStream.listen((event) {
      /// TODO: uncomment
      if (!_collision) {
        if ((velocityY - 2).abs() < maxVelocityY) {
          velocityY -= 2;
        }
      }
    });
  }

  void _watchBorders(double velocity) {
    final double newY = position.y + velocity;
    if (newY > screenSize.y || newY < 0.0) {
      velocityY = 0;
      return;
    }
  }

  @override
  void onRemove() {
    _subscription.cancel();
    super.onRemove();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    _collision = true;
    if(!_hasEffect) {
      this.addEffect(RotateEffect(
        angle: 20,
        speed: 15,
        curve: Curves.easeInOut,
      ));
      _hasEffect = true;
      _onCollide();
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    velocityY = gravity < maxVelocityY ? velocityY + gravity : maxVelocityY;
    _watchBorders(velocityY);
    position.y += velocityY;
    super.update(dt);
  }
}
