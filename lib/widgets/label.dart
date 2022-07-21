import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Label{
  Widget labelStatus({label, width = 60.0, borderRadius =10.0, warna = Colors.yellow, warnaBorder = Colors.yellowAccent, isCircularRadius = true, bottomLeft=10.0, bottomRight=10.0,topLeft=10.0,topRight=10.0, fontsize =12.0, fontfamily =""}){
    var wg = Container(
          padding: EdgeInsets.all(5),
          width: width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
    borderRadius: isCircularRadius?  BorderRadius.circular(borderRadius) : BorderRadius.only(bottomLeft:Radius.circular(bottomLeft), bottomRight:  Radius.circular(bottomRight), topLeft: Radius.circular(topLeft), topRight: Radius.circular(topRight) ),
    color: warna,
    boxShadow: [
      BoxShadow(color: Colors.yellowAccent, spreadRadius: 1),
    ],
  ),
          child:Text(
          label,
          style: TextStyle(color: Colors.black, fontSize: fontsize,fontWeight: FontWeight.bold, fontFamily: fontfamily ==""?"":fontfamily),
        ));
        return wg;
  } 

    Widget labelNotifikasi({label,  borderRadius =25.0, warna = Colors.red, warnaText= Colors.white , warnaBorder = Colors.redAccent, isCircularRadius = true, bottomLeft=10.0, bottomRight=10.0,topLeft=10.0,topRight=10.0}){
    var wg = Container(
          padding: EdgeInsets.all(5),
          height: 30,
          width: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
    borderRadius: isCircularRadius?  BorderRadius.circular(borderRadius) : BorderRadius.only(bottomLeft:Radius.circular(bottomLeft), bottomRight:  Radius.circular(bottomRight), topLeft: Radius.circular(topLeft), topRight: Radius.circular(topRight) ),
    color: warna,
    boxShadow: [
      BoxShadow(color: Colors.yellowAccent, spreadRadius: 1),
    ],
  ),
          child:Text(
          label,
          style: TextStyle(color: warnaText, fontSize: 12,fontWeight: FontWeight.bold),
        ));
        return wg;
  } 
}