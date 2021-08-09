import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

class GroundCollidable extends SpriteComponent with Hitbox, Collidable {
  final Vector2 _screenSize;

  GroundCollidable(this._screenSize) {
    size = Vector2(_screenSize.x, 2.0);
    position = Vector2(0.0, _screenSize.y + 1);
    addShape(HitboxRectangle());
  }
}
