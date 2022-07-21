import 'package:flutter/material.dart';


class PopUpMenuButtons{
  
    Widget selectPopup({listPopupMenuItem, x=30.0,y=55.0, icon = Icons.notifications_active, iconColor= Colors.yellow, callBackSelected, String? posisi="kiri", backgroundColor=Colors.yellow}) => PopupMenuButton<int>(
      // child: CustomPaint(
      //             size: Size(20, 20),
      //             painter: GambarSegitiga()
      //           ),12313
      color: backgroundColor,
      shape:   posisi=="kiri" ?TooltipShapeKiri() :TooltipShapekanan(),
      padding: EdgeInsets.only(top: 0.0),
      offset: Offset(x, y),
          itemBuilder: (context) => listPopupMenuItem
              ,
          initialValue: 1,
          onCanceled: () {
          },
          onSelected: (value) {
            callBackSelected(value);
          },
          icon: Icon(icon, color: iconColor,),
        );
        

      PopupMenuItem<int> popupMenuItem({value, icon, warnaIcon = Colors.black, label="", bool isLine = false, bool isVisible = true}){
      PopupMenuItem<int> wg = PopupMenuItem(
      enabled: isVisible ? isLine ? false : true : false,
      height: isVisible ? isLine ? 2.0:40.0 : 0.0,
      value: value,
      child:  Visibility(
        visible: isVisible,
        child:  isLine? Divider(thickness: 1.0, ): Row(children: [
        Icon(icon, color: warnaIcon),
        SizedBox(width: 5.0,),
        Text(label),]))
    );
    return wg;
      }
}

class TooltipShapeKiri extends ShapeBorder {
   TooltipShapeKiri();
  final BorderSide _side = BorderSide.none;
  final BorderRadiusGeometry _borderRadius = BorderRadius.zero;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(_side.width);

  @override
  Path getInnerPath(
    Rect rect, {
    TextDirection? textDirection,
  }) {
    final Path path = Path();

    path.addRRect(
      _borderRadius.resolve(textDirection).toRRect(rect).deflate(_side.width),
    );

    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final Path path = Path();
    final RRect rrect = _borderRadius.resolve(textDirection).toRRect(rect);

    path.moveTo(0, 10);
    path.quadraticBezierTo(0, 0, 10, 0); //sudut kiri atas segi empat
    path.lineTo(rrect.width - 215, 0); //sudut kiri segitiga
    path.lineTo(rrect.width - 205, -10); // sudut 90 derajat
    path.lineTo(rrect.width - 195, 0); //sudut kanan segitiga
    path.lineTo(rrect.width - 10, 0); //sudut kanan atas segi empat 
    path.quadraticBezierTo(rrect.width, 0, rrect.width, 10);
    path.lineTo(rrect.width, rrect.height - 10); //sudut kanan bawah segi empat 
    path.quadraticBezierTo(
        rrect.width, rrect.height, rrect.width - 10, rrect.height);
    path.lineTo(10, rrect.height); //sudut kiri bawah segi empat 
    path.quadraticBezierTo(0, rrect.height, 0, rrect.height - 10);

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => RoundedRectangleBorder(
        side: _side.scale(t),
        borderRadius: _borderRadius * t,
      );
}

class TooltipShapekanan extends ShapeBorder {
   TooltipShapekanan();
  final BorderSide _side = BorderSide.none;
  final BorderRadiusGeometry _borderRadius = BorderRadius.zero;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(_side.width);

  @override
  Path getInnerPath(
    Rect rect, {
    TextDirection? textDirection,
  }) {
    final Path path = Path();

    path.addRRect(
      _borderRadius.resolve(textDirection).toRRect(rect).deflate(_side.width),
    );

    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final Path path = Path();
    final RRect rrect = _borderRadius.resolve(textDirection).toRRect(rect);

    path.moveTo(0, 10);
    path.quadraticBezierTo(0, 0, 10, 0); //sudut kiri atas segi empat
    path.lineTo(rrect.width - 30, 0); //sudut kiri segitiga
    path.lineTo(rrect.width - 20, -10); // sudut 90 derajat
    path.lineTo(rrect.width - 10, 0); //sudut kanan atas segi empat 
    path.quadraticBezierTo(rrect.width, 0, rrect.width, 10);
    path.lineTo(rrect.width, rrect.height - 10); //sudut kanan bawah segi empat 
    path.quadraticBezierTo(
        rrect.width, rrect.height, rrect.width - 10, rrect.height);
    path.lineTo(10, rrect.height); //sudut kiri bawah segi empat 
    path.quadraticBezierTo(0, rrect.height, 0, rrect.height - 10);

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => RoundedRectangleBorder(
        side: _side.scale(t),
        borderRadius: _borderRadius * t,
      );
}