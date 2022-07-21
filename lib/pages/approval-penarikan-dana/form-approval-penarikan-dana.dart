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

class ApprovalPenarikanDanaDialog {
  GlobalKey<FormState>? _key;
  bool autoValidate = false;
  int id = 0;
  bool isAktif = true;
  final txtKodeController = TextEditingController();
  final txtNamaController = TextEditingController();
  final txtSatuanController = TextEditingController();
  final txtKeteranganController = TextEditingController();
  final txtKategoriNamaController = TextEditingController();
  final txtKategoriIdController = TextEditingController();

  final txtKodeFocusNode = FocusNode();
  final txtNamaFocusNode = FocusNode();
  final txtSatuanFocusNode = FocusNode();
  final txtKeteranganFocusNode = FocusNode();
  final txtKategoriNamaFocusNode = FocusNode();
  final txtKategoriIdFocusNode = FocusNode();

  bool isFirst = true;

  /* checkbox */
  int isActive = 0;
  bool isActiveOption = false;

  Future<int> getUserId() async {
    return Prefs.getInt('userId');
  }

  Future<dynamic> getData(isEdit, data) async {
    if (isEdit) {
      final vData = await ApiUtilities()
          .getGlobalParamNoLimit(namaApi: "banksampah", where: {"id": data});
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

        listUP(label, BuildContext context) async {
          // final res = await Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => ListUpCategoriBarangPage(),
          //   ),
          // );
          // if (res != null) {
          //   setState(() {
          //     txtKategoriNamaController.text = res["kategori_nama"];
          //     txtKategoriIdController.text = res["id"];
          //   });
          // }
        }

        // ignore: non_constant_identifier_names
        changeTextField(pil, val) {
          setState(() {
            print("pilihan=" + pil.toString() + " - value = " + val.toString());
          });
        }

        change_isactive(val) {
          setState(() {
            isActive = val;
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
                    "Form Approval Penarikan Dana",
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
                              txtKodeController.text =
                                  snapshot.data["bank_nama"];
                              txtNamaController.text =
                                  snapshot.data["alamat"];
                              txtSatuanController.text =
                                  snapshot.data["prop_kode"];
                              txtKategoriIdController.text =
                                  snapshot.data["kota_kode"];
                              txtKategoriNamaController.text =
                                  snapshot.data["kec_kode"];
                              txtKeteranganController.text =
                                  snapshot.data["kel_kode"];
                              isActive = int.parse(snapshot.data["active"]) == 1
                                  ? 0
                                  : 1;
                                 isActiveOption = int.parse(snapshot.data["daftar_baru"])==1? false : true;

                                  
                            } else {
                              txtKodeController.text = "";
                              txtNamaController.text = "";
                              txtSatuanController.text = "";
                              txtKategoriIdController.text = "";
                              txtKategoriNamaController.text = "";
                              txtKeteranganController.text = "";
                              isActive = 0;
                              isActiveOption = false;
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
                                      label: "Nama Bank",
                                      textController: txtKodeController,
                                      textChange: changeTextField,
                                      textFocusNote: txtKodeFocusNode,
                                    ),
                                    TextBox().textboxWithBorderValidate(
                                      context,
                                      label: "Alamat",
                                      textController: txtNamaController,
                                      textChange: changeTextField,
                                      textFocusNote: txtNamaFocusNode,
                                    ),
                                    TextBox().textboxWithBorderValidate(
                                      context,
                                      label: "Prop_kode",
                                      textController: txtKategoriNamaController,
                                      textChange: changeTextField,
                                      textFocusNote: txtKategoriNamaFocusNode,
                                    ),
                                    // ListUp().listUpWithBorderValidate(context,
                                    //     label: "Prop_kode",
                                    //     textController:
                                    //         txtKategoriNamaController,
                                    //     textFocusNote: txtKategoriNamaFocusNode,
                                    //     suffixIconOnPressed: listUP),

                                    // DropDown().dropDownDbwithBorder(context,
                                    // label: "Kategori Barang",
                                    // value: barang,
                                    // items:listBarang,
                                    // display: display_barang,
                                    // cbOnChage:  change_barang),
                                    TextBox().textboxWithBorderValidate(
                                      context,
                                      label: "Kota_kode",
                                      textController: txtSatuanController,
                                      textChange: changeTextField,
                                      textFocusNote: txtSatuanFocusNode,
                                    ),

                                    TextBox().textboxWithBorderValidate(context,
                                        label: "Kec_kode",
                                        textController: txtKeteranganController,
                                        textChange: changeTextField,
                                        textFocusNote: txtKeteranganFocusNode,
                                        isMandatory: false,
                                        ),
                                    TextBox().textboxWithBorderValidate(context,
                                        label: "Kel_kode",
                                        textController: txtKeteranganController,
                                        textChange: changeTextField,
                                        textFocusNote: txtKeteranganFocusNode,
                                        isMandatory: false,
                                        ),
                                    CheckBox().flutterToggleTab(
                                        index: isActive,
                                        listLabel: ["Approved", "Not Approved"],
                                        width: 60.0,
                                        isActive: isActiveOption,
                                        callbackselectedLabelIndex:
                                            change_isactive),
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
                      child: RaisedButton(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        elevation: 5,
                        highlightElevation: 10,
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(0.0),
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
                            var dataSave = <dynamic, dynamic>{
                              "id":int.parse(data.toString()),
                              "active": isActive == 0 ? 1 : 0
                            };
                            var where = isEdit
                                ? <dynamic, dynamic>{
                                    "id": int.parse(data.toString())
                                  }
                                : null;
                            ApiUtilities().saveUpdateData(
                                context: context,
                                data: dataSave,
                                namaAPI: "banksampah",
                                isEdit: isEdit,
                                where: where,
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
