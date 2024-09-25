import 'dart:math';

import 'package:flutter/material.dart';

class OvalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Save the current canvas state
    canvas.save();

    // Move the canvas origin (0,0) to the center of the canvas
    canvas.translate(size.width / 2, size.height / 4.7);

    // Rotate the canvas by 45 degrees (pi/4 radians)
    canvas.rotate(pi / 0.81);

    Paint paint = Paint()
      ..shader = const RadialGradient(
        colors: [
          Color(0xff0A1832),
          Color(0xff43116A),
        ],
        stops: [0, 0],
        // Two colors gradient and blur effect
      ).createShader(
        Rect.fromCenter(
          center: Offset.zero,
          width: size.width,
          height: size.height,
        ),
      );

    paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);

    // Define the oval's bounding rectangle
    Rect ovalRect = Rect.fromLTWH(
      -size.width * 0.3, // Adjusted offset (centered on canvas)
      -size.height * 0.3, // Adjusted offset (centered on canvas)
      size.width * 0.6, // Width of the oval
      size.height * 0.8, // Height of the oval
    );

    // Draw the oval shape with gradient colors
    canvas.drawOval(ovalRect, paint);

    // Restore the canvas to its previous state (undo the rotation and translation)
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false; // No need to repaint unless the design changes
  }
}
