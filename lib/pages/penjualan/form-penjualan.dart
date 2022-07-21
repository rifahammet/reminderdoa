import 'dart:async';
import 'dart:convert';
import 'package:charcode/ascii.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
// import 'package:doa/pages/listups/listup-kategori-barang.dart';
import 'package:doa/pages/listups/listup-store-sampah.dart';
import 'package:doa/pages/listups/listup-user.dart';
import 'package:doa/pages/listups/listupt-bank-sampah..dart';
import 'package:doa/pages/penjualan/form-additem-penjualan.dart';
import 'package:doa/pages/store-sampah/form-additem-sampah.dart';
import 'package:doa/utils/api-utility.dart';
import 'package:doa/utils/api.dart';
import 'package:doa/utils/function.dart';
import 'package:doa/utils/pref_manager.dart';
import 'package:doa/widgets/checkbox.dart';
import 'package:doa/widgets/datepicker.dart';
import 'package:doa/widgets/detail-item.dart';
import 'package:doa/widgets/dropdown.dart';
import 'package:doa/widgets/listup.dart';
import 'package:doa/widgets/textbox.dart';
import 'package:sweetalert/sweetalert.dart';

class PenjualanDialog {
  GlobalKey<FormState>? _key;
  bool autoValidate = false;
  int id = 0;
  bool isAktif = true;
  String? tanggalTransaksi;
  double height = 465;
  final txtTanggalTransaksiController = TextEditingController();
  final txtNomorTransaksiController = TextEditingController();
  final txtJumlahDanaController = TextEditingController();
  final txtKeteranganController = TextEditingController();
  final txtNomorReferensiController = TextEditingController();
  final txtNoStoreSampahController = TextEditingController();

  final txtTanggalTransaksiFocusNode = FocusNode();
  final txtNomorTransaksiFocusNode = FocusNode();
  final txtJumlahDanaFocusNode = FocusNode();
  final txtKeteranganFocusNode = FocusNode();
  final txtNomorReferensiFocusNode = FocusNode();
  final txtNoStoreSampahFocusNode = FocusNode();

  bool isFirst = true;
  dynamic nGrandTotal = 0;
  int idHeader = 0;

  List<dynamic>? dataDetails = [];
  List<dynamic>? deletedDetails = [];

  /* checkbox */
  int isActive = 1;

  Future<dynamic> getData(isEdit, data) async {
    if (isEdit) {
      final vData = await ApiUtilities()
          .getGlobalParam(namaApi: "penjualandetail", where: {"id": data,"deleted_detail": 0});
      return vData["data"]["data"];
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
            print("pilihan=" + pil.toString() + " - value = " + val.toString());
          });
        }

        change_isactive(val) {
          setState(() {
            isActive = val;
          });
        } /* end call back */

        /* add item */
        addItem({isEdit, List<dynamic>? listItem, index = 0}) async {
          FocusScope.of(context).requestFocus(FocusNode());
          final res = await showDialog(
            context: context,
            builder: (BuildContext context) => new AddItemPenjualanDialog()
                .buildAddDialog(
                    context: context,
                    data: listItem,
                    index: index,
                    isEdit: isEdit,
                    sourceForm: this),
          );

          if (res != null) {
            setState(() {
              if (isEdit) {
                listItem!.removeAt(index);
              }
              listItem!.add(res);
              //txtNamaAnggotaController.text = res["prop_nama"];
            });
          }
        }
        /* end add item */

        onClearInputontroller(data) {
          setState(() {});
        }

        callBackAddData(List<dynamic> s) {
          addItem(isEdit: false, listItem: s);
        }

        callBackDelete(isAPI, data) async {
          setState(() {
            if (isEdit) {
              if (data["isEdit"]) {
                deletedDetails!.add(data);
              } else {
                print("news");
              }
            }
          });
          if (isAPI) {
            //  Navigator.pop(context);
          }
        }

        callBackView(index) {
          addItem(isEdit: true, listItem: dataDetails, index: index);
        }

        isiWidget(index) {
          var nTotal = double.parse(dataDetails![index]["qty"].toString()) *
              double.parse(dataDetails![index]["harga_jual"].toString());
          return Padding(
              padding: EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                          width: 50,
                          child: Text(dataDetails![index]["barang_kode"])),
                      Expanded(child: Text(dataDetails![index]["barang_nama"])),
                      SizedBox(
                          width: 50,
                          child: Text(dataDetails![index]["satuan"])),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                          width: 50,
                          child: Align(
                              alignment: Alignment.center,
                              child:

                                  Text(
                                    Fungsi().format(double.parse(dataDetails![index]["qty"].toString()), isInteger: false)
                                    
                                    ))),
                      SizedBox(
                          width: 10,
                          child: Align(
                              alignment: Alignment.center, child: Text("x"))),
                      Expanded(
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                Fungsi().format(double.parse(dataDetails![index]["harga_jual"].toString()), isInteger: false, isMataUang: true)
                                ))),
                      SizedBox(
                          width: 10,
                          child: Align(
                              alignment: Alignment.center, child: Text("="))),
                      SizedBox(
                          width: 120,
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(Fungsi().format(nTotal, isInteger: false, isMataUang: true).toString()))),
                    ],
                  ),
                  SizedBox(
                      width: 100,
                      child: Align(
                          alignment: Alignment.center,
                          child:
                              Text(dataDetails![index]["isEdit"].toString())))
                ],
              ));
        }

         listUP(label,BuildContext context) async {
        final res = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ListUpStoreSampahPage(),
          ),
        );
        if (res != null) {
          setState(() {
            // barangKode = res["barang_kode"];
            // barangId =int.parse(res["id"]);
            // txtNamaBarangController.text = res["barang_nama"];
            // //txtHargaJualController.text = Fungsi().format(double.parse(res["harga_jual"]),  isInteger: false); 
            // //barangHarga = double.parse(res["harga_jual"]);
            // satuan =res["satuan"];
          });
        }
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
                    "Form Penjualan Sampah",
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
                              for (var snapData in snapshot.data) {
                                {
                                  var newData = {
                                    "id":int.parse(snapData["penjualan_id_detail"]),
                                    "barang_id":
                                        int.parse(snapData["barang_id"]),
                                    "barang_kode": snapData["barang_kode"],
                                    "barang_nama": snapData["barang_nama"],
                                    "satuan": snapData["satuan"],
                                    "harga_jual":
                                        double.parse(snapData["harga_jual"]),
                                    "qty": double.parse(snapData["qty"]),
                                    "keterangan": snapData["keterangan"],
                                    "isEdit": true,
                                    "isChanged" : false
                                  };
                                  dataDetails?.add(newData);
                                }
                              }
                              if(snapshot.data!=null){
                              var dataHeader = snapshot.data[0];
                              idHeader = int.parse(dataHeader["id"]);
                              txtTanggalTransaksiController.text =
                                  dataHeader["tanggal_transaksi"];
                              txtTanggalTransaksiController.text = formatDate(
                                  DateTime.parse(
                                      dataHeader["tanggal_transaksi"]),
                                  [dd, '-', mm, '-', yyyy]);
                              tanggalTransaksi =
                                  dataHeader["tanggal_transaksi"];
                              txtNomorTransaksiController.text =
                                  dataHeader["nomor_transaksi"];
txtNomorReferensiController.text =
                                  dataHeader["nomor_referensi"];
                              // txtJumlahDanaController.text = Fungsi().format(
                              //     double.parse(dataHeader['total_rupiah']),
                              //     isInteger: false);
                              txtKeteranganController.text =
                                  dataHeader["keterangan"];
                              // isActive=
                              // int.parse(snapshot.data["cash"]);
                              }
                              else{
                                txtTanggalTransaksiController.text = formatDate(
                                  DateTime.now(), [dd, '-', mm, '-', yyyy]);
                              tanggalTransaksi = Fungsi().fmtDateTimeYearNow();
                              txtNomorTransaksiController.text = "";
                              txtNomorReferensiController.text ="";
                              txtJumlahDanaController.text = "0.00";
                              txtKeteranganController.text = "";
                              isActive = 1;
                              }
                            } else {
                              txtTanggalTransaksiController.text = formatDate(
                                  DateTime.now(), [dd, '-', mm, '-', yyyy]);
                              tanggalTransaksi = formatDate(
                                  DateTime.now(), [yyyy, '-', mm, '-', dd]);
                              txtNomorTransaksiController.text = "";
                              txtJumlahDanaController.text = "0.00";
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
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              color: Colors.white,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    Visibility(
                                        visible: true,
                                        child: Container(
                                            child: Column(
                                          children: [
                                            DatePicker().datePickerBorder(
                                              context,
                                              textController:
                                                  txtTanggalTransaksiController,
                                              label: "Tanggal Transaksi",
                                              fungsiCallback:
                                                  displayTanggalTransaksi,
                                              formatDate: tanggalTransaksi,
                                            ),
                                            TextBox().textboxWithBorderValidate(context,
                                                label: "Nomor Referensi",
                                                textController:
                                                    txtNomorReferensiController,
                                                textChange: changeTextField,
                                                isMandatory: true,
                                                textFocusNote:
                                                    txtNomorReferensiFocusNode),
                                            ListUp().listUpWithBorderValidate(context,
                                                label: "Store Sampah",
                                                textController: txtNoStoreSampahController,
                                                textFocusNote: txtNoStoreSampahFocusNode,
                                                suffixIconOnPressed: listUP
                                                ),
                                            TextBox().textboxWithBorderValidate(
                                                context,
                                                label: "Keterangan",
                                                textController:
                                                    txtKeteranganController,
                                                textChange: changeTextField,
                                                textFocusNote:
                                                    txtKeteranganFocusNode,
                                                isMandatory: false,
                                                maxlines: 3),
                                          ],
                                        ))),
                                    DetailItem().getDetailItem(
                                        context: context,
                                        callBackAddData: callBackAddData,
                                        callBackDelete: callBackDelete,
                                        callBackView: callBackView,
                                        data: dataDetails,
                                        isAPI: true,
                                        judulTabel: "Item Barang",
                                        warnaHeader: Colors.green,
                                        warna: Colors.green,
                                        isiWidget: isiWidget,
                                        isKlik: false,
                                        height: height,
                                        primaryKey: "barang_id",
                                       isCardBody: false
                                        ),
                                    //Text(nGrandTotal.toString()),
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
                            print("SS/" +
                                formatDate(DateTime.now(), [mm, '/', yyyy])
                                    .toString() +
                                "/");

                            List<dynamic> dataSave;
                            dynamic dataSaveEdit;
                            List<dynamic> dataEdit = [];
                            dynamic dataSaveNew;
                            List<dynamic> dataNew = [];
                            dynamic dataSaveDelete;
                            List<dynamic> dataDelete = [];

                            dataSave = [
                              {
                                "penjualanheader": {
                                  "action": isEdit ? "update" : "new",
                                  "data": [
                                    isEdit
                                        ? {
                                            "nomor_transaksi":
                                                txtNomorTransaksiController
                                                    .text,
                                            "tanggal_transaksi":
                                                tanggalTransaksi,
                                            "deleted":0,
                                            "approved":0,
                                            "nomor_referensi": txtNomorReferensiController.text,
                                            "keterangan":
                                                txtKeteranganController.text,
                                            "dt_updated":Fungsi().fmtDateTimeYearNow(),
                                            "updated_user_profile_id" : Prefs.getInt("userId")
                                              
                                          }
                                        : {
                                            "tanggal_transaksi":
                                                tanggalTransaksi,
                                            "nomor_referensi": txtNomorReferensiController.text,
                                            "bank_id": Prefs.getInt("bank_id"),
                                            "keterangan":
                                                txtKeteranganController.text,
                                            "created_user_profile_id" : Prefs.getInt("userId")
                                          }
                                  ]
                                }
                              }
                            ];
                            /* data grid new dan edit*/
                            if (dataDetails!.length > 0) {
                              if (isEdit) {
                                for (var snapData in dataDetails!) {
                                  
                                    if (snapData["isEdit"]) {
                                      if (snapData["isChanged"]) {
                                      var newData = {
                                        "id": snapData["id"],
                                        "penjualan_id_header": idHeader,
                                        "barang_id": snapData["barang_id"],
                                        "harga_jual": snapData["harga_jual"],
                                        "qty": snapData["qty"],
                                        "keterangan": snapData["keterangan"],
                                        "bank_id": Prefs.getInt("bank_id")
                                      };
                                      dataEdit.add(newData);
                                      }
                                    } else {
                                      print("idHeader="+idHeader.toString());
                                      var newData = {
                                        "penjualan_id_header": idHeader,
                                        "barang_id": snapData["barang_id"],
                                        "harga_jual": snapData["harga_jual"],
                                        "qty": snapData["qty"],
                                        "keterangan": snapData["keterangan"],
                                        "bank_id": Prefs.getInt("bank_id")
                                      };
                                      dataNew.add(newData);
                                    }
                                  
                                }
                              } else {
                                for (var snapData in dataDetails!) {
                                  
                                      var newData = {
                                        "barang_id": snapData["barang_id"],
                                        "harga_jual": snapData["harga_jual"],
                                        "qty": snapData["qty"],
                                        "keterangan": snapData["keterangan"],
                                        "bank_id": Prefs.getInt("bank_id")
                                      };
                                      dataNew.add(newData);
                                  
                                }
                              }
                            }


                            if(dataEdit.length > 0){
                            dataSaveEdit = {
                              "penjualandetail": {
                                "action": "update",
                                "data": dataEdit
                              }
                            };
                             dataSave.add(dataSaveEdit);
                            }
                            if(dataNew.length > 0){
                              dataSaveNew = {
                                "penjualandetail": {
                                  "action": "new",
                                  "data": dataNew
                                }
                              };
                              dataSave.add(dataSaveNew);
                            }
                            /* end data grid new dan edit*/

                            /* data grid deleted */
                            if(deletedDetails!.length>0){
                            for (var snapData in deletedDetails!) {
                                      var newData = {
                                        "id": snapData["id"],
                                        "deleted":1
                                      };
                                      dataDelete.add(newData);
                                }
                                dataSaveDelete = {
                              "penjualandetail": {
                                "action": "update",
                                "data": dataDelete
                              }
                            };
                            dataSave.add(dataSaveDelete);
                            }
                            print("data save =" + dataSave.toString());
                            Prefs.setBool("isSaving", true);
                            ApiUtilities().saveUpdateBatchData(
                              context: context,
                              data: dataSave,
                              isEdit: isEdit,
                              setState: setState,
                              prefix: "JS/" +
                                  Prefs.getInt("bank_id").toString() +
                                  "/" +
                                  formatDate(DateTime.now(), [mm, '/', yyyy])
                                      .toString() +
                                  "/",
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
