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

class CashBankDialog {
  GlobalKey<FormState>? _key;
  bool autoValidate = false;
  int id = 0;
  bool isAktif = true;
  final txtReferensiController = TextEditingController();
  final txtKeteranganController = TextEditingController();
  final txtJumlahRupiahController = TextEditingController();
  final txtTanggalTransaksiController = TextEditingController();

  final txtReferensiFocusNode = FocusNode();
  final txtKeteranganFocusNode = FocusNode();
  final txtJumlahRupiahFocusNode = FocusNode();
  final txtkategoriFocusNode = FocusNode();
  final txtPembayaranFocusNode = FocusNode();
  bool isFirst = true;
  //String satuan = 'Pcs';

  bool firstLoad = true;

  /* dbcombobox */
  List<dynamic>? listSatuan;
  dynamic satuan;
  String? tanggalTransaksi;
  String kategori = "Pemasukkan";
  String pembayaran = "Cash";
  String nomorTransaksi = "";
  /* checkbox */
  int isActive = 0;

  Future<dynamic> getData(isEdit, data) async {
    if (isEdit) {
      final vData = await ApiUtilities()
          .getGlobalParamNoLimit(namaApi: "cashbank", where: {"id": data});
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

        displayTanggalTransaksi(formatDate, formatYear) {
          setState(() {
            tanggalTransaksi = formatYear.toString();
            txtTanggalTransaksiController.text = formatDate.toString();
            print('tanggal=' + formatDate.toString());
          });
        }

        // ignore: non_constant_identifier_names
        changeTextField(pil, val) {
          setState(() {
            print("pilihan=" + pil.toString() + " - value = " + val.toString());
          });
        }

        cbOnchange_kategori(val) {
          setState((){
kategori = val;
          });
          
        }

        cbOnChange_pembayaran(val) {
          setState((){
          pembayaran = val;
          });
        }

        /* end call back */

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
                    "Form Cash Bank",
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
                              txtReferensiController.text =
                                  snapshot.data["nomor_referensi"];
                              nomorTransaksi = snapshot.data["nomor_transaksi"];
                              txtKeteranganController.text =
                                  snapshot.data["keterangan"];
                              txtJumlahRupiahController.text = Fungsi().format(
                                  double.parse(snapshot.data['jumlah_rupiah']),
                                  isInteger: false);
                              kategori =
                                  int.parse(snapshot.data["pemasukan"]) == 1
                                      ? "Pemasukkan"
                                      : "Pengeluaran";
                              pembayaran =
                                  int.parse(snapshot.data["cash"]) == 0
                                      ? "Cash"
                                      : "Transfer";
                              txtTanggalTransaksiController.text = formatDate(
                                  DateTime.parse(
                                      snapshot.data["tanggal_transaksi"]),
                                  [dd, '-', mm, '-', yyyy]);
                              tanggalTransaksi = Fungsi().fmtDateTimeYear(
                                  snapshot.data["tanggal_transaksi"]);
                            } else {
                              txtReferensiController.text = "";
                              txtKeteranganController.text = "";
                              txtJumlahRupiahController.text = "0.00";
                              kategori = "Pemasukkan";
                              pembayaran = "Cash";
                              txtTanggalTransaksiController.text = formatDate(
                                  DateTime.now(), [dd, '-', mm, '-', yyyy]);
                              tanggalTransaksi = Fungsi().fmtDateTimeYearNow();
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
                                        label: "Nomor Referensi",
                                        textController: txtReferensiController,
                                        textChange: changeTextField,
                                        textFocusNote: txtReferensiFocusNode,
                                        isMandatory: false),

                                    DropDown().dropDownwithBorder(context,
                                        label: 'Pembayaran',
                                        items: <String>['Cash', 'Transfer'],
                                        value: pembayaran,
                                        cbOnChage: cbOnChange_pembayaran,
                                        comboFocusNode: txtPembayaranFocusNode),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    DropDown().dropDownwithBorder(context,
                                        label: 'Kategori',
                                        items: <String>[
                                          'Pemasukkan',
                                          'Pengeluaran'
                                        ],
                                        value: kategori,
                                        cbOnChage: cbOnchange_kategori,
                                        comboFocusNode: txtkategoriFocusNode),
                                    // const Divider(
                                    //   thickness: 1.0,
                                    // ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    TextBox().textboxWithBorderValidate(context,
                                        label: "Jumlah Rupiah",
                                        textController:
                                            txtJumlahRupiahController,
                                        textChange: changeTextField,
                                        textFocusNote: txtJumlahRupiahFocusNode,
                                        isNumber: true,
                                        isInteger: false),
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
                                    "nomor_transaksi": nomorTransaksi,
                                    "nomor_referensi":
                                        txtReferensiController.text,
                                    "jumlah_rupiah": Fungsi().fmtStringToInt(
                                        txtJumlahRupiahController.text),
                                    "bank_id": Prefs.getInt("bank_id"),
                                    "keterangan": txtKeteranganController.text,
                                    "tanggal_transaksi": tanggalTransaksi,
                                    "pemasukan":
                                        kategori == "Pemasukkan" ? 1 : 0,
                                    "cash": pembayaran == "Cash" ? 0 : 1,
                                  }
                                : <dynamic, dynamic>{
                                    "nomor_referensi":
                                        txtReferensiController.text,
                                      "tanggal_transaksi": tanggalTransaksi,
                                    "jumlah_rupiah": Fungsi().fmtStringToInt(
                                        txtJumlahRupiahController.text),
                                    "bank_id": Prefs.getInt("bank_id"),
                                    "keterangan": txtKeteranganController.text,
                                    "pemasukan":
                                        kategori == "Pemasukkan" ? 1 : 0,
                                    "cash": pembayaran == "Cash" ? 0 : 1,
                                  };
                                  Prefs.setBool("isSaving", true);
                            print(dataSave.toString());
                            ApiUtilities().saveUpdateData(
                                context: context,
                                data: dataSave,
                                namaAPI: "cashbank",
                                isEdit: isEdit,
                                setState: setState,
                                prefix: "CB");
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
