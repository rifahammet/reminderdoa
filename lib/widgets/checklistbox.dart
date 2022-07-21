import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckListBox{
    Widget getCheckListBox(
      {context, List<dynamic>? data, isKlik, callBackOnChange,label}) {
    Widget wg = Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          alignment: Alignment.center,
          color: Colors.blue,
          child: Text(label,
              style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
        Container(
            height: (data!.length * 32).toDouble(),
            child: Center(
                child: GestureDetector(
                    child: new ListView.builder(
                        itemCount: data == null ? 0 : data.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            children: [
                              SizedBox(
                                height: 32,
                                width: 32,
                                child: Checkbox(
                                  value: data[index]["value"],
                                  onChanged: (bool? value) {
                                    callBackOnChange(value, data[index]);
                                  },
                                ),
                              ),
                              Expanded(child: Text(data[index]["label"]))
                            ],
                          );
                        }),
                    onTap: () {
                      if (!isKlik) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      }
                    })))
      ],
    );
    return wg;
  }
}