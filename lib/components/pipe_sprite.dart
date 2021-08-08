import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';

class PipeSprite extends SpriteComponent with Hitbox, Collidable {
  final Vector2 _screenSize;
  final _gap = 70;
  final double pipeWidth = 52.0;
  final bool _isTop;
  final int index;
  final Function(int idx) _requestUpdate;
  final double _birdX;
  final Function _addScore;
  late final _pipeHeight;

  late double prevXPosition;
  bool _isScored = false;

  PipeSprite(
      Sprite sprite,
      this._screenSize,
      this._isTop,
      double initY,
      double initX,
      this.index,
      this._requestUpdate,
      this._birdX,
      this._addScore) {
    this.sprite = sprite;
    this._pipeHeight = (_screenSize.y - _gap);
    size = Vector2(52.0, _pipeHeight);
    debugMode = true;
    debugColor = Colors.red;
    prevXPosition = initX;
    addShape(HitboxRectangle());
    updatePipe(initX, initY);
  }

  void updatePipe(double initX, double initY) {
    position = Vector2(initX, _isTop ? initY - _pipeHeight : initY + _gap);
    _isScored = false;
    prevXPosition = initX;
  }

  @override
  void update(double dt) {
    position.x -= 1;
    if (position.x + pipeWidth < 0.0) {
      _requestUpdate(index);
    }
    if (prevXPosition > _birdX &&
        position.x <= _birdX &&
        !_isScored &&
        _isTop) {
      _addScore();
      _isScored = true;
    }
    prevXPosition = position.x;
    super.update(dt);
  }
}
