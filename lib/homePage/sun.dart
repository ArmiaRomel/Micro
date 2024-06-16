import 'package:flutter/material.dart';

class sun extends StatefulWidget {
  @override
  _sunState createState() => _sunState();
}

class _sunState extends State<sun> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _controller.value * 2.0 * 3.141592653589793,
            child: const Icon(
              Icons.wb_sunny,
              size: 50,
              color: Colors.orange,
            ),
          );
        },
      ),
    );
  }
}
