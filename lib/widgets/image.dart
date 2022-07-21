import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class gambar {
    Widget getItemKategoriImage({String? gambar, String? itemText}) {
    var wg = Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 35,
                height: 35,
                child: Image.asset(gambar.toString()),
              ),
              SizedBox(height: 5),
              Text(
                itemText.toString(),
                style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 1.0,
              spreadRadius: 1.0,
              offset: Offset(0.0, 0.0),
            ),
          ],
          color: Colors.white,
        ),
        margin: EdgeInsets.all(10),
        height: 150.0);
    return wg;
  }
}