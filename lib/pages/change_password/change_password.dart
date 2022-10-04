import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:doa/pages/dashboard.dart';
import 'package:doa/utils/api-utility.dart';
import 'package:doa/utils/function.dart';
import 'package:doa/utils/pref_manager.dart';
import 'package:doa/widgets/textbox.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';

class ChangePasswordDialog {
  GlobalKey<FormState>? _key;
  bool autoValidate = false;
  final txtOldPassword = TextEditingController();
  final txtNewPassword = TextEditingController();
  final txtConfirmation = TextEditingController();
  bool _obscureText1 = true;

  // Future<int> getUserId() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   return prefs.getInt('userLoginId');
  // }

  static const TextStyle linkStyle = const TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );

  Widget buildAddDialog(BuildContext context, _myHomePageState, bool isFirst,
      String oldPassword) {
    _key = GlobalKey();
    txtOldPassword.text = isFirst ? oldPassword : '';
    txtNewPassword.text = '';
    txtConfirmation.text = '';

    return StatefulBuilder(builder: (context, setState) {
      /* call back */
      change_text(val) {}

      toggle1(val) {
        setState(() {
          _obscureText1 = !val;
        });
      }
      /* end call back */

      return Form(
          key: _key,
          //autovalidate: true,
          child: Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                backgroundColor: Colors.green,
                leading: new IconButton(
                  icon: new Icon(Icons.close, color: Colors.yellow),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: Text("Ubah Password"),
                centerTitle: true,
              ),
              body: StatefulBuilder(builder: (context, setState) {
                return Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 10,
                    height: MediaQuery.of(context).size.height - 40,
                    padding: EdgeInsets.all(20),
                    color: Colors.white,
                    child: SingleChildScrollView(
                                child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 200,width: 200,child:
                        Container(child: Image.asset('assets/images/widget-icons/protection.png',
                        fit: BoxFit.fill))),
                        SizedBox(height: 40,),
                        TextBox().textBoxwithBorderConfirmedPasswordValidate(
                            confirmationPasswordController: txtConfirmation,
                            newPasswordController: txtNewPassword,
                            oldPasswordController: txtOldPassword,
                            context: context,
                            labelNew: "Password Baru",
                            labelOld: "Password Lama",
                            labelConfirm: "Konfirmasi Password",
                            isMandatory: true,
                            obscureText1: _obscureText1,
                            suffixIconOnPressed: toggle1,
                            isPertama: isFirst),
                      ],
                    )),
                  ),
                );
              }),
              bottomNavigationBar: BottomAppBar(
                  child: Container(
                height: 50,
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
                        colors: <Color>[Colors.green, Colors.green],
                      ),
                    ),
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Ubah Password",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  onPressed: () async {
                    if (_key!.currentState!.validate()) {
                      _key!.currentState!.save();
                      if (txtNewPassword.text.toString() ==
                          txtConfirmation.text.toString()) {
                        // print(Fungsi()
                        //         .strToMD5(txtNewPassword.text)
                        //         .substring(0, 25) +
                        //     " == " +
                        //     txtOldPassword.text);
                        if (txtNewPassword.text == txtOldPassword.text) {
                          txtNewPassword.text = '';
                          txtConfirmation.text = '';
                          SweetAlert.show(
                            context,
                            subtitle:
                                'New password must be different with current password\nplease retype the password and confirmation password',
                            style: SweetAlertStyle.loadingerror,
                          );
                          Future.delayed(const Duration(seconds: 3), () {
                            setState(() {});
                            Navigator.pop(context);
                          });
                        } else {
                          await addRecord(context, setState);
                        }
                      } else {
                        txtNewPassword.text = '';
                        txtConfirmation.text = '';

                        SweetAlert.show(
                          context,
                          subtitle:
                              'Password does not match, please retype the password and confirmation password',
                          style: SweetAlertStyle.loadingerror,
                        );
                        Future.delayed(const Duration(seconds: 3), () {
                            setState(() {});
                            Navigator.pop(context);
                          });
                      }
                    } else {
                      setState(() {
                        autoValidate = true;
                      });
                    }
                  },
                ),
              ))));
    });
  }

  Future addRecord(BuildContext context, setState) async {
    SweetAlert.show(context,
        subtitle: "please_wait", style: SweetAlertStyle.loading);
    var dataSave = <dynamic, dynamic>{
      "user_password": Fungsi().strToMD5(txtNewPassword.text).toString(),
      "isFirst": 0,
      "id": Prefs.getInt("userId")
    };
    //print(dataSave.toString());
    var where = <dynamic, dynamic>{"id": Prefs.getInt("userId")};
    void callBack(data) {
      SweetAlert.show(
        context,
        subtitle: "Password has been changed",
        style: SweetAlertStyle.loadingSuccess,
      );
      Future.delayed(new Duration(seconds: 3), () {
        setState(() {});
        Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => DashboardPage()),
        (Route<dynamic> route) => false,
      );
      });
      
    }

    ApiUtilities().saveUpdateData(
        context: context,
        data: dataSave,
        namaAPI: "signup",
        isEdit: true,
        where: where,
        setState: setState,
        isCustom: true,
        callBack: callBack);
  }
}
