import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flutter_flappy_app/bloc/tap_bloc.dart';

class Bird extends SpriteComponent with Hitbox, Collidable {
  final _tapBloc = TapBloc.getInstance();
  final double birdSize = 20.0;
  final double gravity = 0.1;
  final double maxVelocityY = 5.0;
  final Vector2 screenSize;
  bool _collision = false;
  double velocityY = 0;

  Bird(Sprite sprite, this.screenSize) {
    this.sprite = sprite;
    size = Vector2(birdSize, birdSize);
    position = Vector2(150.0, screenSize.y / 2);
    debugMode = true;
    addShape(HitboxCircle());
    _tapBloc.tapStream.listen((event) {
      if (!_collision) {
        if ((velocityY - 2).abs() < maxVelocityY) {
          velocityY -= 2;
        }
      }
    });
  }

  void _watchBorders(double velocity) {
    final double newY = position.y + velocity;
    if (newY > screenSize.y - birdSize || newY < 0.0) {
      velocityY = 0;
      return;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    // TODO: implement onCollision
    print('!!!! COLLIDED!!!');
    _collision = true;
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
