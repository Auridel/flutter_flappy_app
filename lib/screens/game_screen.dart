import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flappy_app/bloc/tap_bloc.dart';
import 'package:flutter_flappy_app/screens/results_screen.dart';

import 'flappy_game.dart';

class GameScreen extends StatefulWidget {
  static final routeName = '/game';

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late final FlappyGame _game;

  _GameScreenState() {
    _game = FlappyGame(_navigateToResults);
  }

  Future<void> _load() async {
    await Flame.device.fullScreen();
    await Flame.device.setLandscapeRightOnly();
  }

  @override
  void dispose() {
    TapBloc.dispose();
    super.dispose();
  }

  void _navigateToResults(int score) {
    Navigator.of(context).pushReplacementNamed(ResultsScreen.routeName,
        arguments: {'score': score});
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
          return GameWidget(game: _game);
        },
      ),
    );
  }
}
