import 'package:flutter/material.dart';

class ShapeOfTextPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.1646963, size.height * 0.1727920);
    path_0.cubicTo(
        size.width * 0.1779154,
        size.height * 0.07817049,
        size.width * 0.1964816,
        size.height * 0.02439024,
        size.width * 0.2159283,
        size.height * 0.02439024);
    path_0.lineTo(size.width * 0.9264706, size.height * 0.02439024);
    path_0.cubicTo(
        size.width * 0.9650478,
        size.height * 0.02439024,
        size.width * 0.9963235,
        size.height * 0.2318680,
        size.width * 0.9963235,
        size.height * 0.4878049);
    path_0.lineTo(size.width * 0.9963235, size.height * 0.5121951);
    path_0.cubicTo(
        size.width * 0.9963235,
        size.height * 0.7681317,
        size.width * 0.9650478,
        size.height * 0.9756098,
        size.width * 0.9264706,
        size.height * 0.9756098);
    path_0.lineTo(size.width * 0.04489596, size.height * 0.9756098);
    path_0.cubicTo(
        size.width * 0.05375846,
        size.height * 0.9479341,
        size.width * 0.06183824,
        size.height * 0.9090390,
        size.width * 0.06863787,
        size.height * 0.8603683);
    path_0.lineTo(size.width * 0.1646963, size.height * 0.1727920);
    path_0.close();

    Paint paint0Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.007352941;
    paint0Stroke.color = const Color(0xff90CAF9).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Stroke);

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
