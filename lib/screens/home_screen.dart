import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as UI;
import 'package:image/image.dart' as IMG;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flappy_app/constants/constants.dart';
import 'package:flutter_flappy_app/widgets/background_painter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Map<String, UI.Image> _images;
  late Size _size;
  bool _isInit = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  Future<void> _loadAssets() async {
    print(_size);
    _images = {
      'bird': await _loadUiImage(imageAssetPath: assets['bird']!, resizeWidth: 40),
      'bg': await _loadUiImage(imageAssetPath: assets['bg']!, resizeWidth: _size.width.toInt()),
      'pipeTop': await _loadUiImage(imageAssetPath: assets['pipeTop']!, resizeWidth: 90),
      'pipeBottom': await _loadUiImage(imageAssetPath: assets['pipeBottom']!, resizeWidth: 90),
    };
    setState(() {
      _isInit = true;
    });
  }

  Future<UI.Image> _loadUiImage({required String imageAssetPath, int? resizeWidth}) async {
    final ByteData data = await rootBundle.load(imageAssetPath);
    final IMG.Image image = IMG.decodeImage(Uint8List.view(data.buffer))!;
    final IMG.Image resized = resizeWidth != null ? IMG.copyResize(image, width: resizeWidth) : image;
    final List<int> resizedBytes = IMG.encodePng(resized);
    final Completer<UI.Image> completer = new Completer();

    UI.decodeImageFromList(Uint8List.fromList(resizedBytes), (UI.Image img) => completer.complete(img));
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    if(!_isInit) _loadAssets();
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (_isInit)
            Positioned(
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: CustomPaint(
              size: _size,
              painter: BackgroundPainter(_images['bird']!, _images['bg']!,
                    _images['pipeTop']!, _images['pipeBottom']!),
            ),
                ))
        ],
      ),
    );
  }
}
