import 'dart:async';
import 'package:date_format/date_format.dart';
import 'package:doa/pages/listups/listup-kota.dart';
import 'package:doa/pages/listups/listup-propinsi.dart';
import 'package:flutter/material.dart';
import 'package:doa/widgets/datepicker.dart';
import 'package:doa/utils/api-utility.dart';
import 'package:doa/utils/function.dart';
import 'package:doa/utils/pref_manager.dart';
import 'package:doa/widgets/listup.dart';
import 'package:doa/widgets/textbox.dart';
import 'package:sweetalert/sweetalert.dart';
// import 'package:easy_localization/easy_localization.dart';

class ProfileDialog {
  GlobalKey<FormState>? _key;
  bool autoValidate = false;
  int id = 0;
  bool isAktif = true;
  String api_id = '';
  String? tanggalLahir;
  final txtTanggalLahirController = TextEditingController();
  final txtNamaLengkapController = TextEditingController();
  final txtEmailController = TextEditingController();
  final txtNomorTelpController = TextEditingController();
  final txtPropinsiNamaController = TextEditingController();
  final txtUserTypeController = TextEditingController();
  final txtKotaNamaController = TextEditingController();
  final txtPasswordController = TextEditingController();
  final txtPropinsiKodeController = TextEditingController();
  final txtKotaKodeController = TextEditingController();

  // final txtNomorRekeningController = TextEditingController();
  // final txtNamaBankController = TextEditingController();

  // final txtNamaBankFocusNode = FocusNode();
  // final txtNomorRekeningFocusNode = FocusNode();
  final txtEmailFocusNode = FocusNode();
  final txtNamaLengkapFocusNode = FocusNode();
  final txtPropinsiNamaFocusNode = FocusNode();
  final txtNomorTelpFocusNode = FocusNode();
  final txtUserTypeFocusNode = FocusNode();
  final txtKotaNamaFocusNode = FocusNode();
  final txtPasswordFocusNode = FocusNode();

  bool isFirst = true;
  int userLoginId = 0;
  int userProfileId = 0;
  /* checkbox */
  int isActive = 0;

  Future<int> getUserId() async {
    return Prefs.getInt('userId');
  }

  Future<dynamic> getData(isEdit, data) async {
    if (isEdit) {
      final vData = await ApiUtilities()
          .getGlobalParamNoLimit(namaApi: "signup", where: {"id": data});
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
      bool isEdit, bool isView) {
    _key = GlobalKey();
    txtTanggalLahirController.text =
        formatDate(DateTime.now(), [dd, '-', mm, '-', yyyy]);
    tanggalLahir = Fungsi().fmtDateTimeYearNow();
    {
      return StatefulBuilder(builder: (context, setState) {
        /* call back */
        displayTanggallahir(formatDate, formatYear) {
          setState(() {
            tanggalLahir = formatYear.toString();
            txtTanggalLahirController.text = formatDate.toString();
            print('tanggal=' + formatDate.toString());
          });
        }

        // ignore: non_constant_identifier_names
        changeTextField(pil, val) {
          setState(() {
            print("pilihan=" + pil.toString() + " - value = " + val.toString());
          });
        }

        listUPPropinsi(label, BuildContext context) async {
          print(label);
          final res = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ListUpPropinsiDialog()),
          );
          setState(() {
            if (res != null) {
              txtPropinsiNamaController.text = res["prop_nama"];
              txtPropinsiKodeController.text = res["prop_kode"];
            }
          });
        }

        listUPKota(label, BuildContext context) async {
          // ignore: prefer_typing_uninitialized_variables
          print(txtPropinsiKodeController.text);
          final res = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ListUpKotaDialog(
                      propinsi_kode: txtPropinsiKodeController.text,
                    )),
          );
          setState(() {
            if (res != null) {
              txtKotaNamaController.text = res["kota_nama"];
              txtKotaKodeController.text = res["kota_kode"];
              api_id = res["api_id"];
            }
          });
        }
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
                    "Profile",
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
                              userLoginId = int.parse(data.toString());
                              txtNamaLengkapController.text =
                                  snapshot.data["user_fullname"];
                              txtPropinsiNamaController.text =
                                  snapshot.data["prop_nama"];
                              txtPropinsiKodeController.text =
                                  snapshot.data["prop_kode"];
                              txtTanggalLahirController.text =
                                  snapshot.data["birthday"];
                              txtNomorTelpController.text = snapshot.data["hp"];
                              txtUserTypeController.text =
                                  snapshot.data["user_type"];
                              txtKotaNamaController.text =
                                  snapshot.data["kota_nama"];
                              txtKotaKodeController.text =
                                  snapshot.data["kota_kode"];
                              txtPasswordController.text =
                                  snapshot.data["password_default"];
                              //     txtNomorRekeningController.text=snapshot.data["nomor_rekening"];
                              // txtNamaBankController.text=snapshot.data["nama_bank"];
                              txtEmailController.text = snapshot.data["email"];
                              // userLoginId=
                              // int.parse(snapshot.data["user_login_id"]);
                              userProfileId = int.parse(snapshot.data["id"]);
                            } else {
                              txtNamaLengkapController.text = "";
                              txtPropinsiKodeController.text = "";
                              txtPropinsiNamaController.text = "";
                              txtTanggalLahirController.text = "";
                              txtNomorTelpController.text = "";
                              txtUserTypeController.text = "";
                              txtKotaNamaController.text = "";
                              txtKotaKodeController.text = "";
                              txtPasswordController.text = "";
                              // txtNomorRekeningController.text="";
                              // txtNamaBankController.text="";
                              txtEmailController.text = "";
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
                                    ListUp().listUpWithBorderValidate(context,
                                        label: "Propinsi",
                                        textController:
                                            txtPropinsiNamaController,
                                        textFocusNote: txtPropinsiNamaFocusNode,
                                        suffixIconOnPressed: listUPPropinsi),
                                    ListUp().listUpWithBorderValidate(context,
                                        label: "Kota/Kab.",
                                        textController: txtKotaNamaController,
                                        textFocusNote: txtKotaNamaFocusNode,
                                        suffixIconOnPressed: listUPKota),
                                    DatePicker().datePickerBorder(
                                      context,
                                      textController: txtTanggalLahirController,
                                      label: "Tanggal Lahir",
                                      fungsiCallback: displayTanggallahir,
                                      formatDate: tanggalLahir,
                                    ),
                                    TextBox().textboxWithBorderValidate(
                                      context,
                                      label: "Nomor Telepon",
                                      textController: txtNomorTelpController,
                                      textChange: changeTextField,
                                      textFocusNote: txtNomorTelpFocusNode,
                                      isMandatory: false,
                                    ),
                                    TextBox().textboxWithBorderValidate(context,
                                        label: "Email",
                                        textController: txtEmailController,
                                        textChange: changeTextField,
                                        textFocusNote: txtEmailFocusNode,
                                        isEmail: true,
                                        isMandatory: false),
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
                                "signup": {
                                  "action": "update",
                                  "data": [
                                    isEdit
                                        ? {
                                            "id": userLoginId,
                                            "user_name":
                                                txtNamaLengkapController.text,
                                            "prop_kode":
                                                txtPropinsiKodeController.text,
                                            "kota_kode":
                                                txtKotaKodeController.text,
                                            "birthday": tanggalLahir,
                                            "hp": txtNomorTelpController.text
                                          }
                                        : {
                                            "user_name":
                                                txtNamaLengkapController.text
                                          }
                                  ]
                                }
                              },
                            ];
                            ApiUtilities().saveUpdateBatchData(
                                context: context,
                                data: dataSave,
                                isEdit: isEdit,
                                isSingleDelete: true,
                                setState: setState);
                            Prefs.setString('kota_kode', api_id);
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
