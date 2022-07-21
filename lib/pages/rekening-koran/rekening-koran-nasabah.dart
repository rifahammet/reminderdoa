// ignore_for_file: prefer_if_null_operators

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:doa/pages/approval-penarikan-dana/form-approval-penarikan-dana.dart';
import 'package:doa/pages/listups/listup-user.dart';
import 'package:doa/services/pdf_service.dart';
import 'package:doa/utils/api-utility.dart';
import 'package:doa/utils/api.dart';
import 'package:doa/utils/function.dart';
import 'package:doa/utils/pref_manager.dart';
import 'package:doa/widgets/bottomDbNavigation.dart';
import 'package:doa/widgets/button.dart';
import 'package:doa/widgets/datatable.dart';
import 'package:doa/widgets/datepicker.dart';
import 'package:doa/widgets/listup.dart';
import 'package:sweetalert/sweetalert.dart';

class RekeningKoranNasabahPage extends StatefulWidget {
  final bool? isViewOnly;
  const RekeningKoranNasabahPage({Key? key, this.isViewOnly}) : super(key: key);
  @override
  _RekeningKoranNasabahPageState createState() =>
      _RekeningKoranNasabahPageState();
}

class _RekeningKoranNasabahPageState extends State<RekeningKoranNasabahPage> {
  // ManageUserService kebunService = new ManageUserService();
  List<dynamic>? newData =[];
  var bottomNavigationBarIndex = 0;
  int iPos = 1;
  int iPosMax = 0;
  int userProfileId =0;
  bool isKlik = false;
  bool isMatikan = false;
  bool isReset = true;
  bool diKlik = false;
  bool isDisplay = true;
  var _typeItems = <String>['3', '5', '10', '15', '25'];
  var _selectedType = '5';
  List<DropdownMenuItem<String>>? _dropDownType;
  final txtFilter = TextEditingController();
  final txtNamaAnggotaController = TextEditingController();
  final txtNamaAnggotaFocusNode = FocusNode();
  var saldoAkhir = 0.0;

  String? tanggalAwal;
  String? tanggalAkhir;

  final txtAwal = TextEditingController();
  final txtAkhir = TextEditingController();

  displayTanggalAwal(formatDate, formatYear) {
    setState(() {
      tanggalAwal = formatYear.toString();
      txtAwal.text = formatDate.toString();
    });
  }

  displayTanggalAkhir(formatDate, formatYear) {
    setState(() {
      tanggalAkhir = formatYear.toString();
      txtAkhir.text = formatDate.toString();
    });
  }

  fungsiCallbackButton() {
    setState(() {
       saldoAkhir=0;
  isReset=true;
getData(isCount: true, isFirst: true);
    });
  }

  _initDropDowns() {
    _dropDownType = _typeItems
        .map((String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ))
        .toList();
  }

  editData(BuildContext context, dynamic data, bool isEdit, bool isView) async {
    FocusScope.of(context).requestFocus(FocusNode());
    final x = await showDialog(
      context: context,
      builder: (BuildContext context) => ApprovalPenarikanDanaDialog()
          .buildAddDialog(context, this, data, isEdit, isView),
    );
    if (x != null && x) {
      print('setstate');
      setState(() {});
    }
  }

  Future getData(
      {bool isPemilik = true,
      int idkolam = 0,
      bool isCount = false,
      ket = '',
      bool isFirst = false}) async {
    //  int ownerId = Prefs.getInt('ownerId');
    if (!isFirst) {
      return newData;
    }

    ApiUtilities auth = ApiUtilities();

    var dataSave;
    dataSave = [
      {
        "rekeningkorannasabahrupiah": {
          "param": {
            "user_profile_id": Prefs.getString("user_type").toLowerCase()!= "anggota"? userProfileId : Prefs.getInt("userId")  ,
            "tanggal_awal": tanggalAwal,
            "tanggal_akhir": tanggalAkhir
          },
          "output": "procedure"
        }
      }
    ];
    final vDatas = await ApiUtilities().getDataBatch(dataSave);

    // final dataPropinsi = auth.getGlobalParam(
    //     namaApi: "rekeningkorannasabahrupiah",
    //     where: {
    //       "sisa>": 0,
    //     },
    //     like: txtFilter.text.toString().trim() != ""
    //         ? {
    //             "bank_id": Prefs.getInt("bank_id"),
    //             "concat_field": txtFilter.text
    //           }
    //         : {"bank_id": Prefs.getInt("bank_id")},
    //     startFrom: (iPos - 1) * int.parse(_selectedType.toString()),
    //     limit: _selectedType);
    if(vDatas["data"]["data"][0]["rekeningkorannasabahrupiah"].length > 0){
    vDatas["data"]["data"][0]["rekeningkorannasabahrupiah"].add({
      "id": "",
      "nama_lengkap": "Saldo Akhir",
      "bank_id": "",
      "ket": "Saldo Akhir",
      "urut": "",
      "tgl": "",
      "debit": "",
      "credit": "",
      "total": ""
    });
    }
    setState(() {
      newData= vDatas["data"]["data"][0]["rekeningkorannasabahrupiah"];
    });
    return vDatas["data"]["data"][0]["rekeningkorannasabahrupiah"];
  }

  refresh() async {
    setState(() {
      isKlik = !isKlik;
    });
  }

  callBackComboBox(value) {
    setState(() {
      iPos = 1;
      _selectedType = value;
    });
  }

  callBackButtonSearch() async {
    iPos = 1;
    final x = await getData(isCount: true, ket: 'callBackButtonSearch');
    setState(() {
      newData = x;
    });
  }

  callBackView(index) async {}

  callBackEdit(index) async {}

  callBackDelete(index) async {}

  callBackButton(data) async {
    SweetAlert.show(context,
        subtitle: "please_wait", style: SweetAlertStyle.loading);
    var dataSave = [
      {
        "storesampahheader": {
          "action": "update",
          "data": [
            {"posted_nasabah": 1}
          ],
          "where": {
            "posted_nasabah": 0,
            "approved": 1,
            "bank_id": Prefs.getInt("bank_id")
          }
        }
      },
      {
        "penarikandananew": {
          "action": "update",
          "data": [
            {"posted_nasabah": 1}
          ],
          "where": {
            "bayar": 1,
            "posted_nasabah": 0,
            "user_profile_id": data["id"]
          }
        }
      },
      {
        "saldoawalnasabah": {
          "action": "new",
          "data": [
            {"total_rupiah": data["sisa"], "user_profile_id": data["id"]}
          ]
        }
      }
    ];
    void callBack() {
      SweetAlert.show(
        context,
        subtitle: "Data has been Approved",
        style: SweetAlertStyle.loadingSuccess,
      );
      // ignore: prefer_const_constructors
      Future.delayed(new Duration(seconds: 3), () {
        setState(() {});
        Navigator.pop(context);
      });
    }

    ApiUtilities().saveUpdateBatchData(
        context: context,
        data: dataSave,
        isEdit: true,
        setState: setState,
        isCustom: true,
        callBack: callBack);
  }

  callBackIsiWidget(index) {
    if(isReset){
    if (newData?[index]['nama_lengkap'] != "Saldo Akhir") {
      if (newData?[index]['ket'] == "Saldo Awal" ||
          newData?[index]['ket'] == "Store Sampah") {
            // setState(() {
              saldoAkhir = saldoAkhir + double.parse(newData?[index]['total']);
            // });
        
      } else {
        // setState(() {
          saldoAkhir = saldoAkhir - double.parse(newData?[index]['total']);
        // });
        
      }
    }
    else{
      isReset= false;
    }
    }

    Widget wg = Container(
      padding: EdgeInsets.only(top: index == 0 ? 10 : 0),
      child: newData?[index]["nama_lengkap"] != "Saldo Akhir"
          ? Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: <Widget>[
                  SizedBox(
                      width: 90,
                      child: Text(
                        newData?[index]['tgl'] == null?  "01-01-2022" :Fungsi().fmtDateDay(newData?[index]['tgl']),
                        
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 12),
                      )),
                  Container(
                      alignment: Alignment.centerRight,
                      width: 90,
                      child: Text(
                        Fungsi().format(double.parse(newData?[index]['debit']),
                            isInteger: false, isMataUang: false),
                        style: TextStyle(color: Colors.grey[700], fontSize: 12),
                      )),
                  Container(
                      alignment: Alignment.centerRight,
                      width: 90,
                      child: Text(
                        Fungsi().format(double.parse(newData?[index]['credit']),
                            isInteger: false, isMataUang: false),
                        style: TextStyle(color: Colors.grey[700], fontSize: 12),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Text(
                    newData?[index]['ket'],
                    style: TextStyle(color: Colors.grey[700], fontSize: 12),
                  )),
                ],
              ))
          : Padding(
              padding: EdgeInsets.only(left: 10, right: 15),
              child: Row(children: [
SizedBox(
                      width: 90,
                      child: Text(
"",
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 12),
                      )),
                  Container(
                      alignment: Alignment.centerRight,
                      width: 90,
                      child: Text(
                        saldoAkhir> 0? Fungsi().format(saldoAkhir,
                                isInteger: false, isMataUang: false) : ".00",
                        style: TextStyle(color: Colors.grey[700], fontSize: 12),
                      )),
                  Container(
                      alignment: Alignment.centerRight,
                      width: 90,
                      child: Text(
                        saldoAkhir<0? Fungsi().format(saldoAkhir *-1,
                                isInteger: false, isMataUang: false): ".00",
                        style: TextStyle(color: Colors.grey[700], fontSize: 12),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Text(
                    "Saldo Akhir",
                    style: TextStyle(color: Colors.grey[700], fontSize: 12),
                  )),
              ])),
    );

    return wg;
  }

  callBack(int index) async {
    SweetAlert.show(context,
        subtitle: "Please Wait", style: SweetAlertStyle.loading);
    setState(() {
      diKlik = true;
      this.bottomNavigationBarIndex = index;

      Fungsi formating = new Fungsi();
      iPos = formating.getPos(index, iPos, iPosMax);
      print("current page=" +
          iPos.toString() +
          " page maximum=" +
          iPosMax.toString());
    });
    final tList = await getData(isCount: false, ket: 'callBack');
    setState(() {
      newData = tList;
      diKlik = false;
      Navigator.of(context).pop();
    });
    //
  }

        listUP(label, BuildContext context) async {
          final res = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListUpUserDialog(),
            ),
          );
          if (res != null) {
            setState(() {
              txtNamaAnggotaController.text = res["nama_lengkap"];
              userProfileId = int.parse(res["id"]);
            });
          }
        }
        
  addWidget(){
   Widget wg =  Column(children: [
     SizedBox(height: 5,),
ListUp().listUpWithBorderValidate(
                                                context,
                                                label: "Nama Anggota",
                                                textController:
                                                    txtNamaAnggotaController,
                                                textFocusNote:
                                                    txtNamaAnggotaFocusNode,
                                                suffixIconOnPressed: listUP,
                                                padding: 0.0
                                          )
                                                 
   ],)
   
   ;
   return wg;
  }

  @override
  void initState() {
    super.initState();
    txtAwal.text = Fungsi().fmtDateDayNow();
    tanggalAwal = Fungsi().fmtDateTimeYearNow();
    txtAkhir.text = Fungsi().fmtDateDayNow();
    tanggalAkhir = Fungsi().fmtDateTimeYearNow();
    _initDropDowns();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        
        appBar: AppBar(
          automaticallyImplyLeading: Prefs.getString("user_type").toString().toLowerCase() == "admin"? false : true,
        backgroundColor: Colors.green[700],
        title: const Text(
          "Nasabah",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          IconButton(
              //iconSize: 48,
              icon: Icon(Icons.picture_as_pdf),
              onPressed: () {
                var htmlContent = """
        <!DOCTYPE html>
        <html>
          <head>
            <style>
            table, th, td {
              border: 1px solid black;
              border-collapse: collapse;
            }
            th, td, p {
              padding: 5px;

            }
            </style>
          </head>
          <body>
            <h2>Report Rekening Koran Nasabah</h2>
             </br>
             <h3>Nama : ${txtNamaAnggotaController.text}</h3>
            <table style="width:100%">
              <caption></caption>
              <tr>
                <th align="center" >Tanggal</th>
                 <th align="center" >Debit</th>
                 <th align="center" >Credit</th>
                <th align="center" >Keterangan</th>
              </tr>
              """;


    for (var i = 0; i < newData!.length; i++) {
      htmlContent = htmlContent +
          """
                <tr>

                <td>${newData![i]["tgl"]==null || newData![i]["tgl"]== "" ? "" : Fungsi().fmtDateDay(newData![i]["tgl"])}</td>
                <td align="right">${ Fungsi().format(double.parse((newData![i]["ket"]=="Saldo Akhir"? (saldoAkhir > 0 ? saldoAkhir: 0) : newData![i]["debit"]).toString()), isInteger: false)}</td>
                <td align="right">${Fungsi().format(double.parse((newData![i]["ket"]=="Saldo Akhir"? (saldoAkhir < 0 ? (saldoAkhir * -1): 0) : newData![i]["credit"]).toString()), isInteger: false)}</td>
                <td align="right">${newData![i]["ket"]}</td>
              </tr>
                """;
    }
    htmlContent = htmlContent +
        """
            </table>
          </body>
        </html>
        """;
                setState(() {
                  
                  // PDFService().generatePdf(htmlContent: htmlContent, judulReport: "Rekening Koran", context: context, filename: "rekening_koran");
                });
              },
            ),
          IconButton(
              //iconSize: 48,
              icon: Icon(!isDisplay
                  ? Icons.remove_red_eye
                  : Icons.visibility_off_outlined),
              onPressed: () {
                setState(() {
                  isDisplay = !isDisplay;
                });
              },
            )],
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
        body: Container(
            color: Colors.grey[100],
            child: Column(
              children: <Widget>[
                Expanded(
                    child: 
                    // FutureBuilder(
                    //     future: getData(isCount: true, isFirst: true),
                    //     builder: (context, AsyncSnapshot snapshot) {
                    //       if (snapshot.hasError) print(snapshot.error);
                    //       if (snapshot.hasData) {
                    //         var jmlData = 6;
                    //         Fungsi fungsi = new Fungsi();
                    //         iPosMax = fungsi.getIposMax(_selectedType, jmlData);
   
                    //         newData = snapshot.data;
                    //         return 
                            
                            Column(
                              children: <Widget>[
                                Visibility(
                                  visible: isDisplay,
                                  child: 
                                DatePicker().rangeDatePickerBorder(
                                    context: context,
                                    inputBoxControllerAwal: txtAwal,
                                    inputBoxControllerAkhir: txtAkhir,
                                    fungsiCallbackAwal: displayTanggalAwal,
                                    fungsiCallbackAkhir: displayTanggalAkhir,
                                    fungsiCallbackButton: fungsiCallbackButton,
                                    formatDateAwal: tanggalAwal,
                                    formatDateAkhir: tanggalAkhir,
                                    buttonColor1: Colors.green,
                                    buttonColor2: Colors.green[700],
                                    backgroundColor: Colors.grey[300],
                                    addWidget: Prefs.getString("user_type").toLowerCase()!= "anggota"? addWidget() : null
                                    )),
                                // DataTablet().getSearchForm(context,
                                //     txtFilter: txtFilter,
                                //     returnComboBox: callBackComboBox,
                                //     // dropDownData: _dropDownType,
                                //     comboSelected: _selectedType,
                                //     returnButtonSearch: callBackButtonSearch),
                                Padding(
                                    padding: EdgeInsets.only(left: 5, right: 5),
                                    child: Container(
                                        padding:
                                            EdgeInsets.only(top: isDisplay? 5:10, bottom: 5),
                                        color: Colors.green,
                                        child: Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                                width: 90,
                                                child: Text(
                                                  "Tanggal",
                                                  style: TextStyle(

                                                      color: Colors.yellow,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                            Container(
                                              alignment: Alignment.center,
                                              width: 90,
                                              child: Text("Debit",
                                                  style: TextStyle(
                                                      color: Colors.yellow,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                            SizedBox(width: 10),
                                            Container(
                                              alignment: Alignment.center,
                                              width: 90,
                                              child: Text("Credit",
                                                  style: TextStyle(
                                                      color: Colors.yellow,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                            Expanded(
                                              child: 
                                              Container(
                                                alignment: Alignment.center,
                                                child: Text("Keterangan",
                                                  style: TextStyle(
                                                      color: Colors.yellow,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold))),
                                            ),
                                          ],
                                        ))),
                                DataTablet().getListData(
                                    context: context,
                                    newData: newData,
                                    callBackDelete: callBackDelete,
                                    callBackEdit: callBackEdit,
                                    callBackView: callBackView,
                                    isiWidget: callBackIsiWidget,
                                    isCustom: true,
                                    isEditOnly: true,
                                    filePNG:
                                        "assets/images/widget-icons/note.png",
                                    isKlik: isKlik,
                                    warna: Colors.green,
                                    isAktifGantiWarna: false,
                                    //fieldGantiWarna: "active",
                                    isNoDecoration: true,
                                    isAPI: true),
                              ],
                            )
                        //   }
                        //   return Center(
                        //     child: CircularProgressIndicator(),
                        //   );
                        // })
                        )
              ],
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: IgnorePointer(
            ignoring: true,
            ));
  }
}
