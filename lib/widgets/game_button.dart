import 'package:flutter/material.dart';

class GameButton extends StatefulWidget {
  final Function _onTap;
  final String _text;
  final Function(AnimationController) _setAnimationController;

  const GameButton(
      {Key? key,
      required Function onTap,
      required String text,
      required Function(AnimationController) setAnimationController})
      : this._onTap = onTap,
        this._text = text,
        this._setAnimationController = setAnimationController,
        super(key: key);

  @override
  _GameButtonState createState() => _GameButtonState();
}

class _GameButtonState extends State<GameButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    widget._setAnimationController(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: GestureDetector(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.deepOrange,
              border: Border.all(width: 1.0, color: Colors.white70)),
          child: Text(
            widget._text,
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        ),
        onTap: () {
          widget._onTap();
        },
      ),
    );
  }
}
