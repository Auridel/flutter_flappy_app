import 'package:flutter/services.dart';
import 'package:flutter_flappy_app/screens/game_screen.dart';
import 'package:flutter_flappy_app/widgets/background_animation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_flappy_app/widgets/game_button.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final AnimationController? _controller;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  void _setAnimationController(AnimationController value) {
    _controller = value;
  }

  void _startButtonAnimation() {
    _controller?..forward();
  }

  void _onPlayPress() {
    Navigator.of(context).pushReplacementNamed(GameScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
              child: BackgroundAnimation(
            size: size,
            onCanvasReady: _startButtonAnimation,
          )),
          Positioned(
              bottom: 40,
              left: size.width / 2 - 90,
              child: GameButton(
                onTap: _onPlayPress,
                text: 'Start Game',
                setAnimationController: _setAnimationController,
              ))
        ],
      ),
    );
  }
}
