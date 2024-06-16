import 'package:flutter/material.dart';
import 'gradientIcon.dart';

class cloud extends StatefulWidget {
  final double sized;

  cloud({required this.sized});
  @override
  _cloudState createState() => _cloudState();
}

class _cloudState extends State<cloud> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 30),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return GradientIcon(
              icon: Icons.cloud,
              size: widget.sized,
              gradient: LinearGradient(
                colors: [Color(0xffD2CDFE), Color(0xffF8F7FF)],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            );
          },
        ),
      ],
    );
  }
}
