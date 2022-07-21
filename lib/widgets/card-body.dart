import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardBody {

Widget cardIcon(){
  var wg = Card(
    elevation: 0.0,
    child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 70,
                        color: Colors.transparent,
                        child: Row(
                          children: <Widget>[
                            Container(
                              color: Colors.red,
                              width: 70,
                              height: 70,
                              child: Icon(Icons.cake, color: Colors.white),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('Test Title'),
                                  Text('Test Video',
                                      style: TextStyle(color: Colors.grey))
                                ],
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios,
                                color: Colors.blue),
                          ],
                        ),
                      ),
                    ),
                  ));
                  return wg;
}
}