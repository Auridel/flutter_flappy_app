import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as UI;
import 'package:flutter/material.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flappy_app/screens/flappy_game.dart';

class Background {
  // final FlappyGame game;
  // Sprite bgSprite;

  Future<UI.Image> loadUiImage(String imageAssetPath) async {
    final ByteData data = await rootBundle.load(imageAssetPath);
    final Completer<UI.Image> completer = Completer();
    UI.decodeImageFromList(Uint8List.view(data.buffer), (UI.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  // Background(this.game) {};
}