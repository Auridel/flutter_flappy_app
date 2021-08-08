import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as UI;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BackgroundPainter extends CustomPainter {
  final UI.Image bg;
  final UI.Image bird;
  final UI.Image pipeTop;
  final UI.Image pipeBottom;
  final _gap = 130.0;

  double _bg1X = 0;
  double? _bg2X;
  double? _birdY;

  BackgroundPainter(this.bird, this.bg, this.pipeTop, this.pipeBottom);

  @override
  void paint(Canvas canvas, Size size) {
    if(_bg2X == null || _birdY == null) {
      _bg2X = size.width;
      _birdY = size.height / 2;
    }

    final bg1Paint = Paint();
    final bg2Paint = Paint();
    final birdPaint = Paint();
    final pipeTopPaint = Paint();
    final pipeBottomPaint = Paint();
    canvas.drawImage(bg, Offset(_bg1X, 0.0), bg1Paint);
    canvas.drawImage(bg, Offset(_bg2X!, 0.0), bg2Paint);
    canvas.drawImage(bird, Offset(150.0, _birdY!), birdPaint);
    canvas.drawImage(pipeTop, Offset(200, size.height / 3 - pipeTop.height), pipeTopPaint);
    canvas.drawImage(pipeBottom, Offset(200, size.height / 3 + _gap), pipeBottomPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}