import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doa/utils/function.dart';

class TextBox {
  Widget textBoxBorderedIcon(context,
      {hint, icon, padding = 0, textController, isEnabled = true}) {
    var wg = Container(
        width: MediaQuery.of(context).size.width - padding,
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: TextField(
          controller: textController,
          enabled: isEnabled,
          autocorrect: true,
          onTap: () {
            textController.selection = TextSelection(
                baseOffset: 0, extentOffset: textController.value.text.length);
          },
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            hintStyle: TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.white70,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(color: Colors.grey, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.grey, width: 2),
            ),
          ),
        ));
    return wg;
  }

  Widget textBoxBorderedIconValidate(context,
      {textName,
      hint,
      icon,
      padding = 0,
      obscureText = false,
      textController,
      isEnabled = true,
      int maxlength = 25,
      bool isNumber = false,
      bool isMultiLine = false,
      // ignore: avoid_init_to_null
      suffixIcon = null,
      textChange,
      suffixIconIconOnPressed}) {
    var wg = Container(
        width: MediaQuery.of(context).size.width - padding,
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: TextFormField(
          controller: textController,
          enabled: isEnabled,
          validator: (value) {
            if (value!.isEmpty) {
              return textName + " must be filled.";
            }
            return null;
          },
          keyboardType: isMultiLine
              ? TextInputType.multiline
              : isNumber
                  ? TextInputType.phone
                  : TextInputType.text,
          obscureText: obscureText,
          autocorrect: obscureText ? true : false,
          onFieldSubmitted: (value) {
            if (isNumber) {
              textController?.text = format(
                  double.parse(value.replaceAll(",", "")),
                  isInteger: true);
              textChange(textName, value.toString());
            } else {
              textChange(textName, value.toString());
            }
          },
          onTap: () {
            textController.selection = TextSelection(
                baseOffset: 0, extentOffset: textController.value.text.length);
          },
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.white70,
            suffixIcon: suffixIcon == null
                ? null
                : IconButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      suffixIconIconOnPressed(obscureText);
                    },
                    icon: Icon(suffixIcon)),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(color: Colors.grey, width: 2),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(color: Colors.grey, width: 2),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(color: Colors.grey, width: 2),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.grey, width: 2),
            ),
          ),
        ));
    return wg;
  }

  Widget textBoxBorderedIconEmailValidate(
    context, {
    textName,
    hint,
    icon,
    padding = 0,
    textController,
    isEnabled = true,
  }) {
    var wg = Container(
        width: MediaQuery.of(context).size.width - padding,
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: TextFormField(
          controller: textController,
          enabled: isEnabled,
          validator: (value) {
            if (value!.isEmpty) {
              return textName + " must be filled.";
            }
            Pattern pattern =
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            RegExp regex = new RegExp(pattern.toString());
            if (!regex.hasMatch(value)) {
              return 'Enter Valid Email';
            }

            return null;
          },
          keyboardType: TextInputType.emailAddress,
          maxLines: null,
          autocorrect: true,
          onTap: () {
            textController.selection = TextSelection(
                baseOffset: 0, extentOffset: textController.value.text.length);
          },
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            hintStyle: TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.white70,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(color: Colors.grey, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(color: Colors.grey, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(color: Colors.grey, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.grey, width: 2),
            ),
          ),
        ));
    return wg;
  }

  Widget textboxWithBorderValidate(context,
      {label,
      TextEditingController? textController,
      FocusNode? textFocusNote,
      hint,
      // ignore: avoid_init_to_null
      prefixIcon = null,
      // ignore: avoid_init_to_null
      suffixIcon = null,
      // ignore: avoid_init_to_null
      maxlenght = null,
      // ignore: avoid_init_to_null
      maxlines = null,
      isNumber = false,
      isEmail = false,
      isReadOnly = false,
      prefixIconOnPressed,
      textChange,
      textSuffix = "",
      isInteger = false,
      isMandatory = true}) {
    var wg = Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
        child: Row(
          children: [
            Expanded(
                child: 
                Focus(
                  onFocusChange: (hasFocus) {
                    if(!hasFocus){
    if (isNumber) {
                  textController?.text = format(
                      double.parse(textController.text.replaceAll(",", "")),
                      isInteger: isInteger);
                  textChange(label, textController?.text.toString());
                } else {
                  textChange(label, textController?.text.toString());
                }
                    }
  },
                  child: 
                TextFormField(
              textAlign: isNumber ? TextAlign.right : TextAlign.left,
              cursorColor: Colors.black,
              controller: textController,
              focusNode: textFocusNote,
              maxLines: maxlines,
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
                      if (isEmail) {
                        Pattern pattern =
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                        RegExp regex = new RegExp(pattern.toString());
                        if (!regex.hasMatch(value)) {
                          return 'Enter Valid Email';
                        }

                        return null;
                      } else {
                        return null;
                      }
                    }
                  }
                } else {
                  return null;
                }
              },
              keyboardType: maxlines != null
                  ? TextInputType.multiline
                  : isNumber
                      ? isInteger
                          ? const TextInputType.numberWithOptions(
                              decimal: false)
                          : const TextInputType.numberWithOptions(decimal: true)
                      : TextInputType.text,
                      
              onFieldSubmitted: (value) {
                if (isNumber) {
                  textController?.text = format(
                      double.parse(value.replaceAll(",", "")),
                      isInteger: isInteger);
                  textChange(label, value.toString());
                } else {
                  textChange(label, value.toString());
                }
              },
              onTap: () {
                if (!isReadOnly) {
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
                suffixIcon: suffixIcon == null
                    ? null
                    : IconButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          prefixIconOnPressed;
                        },
                        icon: Icon(suffixIcon)),
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
            )
                )
            ),
          ],
        ));
    return wg;
  }

  Widget textBoxwithBorderConfirmedPasswordValidate(
      {context,
      labelNew,
      labelOld,
      labelConfirm,
      isMandatory,
      suffixIconOnPressed,
      suffixIcon,
      String? inputBoxOldPassword,
      String? inputBoxName,
      String? inputBoxConfirmation,
      TextEditingController? oldPasswordController,
      TextEditingController? newPasswordController,
      TextEditingController? confirmationPasswordController,
      obscureText1,
      bool isPertama = false}) {
    var wg = Column(
      children: [
        Visibility(
          visible: !isPertama,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
            child: TextFormField(
              controller: oldPasswordController,
              obscureText: obscureText1,
              validator: (value) {
                if (value!.isEmpty) {
                  return labelOld + " must be filled.";
                } else {
                  if (value.length < 6) {
                    return labelOld + " must be more than six character.";
                  }
                }
                return null;
              },
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: "[ " + labelOld + (isMandatory ? " *" : "") + " ]",
                labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.brown),
                hintText: Fungsi().isVocal(labelOld.toString())
                    ? "Please insert  an " + labelOld.toString().toLowerCase()
                    : "Please insert  a " + labelOld.toString().toLowerCase(),
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
              onSaved: (text) {},
              onTap: () {
                oldPasswordController!.selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: oldPasswordController.value.text.length);
              },
            ),
          ),
        ),
        Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
            child: TextFormField(
              //keyboardType: TextInputType.number,
              //inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              controller: newPasswordController,
              obscureText: obscureText1,
              validator: (value) {
                if (value!.isEmpty) {
                  return labelNew + " must be filled.";
                } else {
                  if (value.length < 6) {
                    return labelNew + " must be more than six character.";
                  }
                }
                return null;
              },

              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: "[ " + labelNew + (isMandatory ? " *" : "") + " ]",
                labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.brown),
                hintText: Fungsi().isVocal(labelNew.toString())
                    ? "Please insert  an " + labelNew.toString().toLowerCase()
                    : "Please insert  a " + labelNew.toString().toLowerCase(),
                suffixIcon: IconButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      suffixIconOnPressed(obscureText1);
                    },
                    icon: Icon(!obscureText1
                        ? Icons.visibility_off
                        : Icons.visibility)),
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
              onSaved: (text) {},
              onTap: () {
                newPasswordController!.selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: newPasswordController.value.text.length);
              },
            )),

        /* end disini */

        /* disini */
        Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
          child: TextFormField(
            controller: confirmationPasswordController,
            obscureText: obscureText1,
            validator: (value) {
              if (value!.isEmpty) {
                return labelConfirm + " must be filled.";
              } else {
                if (value.length < 6) {
                  return labelConfirm! + " must be more than 6 character.";
                }
              }
              return null;
            },
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelText: "[ " + labelConfirm + (isMandatory ? " *" : "") + " ]",
              labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.brown),
              hintText: Fungsi().isVocal(labelConfirm.toString())
                  ? "Please insert  an " + labelConfirm.toString().toLowerCase()
                  : "Please insert  a " + labelConfirm.toString().toLowerCase(),

              // suffixIcon: IconButton(
              //         onPressed: (){
              //           FocusScope.of(context).unfocus();
              //           suffixIconOnPressed;
              //           }, icon: Icon(
              //             obscureText1 ? Icons.visibility_off : Icons.visibility,
              //             semanticLabel:
              //                 obscureText1)),

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
            onSaved: (text) {},
            onTap: () {
              confirmationPasswordController!.selection = TextSelection(
                  baseOffset: 0,
                  extentOffset:
                      confirmationPasswordController.value.text.length);
            },
          ),
        ),
      ],
    );
    return wg;
  }

  Widget getTextFieldHide(
      String inputBoxName, TextEditingController inputBoxController) {
    var wg = Visibility(
        visible: false,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: TextFormField(
            controller: inputBoxController,
            decoration: InputDecoration(
              hintText: inputBoxName,
            ),
          ),
        ));

    return wg;
  }

  Widget getTextFieldPasswordValidate(
      lebars,
      String inputBoxName,
      TextEditingController inputBoxController,
      textChange,
      _obscureText,
      toggle) {
    var wg = Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[
          Container(
            width: double.parse('$lebars'),
            child: Text(inputBoxName),
          ),
          Text(' :  '),
          Expanded(
              child: TextFormField(
            //keyboardType: TextInputType.number,
            //inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
            controller: inputBoxController,
            obscureText: _obscureText,
            validator: (value) {
              if (value!.isEmpty) {
                return inputBoxName + " must be filled.";
              } else {
                if (value.length < 6) {
                  return inputBoxName + " must be more than six character.";
                }
              }
              return null;
            },

            decoration: const InputDecoration(),
            onFieldSubmitted: (value) {
              textChange(inputBoxName, value);
            },
            onTap: () {
              inputBoxController.selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: inputBoxController.value.text.length);
            },
          )),
          FlatButton(
              onPressed: toggle(inputBoxName, _obscureText),
              child: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
                semanticLabel: _obscureText ? 'show password' : 'hide password',
              ))
        ],
      ),
    );

    return wg;
  }

  Widget getTextFieldConfirmedPasswordValidate(
      lebars,
      String inputBoxOldPassword,
      String inputBoxName,
      String inputBoxConfirmation,
      TextEditingController oldPasswordController,
      TextEditingController newPasswordController,
      TextEditingController confirmationPasswordController,
      textChange,
      _obscureText1,
      toggle,
      {isFirst = false}) {
    var wg = new Column(
      children: [
        Visibility(
          visible: !isFirst,
          child: new Padding(
            padding: const EdgeInsets.all(5.0),
            child: new Row(
              children: <Widget>[
                new Container(
                  width: double.parse('$lebars'),
                  child: Text(inputBoxOldPassword),
                ),
                new Text(' :  '),
                new Expanded(
                    child: new TextFormField(
                  //keyboardType: TextInputType.number,
                  //inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  controller: oldPasswordController,
                  obscureText: _obscureText1,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return inputBoxOldPassword + " must be filled.";
                    } else {
                      if (value.length < 6) {
                        return inputBoxOldPassword +
                            " must be more than six character.";
                      }
                    }
                    return null;
                  },

                  decoration: InputDecoration(),
                  onSaved: (text) {},
                  onTap: () {
                    oldPasswordController.selection = TextSelection(
                        baseOffset: 0,
                        extentOffset: oldPasswordController.value.text.length);
                  },
                )),
                // new SizedBox(
                //     width: 50,
                //     child: FlatButton(
                //         onPressed: () async {
                //           toggle(_obscureText1);
                //         },
                //         child: Icon(
                //           _obscureText1 ? Icons.visibility_off : Icons.visibility,
                //           semanticLabel:
                //               _obscureText1 ? 'show password' : 'hide password',
                //         )))
              ],
            ),
          ),
        ),
        new Padding(
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
                //keyboardType: TextInputType.number,
                //inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                controller: newPasswordController,
                obscureText: _obscureText1,
                validator: (value) {
                  if (value!.isEmpty) {
                    return inputBoxName + " must be filled.";
                  } else {
                    if (value.length < 6) {
                      return inputBoxName + " must be more than six character.";
                    }
                  }
                  return null;
                },

                decoration: InputDecoration(),
                onSaved: (text) {},
                onTap: () {
                  newPasswordController.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: newPasswordController.value.text.length);
                },
              )),
              new SizedBox(
                  width: 50,
                  child: FlatButton(
                      onPressed: () async {
                        toggle(_obscureText1);
                      },
                      child: Icon(
                        _obscureText1 ? Icons.visibility_off : Icons.visibility,
                        semanticLabel:
                            _obscureText1 ? 'show password' : 'hide password',
                      )))
            ],
          ),
        ),
        /* end disini */

        /* disini */
        new Padding(
          padding: const EdgeInsets.all(5.0),
          child: new Row(
            children: <Widget>[
              new Container(
                width: double.parse('$lebars'),
                child: Text("Re-Password"),
              ),
              new Text(' :  '),
              new Expanded(
                  child: new TextFormField(
                //keyboardType: TextInputType.number,
                //inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                controller: confirmationPasswordController,
                obscureText: _obscureText1,
                validator: (value) {
                  if (value!.isEmpty) {
                    return inputBoxConfirmation + " must be filled.";
                  } else {
                    if (value.length < 6) {
                      return inputBoxConfirmation +
                          " must be more than 6 character.";
                    }
                  }
                  return null;
                },

                decoration: InputDecoration(),
                onSaved: (text) {},
                onTap: () {
                  confirmationPasswordController.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset:
                          confirmationPasswordController.value.text.length);
                },
              )),
            ],
          ),
        ),
      ],
    );
    return wg;
  }

  Widget getEmailFieldValidate(lebars, String inputBoxName,
      TextEditingController inputBoxController, textChange,
      {bool isEnable = true}) {
    var wg = Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[
          Container(
            width: double.parse('$lebars'),
            child: Text(inputBoxName),
          ),
          Text(' :  '),
          Expanded(
              child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            //inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
            controller: inputBoxController,
            enabled: isEnable,
            validator: (value) {
              if (value!.isEmpty) {
                return inputBoxName + " must be filled.";
              }
              Pattern pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regex = RegExp(pattern.toString());
              if (!regex.hasMatch(value)) {
                return 'Enter Valid Email';
              }

              return null;
            },

            decoration: const InputDecoration(),
            onFieldSubmitted: (value) {
              textChange(inputBoxName, value);
            },
            onTap: () {
              inputBoxController.selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: inputBoxController.value.text.length);
            },
          ))
        ],
      ),
    );

    return wg;
  }

  Widget getTextFieldValidateNumberBetween(
      lebars,
      String inputBoxName,
      TextEditingController inputBoxController,
      FocusNode _focusNode,
      textChange,
      minValue,
      maxValue,
      {String param = '',
      bool isInteger = true,
      bool isEnable = true}) {
    // _focusNode.addListener(() {
    //   if (!_focusNode.hasFocus) {
    //     inputBoxController.text = format(
    //         double.parse(inputBoxController.text.replaceAll(",", "")),
    //         isInteger: isInteger);
    //   }
    // });
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
            keyboardType: isInteger
                ? TextInputType.numberWithOptions(decimal: false)
                : TextInputType.numberWithOptions(decimal: true),
            //inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
            controller: inputBoxController,
            focusNode: _focusNode,
            enabled: isEnable,
            validator: (value) {
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
              if ((n >= minValue && n <= maxValue) == false) {
                return '"$value" is not a valid number from ' +
                    minValue.toString() +
                    ' to ' +
                    maxValue.toString();
              }

              return null;
            },

            decoration: new InputDecoration(
              hintText: "Number(" +
                  minValue.toString() +
                  " - " +
                  maxValue.toString() +
                  ")",
            ),
            onFieldSubmitted: (value) {
              inputBoxController.text = format(
                  double.parse(value.replaceAll(",", "")),
                  isInteger: isInteger);
              textChange(inputBoxName, value.toString());
            },
            onTap: () {
              inputBoxController.selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: inputBoxController.value.text.length);
            },
          )),
          Text(param)
        ],
      ),
    );

    return wg;
  }

  Widget getTextFieldValidateNumber(
      lebars,
      String inputBoxName,
      TextEditingController inputBoxController,
      FocusNode _focusNode,
      textChange,
      {String param = '',
      bool isInteger = true,
      bool isEnable = true}) {
    // _focusNode.addListener(() {
    //   if (!_focusNode.hasFocus) {
    //     inputBoxController.text = format(
    //         double.parse(inputBoxController.text.replaceAll(",", "")),
    //         isInteger: isInteger);
    //   }
    // });
    var wg = Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[
          Container(
            width: double.parse('$lebars'),
            child: Text(inputBoxName),
          ),
          const Text(' :  '),
          Expanded(
              child: TextFormField(
            keyboardType: isInteger
                ? const TextInputType.numberWithOptions(decimal: false)
                : const TextInputType.numberWithOptions(decimal: true),
            //inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
            controller: inputBoxController,
            focusNode: _focusNode,
            enabled: isEnable,
            validator: (value) {
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
            },

            decoration: const InputDecoration(
                // hintText: inputBoxName,
                ),
            onFieldSubmitted: (value) {
              inputBoxController.text = format(
                  double.parse(value.replaceAll(",", "")),
                  isInteger: isInteger);
              textChange(inputBoxName, value.toString());
            },
            onTap: () {
              inputBoxController.selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: inputBoxController.value.text.length);
            },
          )),
          Text(param)
        ],
      ),
    );

    return wg;
  }

  Widget getTextField(lebars, String inputBoxName,
      TextEditingController inputBoxController, bool number,
      {String param = '', bool isEnable = true}) {
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
            child: number
                ? new TextFormField(
                    //keyboardType: TextInputType.number,
                    //inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                    controller: inputBoxController,
                    enabled: isEnable,
                    decoration: new InputDecoration(
                        //hintText: inputBoxName,
                        ),
                  )
                : new TextFormField(
                    controller: inputBoxController,
                    enabled: isEnable,
                    decoration: new InputDecoration(
                        //hintText: inputBoxName,
                        ),
                    onTap: () {
                      inputBoxController.selection = TextSelection(
                          baseOffset: 0,
                          extentOffset: inputBoxController.value.text.length);
                    },
                  ),
          ),
          Text(param)
        ],
      ),
    );

    return wg;
  }

  String format(double n, {bool isInteger = true}) {
    print('n=' + n.toString());
    if (isInteger) {
      final formatter = NumberFormat("#,###", "en_US");
      return formatter.format(n);
    } else {
      final formatter = NumberFormat("#,###.00", "en_US");
      return formatter.format(n);
    }
  }
}
