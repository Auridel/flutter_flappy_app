import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class PipeSprite extends SpriteComponent with Hitbox, Collidable {
  final Vector2 _screenSize;
  final _gap = 70;
  final double pipeWidth = 52.0;
  final bool _isTop;
  final int index;
  final Function(int idx) _requestUpdate;
  late final _pipeHeight;

  PipeSprite(Sprite sprite, this._screenSize, this._isTop, double initY,
      double initX, this.index, this._requestUpdate) {
    this.sprite = sprite;
    this._pipeHeight = (_screenSize.y - _gap);
    size = Vector2(52.0, _pipeHeight);
    debugMode = true;
    debugColor = Colors.red;
    updatePipe(initX, initY);
  }

  void updatePipe(double initX, double initY) {
    position = Vector2(initX, _isTop ? initY - _pipeHeight : initY + _gap);
  }

  @override
  void update(double dt) {
    position.x -= 1;
    if (position.x + pipeWidth < 0.0) {
      print('update requested $index');
      _requestUpdate(index);
    }
    super.update(dt);
  }
}
