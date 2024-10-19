import 'package:flutter/material.dart';

class GroupCustomPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9968727, size.height * 0.5072171);
    path_0.cubicTo(
        size.width * 0.9970187,
        size.height * 0.7773000,
        size.width * 0.9634419,
        size.height * 0.9967585,
        size.width * 0.9219663,
        size.height * 0.9967585);
    path_0.lineTo(size.width * 0.1121363, size.height * 0.9967585);
    path_0.cubicTo(
        size.width * 0.09448352,
        size.height * 0.9967585,
        size.width * 0.07739813,
        size.height * 0.9561585,
        size.width * 0.06389401,
        size.height * 0.8821220);
    path_0.lineTo(size.width * 0.0002780255, size.height * 0.5333488);
    path_0.lineTo(size.width * 0.06323633, size.height * 0.1518439);
    path_0.cubicTo(
        size.width * 0.07709775,
        size.height * 0.06784878,
        size.width * 0.09532921,
        size.height * 0.02115415,
        size.width * 0.1142633,
        size.height * 0.02115412);
    path_0.lineTo(size.width * 0.9219663, size.height * 0.02115412);
    path_0.cubicTo(
        size.width * 0.9632322,
        size.height * 0.02115407,
        size.width * 0.9967266,
        size.height * 0.2384927,
        size.width * 0.9968727,
        size.height * 0.5072171);
    path_0.close();

    canvas.drawShadow(path_0, Colors.black, 3, true);

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xff1B3D6F).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
