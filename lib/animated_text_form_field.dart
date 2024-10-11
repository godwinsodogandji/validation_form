import 'package:flutter/material.dart';


class AnimatedTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final int delay;
  final bool obscureText;
  final IconData prefixIcon;
  final String? Function(String?)? validator;

  const AnimatedTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.delay,
    this.obscureText = false,
    required this.prefixIcon,
    this.validator,
  });

  @override
  _AnimatedTextFormFieldState createState() => _AnimatedTextFormFieldState();
}

class _AnimatedTextFormFieldState extends State<AnimatedTextFormField> {
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
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: const TextStyle(color: Colors.blueGrey),
          prefixIcon: Icon(widget.prefixIcon, color: Colors.blueGrey),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blueGrey),
            borderRadius: BorderRadius.circular(12.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blueGrey),
            borderRadius: BorderRadius.circular(12.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(12.0),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 20.0,
          ),
        ),
        validator: widget.validator,
      ),
    );
  }
}
