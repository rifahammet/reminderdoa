import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:fswitch/fswitch.dart';

class CheckBox{

        Widget checkBox({lebars, checkBoxLabel, bool? boolValue, cbOnChage, isUpDown =false}) {
    var wg =  Container(
      padding: const EdgeInsets.all(5.0),
      width: double.parse('$lebars'),
      child:  isUpDown ? Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
           Container(
            child: Text(checkBoxLabel, textAlign: TextAlign.center,),
          ),
          Checkbox(
              value: boolValue,
              onChanged: (bool? value) {
                cbOnChage(value);
              },
            ), 
        ],
      ):Row(children: [Checkbox(
              value: boolValue,
              onChanged: (bool? value) {
                cbOnChage(value);
              },
            ),Text(checkBoxLabel)],),
    );
    return wg;
  }
  
    Widget getCheckBox(lebars, String checkBoxLabel, bool monVal, cbOnChage) {
    var wg = new Container(
      padding: const EdgeInsets.all(5.0),
      alignment: FractionalOffset.center,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Container(
            width: double.parse('$lebars'),
            child: Text(checkBoxLabel),
          ),
          new Text(' :'),
          new Expanded(
              child: Container(
            alignment: Alignment.centerLeft,
            child: Checkbox(
              value: monVal,
              onChanged: (bool? value) {
                cbOnChage(value);
              },
            ),
          ))
        ],
      ),
    );
    return wg;
  }

  Widget switchPanel({isSwitched,callbackSwitch,activeTrackColor = Colors.green,activeColor=Colors.green}){

//this goes in as one of the children in our column
var wg = Switch(
  value: isSwitched,
  onChanged: (value) {
    callbackSwitch(value);
  },
  activeTrackColor: Colors.grey[300] , 
  activeColor: Colors.grey[700],
  inactiveTrackColor: activeTrackColor[300],
  inactiveThumbColor: activeColor[700],
);

return wg;
  }

  Widget flutterToggleTab({index, callbackselectedLabelIndex,List<String>? listLabel, List<IconData>? listIcon,width=45.0,height=30.0,isActive= true,isDisable=false,selectedColor = Colors.red}){
    var wg = Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 15),
        child: IgnorePointer(
  ignoring: isDisable,
  child: FlutterToggleTab(  
  // width in percent, to set full width just set to 100  
  width: width,  
  borderRadius: 15,  
  height: height,  
  initialIndex: 0,   
selectedIndex: index,
  selectedBackgroundColors: [index == 0 ? Colors.green :selectedColor],
  selectedTextStyle: TextStyle(  
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w700),
  unSelectedTextStyle: TextStyle(  
    color: Colors.black87,
    fontSize: 14,
    fontWeight: FontWeight.w500),
  labels: isActive ? ["Active","Not Active"]: listLabel,
  icons: listIcon,  
  selectedLabelIndex: (index) {  
    callbackselectedLabelIndex(index);
  },  
)));
return wg;
  }

  Widget fSwitch({isText=true,labelClose,labelOpen, iconClose = Icons.close,iconOpen =Icons.check,isOpen,onChanged} ){
    var wg = FSwitch(
  width: 65.0,
  height: 35.538,
  open: isOpen,
  onChanged: (value) {
    onChanged(value);
  },
  closeChild: isText ? Text(
    labelClose,
    style: const TextStyle(
        color: Colors.white, fontSize: 11),
  ): Icon(
    iconClose,
    size: 16,
    color: Colors.white,
  ),
  openChild: isText ? Text(
    labelOpen,
    style: const TextStyle(
        color: Colors.white, fontSize: 11),
  ):  Icon(
    iconOpen,
    size: 16,
    color: Colors.white,
  ),
);
return wg;
  }
}