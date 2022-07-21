import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ExpandableMenu {

  Widget expandableMenu({title,isDisplay, callBack, isiWidget, lebar}){
    var wg = Column(children: [
      Container(
        
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              style: BorderStyle.solid,
                              width: 1.0,
                            ),
                            color: Colors.yellow[100],
                            borderRadius: BorderRadius.circular(30.0),
                          ),

                          height: 40,
                          width: lebar,
                          child: 
                          
                            Row(
                            children: [
                                Expanded(child:            
                              Text(
                                title,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                             
                               IconButton(
                //iconSize: 48,
                icon: Icon(!isDisplay
                    ? Icons.arrow_circle_down_sharp
                    : Icons.arrow_circle_up_sharp),
                onPressed: () {
                  callBack(!isDisplay);
                  // setState(() {
                  //   isDisplay = !isDisplay;
                  // });
                },
              ),
                            ],
                          ),
                          
                          ),
      Visibility(
                            visible: isDisplay,
                            child: isiWidget())
                          ])
                          ;
                          return wg;
  }
}