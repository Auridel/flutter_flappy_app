import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'flappy_game.dart';

class GameScreen extends StatelessWidget {
  final FlappyGame game = FlappyGame();

  Future<void> _load() async {
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _load(),
        builder: (ctx, snapshot) {
          if(snapshot.connectionState != ConnectionState.done) {
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