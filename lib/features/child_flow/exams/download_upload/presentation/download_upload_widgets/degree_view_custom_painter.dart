
import 'package:flutter/material.dart';

class DegreeViewCustomPainter extends CustomPainter {
@override
void paint(Canvas canvas, Size size) {

Paint paint0Fill = Paint()..style=PaintingStyle.fill;
paint0Fill.color = const Color(0xffF9A144).withOpacity(1.0);
canvas.drawRRect(RRect.fromRectAndCorners(Rect.fromLTWH(0,0,size.width,size.height),bottomRight: Radius.circular(size.width*0.08438819),bottomLeft:  Radius.circular(size.width*0.08438819),topLeft:  Radius.circular(size.width*0.08438819),topRight:  Radius.circular(size.width*0.08438819)),paint0Fill);

Paint paint1Fill = Paint()..style=PaintingStyle.fill;
paint1Fill.color = const Color(0xffFAFAFA).withOpacity(1.0);
canvas.drawRRect(RRect.fromRectAndCorners(Rect.fromLTWH(size.width*0.06751055,size.height*0.05882437,size.width*0.8734177,size.height*0.8770051),bottomRight: Radius.circular(size.width*0.08438819),bottomLeft:  Radius.circular(size.width*0.08438819),topLeft:  Radius.circular(size.width*0.08438819),topRight:  Radius.circular(size.width*0.08438819)),paint1Fill);

Paint paint2Fill = Paint()..style=PaintingStyle.fill;
paint2Fill.color = Colors.white.withOpacity(1.0);
canvas.drawOval(Rect.fromCenter(center:Offset(size.width*0.9451477,size.height*0.05882335),width:size.width*0.04219409,height:size.height*0.05347594),paint2Fill);

Paint paint3Fill = Paint()..style=PaintingStyle.fill;
paint3Fill.color = Colors.white.withOpacity(1.0);
canvas.drawOval(Rect.fromCenter(center:Offset(size.width*0.04641350,size.height*0.07486701),width:size.width*0.04219409,height:size.height*0.05347594),paint3Fill);

Paint paint4Fill = Paint()..style=PaintingStyle.fill;
paint4Fill.color = Colors.white.withOpacity(1.0);
canvas.drawOval(Rect.fromCenter(center:Offset(size.width*0.05485232,size.height*0.9144365),width:size.width*0.04219409,height:size.height*0.05347594),paint4Fill);

Paint paint5Fill = Paint()..style=PaintingStyle.fill;
paint5Fill.color = Colors.white.withOpacity(1.0);
canvas.drawOval(Rect.fromCenter(center:Offset(size.width*0.9493671,size.height*0.9144365),width:size.width*0.04219409,height:size.height*0.05347594),paint5Fill);

}

@override
bool shouldRepaint(covariant CustomPainter oldDelegate) {
return true;
}
}