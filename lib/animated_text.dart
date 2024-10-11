import 'package:flutter/material.dart';


class AnimatedText extends StatefulWidget {
  final String text;
  final int delay;

  const AnimatedText({super.key, required this.text, required this.delay});

  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}


class _AnimatedTextState extends State<AnimatedText> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: widget.delay), () {
      setState(() {
        _visible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: const Duration(seconds: 1),
      child: Text(
        widget.text,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}