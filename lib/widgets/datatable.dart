import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sweetalert/sweetalert.dart';

class DataTablet {
  Widget getSearchForm(context,
      {txtFilter,
      comboSelected = '3',
      dropDownData = 0,
      returnButtonSearch,
      returnComboBox}) {
    var height = 65.0;
    var wg = new Container(
        color: Colors.white,
        padding: EdgeInsets.only(bottom: 5),
        height: height + 5,
        child: Container(
            height: height,
            padding: EdgeInsets.fromLTRB(10, 9.7, 10, 10),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(style: BorderStyle.solid, width: 1.0),
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(
                            border: Border(
                          right: BorderSide(width: 1.0),
                        )),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 5),
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                            isExpanded: false,
                            value: comboSelected,
                            onTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                            onChanged: (value) {
                              FocusScope.of(context).requestFocus(FocusNode());
                              returnComboBox(value);
                            },
                            items: (dropDownData == 0
                                    ? <String>['3', '5', '10', '15', '25']
                                    : dropDownData)
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          )),
                        )),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: new TextFormField(
                        controller: txtFilter,
                        textAlign: TextAlign.center,
                        decoration: new InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 15.0, top: 10.0, bottom: 15.0)),
                        onTap: () {
                          txtFilter.selection = TextSelection(
                              baseOffset: 0,
                              extentOffset: txtFilter.value.text.length);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => txtFilter.clear(),
                          icon: Icon(Icons.clear, size: 30 * 0.6),
                        ),
                        Container(
                            decoration: BoxDecoration(
                                border: Border(
                              left: BorderSide(width: 1.0),
                            )),
                            child: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () async {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                returnButtonSearch();
                              },
                            ))
                      ],
                    )
                  ],
                ))));
    return wg;
  }

  Widget getListData(
      {context,
      newData,
      filePNG = '',
      callBackView,
      callBackEdit,
      callBackDelete,
      isKlik,
      isiWidget,
      bool isSeperateLine = true,
      bool isNoDecoration = false,
      bool isCustom = false,
      Color warna = Colors.blue,
      bool isDeleteOnly = false,
      bool isEditOnly = false,
      bool isAktifGantiWarna = false,
      bool isAPI = false,
      bool isListUP = false,
      bool isClosed = false,
      fieldGantiWarna = "isActive",
      int paramGantiWarna = 1}) {
    //print('data list=' + newData.length.toString());
    Widget wg = Expanded(
        child: Center(
      child: newData.length > 0
          ? GestureDetector(
              child: ListView.builder(
                  itemCount: newData == null ? 0 : newData.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        GestureDetector(
                            onTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              callBackView(index);
                            },
                            child: isCustom
                                ? isiWidget(index)
                                : isListUP
                                    ? getListUpOnly(
                                        callBackEdit: callBackEdit,
                                        context: context,
                                        index: index,
                                        isiWidget: isiWidget,
                                        warna: isAktifGantiWarna
                                            ? int.parse(newData[index]
                                                            [fieldGantiWarna]
                                                        .toString()) ==
                                                    paramGantiWarna
                                                ? warna
                                                : Colors.red
                                            : warna,
                                      )
                                    : isDeleteOnly
                                        ? getDeleteOnly(
                                            callBackDelete: callBackDelete,
                                            context: context,
                                            filePNG: filePNG,
                                            index: index,
                                            isiWidget: isiWidget,
                                            isNoDecoration: isNoDecoration,
                                            warna: isAktifGantiWarna
                                                ? int.parse(newData[index][
                                                                fieldGantiWarna]
                                                            .toString()) ==
                                                        paramGantiWarna
                                                    ? warna
                                                    : Colors.red
                                                : warna,
                                            isAPI: isAPI,
                                            isClosed: isClosed)
                                        : isEditOnly
                                            ? getEditOnly(
                                                callBackEdit: callBackEdit,
                                                context: context,
                                                filePNG: filePNG,
                                                index: index,
                                                isiWidget: isiWidget,
                                                isNoDecoration: isNoDecoration,
                                                isClosed: isClosed,
                                                warna: isAktifGantiWarna
                                                    ? int.parse(newData[index][
                                                                    fieldGantiWarna]
                                                                .toString()) ==
                                                            paramGantiWarna
                                                        ? warna
                                                        : Colors.red
                                                    : warna)
                                            : getDeleteEdit(
                                                callBackDelete: callBackDelete,
                                                callBackEdit: callBackEdit,
                                                context: context,
                                                filePNG: filePNG,
                                                index: index,
                                                isiWidget: isiWidget,
                                                warna: isAktifGantiWarna
                                                    ? int.parse(newData[index][
                                                                    fieldGantiWarna]
                                                                .toString()) ==
                                                            paramGantiWarna
                                                        ? warna
                                                        : Colors.red
                                                    : warna,
                                                isAPI: isAPI,
                                                isClosed: isClosed)),
                        Visibility(
                            visible: isNoDecoration,
                            child: Padding(
                                padding:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                child: isSeperateLine
                                    ? Divider(
                                        thickness: 1,
                                      )
                                    : SizedBox(
                                        height: 10.0,
                                      )))
                      ],
                    );
                  }),
              onTap: () {
                if (!isKlik) {
                  FocusScope.of(context).requestFocus(FocusNode());
                }
              })
          : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  height: 100,
                  width: 100,
                  padding: EdgeInsets.all(5),
                  child: Image.asset(
                    'assets/images/widget-icons/empty-folder.png',
                  )),
              Text("Data is Empty")
            ]),
    ));
    return wg;
  }

  Widget getListDataNoScroll(
      {context,
      newData,
      filePNG = '',
      callBackView,
      callBackEdit,
      callBackDelete,
      isKlik,
      isiWidget,
      bool isNoDecoration = false,
      bool isCustom = false,
      Color warna = Colors.blue,
      bool isDeleteOnly = false,
      bool isEditOnly = false,
      bool isAktifGantiWarna = false,
      bool isAPI = false,
      bool isListUP = false,
      bool isClosed = false,
      fieldGantiWarna = "isActive",
      int paramGantiWarna = 1}) {
    //print('data list=' + newData.length.toString());
    Widget wg = Expanded(
        child: Center(
      child: newData.length > 0
          ? GestureDetector(
              child: SingleChildScrollView(
                  child: Column(children: [
                ListView.builder(
                    itemCount: newData == null ? 0 : newData.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          GestureDetector(
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                callBackView(index);
                              },
                              child: isCustom
                                  ? isiWidget(index)
                                  : isListUP
                                      ? getListUpOnly(
                                          callBackEdit: callBackEdit,
                                          context: context,
                                          index: index,
                                          isiWidget: isiWidget,
                                          warna: isAktifGantiWarna
                                              ? int.parse(newData[index]
                                                              [fieldGantiWarna]
                                                          .toString()) ==
                                                      paramGantiWarna
                                                  ? warna
                                                  : Colors.red
                                              : warna,
                                        )
                                      : isDeleteOnly
                                          ? getDeleteOnly(
                                              callBackDelete: callBackDelete,
                                              context: context,
                                              filePNG: filePNG,
                                              index: index,
                                              isiWidget: isiWidget,
                                              isNoDecoration: isNoDecoration,
                                              warna: isAktifGantiWarna
                                                  ? int.parse(newData[index][
                                                                  fieldGantiWarna]
                                                              .toString()) ==
                                                          paramGantiWarna
                                                      ? warna
                                                      : Colors.red
                                                  : warna,
                                              isAPI: isAPI,
                                              isClosed: isClosed)
                                          : isEditOnly
                                              ? getEditOnly(
                                                  callBackEdit: callBackEdit,
                                                  context: context,
                                                  filePNG: filePNG,
                                                  index: index,
                                                  isiWidget: isiWidget,
                                                  isNoDecoration:
                                                      isNoDecoration,
                                                  isClosed: isClosed,
                                                  warna: isAktifGantiWarna
                                                      ? int.parse(newData[index]
                                                                      [
                                                                      fieldGantiWarna]
                                                                  .toString()) ==
                                                              paramGantiWarna
                                                          ? warna
                                                          : Colors.red
                                                      : warna)
                                              : getDeleteEdit(
                                                  callBackDelete:
                                                      callBackDelete,
                                                  callBackEdit: callBackEdit,
                                                  context: context,
                                                  filePNG: filePNG,
                                                  index: index,
                                                  isiWidget: isiWidget,
                                                  warna: isAktifGantiWarna
                                                      ? int.parse(newData[index]
                                                                      [
                                                                      fieldGantiWarna]
                                                                  .toString()) ==
                                                              paramGantiWarna
                                                          ? warna
                                                          : Colors.red
                                                      : warna,
                                                  isAPI: isAPI,
                                                  isClosed: isClosed)),
                          Visibility(
                              visible: isNoDecoration,
                              child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 10.0, right: 10.0),
                                  child: Divider(
                                    thickness: 1,
                                  )))
                        ],
                      );
                    })
              ])),
              onTap: () {
                if (!isKlik) {
                  FocusScope.of(context).requestFocus(FocusNode());
                }
              })
          : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  height: 100,
                  width: 100,
                  padding: EdgeInsets.all(5),
                  child: Image.asset(
                    'assets/images/widget-icons/empty-folder.png',
                  )),
              Text("Data is Empty")
            ]),
    ));
    return wg;
  }

  Widget getListUpOnly({context, index, isiWidget, callBackEdit, warna}) {
    Widget wg = Container(
      margin: EdgeInsets.fromLTRB(10, index == 0 ? 5 : 0, 10, 10),
      padding: EdgeInsets.fromLTRB(5, 13, 5, 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: isiWidget == null ? Container() : isiWidget(index),
          ),
          Column(
            children: <Widget>[
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey[200]),
                  child: Ink(
                    decoration: ShapeDecoration(
                      color: Colors.green,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.check),
                      color: Colors.green,
                      onPressed: () async {
                        callBackEdit(index);
                      },
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            stops: [0.015, 0.015],
            colors: [warna, Colors.white],
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 2.0,
              spreadRadius: 2.0,
              offset: Offset(0.0, 0.0),
            ),
          ]),
    );
    return wg;
  }

  Widget getEditOnly(
      {context,
      index,
      filePNG,
      isiWidget,
      callBackEdit,
      warna,
      isNoDecoration,
      isClosed}) {
    Widget wg = Container(
      margin: EdgeInsets.fromLTRB(
          10, index == 0 ? 15 : 0, 10, isNoDecoration ? 0 : 15),
      padding: EdgeInsets.fromLTRB(
          5, isNoDecoration ? 0 : 13, 5, isNoDecoration ? 0 : 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Visibility(
            visible: filePNG == '' ? false : true,
            child: Container(
              margin: EdgeInsets.only(left: 10),
              padding: EdgeInsets.all(5),
              child: Image.asset(filePNG),
              width: 60,
              height: 60,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: isiWidget == null ? Container() : isiWidget(index),
          ),
          Visibility(
              visible: !isClosed,
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey[200]),
                      child: Ink(
                        decoration: ShapeDecoration(
                          color: Colors.green[300],
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.edit),
                          color: Colors.green,
                          onPressed: () async {
                            callBackEdit(index);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
      decoration: isNoDecoration
          ? null
          : BoxDecoration(
              gradient: LinearGradient(
                stops: [0.015, 0.015],
                colors: [warna, Colors.white],
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 2.0,
                  spreadRadius: 2.0,
                  offset: Offset(0.0, 0.0),
                ),
              ],
            ),
    );
    return wg;
  }

  Widget getDeleteOnly(
      {context,
      index,
      filePNG = '',
      isiWidget,
      callBackDelete,
      isNoDecoration,
      warna,
      isAPI,
      isClosed,
      isSingleClose}) {
    Widget wg = Container(
      margin: EdgeInsets.fromLTRB(
          10, index == 0 ? 0 : 0, 10, isNoDecoration ? 0 : 15),
      padding: EdgeInsets.fromLTRB(
          5, isNoDecoration ? 0 : 0, 5, isNoDecoration ? 0 : 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Visibility(
            visible: filePNG == '' ? false : true,
            child: Container(
              margin: EdgeInsets.only(left: 10),
              padding: EdgeInsets.all(5),
              child: Image.asset(filePNG),
              width: 60,
              height: 60,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            //width: 200,
            child: isiWidget == null ? Container() : isiWidget(index),
          ),
          Column(
            children: <Widget>[
              Center(
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.grey[200]),
                    child: Visibility(
                        visible: !isClosed,
                        child: Ink(
                          decoration: ShapeDecoration(
                            color: Colors.green,
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
                                  subtitle: "Ingin hapus data",
                                  style: SweetAlertStyle.confirm,
                                  showCancelButton: true,
                                  onPress: (bool isConfirm) {
                                if (isConfirm) {
                                  SweetAlert.show(context,
                                      subtitle: "Deleting",
                                      style: SweetAlertStyle.loading);
                                  callBackDelete(index);

                                  //new Future.delayed(new Duration(seconds: 2), () {
                                  if (!isAPI) {
                                    SweetAlert.show(context,
                                        subtitle: "Success",
                                        style: SweetAlertStyle.loadingSuccess);
                                    new Future.delayed(new Duration(seconds: 2),
                                        () {
                                      Navigator.pop(context);
                                      //setState(() {});
                                    });
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
      decoration: isNoDecoration
          ? null
          : BoxDecoration(
              gradient: LinearGradient(
                stops: [0.015, 0.015],
                colors: [warna, Colors.white],
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 2.0,
                  spreadRadius: 2.0,
                  offset: Offset(0.0, 0.0),
                ),
              ],
            ),
    );
    return wg;
  }

  Widget getDeleteEdit(
      {context,
      index,
      filePNG = '',
      isiWidget,
      callBackEdit,
      callBackDelete,
      warna,
      isAPI,
      isClosed}) {
    Widget wg = Container(
      margin: EdgeInsets.fromLTRB(10, index == 0 ? 15 : 0, 10, 15),
      padding: EdgeInsets.fromLTRB(5, 13, 5, 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Visibility(
              visible: filePNG == '' ? false : true,
              child: Container(
                  margin: EdgeInsets.only(left: 10),
                  padding: EdgeInsets.all(5),
                  child: Image.asset(
                      //'assets/images/hydroponic-gardening1.png'
                      filePNG))),
          SizedBox(width: 10),
          Expanded(
            child: isiWidget == null ? Container() : isiWidget(index),
          ),
          Column(
            children: <Widget>[
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey[200]),
                  child: Ink(
                    decoration: ShapeDecoration(
                      color: Colors.green,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.edit),
                      color: Colors.green,
                      onPressed: () {
                        callBackEdit(index);
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey[200]),
                  child: Ink(
                    decoration: ShapeDecoration(
                      color: Colors.green,
                      shape: CircleBorder(),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.delete_forever),
                      color: Colors.red,
                      onPressed: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (isClosed) {
                          return;
                        }
                        SweetAlert.show(context,
                            subtitle: "Ingin menghapus data",
                            style: SweetAlertStyle.confirm,
                            showCancelButton: true, onPress: (bool isConfirm) {
                          if (isConfirm) {
                            SweetAlert.show(context,
                                subtitle: "Deleting",
                                style: SweetAlertStyle.loading);
                            callBackDelete(index);
                            if (!isAPI) {
                              //new Future.delayed(new Duration(seconds: 2), () {
                              SweetAlert.show(context,
                                  subtitle: "Success",
                                  style: SweetAlertStyle.loadingSuccess);
                              new Future.delayed(new Duration(seconds: 2), () {
                                Navigator.pop(context);
                                //setState(() {});
                              });
                              //});
                            }
                          } else {
                            SweetAlert.show(context,
                                subtitle: "Cancel",
                                style: SweetAlertStyle.loadingerror);
                            new Future.delayed(new Duration(seconds: 2), () {
                              Navigator.pop(context);
                            });
                          }
                          // return false to keep dialog
                          return false;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          stops: [0.015, 0.015],
          colors: [warna, Colors.white],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 2.0,
            spreadRadius: 2.0,
            offset: Offset(0.0, 0.0),
          ),
        ],
      ),
    );
    return wg;
  }
}
