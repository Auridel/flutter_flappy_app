import 'package:flutter/material.dart';
import 'package:flutter_flappy_app/screens/flappy_game.dart';

class GameScore {
  final FlappyGame _game;
  late TextPainter _painter;
  late TextStyle _textStyle;
  late Offset _position;

  final _baseText = 'Score: ';
  int _score = 0;

  GameScore(this._game) {
    _painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    _textStyle = TextStyle(
      color: Color(0xffffffff),
      fontSize: 20,
      shadows: <Shadow>[
        Shadow(
          blurRadius: 7,
          color: Color(0xff000000),
          offset: Offset(3, 3),
        ),
      ],
    );
    _position = Offset(20.0, 10.0);

    _paint();
  }

  void render(Canvas canvas) {
    _painter.paint(canvas, _position);
  }

  void _paint() {
    _painter.text = TextSpan(
      text: '$_baseText$_score',
      style: _textStyle,
    );
    _painter.layout();
  }

  void update(double t) {
    if (_score != _game.score) {
      _score = _game.score;
      _paint();
    }
  }
}
