import 'package:flutter/material.dart';
import 'package:flutter_flappy_app/screens/game_screen.dart';
import 'package:flutter_flappy_app/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flappy Bird',
        home: HomeScreen(),
      );
  }
}