import 'package:flutter/material.dart';

class DropDown {
  Widget getDbDropdown(
      lebars, inputBoxName, context, value, cbOnChage, items, display,
      {warna = Colors.black, fontsize = 14.0, double padding = 5.0}) {
    return new Container(
        padding: const EdgeInsets.all(5.0),
        alignment: Alignment.center,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
              width: double.parse('$lebars'),
              child: Text(inputBoxName,
                  style: TextStyle(color: warna, fontSize: fontsize)),
            ),
            new Text(' :  ',
                style: TextStyle(color: warna, fontSize: fontsize)),
            Expanded(
                child: Container(
              child: new DropdownButton<dynamic>(
                isExpanded: true,
                value: value,
                onChanged: (newValue) {
                  cbOnChage(newValue);
                },
                items: items.map<DropdownMenuItem<dynamic>>((dynamic e) {
                  var ket = display(e);
                  return DropdownMenuItem<dynamic>(
                      value: e,
                      child: Text(ket,
                          style: TextStyle(color: warna, fontSize: fontsize)));
                }).toList(),
              ),
            ))
          ],
        ));
  }

  Widget getDropdown(lebars, inputBoxName, context, value, cbOnChage, items,
      {isKeyAndValue = false}) {
    return new Container(
        padding: const EdgeInsets.all(5.0),
        alignment: FractionalOffset.center,
        child: new Row(
          children: <Widget>[
            new Container(
              width: double.parse('$lebars'),
              child: Text(inputBoxName),
            ),
            new Text(' :  '),
            Expanded(
                child: Container(
              child: new DropdownButton<String>(
                isExpanded: true,
                value: value,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.black),
                underline: Container(
                  height: 2,
                  color: Colors.green,
                ),
                onChanged: (String? newValue) {
                  cbOnChage(newValue);
                },
                items: isKeyAndValue
                    ? items.entries
                        .map<DropdownMenuItem<String>>(
                            (MapEntry<String, dynamic> e) =>
                                DropdownMenuItem<String>(
                                  value: e.key,
                                  child: Text(e.value),
                                ))
                        .toList()
                    : items.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
              ),
            ))
          ],
        ));
  }

  Widget dropDownwithBorder(context,
      {label,
      value,
      cbOnChage,
      preffixIcon = null,
      items,
      isKeyAndValue = false,
      FocusNode? comboFocusNode}) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        child: InputDecorator(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[100],
              labelText: '[ ' + label.toString() + ' ]',
              labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.brown),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide: BorderSide(color: Colors.grey, width: 2)),
            ),
            child: DropdownButtonHideUnderline(
                child: Row(
              children: [
                Visibility(
                    visible: preffixIcon == null ? false : true,
                    child: Row(
                      children: [
                        Icon(
                          preffixIcon,
                          color: Colors.grey[500],
                        ),
                        SizedBox(
                          width: 10,
                        )
                      ],
                    )),
                Expanded(
                    child: DropdownButton<String>(                      
                  isExpanded: true,
                  value: value,
                  isDense: true,
                  focusNode: comboFocusNode,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.black),
                  underline: Container(
                    height: 2,
                    color: Colors.green,
                  ),
                  onChanged: (String? newValue) {
                    //print(newValue);
                    cbOnChage(newValue);
                  },
                  items: isKeyAndValue
                      ? items.entries
                          .map<DropdownMenuItem<String>>(
                              (MapEntry<String, dynamic> e) =>
                                  DropdownMenuItem<String>(
                                    value: e.key,
                                    child: Text(e.value),
                                  ))
                          .toList()
                      : items.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                ))
              ],
            ))));
  }

  Widget dropDownDbwithBorder(context,
      {label,
      value,
      cbOnChage,
      preffixIcon = null,
      display,
      items,
      isKeyAndValue = false,
      FocusNode? comboFocusNode}) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
        child: InputDecorator(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[100],
              labelText: '[ ' + label.toString() + ' ]',
              labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.brown),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide: BorderSide(color: Colors.grey, width: 2)),
            ),
            child: DropdownButtonHideUnderline(
                child: Row(
              children: [
                Visibility(
                    visible: preffixIcon == null ? false : true,
                    child: Row(
                      children: [
                        Icon(
                          preffixIcon,
                          color: Colors.grey[500],
                        ),
                       const SizedBox(
                          width: 10,
                        )
                      ],
                    )),
                Expanded(
                    child: DropdownButton<dynamic>(
                  isExpanded: true,
                  value:  value ,
                  isDense: true,
                  onChanged: (newValue) {
                    cbOnChage(newValue);
                  },
                  items: items.map<DropdownMenuItem<dynamic>>((dynamic e) {
                    var ket = display(e);
                    return DropdownMenuItem<dynamic>(
                        value: e, child: Text(ket));
                  }).toList(),
                ))
              ],
            ))));
  }

  Widget dropDownDbwithBorderNew(context,
      {label,
      value,
      cbOnChage,
      preffixIcon = null,
      display,
      items,
      isKeyAndValue = false,
      FocusNode? comboFocusNode}) {
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        child: InputDecorator(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[100],
              labelText: '[ ' + label.toString() + ' ]',
              labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.brown),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  borderSide: BorderSide(color: Colors.grey, width: 2)),
            ),
            child: DropdownButtonHideUnderline(
                child: Row(
              children: [
                Visibility(
                    visible: preffixIcon == null ? false : true,
                    child: Row(
                      children: [
                        Icon(
                          preffixIcon,
                          color: Colors.grey[500],
                        ),
                       const SizedBox(
                          width: 10,
                        )
                      ],
                    )),
                Expanded(
                    child: DropdownButton<dynamic>(
                  isExpanded: true,
                  value:  value ,
                  onChanged: (newValue) {
                    cbOnChage(newValue);
                  },
                  items: items.map<DropdownMenuItem<dynamic>>((dynamic e) {
                    var ket = display(e);
                    return DropdownMenuItem<dynamic>(
                        value: e, child: Text(ket));
                  }).toList(),
                ))
              ],
            ))));
  }
}
