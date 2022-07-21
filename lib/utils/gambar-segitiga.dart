import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GambarSegitiga extends CustomPainter {
 
  Paint? painter;
 
  GambarSegitiga() {
 
    painter = Paint()
      ..color = Colors.purpleAccent
      ..style = PaintingStyle.fill;
 
  }
  
  @override
  void paint(Canvas canvas, Size size) {
 
    var path = Path();
 
    path.moveTo(size.width/2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.height, size.width);
    path.close();
 
    canvas.drawPath(path, painter!);
  }
 
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}