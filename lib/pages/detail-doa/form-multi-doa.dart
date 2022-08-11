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

class MultiDoaDialog {
  GlobalKey<FormState>? _key;
  bool autoValidate = false;
  int id = 0;
  List isFavorit = [];
  List isFavoritEdit = [];
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
  final txtWaktuSahurController = TextEditingController();
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
  String vExpandableMenu = "sholat";
  /* dbcombobox */
  List<dynamic>? listSatuan;
  dynamic satuan;

  /* checkbox */
  bool cboSholat = false;
  bool cboBuka = false;
  bool cboSahur = false;
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
  List<dynamic>? newData;

  Future<dynamic> getData(isEdit, topic) async {
    // if(firstLoad){
    //             final data = await ApiUtilities().getGlobalParamNoLimit(namaApi: "satuan", where: {"active" : 1, "deleted" : 0, "bank_id": Prefs.getInt("bank_id")});
    //             listSatuan=data["data"]["data"];

    //              firstLoad = false;
    // }
    if (isEdit) {
      var vData;
      if (topic == "Sholat") {
        vData = await ApiUtilities().getGlobalParamNoLimit(
            namaApi: "usersholat", where: {"user_id": Prefs.getInt('userId')});
      } else if (topic == "Imsak") {
        vData = await ApiUtilities().getGlobalParamNoLimit(
            namaApi: "usersimsak", where: {"user_id": Prefs.getInt('userId')});
      } else if (topic.toString().contains("Time")) {
        String date = topic.toString().substring(5, 15);
        String time = topic.toString().substring(16);
        vData = await ApiUtilities().getGlobalParamNoLimit(
            namaApi: "usertime",
            where: {
              "user_id": Prefs.getInt('userId'),
              "date": date,
              "time": time
            });
      }
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

  Widget buildAddDialog(BuildContext context, sourceForm, bool isEdit,
      bool isView, String topic) {
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
                      future: getData(isEdit, topic),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          newData = snapshot.data;
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
                                      width: MediaQuery.of(context).size.width -
                                          100,
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
                                  height:
                                      MediaQuery.of(context).size.height - 10,
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 20, 10, 10),
                                  color: Colors.transparent,
                                  child: ListView.builder(
                                      itemCount:
                                          newData == null ? 0 : newData!.length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        isFavorit.add(
                                            newData?[index]['isfavorit'] == "1"
                                                ? false
                                                : true);
                                        isFavoritEdit.add(
                                            newData?[index]['isedit'] == "3"
                                                ? false
                                                : true);
                                        change_isactive(val) async {
                                          SweetAlert.show(context,
                                              subtitle: "please_wait",
                                              style: SweetAlertStyle.loading);
                                          var dataSave;
                                          dataSave = isFavoritEdit[index]
                                              ? <dynamic, dynamic>{
                                                  "isfavorit": val ? 0 : 1
                                                }
                                              : <dynamic, dynamic>{
                                                  "isfavorit": val ? 0 : 1,
                                                  "user_id":
                                                      Prefs.getInt("userId"),
                                                  "doa_id": newData?[index]
                                                      ['doa_id']
                                                };
                                          var where = isFavoritEdit[index]
                                              ? <dynamic, dynamic>{
                                                  "doa_id": newData?[index]
                                                      ['doa_id'],
                                                  "user_id":
                                                      Prefs.getInt("userId")
                                                }
                                              : null;
                                          ApiUtilities().saveUpdateData(
                                              context: context,
                                              data: dataSave,
                                              namaAPI: "doafavorit",
                                              isEdit: isFavoritEdit[index],
                                              isSingleDelete: true,
                                              caption: !val
                                                  ? "Doa telah didaftarkan ke favorit"
                                                  : "Doa telah dilepaskan dari favorit",
                                              where: where);
                                          setState(() {
                                            isFavoritEdit[index] = true;
                                            isFavorit[index] = val;
                                          });
                                        } /* end call back */

                                        return Column(
                                          children: <Widget>[
                                            Row(
                                              children: [
                                                Label().labelStatus(
                                                    label: newData?[index]
                                                        ['type_name'],
                                                    width: 100.0,
                                                    warna: Colors.green,
                                                    warnaBorder:
                                                        Colors.green[700]),
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
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                new CheckBox().switchPanel(
                                                    activeColor: Colors.green,
                                                    activeTrackColor:
                                                        Colors.green,
                                                    isSwitched:
                                                        isFavorit[index],
                                                    callbackSwitch:
                                                        change_isactive),
                                                //Label().labelStatus(label:txtTypeNameController.text,width: 100.0, warna: Colors.green, warnaBorder: Colors.green[700])
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  newData?[index]['doa_name'],
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.deepPurple),
                                                )),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              newData?[index]['arab'],
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
                                            Text(newData?[index]['latin'],
                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FontStyle.italic)),
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
                                              newData?[index]['arti'],
                                              textAlign: TextAlign.justify,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            if (index != newData!.length - 1)
                                              Divider(
                                                  color: Colors.orange[700]),
                                          ],
                                        );
                                      }),
                                ),
                              ],
                            ),
                          );
                          // return GestureDetector(
                          //   child: ListView.builder(
                          //       itemCount:
                          //           newData == null ? 0 : newData!.length,
                          //       scrollDirection: Axis.vertical,
                          //       itemBuilder: (BuildContext context, int index) {
                          //         return Center(
                          //             child: Stack(
                          //           alignment: Alignment.center,
                          //           children: [
                          //             Padding(
                          //                 padding: EdgeInsets.only(bottom: 50),
                          //                 child: Image.asset(
                          //                   'assets/images/tameng2.png',
                          //                   color:
                          //                       Colors.white.withOpacity(0.5),
                          //                   colorBlendMode: BlendMode.modulate,
                          //                   width: MediaQuery.of(context)
                          //                           .size
                          //                           .width -
                          //                       100,
                          //                 )),
                          //             Align(
                          //                 alignment: Alignment.bottomCenter,
                          //                 child: Image.asset(
                          //                   'assets/images/border-bawah-hijau.png',
                          //                   color:
                          //                       Colors.white.withOpacity(0.3),
                          //                   colorBlendMode: BlendMode.modulate,
                          //                   width: MediaQuery.of(context)
                          //                       .size
                          //                       .width,
                          //                 )),
                          //             Container(
                          //               width:
                          //                   MediaQuery.of(context).size.width -
                          //                       10,
                          //               height:
                          //                   MediaQuery.of(context).size.height -
                          //                       10,
                          //               padding: const EdgeInsets.fromLTRB(
                          //                   10, 20, 10, 10),
                          //               color: Colors.transparent,
                          //               // child: SingleChildScrollView(
                          //               child: Column(
                          //                 children: <Widget>[
                          //                   Row(
                          //                     children: [
                          //                       Label().labelStatus(
                          //                           label: newData?[index]
                          //                               ['type_name'],
                          //                           width: 100.0,
                          //                           warna: Colors.green,
                          //                           warnaBorder:
                          //                               Colors.green[700]),
                          //                       // Text(txtNameController.text,
                          //                       //     style: TextStyle(
                          //                       //         fontSize: 16,
                          //                       //         fontWeight: FontWeight.bold)),
                          //                       Expanded(
                          //                         child: Container(),
                          //                       ),
                          //                       Text(
                          //                         "Favorit",
                          //                         style: TextStyle(
                          //                             fontWeight:
                          //                                 FontWeight.bold),
                          //                       ),
                          //                       CheckBox().switchPanel(
                          //                           activeColor: Colors.green,
                          //                           activeTrackColor:
                          //                               Colors.green,
                          //                           isSwitched: isFavorit,
                          //                           callbackSwitch:
                          //                               change_isactive),
                          //                       //Label().labelStatus(label:txtTypeNameController.text,width: 100.0, warna: Colors.green, warnaBorder: Colors.green[700])
                          //                     ],
                          //                   ),
                          //                   SizedBox(
                          //                     height: 20,
                          //                   ),
                          //                   Align(
                          //                       alignment: Alignment.center,
                          //                       child: Text(
                          //                         newData?[index]['doa_name'],
                          //                         textAlign: TextAlign.center,
                          //                         style: TextStyle(
                          //                             fontSize: 16,
                          //                             fontWeight:
                          //                                 FontWeight.bold,
                          //                             color: Colors.deepPurple),
                          //                       )),
                          //                   SizedBox(
                          //                     height: 20,
                          //                   ),
                          //                   Text(
                          //                     newData?[index]['arab'],
                          //                     textAlign: TextAlign.right,
                          //                     style: TextStyle(
                          //                         fontSize: 25,
                          //                         fontWeight: FontWeight.bold),
                          //                   ),
                          //                   SizedBox(
                          //                     height: 20,
                          //                   ),
                          //                   Text(
                          //                     "Latin",
                          //                     style: TextStyle(
                          //                         fontWeight: FontWeight.bold),
                          //                     textAlign: TextAlign.left,
                          //                   ),
                          //                   SizedBox(
                          //                     height: 5,
                          //                   ),
                          //                   Text(newData?[index]['latin'],
                          //                       textAlign: TextAlign.justify,
                          //                       style: TextStyle(
                          //                           fontWeight: FontWeight.bold,
                          //                           fontStyle:
                          //                               FontStyle.italic)),
                          //                   SizedBox(
                          //                     height: 20,
                          //                   ),
                          //                   Text(
                          //                     "Artinya",
                          //                     style: TextStyle(
                          //                       fontWeight: FontWeight.bold,
                          //                     ),
                          //                     textAlign: TextAlign.left,
                          //                   ),
                          //                   SizedBox(
                          //                     height: 5,
                          //                   ),
                          //                   Text(
                          //                     newData?[index]['arti'],
                          //                     textAlign: TextAlign.justify,
                          //                   ),
                          //                 ],
                          //               ),
                          //               // ),
                          //             ),
                          //           ],
                          //         ));
                          //       }),
                          // );
                          // return Expanded(
                          //     child: Center(
                          //       child: newData!.length > 0
                          //           ? GestureDetector(
                          //             child: ListView.builder(
                          //               itemCount: newData == null ? 0 : newData!.length,
                          //               scrollDirection: Axis.vertical,
                          //               itemBuilder: (BuildContext context, int index) {
                          //                 return Center(
                          //                   child: Stack(
                          //                     alignment: Alignment.center,
                          //                     children: [
                          //                       Padding(
                          //                           padding: EdgeInsets.only(bottom: 50),
                          //                           child: Image.asset(
                          //                             'assets/images/tameng2.png',
                          //                             color: Colors.white.withOpacity(0.5),
                          //                             colorBlendMode: BlendMode.modulate,
                          //                             width:
                          //                                 MediaQuery.of(context).size.width - 100,
                          //                           )),
                          //                       Align(
                          //                           alignment: Alignment.bottomCenter,
                          //                           child: Image.asset(
                          //                             'assets/images/border-bawah-hijau.png',
                          //                             color: Colors.white.withOpacity(0.3),
                          //                             colorBlendMode: BlendMode.modulate,
                          //                             width: MediaQuery.of(context).size.width,
                          //                           )),
                          //                       Container(
                          //                         width: MediaQuery.of(context).size.width - 10,
                          //                         height: MediaQuery.of(context).size.height - 10,
                          //                         padding:
                          //                             const EdgeInsets.fromLTRB(10, 20, 10, 10),
                          //                         color: Colors.transparent,
                          //                         // child: SingleChildScrollView(
                          //                           child: Column(
                          //                             children: <Widget>[
                          //                               Row(
                          //                                 children: [
                          //                                   Label().labelStatus(
                          //                                       label: newData?[index]['type_name'],
                          //                                       width: 100.0,
                          //                                       warna: Colors.green,
                          //                                       warnaBorder: Colors.green[700]),
                          //                                   // Text(txtNameController.text,
                          //                                   //     style: TextStyle(
                          //                                   //         fontSize: 16,
                          //                                   //         fontWeight: FontWeight.bold)),
                          //                                   Expanded(
                          //                                     child: Container(),
                          //                                   ),
                          //                                   Text(
                          //                                     "Favorit",
                          //                                     style: TextStyle(
                          //                                         fontWeight: FontWeight.bold),
                          //                                   ),
                          //                                   CheckBox().switchPanel(
                          //                                       activeColor: Colors.green,
                          //                                       activeTrackColor: Colors.green,
                          //                                       isSwitched: isFavorit,
                          //                                       callbackSwitch: change_isactive),
                          //                                   //Label().labelStatus(label:txtTypeNameController.text,width: 100.0, warna: Colors.green, warnaBorder: Colors.green[700])
                          //                                 ],
                          //                               ),
                          //                               SizedBox(
                          //                                 height: 20,
                          //                               ),
                          //                               Align(
                          //                                   alignment: Alignment.center,
                          //                                   child: Text(
                          //                                     txtNameController.text,
                          //                                     textAlign: TextAlign.center,
                          //                                     style: TextStyle(
                          //                                         fontSize: 16,
                          //                                         fontWeight: FontWeight.bold,
                          //                                         color: Colors.deepPurple),
                          //                                   )),
                          //                               SizedBox(
                          //                                 height: 20,
                          //                               ),
                          //                               Text(
                          //                                 newData?[index]['type_name'],
                          //                                 textAlign: TextAlign.right,
                          //                                 style: TextStyle(
                          //                                     fontSize: 25,
                          //                                     fontWeight: FontWeight.bold),
                          //                               ),
                          //                               SizedBox(
                          //                                 height: 20,
                          //                               ),
                          //                               Text(
                          //                                 "Latin",
                          //                                 style: TextStyle(
                          //                                     fontWeight: FontWeight.bold),
                          //                                 textAlign: TextAlign.left,
                          //                               ),
                          //                               SizedBox(
                          //                                 height: 5,
                          //                               ),
                          //                               Text(newData?[index]['latin'],
                          //                                   textAlign: TextAlign.justify,
                          //                                   style: TextStyle(
                          //                                       fontWeight: FontWeight.bold,
                          //                                       fontStyle: FontStyle.italic)),
                          //                               SizedBox(
                          //                                 height: 20,
                          //                               ),
                          //                               Text(
                          //                                 "Artinya",
                          //                                 style: TextStyle(
                          //                                   fontWeight: FontWeight.bold,
                          //                                 ),
                          //                                 textAlign: TextAlign.left,
                          //                               ),
                          //                               SizedBox(
                          //                                 height: 5,
                          //                               ),
                          //                               Text(
                          //                                 newData?[index]['arti'],
                          //                                 textAlign: TextAlign.justify,
                          //                               ),
                          //                             ],
                          //                           ),
                          //                         // ),
                          //                       ),
                          //                     ],
                          //                   )
                          //                 );
                          //               }
                          //             )
                          //           )
                          //           : Column(
                          //               mainAxisAlignment: MainAxisAlignment.center,
                          //               children: [
                          //                   Container(
                          //                       height: 100,
                          //                       width: 100,
                          //                       padding: EdgeInsets.all(5),
                          //                       child: Image.asset(
                          //                         'assets/images/widget-icons/empty-folder.png',
                          //                       )),
                          //                   Text("Data is Empty")
                          //                 ]),
                          // ));
                          // if (isEdit) {
                          //   txtArabController.text = snapshot.data["arab"];
                          //   txtNameController.text = snapshot.data["name"];
                          //   txtTypeNameController.text =
                          //       snapshot.data["type_name"];
                          //   txtTypeIdController.text = snapshot.data["type_id"];
                          //   txtLatinController.text = snapshot.data["latin"];
                          //   txtArtiController.text = snapshot.data["arti"];
                          //   isFavorit =
                          //       int.parse(snapshot.data["isfavorit"]) == 1
                          //           ? false
                          //           : true;
                          //   isActive =
                          //       int.parse(snapshot.data["is_active"]) == 1
                          //           ? 0
                          //           : 1;
                          //   isFavoritEdit =
                          //       int.parse(snapshot.data["isedit"]) == 3
                          //           ? false
                          //           : true;
                          //   favoritId = int.parse(snapshot.data["favorit_id"]);
                          // } else {
                          //   txtArabController.text = "";
                          //   txtNameController.text = "";
                          //   txtTypeIdController.text = "";

                          //   txtTypeNameController.text = "";
                          //   txtLatinController.text = "";

                          //   isActive = 0;
                          //   txtArtiController.text = "";
                          // }

                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      });
                })));
      });
    }
  }
}
