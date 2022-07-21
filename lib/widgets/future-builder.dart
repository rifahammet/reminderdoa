import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FuturesBuilder{
  Widget futureBuilder({getData,callBack,widget}){
    var wg = FutureBuilder(
        future: getData, // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            callBack(true,snapshot.data);
          } else if (snapshot.hasError) {
             callBack(false,snapshot);
          } else {
            children = const <Widget>[
              SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Please Wait...'),
              )
            ];
          }
          return widget;
        },
      );
      return wg;
  }
}