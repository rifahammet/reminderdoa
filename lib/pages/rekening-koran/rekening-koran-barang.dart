// ignore_for_file: prefer_if_null_operators

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:doa/pages/approval-penarikan-dana/form-approval-penarikan-dana.dart';
import 'package:doa/services/pdf_service.dart';
import 'package:doa/utils/api-utility.dart';
import 'package:doa/utils/api.dart';
import 'package:doa/utils/function.dart';
import 'package:doa/utils/pref_manager.dart';
import 'package:doa/widgets/bottomDbNavigation.dart';
import 'package:doa/widgets/button.dart';
import 'package:doa/widgets/datatable.dart';
import 'package:doa/widgets/datepicker.dart';
import 'package:doa/widgets/label.dart';
import 'package:sweetalert/sweetalert.dart';

class RekeningKoranBarangPage extends StatefulWidget {
  final bool? isViewOnly;
  const RekeningKoranBarangPage({Key? key, this.isViewOnly}) : super(key: key);
  @override
  _RekeningKoranBarangPageState createState() =>
      _RekeningKoranBarangPageState();
}

class _RekeningKoranBarangPageState extends State<RekeningKoranBarangPage> {
  // ManageUserService kebunService = new ManageUserService();
  List<dynamic>? newData = [];
  var bottomNavigationBarIndex = 0;
  int iPos = 1;
  int iPosMax = 0;
  bool isKlik = false;
  bool isMatikan = false;
  bool diKlik = false;
  bool isDisplay = true;
  var _typeItems = <String>['3', '5', '10', '15', '25'];
  var _selectedType = '5';
  List<DropdownMenuItem<String>>? _dropDownType;
  final txtFilter = TextEditingController();
  var saldoAkhir = 0.0;

  String? tanggalAwal;
  String? tanggalAkhir;
  String namaBarang = "";

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
      saldoAkhir = 0.0;
      namaBarang = "";
      getData(isCount: true, isFirst: true);
    });
  }

callBackView(index){}


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

    ApiUtilities auth = ApiUtilities();

    var dataSave;
    dataSave = [
      {
        "rekeningkoranbarang": {
          "param": {
            "bank_id": Prefs.getInt("bank_id"),
            "tanggal_awal": tanggalAwal,
            "tanggal_akhir": tanggalAkhir
          },
          "output": "procedure"
        }
      }
    ];
    final vDatas = await ApiUtilities().getDataBatch(dataSave);
    newData = vDatas["data"]["data"][0]["rekeningkoranbarang"];
   // return vDatas["data"]["data"][0]["rekeningkoranbarang"];
  }

  refresh() async {
    setState(() {
      isKlik = !isKlik;
    });
  }





  callBackIsiWidget(index) {
    var lastSaldo = 0.0;
    if (index == newData!.length - 1) {
      if (namaBarang != newData?[index]['barang_nama']) {
       // saldoAkhir = 0.0;
        lastSaldo = double.parse(newData?[index]['total']);
      } else {
        lastSaldo = saldoAkhir + (double.parse(newData?[index]['total'])*-1);
      }
    }

    // print(namaBarang + " = " + newData?[index]['barang_nama']);
    Widget wg = Container(
      padding: EdgeInsets.only(top: index == 0 ? 10 : 0),
      child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Column(children: [
            Visibility(
                visible: index == 0
                    ? false
                    : namaBarang != newData![index]['barang_nama']
                        ? true
                        : false,
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: 
                        Row(
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                width: 90,
                                child: Text(
                                  "",
                                  style: TextStyle(
                                      
                                      fontSize: 12),
                                )),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 90,
                              child: Text(Fungsi().format(saldoAkhir>0? (saldoAkhir):0.0, isInteger: false),
                                  style: TextStyle(
                                      
                                      fontSize: 12,)),
                            ),
                            
                            Container(
                              alignment: Alignment.centerRight,
                              width: 90,
                              child: Text(Fungsi().format(saldoAkhir<0? (saldoAkhir*-1):0.0, isInteger: false),
                                  style: TextStyle(
                                      
                                      fontSize: 12)),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Saldo Akhir",
                                      style: TextStyle(
                                          
                                          fontSize: 12))),
                            ),
                          ],
                        )                     
                        ),
                    Container(
                      color: Colors.red,
                      height: 2.0,
                    ),
                    SizedBox(
                      height: 7,
                    )
                  ],
                )),
            Visibility(
                visible: namaBarang == ""
                    ? true
                    : namaBarang != newData?[index]['barang_nama']
                        ? true
                        : false,
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Label().labelStatus(
                            label: newData?[index]['barang_nama'],
                            warna: Colors.orange,
                            width: 150.0,
                            isCircularRadius: false,
                            bottomLeft: 0.0,
                            bottomRight: 0.0)),
                    Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
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
                                      fontWeight: FontWeight.bold),
                                )),
                            Container(
                              alignment: Alignment.center,
                              width: 90,
                              child: Text("Debit",
                                  style: TextStyle(
                                      color: Colors.yellow,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(width: 10),
                            Container(
                              alignment: Alignment.center,
                              width: 90,
                              child: Text("Credit",
                                  style: TextStyle(
                                      color: Colors.yellow,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Expanded(
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Text("Keterangan",
                                      style: TextStyle(
                                          color: Colors.yellow,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold))),
                            ),
                          ],
                        )),
                    Container(
                      color: Colors.red,
                      height: 2.0,
                    ),
                    SizedBox(
                      height: 7,
                    )
                  ],
                )),
            Row(
              children: <Widget>[
                SizedBox(
                    width: 90,
                    child: Text(
                     Fungsi().fmtDateDay( newData?[index]['tgl']),
                      style: TextStyle(color: Colors.grey[700], fontSize: 12),
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
            ),
            
            Visibility(
                visible: index == newData!.length - 1 ? true : false,
                child: Column(
                  children: [
                    Divider(thickness: 1.0,),

                    Container(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: 
                        Row(
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                width: 90,
                                child: Text(
                                  "",
                                  style: TextStyle(
                                      
                                      fontSize: 12),
                                )),
                            Container(
                              alignment: Alignment.centerRight,
                              width: 90,
                              child: Text(Fungsi().format(lastSaldo>0? (lastSaldo*-1):0.0,  isInteger: false),
                                  style: TextStyle(
                                      
                                      fontSize: 12,)),
                            ),
                            
                            Container(
                              alignment: Alignment.centerRight,
                              width: 90,
                              child: Text(Fungsi().format(lastSaldo<0? (lastSaldo*-1):0.0,  isInteger: false),
                                  style: TextStyle(
                                      
                                      fontSize: 12)),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Saldo Akhir",
                                      style: TextStyle(
                                          
                                          fontSize: 12))),
                            ),
                          ],
                        )
                        ),
                    Container(
                      color: Colors.red,
                      height: 2.0,
                    ),
                    SizedBox(
                      height: 7,
                    )
                  ],
                ))
          ])),
    );
    if (namaBarang != newData?[index]['barang_nama']) {
      print("beda");
      saldoAkhir = 0.0;
    }
    if (int.parse(newData?[index]['urut']) == 3) {
      saldoAkhir = saldoAkhir - double.parse(newData?[index]['total']);
    } else {
      saldoAkhir = saldoAkhir + double.parse(newData?[index]['total']);
    }
print(newData?[index]['urut'] + " - "+newData?[index]['total']);
    namaBarang = newData?[index]['barang_nama'];

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

  @override
  void initState() {
    super.initState();
    txtAwal.text = Fungsi().fmtDateDayNow();
    tanggalAwal = Fungsi().fmtDateTimeYearNow();
    txtAkhir.text = Fungsi().fmtDateDayNow();
    tanggalAkhir = Fungsi().fmtDateTimeYearNow();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading:
            Prefs.getString("user_type").toString().toLowerCase() == "admin"
                ? false
                : true,
        backgroundColor: Colors.green[700],
        title: const Text(
          "Barang",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          IconButton(
            //iconSize: 48,
            icon: Icon(Icons.picture_as_pdf),
            onPressed: () {
              namaBarang = "";
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
            <h2>Report Rekening Koran Barang</h2>
             </br>
            <table style="width:100%">
              <caption></caption>
              
              """;
              var lastSaldo = 0.0;
              for (var i = 0; i < newData!.length; i++) {
                if (i == newData!.length ) {
                  if (namaBarang != newData?[i]['barang_nama']) {
                    lastSaldo = double.parse(newData?[i]['total']);
                    htmlContent = htmlContent +
                        """
                  <tr>
                  <th colspan=4>${newData?[i]['barang_nama']}</th>
                  </tr>
                  <tr>
                    <th align="center" >Tanggal</th>
                    <th align="center" >Debit</th>
                    <th align="center" >Credit</th>
                    <th align="center" >Keterangan</th>
                  </tr>
                    """;
                  } else {
                    lastSaldo = saldoAkhir + double.parse(newData?[i]['total']);
                  }
                } else {
                  if (namaBarang != newData?[i]['barang_nama']) {
                    if (namaBarang != "") {
                      htmlContent = htmlContent +
                          """
                <tr>

                <td></td>
                <td align="right">${Fungsi().format(saldoAkhir > 0 ? saldoAkhir : 0, isInteger: false)}</td>
                <td align="right">${Fungsi().format(saldoAkhir < 0 ? saldoAkhir*-1 : 0, isInteger: false)}</td>
                <td align="right">"Saldo Akhir</td>
              </tr>
                """;
                    }
                    htmlContent = htmlContent +
                      """
                      <tr>
                      <th colspan=4>${newData?[i]['barang_nama']}</th>
                      </tr>
                      <tr>
                      <th align="center" >Tanggal</th>
                      <th align="center" >Debit</th>
                      <th align="center" >Credit</th>
                      <th align="center" >Keterangan</th>
                    </tr>
                    """;
                  }
                }
                htmlContent = htmlContent +
                    """
                <tr>

                <td>${Fungsi().fmtDateDay(newData![i]["tgl"])}</td>
                <td align="right">${Fungsi().format(double.parse(newData![i]["debit"]), isInteger: false)}</td>
                <td align="right">${Fungsi().format(double.parse(newData![i]["credit"]), isInteger: false)}</td>
                <td align="right">${newData![i]["ket"]}</td>
              </tr>
                """;
                if (namaBarang != newData?[i]['barang_nama']) {
                  saldoAkhir = 0.0;
                }
                
                if (int.parse(newData?[i]['urut']) == 3) {
                  saldoAkhir = saldoAkhir - (double.parse(newData?[i]['total']));
                } else {
                  saldoAkhir = saldoAkhir + double.parse(newData?[i]['total']);
                }
                
                if(i == newData?.length){

                }

                namaBarang = newData?[i]['barang_nama'];
              }
              print("total="+saldoAkhir.toString());
               htmlContent = htmlContent +
                          """
                <tr>

                <td></td>
                <td align="right">${Fungsi().format(saldoAkhir > 0 ? saldoAkhir : 0, isInteger: false)}</td>
                <td align="right">${Fungsi().format(saldoAkhir < 0 ? saldoAkhir*-1: 0, isInteger: false)}</td>
                <td align="right">"Saldo Akhir</td>
              </tr>
                """;
              htmlContent = htmlContent +
                  """
            </table>
          </body>
        </html>
        """;
              setState(() {
                // PDFService().generatePdf(
                //     htmlContent: htmlContent,
                //     judulReport: "Rekening Koran",
                //     context: context,
                //     filename: "rekening_koran");
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
          )
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
      body: Container(
          color: Colors.grey[100],
          child: Column(
            children: <Widget>[
              Expanded(
                  child: Column(
                children: <Widget>[
                  Visibility(
                      visible: isDisplay,
                      child: DatePicker().rangeDatePickerBorder(
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
                          backgroundColor: Colors.grey[300])),
                  DataTablet().getListDataNoScroll(
                      context: context,
                      newData: newData,
                      isiWidget: callBackIsiWidget,
                      callBackView: callBackView,
                      isCustom: true,
                      isEditOnly: true,
                      filePNG: "assets/images/widget-icons/note.png",
                      isKlik: isKlik,
                      warna: Colors.green,
                      isAktifGantiWarna: false,
                      //fieldGantiWarna: "active",
                      isNoDecoration: true,
                      isAPI: true),
                ],
              ))
            ],
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: IgnorePointer(
        ignoring: true,
      ),
    );
  }
}
