import 'package:flutter_flappy_app/screens/game_screen.dart';
import 'package:flutter_flappy_app/widgets/background_animation.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          )),
          Positioned(
              bottom: 40,
              left: size.width / 2 - 90,
              child: GestureDetector(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.deepOrange,
                      border: Border.all(width: 1.0, color: Colors.white70)),
                  child: Text(
                    'Start Game',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(GameScreen.routeName);
                },
              ))
        ],
      ),
    );
  }
}
