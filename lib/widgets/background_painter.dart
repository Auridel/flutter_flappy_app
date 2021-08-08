import 'dart:ui' as UI;

import 'package:flutter/material.dart';

class BackgroundPainter extends CustomPainter {
  final UI.Image _bg;
  final UI.Image _bird;
  final UI.Image _pipeTop;
  final UI.Image _pipeBottom;
  final _gap = 130.0;
  final _birdX = 150.0;

  double _bg1X;
  double _bg2X = 0.0;
  double _birdY;
  double _pipeX1 = 0.0;
  double _pipeX2 = 0.0;

  BackgroundPainter(this._birdY, this._bg1X, this._bird, this._bg,
      this._pipeTop, this._pipeBottom);

  @override
  void paint(Canvas canvas, Size size) {
    _bg2X = size.width + _bg1X;
    _pipeX1 = size.width / 2 + _bg1X;
    _pipeX2 = _pipeX1 + size.width;
    final bg1Paint = Paint();
    final bg2Paint = Paint();
    final birdPaint = Paint();
    final pipeTopPaint1 = Paint();
    final pipeBottomPaint1 = Paint();
    final pipeTopPaint2 = Paint();
    final pipeBottomPaint2 = Paint();
    canvas.drawImage(_bg, Offset(_bg1X, 0.0), bg1Paint);
    canvas.drawImage(_bg, Offset(_bg2X, 0.0), bg2Paint);
    canvas.drawImage(_bird, Offset(_birdX, _birdY), birdPaint);
    canvas.drawImage(_pipeTop,
        Offset(_pipeX1, size.height / 3 - _pipeTop.height), pipeTopPaint1);
    canvas.drawImage(
        _pipeBottom, Offset(_pipeX1, size.height / 3 + _gap), pipeBottomPaint1);
    canvas.drawImage(_pipeTop,
        Offset(_pipeX2, size.height / 3 - _pipeTop.height), pipeTopPaint2);
    canvas.drawImage(
        _pipeBottom, Offset(_pipeX2, size.height / 3 + _gap), pipeBottomPaint2);
  }

  @override
  bool shouldRepaint(covariant BackgroundPainter oldDelegate) {
    return oldDelegate._birdY != _birdY;
  }
}
