import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter_flappy_app/bloc/tap_bloc.dart';
import 'package:flutter_flappy_app/components/bird.dart';
import 'package:flutter_flappy_app/components/game_score.dart';
import 'package:flutter_flappy_app/components/ground_collidable.dart';
import 'package:flutter_flappy_app/components/pipe_sprite.dart';
import 'package:flutter_flappy_app/helpers/math_helpers.dart';

enum EPipePosition { Top, Bottom }

class FlappyGame extends BaseGame with TapDetector, HasCollidables {
  final bg = SpriteComponent();
  final bg2 = SpriteComponent();
  final _tapStream = TapBloc.getInstance();
  late final List<Map<EPipePosition, PipeSprite>> _pipes;
  final double _pipeBetweenGapHorizontal = 200.0;
  final double _birdX = 150.0;
  late final GameScore _gameScore;
  late final Function(int score) _navigateToResults;

  double _speed = 1.0;
  int _score = 0;

  int get score => _score;

  FlappyGame(Function(int score) navigateToResults) {
    this._navigateToResults = navigateToResults;
    _gameScore = GameScore(this);
  }

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

    await _initPipes(size);
    add(Bird(await loadSprite('bird.png'), _birdX, size, _onCollide));
    add(GroundCollidable(size));
  }

  void _onCollide() {
    Future.delayed(Duration(seconds: 2), () {
      super.pauseEngine();
      _navigateToResults(_score);
    });
  }

  void _addScore() {
    _score += 1;
    if (_score % 10 == 0 && _score < 100) {
      _increaseSpeed();
    }
  }

  void _increaseSpeed() {
    _speed += 0.1;
  }

  Future<void> _initPipes(Vector2 screenSize) async {
    final pipeTopSprite = await loadSprite('fbPipeTop.png');
    final pipeBottomSprite = await loadSprite('fbPipeBottom.png');
    final int pipesCount = (screenSize.x / _pipeBetweenGapHorizontal).round();
    final pipesInitY =
        List.generate(pipesCount, (index) => generateRandomPipeY(screenSize.y));
    print(pipesInitY);
    _pipes = List.generate(pipesCount, (index) {
      return {
        EPipePosition.Top: PipeSprite(
            pipeTopSprite,
            screenSize,
            true,
            pipesInitY[index],
            (index + 1) * _pipeBetweenGapHorizontal + screenSize.x / 2,
            index,
            _requestUpdate,
            _birdX,
            _addScore),
        EPipePosition.Bottom: PipeSprite(
            pipeBottomSprite,
            screenSize,
            false,
            pipesInitY[index],
            (index + 1) * _pipeBetweenGapHorizontal + screenSize.x / 2,
            index,
            _requestUpdate,
            _birdX,
            _addScore),
      };
    });
    _pipes.forEach((element) {
      add(element[EPipePosition.Top]!);
      add(element[EPipePosition.Bottom]!);
    });
  }

  void _requestUpdate(int index) {
    _onPipePairOut(_pipes[index]);
  }

  void _onPipePairOut(Map<EPipePosition, PipeSprite> pair) {
    final randomY = generateRandomPipeY(size.y);
    pair[EPipePosition.Top]?.updatePipe(size.x, randomY);
    pair[EPipePosition.Bottom]?.updatePipe(size.x, randomY);
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
  void render(Canvas canvas) {
    super.render(canvas);
    _gameScore.render(canvas);
  }

  @override
  void update(double t) {
    super.update(t);
    bg.position.x -= _speed;
    bg2.position.x -= _speed;
    if (bg.position.x <= -size.x) {
      bg.position.x = 0.0;
      bg2.position.x = size.x;
    }
    _gameScore.update(t);
  }
}
