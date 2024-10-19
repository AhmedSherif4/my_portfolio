import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class TVPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9809886, size.height * 0.7438654);
    path_0.cubicTo(
        size.width * 0.9809886,
        size.height * 0.7571731,
        size.width * 0.9766236,
        size.height * 0.7697756,
        size.width * 0.9689278,
        size.height * 0.7792885);
    path_0.cubicTo(
        size.width * 0.9612357,
        size.height * 0.7887949,
        size.width * 0.9504259,
        size.height * 0.7948718,
        size.width * 0.9383232,
        size.height * 0.7948718);
    path_0.lineTo(size.width * 0.06167567, size.height * 0.7948718);
    path_0.cubicTo(
        size.width * 0.04957567,
        size.height * 0.7948718,
        size.width * 0.03876578,
        size.height * 0.7887949,
        size.width * 0.03107213,
        size.height * 0.7792885);
    path_0.cubicTo(
        size.width * 0.02337548,
        size.height * 0.7697756,
        size.width * 0.01901141,
        size.height * 0.7571731,
        size.width * 0.01901141,
        size.height * 0.7438654);
    path_0.lineTo(size.width * 0.01901141, size.height * 0.05741814);
    path_0.cubicTo(
        size.width * 0.01901141,
        size.height * 0.04410801,
        size.width * 0.02337548,
        size.height * 0.03150494,
        size.width * 0.03107213,
        size.height * 0.02199429);
    path_0.cubicTo(
        size.width * 0.03876578,
        size.height * 0.01248737,
        size.width * 0.04957567,
        size.height * 0.006410256,
        size.width * 0.06167567,
        size.height * 0.006410256);
    path_0.lineTo(size.width * 0.9383232, size.height * 0.006410256);
    path_0.cubicTo(
        size.width * 0.9504411,
        size.height * 0.006410256,
        size.width * 0.9612510,
        size.height * 0.01248045,
        size.width * 0.9689392,
        size.height * 0.02198147);
    path_0.cubicTo(
        size.width * 0.9766274,
        size.height * 0.03148468,
        size.width * 0.9809886,
        size.height * 0.04408654,
        size.width * 0.9809886,
        size.height * 0.05741814);
    path_0.lineTo(size.width * 0.9809886, size.height * 0.7438654);
    path_0.close();

    Paint paint0Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.007604563;
    paint0Stroke.color = const Color(0xff6640C2).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Stroke);

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.01520913, size.height * 0.8012821);
    path_1.cubicTo(
        size.width * 0.01729179,
        size.height * 0.8300321,
        size.width * 0.03722992,
        size.height * 0.8525641,
        size.width * 0.06150000,
        size.height * 0.8525641);
    path_1.lineTo(size.width * 0.9385019, size.height * 0.8525641);
    path_1.cubicTo(
        size.width * 0.9627719,
        size.height * 0.8525641,
        size.width * 0.9827072,
        size.height * 0.8300321,
        size.width * 0.9847909,
        size.height * 0.8012821);
    path_1.lineTo(size.width * 0.01520913, size.height * 0.8012821);
    path_1.close();

    Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.01519802, size.height * 0.8269167),
        Offset(size.width * 0.9847909, size.height * 0.8269167),
        [const Color(0xffA1BAFF).withOpacity(1), Colors.white.withOpacity(1)],
        [0, 1]);
    canvas.drawPath(path_1, paint1Fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.4600760, size.height * 0.8525641);
    path_2.lineTo(size.width * 0.5437262, size.height * 0.8525641);
    path_2.lineTo(size.width * 0.5437262, size.height * 0.9487179);
    path_2.lineTo(size.width * 0.4600760, size.height * 0.9487179);
    path_2.lineTo(size.width * 0.4600760, size.height * 0.8525641);
    path_2.close();

    Paint paint2Fill = Paint()..style = PaintingStyle.fill;
    paint2Fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.4600722, size.height * 0.9006346),
        Offset(size.width * 0.5437186, size.height * 0.9006346), [
      const Color(0xff270036).withOpacity(1),
      const Color(0xff4F008B).withOpacity(1),
      const Color(0xff4C24B1).withOpacity(1)
    ], [
      0,
      0.594,
      1
    ]);
    canvas.drawPath(path_2, paint2Fill);

    Paint paint3Fill = Paint()..style = PaintingStyle.fill;
    paint3Fill.color = Colors.white.withOpacity(1.0);
    canvas.drawRect(
        Rect.fromLTWH(size.width * 0.03422053, size.height * 0.06410256,
            size.width * 0.9315589, size.height * 0.6794872),
        paint3Fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.7034221, size.height * 0.9935897);
    path_4.lineTo(size.width * 0.3003802, size.height * 0.9935897);
    path_4.lineTo(size.width * 0.3044494, size.height * 0.9745833);
    path_4.cubicTo(
        size.width * 0.3093354,
        size.height * 0.9517564,
        size.width * 0.3258049,
        size.height * 0.9358974,
        size.width * 0.3446156,
        size.height * 0.9358974);
    path_4.lineTo(size.width * 0.6591863, size.height * 0.9358974);
    path_4.cubicTo(
        size.width * 0.6779962,
        size.height * 0.9358974,
        size.width * 0.6944677,
        size.height * 0.9517564,
        size.width * 0.6993536,
        size.height * 0.9745833);
    path_4.lineTo(size.width * 0.7034221, size.height * 0.9935897);
    path_4.close();

    Paint paint4Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    paint4Stroke.color = const Color(0xff383939).withOpacity(1.0);
    paint4Stroke.strokeCap = StrokeCap.round;
    paint4Stroke.strokeJoin = StrokeJoin.round;
    canvas.drawPath(path_4, paint4Stroke);

    Paint paint4Fill = Paint()..style = PaintingStyle.fill;
    paint4Fill.color = const Color(0xff45298C).withOpacity(1.0);
    canvas.drawPath(path_4, paint4Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
