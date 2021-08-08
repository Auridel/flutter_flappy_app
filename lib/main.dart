import 'package:flutter/material.dart';
import 'package:flutter_flappy_app/screens/game_screen.dart';
import 'package:flutter_flappy_app/screens/home_screen.dart';

import 'helpers/custom_transition.dart';

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
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CustomTransitionBuilder(),
            TargetPlatform.iOS: CustomTransitionBuilder(),
          }),
        ),
        home: HomeScreen(),
        routes: {
          GameScreen.routeName: (ctx) => GameScreen(),
        },
      );
  }
}