// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doa/utils/function.dart';
import 'package:intl/intl.dart';



class ListUp {
  Widget getTextFieldValidateWithSearch(String inputBoxName, icon,
      TextEditingController inputBoxController, textChange, search) {
    var wg = new Padding(
        padding: const EdgeInsets.all(5.0),
        child: new TextFormField(
          controller: inputBoxController,
          readOnly: true,
          validator: (value) {
            if (value!.isEmpty) {
              return inputBoxName + " must be filled.";
            }
            return null;
          },
          decoration: InputDecoration(
            fillColor: Color(0xfff6f6f6),
            filled: true,
            labelText: (inputBoxName + " :"),
            hintText: (inputBoxController.text),
            icon: Icon(icon),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                search(inputBoxName, inputBoxController.text);
              },
              child: Icon(Icons.search, semanticLabel: "Search"),
            ),
          ),
          onFieldSubmitted: (value) {
            textChange(inputBoxName, value);
          },
        ));

    return wg;
  }

  Widget getListUpValidate(context, lebars, String inputBoxName,
      TextEditingController inputBoxController,
      {int maxlength = 25,
      String defaultExt = "",
      callBackShowDialog,
      onClearInputontroller,
      isClearButton = false,
      enabled = false}) {
    var wg = new Padding(
      padding: const EdgeInsets.all(5.0),
      child: new Row(
        children: <Widget>[
          new Container(
            width: double.parse('$lebars'),
            child: Text(inputBoxName),
          ),
          new Text(' :  '),
          new Expanded(
              child: new TextFormField(
            maxLines: null,
            controller: inputBoxController,
            enabled: enabled,
            maxLength: maxlength,

            //focusNode: focusNode,
            validator: (value) {
              if (value!.isEmpty) {
                return inputBoxName + " must be filled.";
              }
              return null;
            },
            decoration: InputDecoration(),

            // onFieldSubmitted: (value) {
            //   inputBoxController.text = value + defaultExt;
            //   textChange(inputBoxName, value + defaultExt);
            // },
            onTap: () {
              inputBoxController.selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: inputBoxController.value.text.length);
            },
          )),
          Visibility(
              visible: isClearButton,
              child: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    inputBoxController.clear();
                    onClearInputontroller(inputBoxName);
                  })),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                callBackShowDialog(context);
              })
        ],
      ),
    );

    return wg;
  }

  Widget getListUp(context, lebars, String inputBoxName,
      TextEditingController inputBoxController,
      {int maxlength = 25,
      String defaultExt = "",
      callBackShowDialog,
      onClearInputontroller,
      isClearButton = false,
      enabled = false}) {
    var wg = new Padding(
      padding: const EdgeInsets.all(5.0),
      child: new Row(
        children: <Widget>[
          new Container(
            width: double.parse('$lebars'),
            child: Text(inputBoxName),
          ),
          new Text(' :  '),
          new Expanded(
              child: new TextFormField(
            maxLines: null,
            controller: inputBoxController,
            enabled: enabled,
            maxLength: maxlength,
            decoration: InputDecoration(),
            onTap: () {
              inputBoxController.selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: inputBoxController.value.text.length);
            },
          )),
          Visibility(
              visible: isClearButton,
              child: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    inputBoxController.clear();
                    onClearInputontroller(inputBoxName);
                  })),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                callBackShowDialog(context);
              })
        ],
      ),
    );

    return wg;
  }

  Widget listUpWithBorderValidate(context,
      {label,
      TextEditingController? textController,
      FocusNode? textFocusNote,
      hint,
      // ignore: avoid_init_to_null
      prefixIcon = null,
      // ignore: avoid_init_to_null

      // ignore: avoid_init_to_null
      maxlenght = null,
      // ignore: avoid_init_to_null
      isNumber = false,
      suffixIconOnPressed,
      isReadOnly = true,
      textSuffix = "",
      isInteger = false,
      isMandatory = true,
      padding= 10.0
      }) {
    textFocusNote?.addListener(() {
      if (!textFocusNote.hasFocus) {
        if (isNumber) {
          textController?.text = format(
              double.parse(textController.text.replaceAll(",", "")),
              isInteger: isInteger);
        }
      }
    });
    var wg = Padding(
        padding:  EdgeInsets.only(left: padding, right: padding, top: 5, bottom: 10),
        child: Row(
          children: [
            Expanded(
                child: TextFormField(
              textAlign: isNumber ? TextAlign.right : TextAlign.left,
              cursorColor: Colors.black,
              controller: textController,
              focusNode: textFocusNote,
              readOnly: isReadOnly,
              maxLength: maxlenght == null ? null : maxlenght,
              validator: (value) {
                if (isMandatory) {
                  if (value!.isEmpty) {
                    return label + " must be filled.";
                  } else {
                    if (isNumber) {
                      if (value == null) {
                        return '"$value" is not a valid number';
                      }
                      if (value.trim() == '') {
                        return '"$value"  is not a valid number';
                      }
                      final n = num.tryParse(value.replaceAll(",", ""));
                      if (n == null) {
                        return '"$value" is not a valid number';
                      }
                      return null;
                    } else {
                      return null;
                    }
                  }
                } else {
                  return null;
                }
              },
              keyboardType: isNumber
                  ? isInteger
                      ? const TextInputType.numberWithOptions(decimal: false)
                      : const TextInputType.numberWithOptions(decimal: true)
                  : TextInputType.text,
              onFieldSubmitted: (value) {
                if (isNumber) {
                  textController?.text =
                      format(double.parse(value.replaceAll(",", "")), isInteger: isInteger);
                 // textChange(label, value.toString());
                } else {
                  //textChange(label, value.toString());
                }
              },
              onTap: () {
                if(!isReadOnly){
                textController?.selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: textController.value.text.length);
                }
              },
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: "[ " + label + (isMandatory ? " *" : "") + " ]",
                labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.brown),
                hintText: Fungsi().isVocal(label.toString())
                    ? "Please insert  an " + label.toString().toLowerCase()
                    : "Please insert  a " + label.toString().toLowerCase(),
                suffixText: textSuffix,
                suffixIcon:  IconButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          suffixIconOnPressed(label.toString() , context);
                        },
                        icon: Icon(Icons.search)),
                prefixIcon: prefixIcon == null ? null : Icon(prefixIcon),
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[100],
                focusedErrorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 2)),
                errorBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(color: Colors.grey, width: 2)),
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
          ],
        ));
    return wg;
  }

    String format(double n, {bool isInteger = true}) {
    if (isInteger) {
      final formatter = NumberFormat("#,###", "en_US");
      return formatter.format(n);
    } else {
      final formatter = NumberFormat("#,###.00", "en_US");
      return formatter.format(n);
    }
  }
}
