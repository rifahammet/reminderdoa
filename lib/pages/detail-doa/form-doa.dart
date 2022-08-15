import 'dart:async';
import 'dart:convert';
import 'package:date_format/date_format.dart';
import 'package:doa/widgets/datepicker.dart';
import 'package:doa/widgets/expandablemenu.dart';
import 'package:doa/widgets/label.dart';
import 'package:doa/widgets/show-dialog.dart';
import 'package:doa/widgets/timepicker.dart';
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

class DoaDialog {
  GlobalKey<FormState>? _key;
  bool autoValidate = false;
  int id = 0;
  bool isFavorit = true;
  int favoritId = 0;

  final txtArabController = TextEditingController();
  final txtNameController = TextEditingController();
  final txtLatinController = TextEditingController();
  final txtTypeNameController = TextEditingController();
  final txtTypeIdController = TextEditingController();
  final txtArtiController = TextEditingController();
  final txtWaktuSholatController = TextEditingController();
  final txtWaktuTanggalController = TextEditingController();
  final txtWaktuBukaController = TextEditingController();
  final txtWaktuPagiController = TextEditingController();
  final txtWaktuSiangController = TextEditingController();
  final txtWaktuMalamController = TextEditingController();
  final txtWaktuSeninController = TextEditingController();
  final txtWaktuSelasaController = TextEditingController();
  final txtWaktuRabuController = TextEditingController();
  final txtWaktuKamisController = TextEditingController();
  final txtWaktuJumatController = TextEditingController();
  final txtWaktuSabtuController = TextEditingController();
  final txtWaktuMingguController = TextEditingController();
  final txtTanggalTransaksiController = TextEditingController();

  final txtArabFocusNode = FocusNode();
  final txtNameFocusNode = FocusNode();
  final txtSatuanFocusNode = FocusNode();
  final txtLatinFocusNode = FocusNode();
  final txtTypeNameFocusNode = FocusNode();
  final txtKategoriIdFocusNode = FocusNode();
  final txtArtiFocusNode = FocusNode();
  bool isFirst = true;
  //String satuan = 'Pcs';

  bool firstLoad = true;
  String? tanggalTransaksi;
  bool isDisplaySholat = true;
  bool isDisplayRamadhan = false;
  bool isDisplayBatasWaktu = false;
  bool isDisplayHarian = false;
  bool isDisplayTanggal = false;
  bool isFavoritEdit = false;
  String vExpandableMenu = "sholat";
  /* dbcombobox */
  List<dynamic>? listSatuan;
  dynamic satuan;

  /* checkbox */
  bool cboSholat = false;

  bool cboImsak = false;
  bool cboTanggal = false;
  bool cboPagi = false;
  bool cboSiang = false;
  bool cboMalam = false;
  bool cboSenin = false;
  bool cboSelasa = false;
  bool cboRabu = false;
  bool cboKamis = false;
  bool cboJumat = false;
  bool cboSabtu = false;
  bool cboMinggu = false;
  int isActive = 0;

  Future<int> getUserId() async {
    return Prefs.getInt('userId');
  }

  Future<dynamic> getData(isEdit, data) async {
    // if(firstLoad){
    //             final data = await ApiUtilities().getGlobalParamNoLimit(namaApi: "satuan", where: {"active" : 1, "deleted" : 0, "bank_id": Prefs.getInt("bank_id")});
    //             listSatuan=data["data"]["data"];

    //              firstLoad = false;
    // }
    var vData;
    if (isEdit) {
      vData = await ApiUtilities().getGlobalParamNoLimit(
          namaApi: "masterdoa",
          where: {
            "user_id": Prefs.getInt("userId"),
            "id": data,
            "isfavorit": 1
          });
      bool isSukses = vData["isSuccess"] as bool;
      if (!isSukses) {
        vData = await ApiUtilities()
            .getGlobalParamNoLimit(namaApi: "masterdoa", where: {"id": data});
      }
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

        // listUP(label, BuildContext context) async {
        //   final res = await Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => ListUpCategoriBarangPage(),
        //     ),
        //   );
        //   if (res != null) {
        //     setState(() {
        //       txtTypeNameController.text = res["name"];
        //       txtTypeIdController.text = res["id"];
        //     });
        //   }
        // }
        callBackTimeSholat(data) {
          txtWaktuSholatController.text = data;
        }

        callBackTimeTanggal(data) {
          txtWaktuTanggalController.text = data;
        }

        callBackTimeWaktuPagi(data) {
          txtWaktuPagiController.text = data;
        }

        callBackTimeWaktuSiang(data) {
          txtWaktuSiangController.text = data;
        }

        callBackTimeWaktuMalam(data) {
          txtWaktuMalamController.text = data;
        }

        callBackTimeHarianSenin(data) {
          txtWaktuSeninController.text = data;
        }

        callBackTimeHarianSelasa(data) {
          txtWaktuSelasaController.text = data;
        }

        callBackTimeHarianRabu(data) {
          txtWaktuRabuController.text = data;
        }

        callBackTimeHarianKamis(data) {
          txtWaktuKamisController.text = data;
        }

        callBackTimeHarianJumat(data) {
          txtWaktuJumatController.text = data;
        }

        callBackTimeHarianSabtu(data) {
          txtWaktuSabtuController.text = data;
        }

        callBackTimeHarianMinggu(data) {
          txtWaktuMingguController.text = data;
        }

        display_satuan(data) {
          return data["satuan"];
        }

        change_satuan(data) {
          setState(() {
            satuan = data;
          });
        }

        // ignore: non_constant_identifier_names
        changeTextField(pil, val) {
          setState(() {
            print("pilihan=" + pil.toString() + " - value = " + val.toString());
          });
        }

        change_isactive(val) async {
          //     final vData = await ApiUtilities()
          //     .getGlobalParamNoLimit(namaApi: "userreminder", where: {"doa_id": data, "user_id": Prefs.getInt("userId")});
          // if(vData["isSuccess"]==true){
          //   print("total="+vData["data"]["data"].length.toString());
          //   if(vData["data"]["data"].length >0){
          //     //edit
          //       //print("vdata="+vData.toString());
          //   } else {
          //     //new
          //   }
          SweetAlert.show(context,
              subtitle: "please_wait", style: SweetAlertStyle.loading);
          var dataSave;
          dataSave = isFavoritEdit
              ? <dynamic, dynamic>{"isfavorit": val ? 0 : 1}
              : <dynamic, dynamic>{
                  "isfavorit": val ? 0 : 1,
                  "user_id": Prefs.getInt("userId"),
                  "doa_id": data
                };
          var where = isFavoritEdit
              ? <dynamic, dynamic>{
                  "doa_id": data,
                  "user_id": Prefs.getInt("userId")
                }
              : null;
          ApiUtilities().saveUpdateData(
              context: context,
              data: dataSave,
              namaAPI: "doafavorit",
              isEdit: isFavoritEdit,
              isSingleDelete: true,
              caption: !val
                  ? "Doa telah didaftarkan ke favorit"
                  : "Doa telah dilepaskan dari favorit",
              where: where,
              setState: setState);
          setState(() {
            isFavoritEdit = isFavoritEdit == false ? true : true;
            isFavorit = val;
          });
          //  }

          //var data = vData["data"]["data"][0];
        } /* end call back */

        onPressedDialog(data) {
          // print('data=' + data.toString());
          // SweetAlert.show(
          //   context,
          //   subtitle: "Data has been Approved",
          //   style: SweetAlertStyle.loadingSuccess,
          // );

          SweetAlert.show(context,
              subtitle: "please_wait", style: SweetAlertStyle.loading);
          var userID = Prefs.getInt("userId");
          var arrData = [];
          if (cboSholat) {
            arrData.add({
              "user_id": userID,
              "doa_id": data["id"],
              "isjadwal_sholat": 1
            });
          }

          if (cboImsak) {
            arrData.add({
              "user_id": userID,
              "doa_id": data["id"],
              "isRamadhan": 1,
              "waktu": "Imsak"
            });
          }
          if (cboTanggal) {
            arrData.add({
              "user_id": userID,
              "doa_id": data["id"],
              "isByDate": 1,
              "tanggal": tanggalTransaksi,
              "time": txtWaktuTanggalController.text
            });
          }
          if (cboPagi) {
            arrData.add({
              "user_id": userID,
              "doa_id": data["id"],
              "isWaktu": 1,
              "waktu": "Pagi",
              "time": txtWaktuPagiController.text
            });
          }
          if (cboSiang) {
            arrData.add({
              "user_id": userID,
              "doa_id": data["id"],
              "isWaktu": 1,
              "waktu": "Siang",
              "time": txtWaktuSiangController.text
            });
          }
          if (cboMalam) {
            arrData.add({
              "user_id": userID,
              "doa_id": data["id"],
              "isWaktu": 1,
              "waktu": "Malam",
              "time": txtWaktuMalamController.text
            });
          }
          if (cboSenin) {
            arrData.add({
              "user_id": userID,
              "doa_id": data["id"],
              "isDaily": 1,
              "day": "Senin",
              "time": txtWaktuSeninController.text
            });
          }
          if (cboSelasa) {
            arrData.add({
              "user_id": userID,
              "doa_id": data["id"],
              "isDaily": 1,
              "day": "Selasa",
              "time": txtWaktuSelasaController.text
            });
          }
          if (cboRabu) {
            arrData.add({
              "user_id": userID,
              "doa_id": data["id"],
              "isDaily": 1,
              "day": "Rabu",
              "time": txtWaktuRabuController.text
            });
          }
          if (cboKamis) {
            arrData.add({
              "user_id": userID,
              "doa_id": data["id"],
              "isDaily": 1,
              "day": "Kamis",
              "time": txtWaktuKamisController.text
            });
          }
          if (cboJumat) {
            arrData.add({
              "user_id": userID,
              "doa_id": data["id"],
              "isDaily": 1,
              "day": "Jumat",
              "time": txtWaktuJumatController.text
            });
          }
          if (cboSabtu) {
            arrData.add({
              "user_id": userID,
              "doa_id": data["id"],
              "isDaily": 1,
              "day": "Sabtu",
              "time": txtWaktuSabtuController.text
            });
          }
          if (cboMinggu) {
            arrData.add({
              "user_id": userID,
              "doa_id": data["id"],
              "isDaily": 1,
              "day": "Minggu",
              "time": txtWaktuMingguController.text
            });
          }
          var dataSave = [
            {
              "userreminder": {
                "action": "delete",
                "where": {"user_id": userID, "doa_id": data["id"]}
              }
            },
            {
              "userreminder": {"action": "new", "data": arrData}
            }
          ];

          // print('data saved='+dataSave.toString());
          // Future.delayed(new Duration(seconds: 3), () {
          //   setState(() {});
          //   Navigator.pop(context);
          // });
          void callBack() {
            SweetAlert.show(
              context,
              subtitle: "Data has been Saved",
              style: SweetAlertStyle.loadingSuccess,
            );

            Future.delayed(new Duration(seconds: 3), () {
              setState(() {
                firstLoad = true;
              });
              Navigator.pop(context);
              //Navigator.pop(context);
            });
          }

          //print(dataSave);
          ApiUtilities().saveUpdateBatchData(
              context: context,
              data: dataSave,
              isEdit: false,
              setState: setState,
              isCustom: true,
              callBack: callBack);
        }

        /* call back */

        return WillPopScope(
            key: _key,
            onWillPop: () async => false,
            child: Scaffold(
                resizeToAvoidBottomInset: true,
                appBar: AppBar(
                  backgroundColor: Colors.green[700],
                  leading: IconButton(
                    icon: const Icon(Icons.close, color: Colors.yellow),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  title: const Text(
                    "Doa",
                  ),
                  actions: [
                    Visibility(
                        visible: !Prefs.getBool("isExpired"),
                        child: IconButton(
                          icon: Icon(
                            Icons.settings,
                            color: Colors.yellow,
                          ),
                          onPressed: () async {
                            // do something
                            showDialogWidget(data, setState) {
                              // txtBaseUrlController.text = Api.BASE_URL;
                              // txtBatchUrlController.text = Api.BATCH_URL;
                              print("isFirstLoad=" + firstLoad.toString());
                              if (firstLoad) {
                                setState(() {
                                  firstLoad = false;
                                });
                                txtTanggalTransaksiController.text = formatDate(
                                    DateTime.now(), [dd, '-', mm, '-', yyyy]);
                                tanggalTransaksi =
                                    Fungsi().fmtDateTimeYearNow();
                                txtWaktuSholatController.text =
                                    formatDate(DateTime.now(), [HH, ':', nn]);
                                txtWaktuTanggalController.text =
                                    formatDate(DateTime.now(), [HH, ':', nn]);
                                txtWaktuPagiController.text =
                                    formatDate(DateTime.now(), [HH, ':', nn]);
                                txtWaktuSiangController.text =
                                    formatDate(DateTime.now(), [HH, ':', nn]);
                                txtWaktuMalamController.text =
                                    formatDate(DateTime.now(), [HH, ':', nn]);
                                txtWaktuSeninController.text =
                                    formatDate(DateTime.now(), [HH, ':', nn]);
                                txtWaktuSelasaController.text =
                                    formatDate(DateTime.now(), [HH, ':', nn]);
                                txtWaktuRabuController.text =
                                    formatDate(DateTime.now(), [HH, ':', nn]);
                                txtWaktuKamisController.text =
                                    formatDate(DateTime.now(), [HH, ':', nn]);
                                txtWaktuJumatController.text =
                                    formatDate(DateTime.now(), [HH, ':', nn]);
                                txtWaktuSabtuController.text =
                                    formatDate(DateTime.now(), [HH, ':', nn]);
                                txtWaktuMingguController.text =
                                    formatDate(DateTime.now(), [HH, ':', nn]);
                                if (data["data"].length > 0) {
                                  data["data"].forEach((dynamic vdata) {
                                    if (int.parse(vdata['isjadwal_sholat']) ==
                                        1) {
                                      setState(() {
                                        cboSholat = true;
                                      });
                                    }
                                    if (int.parse(vdata['isRamadhan']) == 1) {
                                      setState(() {
                                        cboImsak = true;
                                      });
                                    }
                                    if (int.parse(vdata['isByDate']) == 1) {
                                      setState(() {
                                        cboTanggal = true;
                                        txtTanggalTransaksiController.text =
                                            formatDate(
                                                DateTime.parse(
                                                    vdata["tanggal"]),
                                                [dd, '-', mm, '-', yyyy]);
                                        tanggalTransaksi = vdata["tanggal"];
                                        txtWaktuTanggalController.text =
                                            vdata['time']
                                                .toString()
                                                .substring(0, 5);
                                      });
                                    }

                                    if (int.parse(vdata['isDaily']) == 1) {
                                      if (vdata['day'] == "Senin") {
                                        setState(() {
                                          cboSenin = true;
                                          txtWaktuSeninController.text =
                                              vdata['time']
                                                  .toString()
                                                  .substring(0, 5);
                                        });
                                      }
                                      if (vdata['day'] == "Selasa") {
                                        setState(() {
                                          cboSelasa = true;
                                          txtWaktuSelasaController.text =
                                              vdata['time']
                                                  .toString()
                                                  .substring(0, 5);
                                        });
                                      }
                                      if (vdata['day'] == "Rabu") {
                                        setState(() {
                                          cboRabu = true;
                                          txtWaktuRabuController.text =
                                              vdata['time']
                                                  .toString()
                                                  .substring(0, 5);
                                        });
                                      }
                                      if (vdata['day'] == "Kamis") {
                                        setState(() {
                                          cboKamis = true;
                                          txtWaktuKamisController.text =
                                              vdata['time']
                                                  .toString()
                                                  .substring(0, 5);
                                        });
                                      }
                                      if (vdata['day'] == "Jumat") {
                                        setState(() {
                                          cboJumat = true;
                                          txtWaktuJumatController.text =
                                              vdata['time']
                                                  .toString()
                                                  .substring(0, 5);
                                        });
                                      }
                                      if (vdata['day'] == "Sabtu") {
                                        setState(() {
                                          cboSabtu = true;
                                          txtWaktuSabtuController.text =
                                              vdata['time']
                                                  .toString()
                                                  .substring(0, 5);
                                        });
                                      }
                                      if (vdata['day'] == "Minggu") {
                                        setState(() {
                                          cboMinggu = true;
                                          txtWaktuMingguController.text =
                                              vdata['time']
                                                  .toString()
                                                  .substring(0, 5);
                                        });
                                      }
                                    }
                                    if (int.parse(vdata['isWaktu']) == 1) {
                                      if (vdata['waktu'] == "Pagi") {
                                        setState(() {
                                          cboPagi = true;
                                          txtWaktuPagiController.text =
                                              vdata['time']
                                                  .toString()
                                                  .substring(0, 5);
                                        });
                                      }
                                      if (vdata['waktu'] == "Siang") {
                                        setState(() {
                                          cboSiang = true;
                                          txtWaktuSiangController.text =
                                              vdata['time']
                                                  .toString()
                                                  .substring(0, 5);
                                        });
                                      }
                                      if (vdata['waktu'] == "Malam") {
                                        setState(() {
                                          cboMalam = true;
                                          txtWaktuMalamController.text =
                                              vdata['time']
                                                  .toString()
                                                  .substring(0, 5);
                                        });
                                      }
                                    }
                                  });
                                }
                              }

                              displayTanggalTransaksi(formatDate, formatYear) {
                                setState(() {
                                  tanggalTransaksi = formatYear.toString();
                                  txtTanggalTransaksiController.text =
                                      formatDate.toString();
                                  print('tanggal=' + formatDate.toString());
                                });
                              }

                              cbOnChangeSholat(val) {
                                setState(() {
                                  cboSholat = val;
                                });
                              }

                              cbOnChangeImsak(val) {
                                setState(() {
                                  cboImsak = val;
                                });
                              }

                              cbOnChangeTanggal(val) {
                                setState(() {
                                  cboTanggal = val;
                                });
                              }

                              cbOnChangePagi(val) {
                                setState(() {
                                  cboPagi = val;
                                });
                              }

                              cbOnChangeSiang(val) {
                                setState(() {
                                  cboSiang = val;
                                });
                              }

                              cbOnChangeMalam(val) {
                                setState(() {
                                  cboMalam = val;
                                });
                              }

                              cbOnChangeSenin(val) {
                                setState(() {
                                  cboSenin = val;
                                });
                              }

                              cbOnChangeSelasa(val) {
                                setState(() {
                                  cboSelasa = val;
                                });
                              }

                              cbOnChangeRabu(val) {
                                setState(() {
                                  cboRabu = val;
                                });
                              }

                              cbOnChangeKamis(val) {
                                setState(() {
                                  cboKamis = val;
                                });
                              }

                              cbOnChangeJumat(val) {
                                setState(() {
                                  cboJumat = val;
                                });
                              }

                              cbOnChangeSabtu(val) {
                                setState(() {
                                  cboSabtu = val;
                                });
                              }

                              cbOnChangeMinggu(val) {
                                setState(() {
                                  cboMinggu = val;
                                });
                              }

                              callBackSholat(value) {
                                if (vExpandableMenu != "sholat") {
                                  setState(() {
                                    vExpandableMenu = "sholat";
                                    isDisplaySholat = value;
                                    isDisplayTanggal = !value;
                                    isDisplayRamadhan = !value;
                                    isDisplayBatasWaktu = !value;
                                    isDisplayHarian = !value;
                                  });
                                }
                              }

                              isiWidgetSholat() {
                                Widget wgs = Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      CheckBox().checkBox(
                                          lebars: 200,
                                          checkBoxLabel: "sholat 5 waktu",
                                          boolValue: cboSholat,
                                          cbOnChage: cbOnChangeSholat),
                                    ]);
                                return wgs;
                              }

                              callBackTanggal(value) {
                                if (vExpandableMenu != "tanggal") {
                                  setState(() {
                                    vExpandableMenu = "tanggal";
                                    isDisplayTanggal = value;
                                    isDisplaySholat = !value;
                                    isDisplayRamadhan = !value;
                                    isDisplayBatasWaktu = !value;
                                    isDisplayHarian = !value;
                                  });
                                }
                              }

                              isiWidgetTanggal() {
                                Widget wgs = Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.only(top: 15),
                                          child: Row(
                                            children: [
                                              CheckBox().checkBox(
                                                  lebars: 100,
                                                  checkBoxLabel: "Tanggal",
                                                  boolValue: cboTanggal,
                                                  cbOnChage: cbOnChangeTanggal,
                                                  isUpDown: true),
                                              Expanded(
                                                  child: Column(
                                                children: [
                                                  DatePicker().datePickerBorder(
                                                    context,
                                                    textController:
                                                        txtTanggalTransaksiController,
                                                    label: "Tanggal",
                                                    fungsiCallback:
                                                        displayTanggalTransaksi,
                                                    formatDate:
                                                        tanggalTransaksi,
                                                  ),
                                                  TimePicker().datePickerBorder(
                                                      context,
                                                      label: "Waktu",
                                                      textController:
                                                          txtWaktuTanggalController,
                                                      fungsiCallback:
                                                          callBackTimeTanggal)
                                                ],
                                              )),
                                            ],
                                          ))
                                    ]);
                                return wgs;
                              }

                              callBackRamadhan(value) {
                                if (vExpandableMenu != "ramadhan") {
                                  setState(() {
                                    vExpandableMenu = "ramadhan";
                                    isDisplayRamadhan = value;
                                    isDisplaySholat = !value;
                                    isDisplayBatasWaktu = !value;
                                    isDisplayHarian = !value;
                                    isDisplayTanggal = !value;
                                  });
                                }
                              }

                              isiWidgetRamadhan() {
                                Widget wgs = Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      CheckBox().checkBox(
                                          lebars: 200,
                                          checkBoxLabel: "Imsak",
                                          boolValue: cboImsak,
                                          cbOnChage: cbOnChangeImsak),
                                    ]);
                                return wgs;
                                // Widget wgs = Column(
                                //     crossAxisAlignment:
                                //         CrossAxisAlignment.start,
                                //     children: <Widget>[
                                //       Padding(
                                //           padding: EdgeInsets.only(top: 15),
                                //           child: Row(
                                //             children: [
                                //               CheckBox().checkBox(
                                //                   lebars: 100,
                                //                   checkBoxLabel: "Imsak",
                                //                   boolValue: cboImsak,
                                //                   cbOnChage: cbOnChangeImsak,
                                //                   isUpDown: true),
                                //               Expanded(
                                //                   child: TimePicker()
                                //                       .datePickerBorder(context,
                                //                           label: "Waktu",
                                //                           textController:
                                //                               txtWaktuImsakController,
                                //                           fungsiCallback:
                                //                               callBackTimeImsak))
                                //             ],
                                //           )),
                                //     ]);
                                // return wgs;
                              }

                              callBackBatasWaktu(value) {
                                if (vExpandableMenu != "waktu") {
                                  setState(() {
                                    vExpandableMenu = "waktu";
                                    isDisplayBatasWaktu = value;
                                    isDisplaySholat = !value;
                                    isDisplayRamadhan = !value;
                                    isDisplayHarian = !value;
                                    isDisplayTanggal = !value;
                                  });
                                }
                              }

                              isiWidgetBatasWaktu() {
                                Widget wgs = Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.only(top: 15),
                                          child: Row(
                                            children: [
                                              CheckBox().checkBox(
                                                  lebars: 100,
                                                  checkBoxLabel: "Pagi",
                                                  boolValue: cboPagi,
                                                  cbOnChage: cbOnChangePagi,
                                                  isUpDown: true),
                                              Expanded(
                                                  child: TimePicker().datePickerBorder(
                                                      context,
                                                      label: "Waktu",
                                                      textController:
                                                          txtWaktuPagiController,
                                                      fungsiCallback:
                                                          callBackTimeWaktuPagi))
                                            ],
                                          )),
                                      Row(
                                        children: [
                                          CheckBox().checkBox(
                                              lebars: 100,
                                              checkBoxLabel: "Siang",
                                              boolValue: cboSiang,
                                              cbOnChage: cbOnChangeSiang,
                                              isUpDown: true),
                                          Expanded(
                                              child: TimePicker().datePickerBorder(
                                                  context,
                                                  label: "Waktu",
                                                  textController:
                                                      txtWaktuSiangController,
                                                  fungsiCallback:
                                                      callBackTimeWaktuSiang))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          CheckBox().checkBox(
                                              lebars: 100,
                                              checkBoxLabel: "Malam",
                                              boolValue: cboMalam,
                                              cbOnChage: cbOnChangeMalam,
                                              isUpDown: true),
                                          Expanded(
                                              child: TimePicker().datePickerBorder(
                                                  context,
                                                  label: "Waktu",
                                                  textController:
                                                      txtWaktuMalamController,
                                                  fungsiCallback:
                                                      callBackTimeWaktuMalam))
                                        ],
                                      ),
                                    ]);
                                return wgs;
                              }

                              callBackHarian(value) {
                                if (vExpandableMenu != "harian") {
                                  setState(() {
                                    vExpandableMenu = "harian";
                                    isDisplayHarian = value;
                                    isDisplaySholat = !value;
                                    isDisplayRamadhan = !value;
                                    isDisplayBatasWaktu = !value;
                                    isDisplayTanggal = !value;
                                  });
                                }
                              }

                              isiWidgetHarian() {
                                Widget wgs = Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.only(top: 15),
                                          child: Row(
                                            children: [
                                              CheckBox().checkBox(
                                                  lebars: 100,
                                                  checkBoxLabel: "Senin",
                                                  boolValue: cboSenin,
                                                  cbOnChage: cbOnChangeSenin,
                                                  isUpDown: true),
                                              Expanded(
                                                  child: TimePicker().datePickerBorder(
                                                      context,
                                                      label: "Waktu",
                                                      textController:
                                                          txtWaktuSeninController,
                                                      fungsiCallback:
                                                          callBackTimeHarianSenin))
                                            ],
                                          )),
                                      Row(
                                        children: [
                                          CheckBox().checkBox(
                                              lebars: 100,
                                              checkBoxLabel: "Selasa",
                                              boolValue: cboSelasa,
                                              cbOnChage: cbOnChangeSelasa,
                                              isUpDown: true),
                                          Expanded(
                                              child: TimePicker().datePickerBorder(
                                                  context,
                                                  label: "Waktu",
                                                  textController:
                                                      txtWaktuSelasaController,
                                                  fungsiCallback:
                                                      callBackTimeHarianSelasa))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          CheckBox().checkBox(
                                              lebars: 100,
                                              checkBoxLabel: "Rabu",
                                              boolValue: cboRabu,
                                              cbOnChage: cbOnChangeRabu,
                                              isUpDown: true),
                                          Expanded(
                                              child: TimePicker().datePickerBorder(
                                                  context,
                                                  label: "Waktu",
                                                  textController:
                                                      txtWaktuRabuController,
                                                  fungsiCallback:
                                                      callBackTimeHarianRabu))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          CheckBox().checkBox(
                                              lebars: 100,
                                              checkBoxLabel: "Kamis",
                                              boolValue: cboKamis,
                                              cbOnChage: cbOnChangeKamis,
                                              isUpDown: true),
                                          Expanded(
                                              child: TimePicker().datePickerBorder(
                                                  context,
                                                  label: "Waktu",
                                                  textController:
                                                      txtWaktuKamisController,
                                                  fungsiCallback:
                                                      callBackTimeHarianKamis))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          CheckBox().checkBox(
                                              lebars: 100,
                                              checkBoxLabel: "Jumat",
                                              boolValue: cboJumat,
                                              cbOnChage: cbOnChangeJumat,
                                              isUpDown: true),
                                          Expanded(
                                              child: TimePicker().datePickerBorder(
                                                  context,
                                                  label: "Waktu",
                                                  textController:
                                                      txtWaktuJumatController,
                                                  fungsiCallback:
                                                      callBackTimeHarianJumat))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          CheckBox().checkBox(
                                              lebars: 100,
                                              checkBoxLabel: "Sabtu",
                                              boolValue: cboSabtu,
                                              cbOnChage: cbOnChangeSabtu,
                                              isUpDown: true),
                                          Expanded(
                                              child: TimePicker().datePickerBorder(
                                                  context,
                                                  label: "Waktu",
                                                  textController:
                                                      txtWaktuSabtuController,
                                                  fungsiCallback:
                                                      callBackTimeHarianSabtu))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          CheckBox().checkBox(
                                              lebars: 100,
                                              checkBoxLabel: "Ahad",
                                              boolValue: cboMinggu,
                                              cbOnChage: cbOnChangeMinggu,
                                              isUpDown: true),
                                          Expanded(
                                              child: TimePicker().datePickerBorder(
                                                  context,
                                                  label: "Waktu",
                                                  textController:
                                                      txtWaktuMingguController,
                                                  fungsiCallback:
                                                      callBackTimeHarianMinggu))
                                        ],
                                      ),
                                    ]);
                                return wgs;
                              }

                              Widget wg = Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ExpandableMenu().expandableMenu(
                                        isDisplay: isDisplaySholat,
                                        title: "Sholat 5 Waktu",
                                        isiWidget: isiWidgetSholat,
                                        callBack: callBackSholat,
                                        lebar:
                                            MediaQuery.of(context).size.width),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    ExpandableMenu().expandableMenu(
                                        isDisplay: isDisplayBatasWaktu,
                                        title: "Batas Waktu",
                                        isiWidget: isiWidgetBatasWaktu,
                                        callBack: callBackBatasWaktu,
                                        lebar:
                                            MediaQuery.of(context).size.width),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    ExpandableMenu().expandableMenu(
                                        isDisplay: isDisplayHarian,
                                        title: "Harian",
                                        isiWidget: isiWidgetHarian,
                                        callBack: callBackHarian,
                                        lebar:
                                            MediaQuery.of(context).size.width),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    ExpandableMenu().expandableMenu(
                                        isDisplay: isDisplayTanggal,
                                        title: "Tanggal",
                                        isiWidget: isiWidgetTanggal,
                                        callBack: callBackTanggal,
                                        lebar:
                                            MediaQuery.of(context).size.width),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    ExpandableMenu().expandableMenu(
                                        isDisplay: isDisplayRamadhan,
                                        title: "Bulan Ramadhan",
                                        isiWidget: isiWidgetRamadhan,
                                        callBack: callBackRamadhan,
                                        lebar:
                                            MediaQuery.of(context).size.width),
                                  ]);
                              return wg;
                            }

                            final vData = await ApiUtilities()
                                .getGlobalParamNoLimit(
                                    namaApi: "userreminder",
                                    where: {
                                  "doa_id": data,
                                  "user_id": Prefs.getInt("userId")
                                }); //
                            if (vData["kode"] == 200) {
                              if (vData["data"]["data"].length > 0) {
                                ShowDialog().showDialogs(
                                    data: {
                                      "id": data,
                                      "data": vData["data"]["data"]
                                    },
                                    contek: context,
                                    isiwidget: showDialogWidget,
                                    judul: "Setting Doa",
                                    onPressed: onPressedDialog,
                                    isExpanded: true,
                                    labelButton: "Submit");
                              } else {
                                ShowDialog().showDialogs(
                                    data: {"id": data, "data": []},
                                    contek: context,
                                    isiwidget: showDialogWidget,
                                    judul: "Setting Doa",
                                    onPressed: onPressedDialog,
                                    isExpanded: true,
                                    labelButton: "Submit");
                              }
                            } else {
                              ShowDialog().showDialogs(
                                  data: {"id": data, "data": []},
                                  contek: context,
                                  isiwidget: showDialogWidget,
                                  judul: "Setting Doa",
                                  onPressed: onPressedDialog,
                                  isExpanded: true,
                                  labelButton: "Submit");
                            }
                          },
                        ))
                  ],
                  centerTitle: true,
                  bottom: PreferredSize(
                      child: Column(children: [
                        Container(
                          color: Colors.orange[700],
                          height: 4.0,
                        )
                      ]),
                      preferredSize: Size.fromHeight(4.0)),
                ),
                body: StatefulBuilder(builder: (context, setState) {
                  return FutureBuilder(
                      future: getData(isEdit, data),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          if (isFirst) {
                            if (isEdit) {
                              txtArabController.text = snapshot.data["arab"];
                              txtNameController.text = snapshot.data["name"];
                              txtTypeNameController.text =
                                  snapshot.data["type_name"];
                              txtTypeIdController.text =
                                  snapshot.data["type_id"];
                              txtLatinController.text = snapshot.data["latin"];
                              txtArtiController.text = snapshot.data["arti"];
                              isFavorit =
                                  int.parse(snapshot.data["isfavorit"]) == 1
                                      ? false
                                      : true;
                              isActive =
                                  int.parse(snapshot.data["is_active"]) == 1
                                      ? 0
                                      : 1;
                              isFavoritEdit =
                                  int.parse(snapshot.data["isedit"]) == 3
                                      ? false
                                      : true;
                              favoritId =
                                  int.parse(snapshot.data["favorit_id"]);
                            } else {
                              txtArabController.text = "";
                              txtNameController.text = "";
                              txtTypeIdController.text = "";

                              txtTypeNameController.text = "";
                              txtLatinController.text = "";

                              isActive = 0;
                              txtArtiController.text = "";
                            }
                            isFirst = false;
                          }
                          return Center(
                              child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(bottom: 50),
                                  child: Image.asset(
                                    'assets/images/tameng2.png',
                                    color: Colors.white.withOpacity(0.5),
                                    colorBlendMode: BlendMode.modulate,
                                    width:
                                        MediaQuery.of(context).size.width - 100,
                                  )),
                              Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Image.asset(
                                    'assets/images/border-bawah-hijau.png',
                                    color: Colors.white.withOpacity(0.3),
                                    colorBlendMode: BlendMode.modulate,
                                    width: MediaQuery.of(context).size.width,
                                  )),
                              Container(
                                width: MediaQuery.of(context).size.width - 10,
                                height: MediaQuery.of(context).size.height - 10,
                                padding:
                                    const EdgeInsets.fromLTRB(10, 20, 10, 10),
                                color: Colors.transparent,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Label().labelStatus(
                                              label: txtTypeNameController.text,
                                              width: 100.0,
                                              warna: Colors.green,
                                              warnaBorder: Colors.green[700]),
                                          // Text(txtNameController.text,
                                          //     style: TextStyle(
                                          //         fontSize: 16,
                                          //         fontWeight: FontWeight.bold)),
                                          Expanded(
                                            child: Container(),
                                          ),
                                          Text(
                                            "Favorit",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          CheckBox().switchPanel(
                                              activeColor: Colors.green,
                                              activeTrackColor: Colors.green,
                                              isSwitched: isFavorit,
                                              callbackSwitch: change_isactive),
                                          //Label().labelStatus(label:txtTypeNameController.text,width: 100.0, warna: Colors.green, warnaBorder: Colors.green[700])
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            txtNameController.text,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.deepPurple),
                                          )),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        txtArabController.text,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Latin",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(txtLatinController.text,
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic)),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Artinya",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        txtArtiController.text,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ));
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

                            var dataSave;
                            dataSave = isEdit
                                ? <dynamic, dynamic>{
                                    "arab": txtArabController.text,
                                    "name": txtNameController.text,
                                    "arti": txtArtiController.text,
                                    "latin": txtLatinController.text,
                                    "type_id": txtTypeIdController.text,
                                    "is_active": isActive == 0 ? 1 : 0,
                                    "dt_updated": Fungsi().fmtDateTimeYearNow()
                                  }
                                : <dynamic, dynamic>{
                                    "arab": txtArabController.text,
                                    "name": txtNameController.text,
                                    "arti": txtArtiController.text,
                                    "type_id": txtTypeIdController.text,
                                    "latin": txtLatinController.text,
                                    "is_active": isActive == 0 ? 1 : 0
                                  };
                            var where = isEdit
                                ? <dynamic, dynamic>{
                                    "id": int.parse(data.toString())
                                  }
                                : null;
                            print("prefix:" + txtTypeIdController.text);
                            ApiUtilities().saveUpdateData(
                                context: context,
                                data: dataSave,
                                namaAPI: "masterdoa",
                                isEdit: isEdit,
                                where: where,
                                setState: setState,
                                prefix: txtTypeIdController.text);
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
