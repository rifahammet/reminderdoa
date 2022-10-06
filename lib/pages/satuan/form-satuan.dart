import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
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

class SatuanDialog {
  GlobalKey<FormState>? _key;
  bool autoValidate = false;
  int id = 0;
  bool isAktif = true;
  final txtKategoriKodeController = TextEditingController();
  final txtNamaController = TextEditingController();
  final txtKeteranganController = TextEditingController();

  final txtKategoriKodeFocusNode = FocusNode();
  final txtNamaFocusNode = FocusNode();
  final txtKeteranganFocusNode = FocusNode();

  bool isFirst = true;

  /* checkbox */
  int isActive = 0;

  Future<int> getUserId() async {
    return Prefs.getInt('userId');
  }

  Future<dynamic> getData(isEdit, data) async {
    if (isEdit) {
      final dataPropinsi = await ApiUtilities()
          .getGlobalParamNoLimit(namaApi: "satuan", where: {"id": data});
      return dataPropinsi["data"]["data"][0];
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
                leading: IconButton(
                  icon: const Icon(Icons.close, color: Colors.yellow),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: const Text(
                  "Form Satuan Barang",
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
                            txtNamaController.text = snapshot.data["satuan"];
                            isActive =
                                int.parse(snapshot.data["active"]) == 1 ? 0 : 1;
                          } else {
                            txtNamaController.text = "";
                            isActive = 0;
                          }
                          isFirst = false;
                        }
                        return
                            Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width - 10,
                            height: MediaQuery.of(context).size.height - 10,
                            padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                            color: Colors.white,
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  TextBox().textboxWithBorderValidate(
                                    context,
                                    label: "Nama Satuan",
                                    textController: txtNamaController,
                                    textChange: changeTextField,
                                    textFocusNote: txtNamaFocusNode,
                                  ),
                                  // ListUp().getListUpValidate(context,100,"Propinsi",txtPropinsiController,callBackShowDialog: listUP, onClearInputontroller: onClearInputontroller),
                                  // DropDown().dropDownDbwithBorder(context,
                                  // label: "Propinsi",
                                  // value: propinsi,
                                  // items:listPropinsi,
                                  // display: display_propinsi,
                                  // cbOnChage:  change_propinsi),
                                  CheckBox().flutterToggleTab(
                                      index: isActive,
                                      listLabel: ["Active", "Not Active"],
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
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          gradient: LinearGradient(
                            colors: <Color>[
                              Theme.of(context).accentColor,
                              Theme.of(context).primaryColorDark,
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
                          dataSave = isEdit?<dynamic, dynamic>{
                            "id": int.parse(data.toString()),
                            "satuan": txtNamaController.text,
                            "active": isActive == 0 ? 1 : 0,
                            "bank_id":Prefs.getInt("bank_id"),
                            "dt_updated": Fungsi().fmtDateTimeYearNow()
                          }:<dynamic, dynamic>{
                            "satuan": txtNamaController.text,
                            "active": isActive == 0 ? 1 : 0,
                            "bank_id":Prefs.getInt("bank_id")
                          };
                          print(dataSave);
                          var where = isEdit?<dynamic, dynamic>{"id":int.parse(data.toString())} : null;
                            ApiUtilities().saveUpdateData(
                                context: context,
                                data: dataSave,
                                namaAPI:"satuan",
                                isEdit: isEdit,
                                where: where,
                                setState: setState 
                                );

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
