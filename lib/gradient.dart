import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  final String text;
  final Gradient gradient;
  final TextStyle style;

  const GradientText({
    required this.text,
    required this.gradient,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return gradient.createShader(bounds);
      },
      child: Text(
        text,
        style: TextStyle(
          fontSize: style.fontSize,
          fontWeight: style.fontWeight,
          color: Colors
              .white, // Text color doesn't matter here, it will be overridden by the shader
        ),
      ),
    );
  }
}
