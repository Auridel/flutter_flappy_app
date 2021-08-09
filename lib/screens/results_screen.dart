import 'package:flutter/material.dart';
import 'package:flutter_flappy_app/widgets/game_button.dart';

class ResultsScreen extends StatefulWidget {
  static const routeName = '/results';

  const ResultsScreen({Key? key}) : super(key: key);

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen>
    with SingleTickerProviderStateMixin {
  late final int? _score;
  late final AnimationController? _controller;
  bool _isInit = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      _score = args['score'];
      setState(() {
        _isInit = true;
      });
      Future.delayed(Duration(milliseconds: 500), () {
        if (_controller != null) {
          _controller?.forward();
        }
      });
    }
    super.didChangeDependencies();
  }

  void _onButtonPress() {
    Navigator.of(context).pushReplacementNamed('/');
  }

  void _setAnimationController(AnimationController controller) {
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
              child: Image.asset(
            'assets/images/bg.png',
            width: size.width,
            fit: BoxFit.cover,
          )),
          if (_score != null)
            Center(
              child: Text(
                'Your score is: $_score',
                style: TextStyle(
                  color: Color(0xffffffff),
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  shadows: <Shadow>[
                    Shadow(
                      blurRadius: 7,
                      color: Color(0xff000000),
                      offset: Offset(3, 3),
                    ),
                  ],
                ),
              ),
            ),
          Positioned(
              bottom: 40,
              left: size.width / 2 - 70,
              child: GameButton(
                onTap: _onButtonPress,
                text: 'Go Back',
                setAnimationController: _setAnimationController,
              ))
        ],
      ),
    );
  }
}
