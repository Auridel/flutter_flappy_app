import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flappy_app/bloc/tap_bloc.dart';

class Bird extends SpriteComponent with Hitbox, Collidable {
  final _tapBloc = TapBloc.getInstance();
  final Function() _onCollide;
  final double _birdSize = 20.0;
  final double _gravity = 0.1;
  final double _maxVelocityY = 5.0;
  final Vector2 _screenSize;
  late final StreamSubscription<void> _subscription;
  bool _collision = false;
  bool _hasEffect = false;
  double _velocityY = 0;

  Bird(Sprite sprite, double birdX, this._screenSize, this._onCollide) {
    this.sprite = sprite;
    size = Vector2(_birdSize, _birdSize);
    position = Vector2(birdX, _screenSize.y / 2);
    addShape(HitboxCircle());
    _subscription = _tapBloc.tapStream.listen((event) {
      if (!_collision) {
        if ((_velocityY - 2).abs() < _maxVelocityY) {
          _velocityY -= 2;
        }
      }
    });
  }

  void _watchBorders(double velocity) {
    final double newY = position.y + velocity;
    if (newY < 0.0 || newY > _screenSize.y - _birdSize / 2) {
      _velocityY = 0;
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
    if (!_hasEffect) {
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
    _velocityY =
        _gravity < _maxVelocityY ? _velocityY + _gravity : _maxVelocityY;
    _watchBorders(_velocityY);
    position.y += _velocityY;
    super.update(dt);
  }
}
