import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as UI;
import 'package:image/image.dart' as IMG;

import 'package:flutter/services.dart';
import 'package:flutter_flappy_app/constants/constants.dart';
import 'package:flutter_flappy_app/widgets/background_painter.dart';

class BackgroundAnimation extends StatefulWidget {
  final Size _size;

  const BackgroundAnimation({Key? key, required Size size})
      : this._size = size,
        super(key: key);

  @override
  _BackgroundAnimationState createState() => _BackgroundAnimationState();
}

class _BackgroundAnimationState extends State<BackgroundAnimation>
    with SingleTickerProviderStateMixin {
  late Map<String, UI.Image> _images;
  late final AnimationController _controller;
  late final Animation<double> _animation;
  bool _isInit = false;
  double _bgX = 0.0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700))
          ..repeat(reverse: true);
    _animation = Tween<double>(
            begin: widget._size.height / 2 + backgroundBirdOffset,
            end: widget._size.height / 2 - backgroundBirdOffset)
        .animate(_controller);
    _controller.addListener(() {
      setState(() {
        _bgX = _bgX == -widget._size.width ? _bgX = 0 : _bgX - 1;
      });
    });
    _loadAssets();
  }

  Future<void> _loadAssets() async {
    _images = {
      'bird': await _loadUiImage(
          imageAssetPath: assets['bird']!, resizeWidth: birdBgWidth),
      'bg': await _loadUiImage(
          imageAssetPath: assets['bg']!,
          resizeWidth: widget._size.width.toInt()),
      'pipeTop': await _loadUiImage(
          imageAssetPath: assets['pipeTop']!, resizeWidth: pipeBgWidth),
      'pipeBottom': await _loadUiImage(
          imageAssetPath: assets['pipeBottom']!, resizeWidth: pipeBgWidth),
    };
    setState(() {
      _isInit = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<UI.Image> _loadUiImage(
      {required String imageAssetPath, int? resizeWidth}) async {
    final ByteData data = await rootBundle.load(imageAssetPath);
    final IMG.Image image = IMG.decodeImage(Uint8List.view(data.buffer))!;
    final IMG.Image resized =
        resizeWidth != null ? IMG.copyResize(image, width: resizeWidth) : image;
    final List<int> resizedBytes = IMG.encodePng(resized);
    final Completer<UI.Image> completer = new Completer();

    UI.decodeImageFromList(Uint8List.fromList(resizedBytes),
        (UI.Image img) => completer.complete(img));
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInit) _loadAssets();
    return AspectRatio(
      aspectRatio: 1.0,
      child: _isInit
          ? CustomPaint(
              size: widget._size,
              painter: BackgroundPainter(
                  _animation.value,
                  _bgX,
                  _images['bird']!,
                  _images['bg']!,
                  _images['pipeTop']!,
                  _images['pipeBottom']!),
            )
          : Image.asset(
              'assets/images/bg.png',
              width: widget._size.width,
              fit: BoxFit.cover,
            ),
    );
  }
}
