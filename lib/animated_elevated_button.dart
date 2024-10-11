import 'package:flutter/material.dart';

class AnimatedElevatedButton extends StatefulWidget {
  final VoidCallback onPressed;
  final int delay;

  const AnimatedElevatedButton({
    super.key,
    required this.onPressed,
    required this.delay,
  });

  @override
  _AnimatedElevatedButtonState createState() => _AnimatedElevatedButtonState();
}

class _AnimatedElevatedButtonState extends State<AnimatedElevatedButton> {
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
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(224, 63, 68, 93),
          padding: const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 40.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: const Text(
          'Submit',
          style: TextStyle(
            fontSize: 18.0,
            color: Color.fromARGB(246, 244, 241, 241),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
