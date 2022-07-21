// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doa/utils/function.dart';

class DatePicker {

   Widget datePickerBorder(context,
      {label,
      TextEditingController? textController,
      String? formatDate,
      fungsiCallback,}) {
    var wg = Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
        child: 
        Row(children: [
          Expanded(
            child: TextFormField(
          controller: textController,
          readOnly: true,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: "[ $label ]",
            labelStyle: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.brown),
            suffixIcon: IconButton(
                    onPressed: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: DateTime.parse(formatDate.toString()) == null ? DateTime.now() : DateTime.parse(formatDate.toString()) ,
                          lastDate: DateTime(2100));
                      if (date != null) {
                        fungsiCallback(Fungsi().fmtDateDay(date),
                            Fungsi().fmtDateTimeYear(date));
                      }
                    }, icon: const Icon(Icons.calendar_today)),
            filled: true,
            fillColor: Colors.grey[100],
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(color: Colors.grey, width: 2),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.grey, width: 2),
            ),
          ),
          //helperText: 'Helper text',

          //  enabledBorder: UnderlineInputBorder(
          //    borderSide: BorderSide(color: Color(0xFF6200EE)),
          //  ),
        )),
        ],)
        );
    return wg;
  }

      Widget rangeDatePickerBorder(
      {labelAwal ="Tanggal Awal",
      labelAkhir= "Tanggal Akhir",
      context,
       inputBoxControllerAwal,
       inputBoxControllerAkhir,
      formatDateAwal,
      formatDateAkhir,
      fungsiCallbackAwal,
      fungsiCallbackAkhir,
      fungsiCallbackButton,labelButton ="View",
      buttonColor1=Colors.blue,
      buttonColor2=Colors.blue,
      backgroundColor = Colors.transparent,
      Widget? addWidget
      }) {
  
    var wg =  Container(
        padding: const  EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 10),
        color: backgroundColor,
        child:  IntrinsicHeight(
          child:  Row(
            children: <Widget>[
              Expanded(
                  child: 
                   Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
            child: TextFormField(
          controller: inputBoxControllerAwal,
          readOnly: true,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: "[ $labelAwal ]",
            labelStyle: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.brown),
            suffixIcon: IconButton(
                    onPressed: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: DateTime.parse(formatDateAwal.toString()) == null ? DateTime.now() : DateTime.parse(formatDateAwal.toString()) ,
                          lastDate: DateTime(2100));
                      if (date != null) {
                        fungsiCallbackAwal(Fungsi().fmtDateDay(date),
                            Fungsi().fmtDateTimeYear(date));
                      }
                    }, icon: const Icon(Icons.calendar_today)),
            filled: true,
            fillColor: Colors.grey[100],
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(color: Colors.grey, width: 2),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.grey, width: 2),
            ),
          ),
        )),
        SizedBox(height: 10,),
        Container(
            child: TextFormField(
          controller: inputBoxControllerAkhir,
          readOnly: true,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: "[ $labelAkhir ]",
            labelStyle: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.brown),
            suffixIcon: IconButton(
                    onPressed: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: DateTime.parse(formatDateAkhir.toString()) == null ? DateTime.now() : DateTime.parse(formatDateAkhir.toString()) ,
                          lastDate: DateTime(2100));
                      if (date != null) {
                        fungsiCallbackAkhir(Fungsi().fmtDateDay(date),
                            Fungsi().fmtDateTimeYear(date));
                      }
                    }, icon: const Icon(Icons.calendar_today)),
            filled: true,
            fillColor: Colors.grey[100],
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(color: Colors.grey, width: 2),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.grey, width: 2),
            ),
          ),
        )),
                addWidget == null ? SizedBox() :addWidget
                ],
              )
              ),
              SizedBox(width: 10,),
           Container(
                    width: 100,
                    height: 130,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      elevation: 5,
                      highlightElevation: 10,
                      textColor: Colors.white,
                      padding: EdgeInsets.all(0.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          gradient: LinearGradient(
                            colors: <Color>[
                              buttonColor1,buttonColor2
                              //Theme.of(context).accentColor,
                              //Theme.of(context).primaryColorDark,
                            ],
                          ),
                        ),
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          labelButton,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      onPressed: () async {
                        fungsiCallbackButton();
                      },
                    ),
                  ),
            ],
          ),
        ));

    return wg;
  }

    Widget getRangeDatePicker(
      lebars,
      setState,
      context,
      String inputBoxNameAwal,
      String inputBoxNameAkhir,
      TextEditingController inputBoxControllerAwal,
      TextEditingController inputBoxControllerAkhir,
      {formatDateAwal,
      formatDateAkhir,
      fungsiCallbackAwal,
      fungsiCallbackAkhir,
      fungsiCallbackButton,
      backgroundColor = Colors.transparent}) {
    var wg =  Container(
        padding: const EdgeInsets.all(5.0),
        height: 107,
        color: backgroundColor,
        child:  IntrinsicHeight(
          child:  Row(
            children: <Widget>[
              Expanded(
                  child:  Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                   Row(
                    children: <Widget>[
                       Container(
                        width: double.parse('$lebars'),
                        child: Text(inputBoxNameAwal),
                      ),
                       Text(' :  '),
                       Expanded(
                        child: Container(
                            child:  TextFormField(
                          controller: inputBoxControllerAwal,
                          decoration:  InputDecoration(
                            hintText: inputBoxNameAwal,
                          ),
                          onTap: () async {
                            FocusScope.of(context)
                                .requestFocus( FocusNode());
                            final date = await showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                initialDate: DateTime.parse(formatDateAwal) == null? 
                                    DateTime.now(): DateTime.parse(formatDateAwal) ,
                                lastDate: DateTime(2100));
                            if (date != null) {
                              setState(() {
                                inputBoxControllerAwal.text =  Fungsi().fmtDateDay(date);
                                fungsiCallbackAwal( Fungsi().fmtDateYear(date));
                              });
                            }
                          },
                        )),
                      )
                    ],
                  ),
                   Row(
                    children: <Widget>[
                       Container(
                        width: double.parse('$lebars'),
                        child: Text(inputBoxNameAkhir),
                      ),
                       Text(' :  '),
                       Expanded(
                        child: Container(
                            child:  TextFormField(
                          controller: inputBoxControllerAkhir,
                          decoration:  InputDecoration(
                            hintText: inputBoxNameAkhir,
                          ),
                          onTap: () async {
                            FocusScope.of(context)
                                .requestFocus( FocusNode());
                            final date = await showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                initialDate: DateTime.parse(formatDateAkhir) == null ? 
                                    DateTime.now():DateTime.parse(formatDateAkhir),
                                lastDate: DateTime(2100));
                            if (date != null) {
                              setState(() {
                                inputBoxControllerAkhir.text = Fungsi().fmtDateDay(date);
                                fungsiCallbackAkhir(Fungsi().fmtDateYear(date));
                              });
                            }
                          },
                        )),
                      )
                    ],
                  ),
                ],
              )),
              Container(
                  padding: EdgeInsets.all(10),
                  width: 100,
                  child: Container(
                    height: 100,
                    padding: EdgeInsets.fromLTRB(5, 3, 5, 3),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      elevation: 5,
                      highlightElevation: 10,
                      textColor: Colors.white,
                      padding: EdgeInsets.all(0.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          gradient: LinearGradient(
                            colors: <Color>[
                              Theme.of(context).accentColor,
                              Theme.of(context).primaryColorDark,
                            ],
                          ),
                        ),
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "View",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      onPressed: () async {
                        fungsiCallbackButton();
                      },
                    ),
                  )),
            ],
          ),
        ));

    return wg;
  }
}
