import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BluryWidget {
  Widget bluryWidget(context,{widgetBody, blurLevel=1.0,padding =0.0} ) {
    var wg = Padding(
      padding: EdgeInsets.only(left: padding, right: padding),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
  child:
  Stack(
      children: [
    BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: blurLevel,
        sigmaY: blurLevel,
      ),
      child: Container(
        height: 220,
        width: MediaQuery.of(context).size.width -20,
        
        
      ),
    ),
    Container(
      width: MediaQuery.of(context).size.width -20,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
            )
          ],
          border: Border.all(
              color: Colors.white.withOpacity(0.2), width: 1.0),
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.5),
              Colors.white.withOpacity(0.2)
            ],
            stops: [0.0, 1.0],
          ),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: widgetBody
        // Column(
        //   children: [
        //     SizedBox(
        //       height: 10,
        //     ),

            // SizedBox(
            //   width: 270,
            //   child: Text(
            //     "Debit Card",
            //     style: TextStyle(
            //         color: Colors.white.withOpacity(0.6),
            //         fontWeight: FontWeight.bold,
            //     fontSize: 22),
            //   )),
            // SizedBox(
            //   height: 70,
            // ),
            // Text(
            //   "7622   4574   3688   3640   ",
            //   style: TextStyle(
            //       fontSize: 23, color: Colors.white.withOpacity(0.4)),
            // ),
            // SizedBox(
            //   width: 275,
            //   child: Row(
            //     children: [
            //       Text(
            //         "6372",
            //         style: TextStyle(
            //             color: Colors.white.withOpacity(0.5),
            //             fontSize: 12),
            //       ),
            //       SizedBox(
            //         width: 100,
            //       ),
            //       Text(
            //         "VALID \n THRU",
            //         style: TextStyle(
            //             fontSize: 6,
            //             color: Colors.white.withOpacity(0.5),
            //             fontWeight: FontWeight.bold),
            //       ),
            //       Text(
            //         "  09/25",
            //         style: TextStyle(
            //             fontSize: 14,
            //             color: Colors.white.withOpacity(0.5)),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // SizedBox(
            //     width: 275,
            //     child: Text(
            //       "FLUTTER DEVS",
            //       style: TextStyle(
            //           color: Colors.white.withOpacity(0.6),
            //           fontWeight: FontWeight.bold),
            //     ))
        //   ],
        // ),
      ),
    ),
  ]),
),));
    return wg;
  }
}
