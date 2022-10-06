import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button {
   Widget RaisedButon({label="Approve", dynamic data, callBack,height=40.0,color1 = Colors.green,color2 = Colors.green}){
    var wg = ElevatedButton(
   onPressed: () {
     callBack(data);
   },
   //textColor: Colors.white,
  //  elevation: 1,
  //           highlightElevation: 2,
  //  color: Colors.transparent,
  //  padding: EdgeInsets.all(0),
  //  shape: RoundedRectangleBorder(
  //     borderRadius: new BorderRadius.circular(18.0),
  //  ),
  style: ButtonStyle(
    elevation: MaterialStateProperty.all(1),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(18.0),
                    ),
                  ),
                  ),
                      padding: MaterialStateProperty.all(EdgeInsets.all(0.0))),
   child: Container(
     alignment: Alignment.center,
     height:height,
      decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(18),
         gradient: LinearGradient(
            colors: <Color>[
               color1,
               color2,
            ],
         ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 10, 24, 12),
      child:  Text(label, style: TextStyle(fontSize: 16)),
   ),
);
return wg;
  }
  Widget raisedGradientButton (context,{label='',padding = 20.0,circular=10.0,labelColor = Colors.white,onPressed}){
    var wg = Container(
          padding: EdgeInsets.fromLTRB(padding, 0, padding, 0),
          child: ElevatedButton(
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.all(
            //     Radius.circular(circular),
            //   ),
            // ),
            // elevation: 3,
            // highlightElevation: 5,
            // textColor: Colors.black,
            // padding: EdgeInsets.all(0.0),
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(3),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(circular),
                    
                    ),
                    
                  ),
                  ),
                      padding: MaterialStateProperty.all(EdgeInsets.all(0.0))),
            child: Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(circular)),
                gradient: LinearGradient(
                  colors: <Color>[
                    Colors.green,
                    Colors.black
                  //   Color(0xFF0D47A1),
                  // Color(0xFF1976D2),
                  // Color(0xFF42A5F5),
                  ],
                ),
              ),
              padding: EdgeInsets.all(10.0),
              child: Text(
                label,
                style: TextStyle(fontSize: 20,color: labelColor),
              ),
            ),
            onPressed:onPressed,
          ),
        );

          return wg;
  }

 
}