import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flappy_app/bloc/tap_bloc.dart';

import 'flappy_game.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final FlappyGame game = FlappyGame();

  Future<void> _load() async {
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();
  }

  @override
  void dispose() {
    TapBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _load(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return GameWidget(game: game);
        },
      ),
    );
  }
}
