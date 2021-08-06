import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as UI;

import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlappyGame extends Game with TapDetector {
  late Size screenSize;
  late List<UI.Image> imagesList;

  @override
  void onResize(Vector2 size) {
    screenSize = size.toSize();
    super.onResize(size);
  }

  Future<UI.Image> loadUiImage(String imageAssetPath) async {
    final ByteData data = await rootBundle.load(imageAssetPath);
    final Completer<UI.Image> completer = Completer();
    UI.decodeImageFromList(Uint8List.view(data.buffer), (UI.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  @override
  void onTap() {
    print('tapped');
  }

  @override
  void render(Canvas canvas) async {
    // Rect testRect = Rect.fromLTWH(10, 20, 300, 400);
    // Paint bgPaint = Paint();
    // bgPaint.color = Colors.lightBlue;
    // canvas.drawRect(testRect, bgPaint);
    // UI.Image bgImage = await loadUiImage('assets/images/bg.png');
    var bgImage = await Sprite.load('assets/images/bg.png');
    Paint bgImagePaint = Paint();
    canvas.drawImage(bgImage, Offset(0.0, 0.0), bgImagePaint);
  }

  @override
  void update(double t) {

  }
}