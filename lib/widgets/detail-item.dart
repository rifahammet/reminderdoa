// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sweetalert/sweetalert.dart';

class DetailItem{
  Widget getDetailItem(
      {context,
      List<dynamic>? data,
      isKlik,
      callBackView,
      isiWidget,
      callBackDelete,
      callBackAddData,
      judulTabel = '',
      warna,
      warnaHeader = Colors.blue,
      isAPI = false,
      isClosed = false,
      height = 0.0,
      primaryKey='id',
      isCardBody=true}) {
    print('data=' + data!.length.toString());
    Widget wg = Column(
      children: [
        Container(
          // padding: EdgeInsets.only(top: 10, bottom: 10),
          alignment: Alignment.center,
          color: warnaHeader,
          child: Row(
            children: [
              Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(45, 0, 0, 0),
                      child: Text('Detail ' + judulTabel,
                          style:
                              TextStyle(color: Colors.white, fontSize: 16)))),
              Visibility(
                  visible: !isClosed,
                  child: Ink(
                    decoration: ShapeDecoration(
                      color: Colors.green,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.add_circle_outline_sharp),
                      color: Colors.yellow,
                      onPressed: () async {
                        callBackAddData(data);
                      },
                    ),
                  ))
            ],
          ),
        ),
        data.length > 0
            ? 
            Center(
                child: 
                Container(
                  height: MediaQuery.of(context).size.height-height,
                  child: 
                GestureDetector(
                    child: new ListView.builder(
                        itemCount: data == null ? 0 : data.length,
                        scrollDirection: Axis.vertical,
                        physics: const AlwaysScrollableScrollPhysics(), 
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                callBackView(index);
                              },
                              child: getDeleteOnlyListItem(
                                  context: context,
                                  index: index,
                                  isiWidget: isiWidget,
                                  callBackDelete: callBackDelete,
                                  warna: warna,
                                  isAPI: isAPI,
                                  isClosed: isClosed,
                                  dataDetails: data,
                                  primaryKey: primaryKey,
                                  isCardBody:isCardBody));
                        }),
                    onTap: () {
                      if (!isKlik) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      }
                    })))
            : Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                alignment: Alignment.center,
                child: Text('Data is empty'),
              )
      ],
    );
    return wg;
  }

  Widget getDeleteOnlyListItem(
      {context, index, isiWidget, callBackDelete, warna, isAPI, isClosed,dataDetails,primaryKey,isCardBody}) {
    Widget wg =  Container(
      margin: EdgeInsets.fromLTRB(0, index == 0 ? 15 : 0, 3, 15),
       padding: isCardBody ?  EdgeInsets.fromLTRB(5, 13, 5, 13) : null,
      child:
      Column(children: [
Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            //width: 200,
            child: isiWidget == null ? Container() : isiWidget(index),
          ),
          Column(
            children: <Widget>[
              Center(
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: Colors.grey[100]),
                    child: Visibility(
                        visible: !isClosed,
                        child: Ink(
                          decoration: ShapeDecoration(
                            //color: Colors.green,
                            shape: CircleBorder(),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.delete_forever),
                            color: Colors.red,
                            onPressed: () async {
                              if (isClosed) {
                                return;
                              }
                              SweetAlert.show(context,
                                  subtitle: "Apakah ingin menghapus data",
                                  style: SweetAlertStyle.confirm,
                                  showCancelButton: true,
                                  onPress: (bool isConfirm) {
                                if (isConfirm) {
                                  SweetAlert.show(context,
                                      subtitle: "Deleting",
                                      style: SweetAlertStyle.loading);
                                      callBackDelete(isAPI,dataDetails[index]);
                //                       dataDetails!.removeWhere((item) =>
                //  item[primaryKey] == dataDetails![index][primaryKey]);
                 dataDetails!.removeAt(index);
                                  

                                  //new Future.delayed(new Duration(seconds: 2), () {
                                  if (!isAPI) {
                                    SweetAlert.show(context,
                                        subtitle: "Success",
                                        style: SweetAlertStyle.loadingSuccess);
                                    new Future.delayed(new Duration(seconds: 2),
                                        () {
                                      Navigator.of(context).pop();
                                      //setState(() {});
                                    });
                                  }else{
                                    Navigator.pop(context);
                                  }
                                  //});
                                } else {
                                  SweetAlert.show(context,
                                      subtitle: "Cancel",
                                      style: SweetAlertStyle.loadingerror);
                                  new Future.delayed(new Duration(seconds: 2),
                                      () {
                                    Navigator.pop(context);
                                  });
                                }
                                // return false to keep dialog
                                return false;
                              });
                            },
                          ),
                        ))),
              ),
            ],
          )
        ],
      ),
      Visibility(
        visible: !isCardBody,
        child:
        Padding(padding: EdgeInsets.only(top: 5),child:
        Divider(
          thickness: 1.0,
          )),)
      ],)
       ,
      decoration: isCardBody? BoxDecoration(
        gradient: LinearGradient(
          stops: [0.015, 0.015],
          colors: [warna, Colors.white],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 2.0,
            spreadRadius: 2.0,
            offset: Offset(0.0, 0.0),
          ),
        ],
      ): null,
    );
    return wg;
  }

}