import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
// import 'package:doa/pages/listups/listup-kategori-barang.dart';
import 'package:doa/pages/listups/listupt-bank-sampah..dart';
import 'package:doa/utils/api-utility.dart';
import 'package:doa/utils/api.dart';
import 'package:doa/utils/function.dart';
import 'package:doa/utils/pref_manager.dart';
import 'package:doa/widgets/checkbox.dart';
import 'package:doa/widgets/dropdown.dart';
import 'package:doa/widgets/listup.dart';
import 'package:doa/widgets/textbox.dart';
import 'package:sweetalert/sweetalert.dart';

class PendaftaranAnggotaDialog {
  GlobalKey<FormState>? _key;
  bool autoValidate = false;
  int id = 0;
  bool isAktif = true;
  final txtNamaLengkapController = TextEditingController();
  final txtAlamatController = TextEditingController();
  final txtNomorTelpController = TextEditingController();
  final txtUserTypeController = TextEditingController();
  final txtUserNameController = TextEditingController();
  final txtPasswordController = TextEditingController();

  final txtNamaLengkapFocusNode = FocusNode();
  final txtAlamatFocusNode = FocusNode();
  final txtNomorTelpFocusNode = FocusNode();
  final txtUserTypeFocusNode = FocusNode();
  final txtUserNameFocusNode = FocusNode();
  final txtPasswordFocusNode = FocusNode();

  bool isFirst = true;
  String userType = 'admin';
  int userLoginId=0;
  int userProfileId=0;
  /* checkbox */
  int isActive = 0;

  Future<int> getUserId() async {
    return Prefs.getInt('userId');
  }

  Future<dynamic> getData(isEdit, data) async {
    if (isEdit) {
      final vData = await ApiUtilities()
          .getGlobalParamNoLimit(namaApi: "userprofile", where: {"id": data});
      return vData["data"]["data"][0];
    } else {
      return [];
    }
  }

  static const TextStyle linkStyle = TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );

  /* list Up */

  Widget buildAddDialog(BuildContext context, sourceForm, dynamic data,
      bool isEdit, bool isView, bool isChangePassword) {
    _key = GlobalKey();

    {
//       /* warna */
//       // Color color = new Color(0x12345678);
//       // String colorString = color.toString(); // Color(0x12345678)
//       // String valueString =
//       //     colorString.split('(0x')[1].split(')')[0]; // kind of hacky..
//       // int value = int.parse(valueString, radix: 16);
//       // Color otherColor = new Color(value);
// /* end warna */

      return StatefulBuilder(builder: (context, setState) {
        /* call back */

        // ignore: non_constant_identifier_names
        changeTextField(pil, val) {
          setState(() {
            print("pilihan=" + pil.toString() + " - value = " + val.toString());
          });
        }

        cbOnChage(val) {
          setState(() {
            userType = val;
          });
        } /* end call back */

        /* call back */

        return Form(
            key: _key,
            child: Scaffold(
                resizeToAvoidBottomInset: true,
                appBar: AppBar(
                  backgroundColor: Colors.green,
                  leading: IconButton(
                    icon: const Icon(Icons.close, color: Colors.yellow),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  title: const Text(
                    "Form Pendaftaran Anggota",
                  ),
                  centerTitle: true,
                ),
                body: StatefulBuilder(builder: (context, setState) {
                  return FutureBuilder(
                      future: getData(isEdit, data),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          if (isFirst) {
                            if (isEdit) {
                              txtNamaLengkapController.text =
                                  snapshot.data["nama_lengkap"];
                              txtAlamatController.text =
                                  snapshot.data["alamat"];
                              txtNomorTelpController.text =
                                  snapshot.data["nomor_telp"];
                              txtUserTypeController.text =
                                  snapshot.data["user_type"];
                              txtUserNameController.text =
                                  snapshot.data["user_name"];
                              txtPasswordController.text =
                                  snapshot.data["password_default"];
                                  userLoginId=
                                  int.parse(snapshot.data["user_login_id"]);
                                  userProfileId=
                                  int.parse(snapshot.data["id"]);
                            } else {
                              txtNamaLengkapController.text = "";
                              txtAlamatController.text = "";
                              txtNomorTelpController.text = "";
                              txtUserTypeController.text = "";
                              txtUserNameController.text = "";
                              txtPasswordController.text = "";
                            }
                            isFirst = false;
                          }
                          return Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width - 10,
                              height: MediaQuery.of(context).size.height - 10,
                              padding:
                                  const EdgeInsets.fromLTRB(10, 20, 10, 10),
                              color: Colors.white,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    TextBox().textboxWithBorderValidate(
                                      context,
                                      label: "Nama Lengkap",
                                      textController: txtNamaLengkapController,
                                      textChange: changeTextField,
                                      textFocusNote: txtNamaLengkapFocusNode,
                                    ),
                                    TextBox().textboxWithBorderValidate(
                                      context,
                                      label: "Alamat",
                                      textController: txtAlamatController,
                                      textChange: changeTextField,
                                      textFocusNote: txtAlamatFocusNode,
                                    ),
                                    TextBox().textboxWithBorderValidate(
                                      context,
                                      label: "Nomor Telepon",
                                      textController: txtNomorTelpController,
                                      textChange: changeTextField,
                                      textFocusNote: txtNomorTelpFocusNode,
                                    ),
                                    DropDown().dropDownwithBorder(context,
                                        label: 'Tipe Anggota',
                                        items: <String>['admin', 'anggota'],
                                        value: userType,
                                        cbOnChage: cbOnChage,
                                        comboFocusNode: txtUserTypeFocusNode),
                                    const Divider(
                                      thickness: 1.0,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextBox().textboxWithBorderValidate(
                                      context,
                                      label: "User Login",
                                      textController: txtUserNameController,
                                      textChange: changeTextField,
                                      textFocusNote: txtUserNameFocusNode,
                                    ),
                                    Visibility(
                                        visible: isChangePassword,
                                        child:
                                            TextBox().textboxWithBorderValidate(
                                          context,
                                          label: "Default Password",
                                          textController: txtPasswordController,
                                          textChange: changeTextField,
                                          textFocusNote: txtPasswordFocusNode,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      });
                }),
                bottomNavigationBar: Visibility(
                    visible: isView,
                    child: BottomAppBar(
                        child: Container(
                      color: Colors.transparent,
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                      // ignore: deprecated_member_use
                      child: ElevatedButton(
                        // shape: const RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.all(
                        //     Radius.circular(15),
                        //   ),
                        // ),
                        // elevation: 5,
                        // highlightElevation: 10,
                        // textColor: Colors.white,
                        // padding: const EdgeInsets.all(0.0),
                        style: ButtonStyle(
    elevation: MaterialStateProperty.all(5),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  ),
                      padding: MaterialStateProperty.all(EdgeInsets.all(0.0))),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            gradient: LinearGradient(
                              colors: <Color>[
                                Colors.green,
                                Colors.green,
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.all(10.0),
                          child: const Text(
                            "Save",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        onPressed: () async {
                          if (_key!.currentState!.validate()) {
                            _key!.currentState!.save();
                            SweetAlert.show(context,
                                subtitle: "please_wait",
                                style: SweetAlertStyle.loading);
                            var dataSave;
                            dataSave = [
                              {
                                "userlogin": {
                                  "action": isEdit ? "update" : "new",
                                  "data": [
                                    isEdit ?
                                    {
                                      "id":userLoginId,
                                      "user_name": txtUserNameController.text,
                                      "user_pass": Fungsi()
                                          .strToMD5(txtPasswordController.text),
                                      "password_default":
                                          txtPasswordController.text
                                    } :
                                    {
                                      "user_name": txtUserNameController.text,
                                      "user_pass": Fungsi()
                                          .strToMD5(txtPasswordController.text),
                                      "password_default":
                                          txtPasswordController.text
                                    } 
                                  ]
                                }
                              },
                              {
                                "userprofile": {
                                  "action":  isEdit ? "update" : "new",
                                  "data": [
                                    isEdit ?
                                    {
                                      "id": userProfileId,
                                      "nama_lengkap":
                                          txtNamaLengkapController.text,
                                      "nomor_telp": txtNomorTelpController.text,
                                      "alamat": txtAlamatController.text,
                                      "user_type": userType,
                                      "bank_id": Prefs.getInt("bank_id")
                                    }:
                                    {
                                      "nama_lengkap":
                                          txtNamaLengkapController.text,
                                      "nomor_telp": txtNomorTelpController.text,
                                      "alamat": txtAlamatController.text,
                                      "user_type": userType,
                                      "bank_id": Prefs.getInt("bank_id")
                                    }
                                  ]
                                }
                              }
                            ];
                            ApiUtilities().saveUpdateBatchData(
                                context: context,
                                data: dataSave,
                                isEdit: isEdit,
                                setState: setState);
                          } else {
                            setState(() {
                              autoValidate = true;
                            });
                          }
                        },
                      ),
                    )))));
      });
    }
  }
}
