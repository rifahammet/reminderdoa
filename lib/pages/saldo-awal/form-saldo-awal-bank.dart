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

class SaldoAwalBankDialog {
  GlobalKey<FormState>? _key;
  bool autoValidate = false;
  int id = 0;
  bool isAktif = true;
  final txtKodeController = TextEditingController();
  final txtNamaController = TextEditingController();
  final txtSatuanController = TextEditingController();
  final txtKeteranganController = TextEditingController();
  final txtKategoriNamaController = TextEditingController();
  final txtKategoriKodeController = TextEditingController();
  final txtKategoriIdController = TextEditingController();
  final txtHargaBeliController = TextEditingController();
  final txtKodeFocusNode = FocusNode();
  final txtNamaFocusNode = FocusNode();
  final txtSatuanFocusNode = FocusNode();
  final txtKeteranganFocusNode = FocusNode();
  final txtKategoriNamaFocusNode = FocusNode();
  final txtKategoriIdFocusNode = FocusNode();
  final txtHargaBeliFocusNode = FocusNode();
  bool isFirst = true;
  String satuan = 'Pcs';

  /* checkbox */
  int isActive = 0;

  Future<int> getUserId() async {
    return Prefs.getInt('userId');
  }

  Future<dynamic> getData(isEdit, data) async {
    if (isEdit) {
      final vData = await ApiUtilities()
          .getGlobalParamNoLimit(namaApi: "saldoawalbank", where: {"id": data});
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
          //     txtKategoriKodeController.text = res["kategori_kode"];
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

        cbOnChange(val) {
          setState(() {
            satuan = val;
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
                    "Form Saldo Awal Bank",
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
                              txtHargaBeliController.text =
                              Fungsi().format(
                                  double.parse(snapshot.data['total_rupiah']),
                                  isInteger: false);
                            } else {

                              txtHargaBeliController.text = "0.00";
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
                                    TextBox().textboxWithBorderValidate(context,
                                        label: "Total Uang",
                                        textController: txtHargaBeliController,
                                        textChange: changeTextField,
                                        textFocusNote: txtHargaBeliFocusNode,
                                        isNumber: true,
                                        isInteger: false),
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
                            dataSave = isEdit
                                ? <dynamic, dynamic>{
                                    "id":data,
                                    "total_rupiah": Fungsi()
                                  .fmtStringToInt(txtHargaBeliController.text),
                                    "bank_id": Prefs.getInt("bank_id")

                                  }
                                : <dynamic, dynamic>{

                                    "total_rupiah": Fungsi()
                                  .fmtStringToInt(txtHargaBeliController.text),
                                    "bank_id": Prefs.getInt("bank_id")
                                  };

                            ApiUtilities().saveUpdateData(
                                context: context,
                                data: dataSave,
                                namaAPI: "saldoawalbank",
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
