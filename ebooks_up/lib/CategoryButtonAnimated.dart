import 'package:flutter/material.dart';

class FloatingButtonAnimation extends StatefulWidget {
  const FloatingButtonAnimation({super.key});

  @override
  _FloatingButtonAnimationState createState() => _FloatingButtonAnimationState();
}

class _FloatingButtonAnimationState extends State<FloatingButtonAnimation> {
  double _buttonSize = 56.0;
  double _buttonElevation = 6.0;

  void _animateButton() {
    setState(() {
      _buttonSize = (_buttonSize == 56.0) ? 200.0 : 56.0;
      _buttonElevation = (_buttonElevation == 6.0) ? 0.0 : 6.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212121),
      body: const SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // Existing code...
            ],
          ),
        ),
      ),
      floatingActionButton: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: _buttonSize,
        height: _buttonSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: _buttonElevation,
              spreadRadius: _buttonElevation,
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: _animateButton,
          backgroundColor: Colors.blue,
          elevation: 0.0,
          child: const Icon(Icons.category_outlined),

        ),
      ),
    );
  }
}
