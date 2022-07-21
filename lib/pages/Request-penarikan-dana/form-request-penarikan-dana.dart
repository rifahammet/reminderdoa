import 'dart:async';
import 'dart:convert';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
// import 'package:doa/pages/listups/listup-kategori-barang.dart';
import 'package:doa/pages/listups/listupt-bank-sampah..dart';
import 'package:doa/utils/api-utility.dart';
import 'package:doa/utils/api.dart';
import 'package:doa/utils/function.dart';
import 'package:doa/utils/pref_manager.dart';
import 'package:doa/widgets/checkbox.dart';
import 'package:doa/widgets/datepicker.dart';
import 'package:doa/widgets/dropdown.dart';
import 'package:doa/widgets/listup.dart';
import 'package:doa/widgets/textbox.dart';
import 'package:sweetalert/sweetalert.dart';

class RequestPenarikanDanaDialog {
  GlobalKey<FormState>? _key;
  bool autoValidate = false;
  int id = 0;
  bool isAktif = true;
  String? tanggalTransaksi;
  final txtTanggalTransaksiController = TextEditingController();
  final txtDanaTersimpanController = TextEditingController();
  final txtJumlahDanaController = TextEditingController();
  final txtKeteranganController = TextEditingController();
  final txtSisaDanaController = TextEditingController();

  final txtTanggalTransaksiFocusNode = FocusNode();
  final txtDanaTersimpanFocusNode = FocusNode();
  final txtJumlahDanaFocusNode = FocusNode();
  final txtKeteranganFocusNode = FocusNode();
  final txtSisaDanaFocusNode = FocusNode();

  bool isFirst = true;

  /* checkbox */
  int isActive = 1;

  Future<dynamic> getData(isEdit, data) async {

  //   var dataSave;
  //   dataSave = [
  //     {
  //       "penarikandana": {
  //         "where": isEdit ? {"id": data} : {"user_profile_id": data.toString()}
  //       },
  //       // "kategori": {
  //       //   "where": {"active": 1}
  //       // },
  //     }
  //   ];
  //  final vDatas = await ApiUtilities().getDataBatch(dataSave);

     if (isEdit) {
    final vData = await ApiUtilities().getGlobalParamNoLimit(
        namaApi: "penarikandanaedit",
        where:  {"id": data.toString()});
    return  vData["data"]["data"][0] ;
      } else {
    final vData = await ApiUtilities().getGlobalParamNoLimit(
        namaApi: "penarikandananew",
        where:  {"id": Prefs.getInt("userId")});
    return  vData["data"]["data"][0] ;
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

/* tanngal */
        displayTanggalTransaksi(formatDate, formatYear) {
          setState(() {
            tanggalTransaksi = formatYear.toString();
            txtTanggalTransaksiController.text = formatDate.toString();
            print('tanggal=' + formatDate.toString());
          });
        }

        /* end tanggal */
        // ignore: non_constant_identifier_names
        changeTextField(pil, val) {
          setState(() {
            if (pil == "Jumlah Dana") {
              if (Fungsi().fmtStringToInt(txtDanaTersimpanController.text) -
                      Fungsi().fmtStringToInt(val.toString()) <
                  0.0) {
                SweetAlert.show(
                  context,
                  subtitle:
                      "Jumlah dana yang di minta tidak boleh lebih besar dari jumlah dana yang tersedia",
                  style: SweetAlertStyle.loadingerror,
                );
                Future.delayed(new Duration(seconds: 3), () {
                  txtJumlahDanaController.text =
                      txtDanaTersimpanController.text;
                  txtSisaDanaController.text = "0.00";
                  Navigator.pop(context);
                });
              } else {
                txtSisaDanaController.text =
                   Fungsi().format (Fungsi().fmtStringToInt(txtDanaTersimpanController.text) -
                            Fungsi().fmtStringToInt(val.toString()), isInteger: false)
                        .toString();
              }
              print(
                  "pilihan=" + pil.toString() + " - value = " + val.toString());
            }
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
                    "Form Pengajuan Penarikan Dana",
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
                              txtTanggalTransaksiController.text =
                                  snapshot.data["tanggal_transaksi"];
                              txtTanggalTransaksiController.text = formatDate(
                                  DateTime.parse(
                                      snapshot.data["tanggal_transaksi"]),
                                  [dd, '-', mm, '-', yyyy]);
                              tanggalTransaksi =
                                  snapshot.data["tanggal_transaksi"];
                              
                              txtDanaTersimpanController.text = 
                                  Fungsi().format(double.parse(snapshot.data['sisa'])+double.parse(snapshot.data['jumlah_dana']),
                                  isInteger: false);
                              ;
                              txtJumlahDanaController.text = Fungsi().format(
                                  double.parse(snapshot.data['jumlah_dana']),
                                  isInteger: false);
txtSisaDanaController.text = Fungsi().format(
                                  double.parse(snapshot.data['sisa']),
                                  isInteger: false);
                              txtKeteranganController.text =
                                  snapshot.data["keterangan"];
                              isActive = int.parse(snapshot.data["cash"]);
                            } else {
                              txtTanggalTransaksiController.text = formatDate(
                                  DateTime.now(), [dd, '-', mm, '-', yyyy]);
                              tanggalTransaksi = Fungsi().fmtDateTimeYearNow();
                              txtSisaDanaController.text = "0.00";
                                
                                txtJumlahDanaController.text = Fungsi().format(
                                    double.parse(snapshot.data['sisa']),
                                    isInteger: false);
                                txtDanaTersimpanController.text = Fungsi()
                                    .format(
                                        double.parse(
                                            snapshot.data['sisa']),
                                        isInteger: false);
                              txtKeteranganController.text = "";
                              isActive = 1;
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
                                    DatePicker().datePickerBorder(
                                      context,
                                      textController:
                                          txtTanggalTransaksiController,
                                      label: "Tanggal Transaksi",
                                      fungsiCallback: displayTanggalTransaksi,
                                      formatDate: tanggalTransaksi,
                                    ),
                                    TextBox().textboxWithBorderValidate(context,
                                        label: "Jumlah Dana Terimpan",
                                        textController:
                                            txtDanaTersimpanController,
                                        textChange: changeTextField,
                                        isMandatory: false,
                                        isReadOnly: true,
                                        textFocusNote:
                                            txtDanaTersimpanFocusNode,
                                        isNumber: true,
                                        isInteger: false),
                                    TextBox().textboxWithBorderValidate(context,
                                        label: "Jumlah Dana",
                                        textController: txtJumlahDanaController,
                                        textChange: changeTextField,
                                        isMandatory: true,
                                        textFocusNote: txtJumlahDanaFocusNode,
                                        isNumber: true,
                                        isInteger: false),
                                    TextBox().textboxWithBorderValidate(context,
                                        label: "Sisa Dana",
                                        textController: txtSisaDanaController,
                                        textChange: changeTextField,
                                        isMandatory: false,
                                        isReadOnly: true,
                                        textFocusNote: txtSisaDanaFocusNode,
                                        isNumber: true,
                                        isInteger: false),
                                    CheckBox().flutterToggleTab(
                                        index: isActive,
                                        listLabel: ["Transfer", "Cash"],
                                        isActive: false,
                                        selectedColor: Colors.yellow[700],
                                        callbackselectedLabelIndex:
                                            change_isactive),
                                    TextBox().textboxWithBorderValidate(context,
                                        label: "Keterangan",
                                        textController: txtKeteranganController,
                                        textChange: changeTextField,
                                        textFocusNote: txtKeteranganFocusNode,
                                        isMandatory: false,
                                        maxlines: 3),
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
                            var dataSave = isEdit
                                ? <dynamic, dynamic>{
                                    "id": int.parse(data.toString()),
                                    "tanggal_transaksi": tanggalTransaksi,
                                    "jumlah_dana": Fungsi().fmtStringToInt(
                                        txtJumlahDanaController.text),
                                    "cash": isActive,
                                    "bank_id" : Prefs.getInt("bank_id"),
                                    "user_profile_id": Prefs.getInt("userId"),
                                    "keterangan": txtKeteranganController.text,
                                  }
                                : <dynamic, dynamic>{
                                    "tanggal_transaksi": tanggalTransaksi,
                                    "jumlah_dana": Fungsi().fmtStringToInt(
                                        txtJumlahDanaController.text),
                                    "cash": isActive,
                                    "bank_id" : Prefs.getInt("bank_id"),
                                    "user_profile_id": Prefs.getInt("userId"),
                                    "keterangan": txtKeteranganController.text,
                                  };

                            ApiUtilities().saveUpdateData(
                                context: context,
                                data: dataSave,
                                namaAPI: "penarikandanaedit",
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
