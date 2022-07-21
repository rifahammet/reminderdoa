import 'package:date_format/date_format.dart';
import 'package:doa/utils/function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class TimePicker{

  Widget datePickerBorder(context,
      {label,
      TextEditingController? textController,
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
            labelStyle:  TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.brown),
            suffixIcon: IconButton(
                    onPressed: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      final jam = await showTimePicker(
                  context: context,
                  builder: (BuildContext context, Widget? child) {
                    return MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(alwaysUse24HourFormat: true),
                      child: child!,
                    );
                  },
                  initialTime: TimeOfDay(
                          hour:
                              int.parse(textController!.text.split(":")[0]),
                          minute: int.parse(
                              textController.text.split(":")[1])) ==null ?
                      TimeOfDay.now():TimeOfDay(
                          hour:
                              int.parse(textController.text.split(":")[0]),
                          minute: int.parse(
                              textController.text.split(":")[1])),
                );
                if (jam != null) {
                  //setState(() {
                    String _addLeadingZeroIfNeeded(int value) {
                      if (value < 10) return '0$value';
                      return value.toString();
                    }
                    String hourLabel = _addLeadingZeroIfNeeded(jam.hour);
                    String minuteLabel = _addLeadingZeroIfNeeded(jam.minute);
                    fungsiCallback('$hourLabel:$minuteLabel');
                   // inputBoxController.text = '$hourLabel:$minuteLabel';
                //  });
                }
                      // final date = await showDatePicker(
                      //     context: context,
                      //     firstDate: DateTime(1900),
                      //     initialDate: DateTime.parse(formatDate.toString()) == null ? DateTime.now() : DateTime.parse(formatDate.toString()) ,
                      //     lastDate: DateTime(2100));
                      // if (date != null) {
                      //   fungsiCallback(Fungsi().fmtDateDay(date),
                      //       Fungsi().fmtDateTimeYear(date));
                      // }
                    }, icon: const Icon(Icons.watch_later_outlined)),
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

    Widget getTimePicker(lebars, setState, context, String inputBoxName,
      TextEditingController inputBoxController) {
    var wg = new Container(
      padding: const EdgeInsets.all(5.0),
      child: new Row(
        children: <Widget>[
          new Container(
            width: double.parse('$lebars'),
            child: Text(inputBoxName),
          ),
          new Text(' :  '),
          new Expanded(
            child: Container(
                child: new TextFormField(
              controller: inputBoxController,
              enabled: false,
              decoration: new InputDecoration(
                hintText: inputBoxName,
              ),
              onTap: () async {},
            )),
          ),
          IconButton(
              icon: Icon(
                Icons.access_time,
                color: Colors.grey[700],
              ),
              onPressed: () async {
                FocusScope.of(context).requestFocus(new FocusNode());

                final jam = await showTimePicker(
                  context: context,
                  builder: (BuildContext context, Widget? child) {
                    return MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(alwaysUse24HourFormat: true),
                      child: child!,
                    );
                  },
                  initialTime: TimeOfDay(
                          hour:
                              int.parse(inputBoxController.text.split(":")[0]),
                          minute: int.parse(
                              inputBoxController.text.split(":")[1])) ==null ?
                      TimeOfDay.now():TimeOfDay(
                          hour:
                              int.parse(inputBoxController.text.split(":")[0]),
                          minute: int.parse(
                              inputBoxController.text.split(":")[1])),
                );
                if (jam != null) {
                  setState(() {
                    String _addLeadingZeroIfNeeded(int value) {
                      if (value < 10) return '0$value';
                      return value.toString();
                    }

                    String hourLabel = _addLeadingZeroIfNeeded(jam.hour);
                    String minuteLabel = _addLeadingZeroIfNeeded(jam.minute);
                    inputBoxController.text = '$hourLabel:$minuteLabel';
                  });
                }
              })
        ],
      ),
    );

    return wg;
  }

  Widget getTextFieldTime(lebars, setState, context, String inputBoxName,
      TextEditingController inputBoxController) {
    var wg = new Container(
      padding: const EdgeInsets.all(5.0),
      child: new Row(
        children: <Widget>[
          new Container(
            width: double.parse('$lebars'),
            child: Text(inputBoxName),
          ),
          new Text(' :  '),
          new Expanded(
            child: Container(
                child: new TextFormField(
              controller: inputBoxController,
              decoration: new InputDecoration(
                hintText: inputBoxName,
              ),
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                DatePicker.showTimePicker(
                  context,
                  showTitleActions: true,
                  //minTime: DateTime(2000, 1, 1),
                  //maxTime: DateTime(2019, 6, 7),
                  theme: DatePickerTheme(
                      headerColor: Colors.orange,
                      backgroundColor: Colors.blue,
                      itemStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
                  onChanged: (date) {
                    // print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
                  },
                  onConfirm: (time) {
                    //print('confirm $time');
                    setState(() {
                      inputBoxController.text = formatDate(time, [HH, ':', nn]);
                    });
                  },
                );
              },
            )),
          )
        ],
      ),
    );

    return wg;
  }
}