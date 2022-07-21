// ignore_for_file: prefer_if_null_operators

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:doa/pages/penjualan/form-penjualan.dart';
import 'package:doa/pages/store-sampah/form-strore-sampah.dart';
import 'package:doa/services/pdf_service.dart';
import 'package:doa/utils/api-utility.dart';
import 'package:doa/utils/api.dart';
import 'package:doa/utils/function.dart';
import 'package:doa/utils/pref_manager.dart';
import 'package:doa/widgets/bottomDbNavigation.dart';
import 'package:doa/widgets/datatable.dart';
import 'package:doa/widgets/label.dart';
import 'package:sweetalert/sweetalert.dart';

class PenjualanPage extends StatefulWidget {
  const PenjualanPage({Key? key}) : super(key: key);
  @override
  _PenjualanPageState createState() => _PenjualanPageState();
}

class _PenjualanPageState extends State<PenjualanPage> {
  // ManageUserService kebunService = new ManageUserService();
  List<dynamic>? newData;
  var bottomNavigationBarIndex = 0;
  int iPos = 1;
  int iPosMax = 0;
  bool isKlik = false;
  bool isMatikan = false;
  bool diKlik = false;
  var _typeItems = <String>['3', '5', '10', '15', '25'];
  var _selectedType = '5';
  var namaBarangOld="";
  List<DropdownMenuItem<String>>? _dropDownType;
  final txtFilter = TextEditingController();

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
      builder: (BuildContext context) =>  PenjualanDialog()
          .buildAddDialog(context, this, data, isEdit, isView),
    );
    if(x!= null && x){
      print('setstate');
    setState(() {
    });
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
    ApiUtilities auth =  ApiUtilities();
    final dataPropinsi = auth.getGlobalParam(
        namaApi: "penjualanheader", like: txtFilter.text.toString().trim()!=""? {"bank_id":Prefs.getInt("bank_id"),"permanent_deleted":0,"posted":0, "concat_field": txtFilter.text}:{"bank_id":Prefs.getInt("bank_id"),"posted":0,"permanent_deleted":0}, startFrom: (iPos-1) * int.parse(_selectedType.toString()) , limit: _selectedType);
    return dataPropinsi;
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

  callBackView(index) async {
    editData(context, int.parse(newData?[index]["id"]), true, true);
  }

  callBackEdit(index) async {
    
  }

  callBackDelete(index) async {
    if(Fungsi().StringToBool(newData![index]["first_approved"])){
 var dataSave = <dynamic, dynamic>{
                            "nomor_transaksi": newData![index]["nomor_transaksi"],
                            "deleted": 1,
                            "approved": 0,
                            "dt_updated": formatDate(
                                  DateTime.now(), [yyyy, '-', mm, '-', dd]),
                            "updated_user_profile_id": Prefs.getInt("userId") 
                          };
                            ApiUtilities().saveUpdateData(
                                context: context,
                                data: dataSave,
                                namaAPI:"penjualanheader",
                                isEdit: true,
                                setState: setState,
                                isSingleDelete: true 
                                );
      

    }else{
          var where = <dynamic, dynamic>{
      "nomor_transaksi": newData![index]["nomor_transaksi"].toString()
    };
    ApiUtilities()
        .hapusData(context: context, namatabel: "penjualanheader", where: where,setState: setState);
    }
  }

  callBackIsiWidget(index) {
    Widget wg = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          newData?[index]['nomor_transaksi'],
          style: TextStyle(color: Colors.grey[700], fontSize: 12,fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5,),
        Text(
          Fungsi().fmtDateDay(newData?[index]['tanggal_transaksi']) ,
          style: TextStyle(color: Colors.grey[700], fontSize: 12),
        ),
        SizedBox(height: 5,),
        Text(
          newData?[index]['nomor_referensi'],
          style: TextStyle(color: Colors.grey[700], fontSize: 12),
        ),
        SizedBox(height: 5,),
        Text(
          Fungsi().format(double.parse( newData?[index]['total']), isMataUang: true, isInteger: false, mataUang: "Rp.")
           ,
          style: TextStyle(color: Colors.grey[700], fontSize: 12),
        ),
        SizedBox(height: 5,),
        Visibility(
          visible: Fungsi().StringToBool(newData![index]['approved']),
          child:
        Label().labelStatus(label: "Approved" , width: 75.0))
      ],
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
      print("current page="+iPos.toString()+ " page maximum="+iPosMax.toString());
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
    _initDropDowns();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text(
          "Penjualan Sampah",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
        actions: [IconButton(
              //iconSize: 48,
              icon: Icon(Icons.picture_as_pdf),
              onPressed: () async {
                
                final dataReport = await ApiUtilities().getGlobalParamNoLimit(namaApi: "penjualandetail" , where: {"bank_id": Prefs.getInt("bank_id"),"posted_barang": 0});
                  print("dataPrint="+dataReport['data']['data'].toString());
                List<dynamic> dataLap = dataReport['data']['data'];
                var qtyPerBarang=0.0;
                var totalPerBarang=0.0;
                var qtyTotal=0.0;
                var grandTotal=0.0;
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
            <h2>Report Penjualan Sampah</h2>
             </br>
            <table style="width:100%">
              <caption></caption>
<tr>
                <th align="center" >Nama Barang</th>
                 <th align="center" >Qty</th>
                 <th align="center" >Harga Jual</th>
<th align="center" >Total</th>
              </tr>
              """;

var totalQty =0.0;
var total=0.0;
    for (var i = 0; i < dataLap.length; i++) {
      totalQty=totalQty+double.parse(dataLap[i]['qty']);
      total=total+(double.parse(dataLap[i]['qty']) * double.parse(dataLap[i]['harga_jual']));
      htmlContent = htmlContent +
        """
<tr>
<td>${dataLap[i]['barang_nama']}</td>
<td align="right">${Fungsi().format(dataLap[i]['qty'], isDouble: false, isInteger: false)}</td>
<td align="right">${Fungsi().format(dataLap[i]['harga_jual'], isDouble: false, isInteger: false)}</td>
<td align="right">${Fungsi().format(double.parse(dataLap[i]['qty']) * double.parse(dataLap[i]['harga_jual']), isInteger: false)}</td>
</tr>
""";
    }
    htmlContent = htmlContent +
        """
<tr>
<th>Total</th>
<th align="right">${Fungsi().format(totalQty,  isInteger: false)}</th>
<td></td>
<th align="right">${Fungsi().format(total, isInteger: false)}</th>
</tr>
            </table>
          </body>
        </html>
        """;
                setState(() {
                  
                  // PDFService().generatePdf(htmlContent: htmlContent, judulReport: "Report Penimbangan", context: context, filename: "rekening_koran");
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
                  child: FutureBuilder(
                      future: getData(isCount: true, isFirst: true),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) print(snapshot.error);
                        if(snapshot.hasData){
                        var jmlData = snapshot.data==null ? 0 : snapshot.data?["isSuccess"]==false? 0: snapshot.data?["data"]["total_data"]==null ? 0 :snapshot.data?["data"]["total_data"];
                        Fungsi fungsi = new Fungsi();
                        iPosMax = fungsi.getIposMax(_selectedType, jmlData);
                        List<dynamic>? list = snapshot.data?["isSuccess"]==false? [] : snapshot.data?["data"]["data"];
                          newData = list;
                          return Column(
                            children: <Widget>[
                              DataTablet().getSearchForm(context,
                                  txtFilter: txtFilter,
                                  returnComboBox: callBackComboBox,
                                  // dropDownData: _dropDownType,
                                  comboSelected: _selectedType,
                                  returnButtonSearch: callBackButtonSearch),
                              DataTablet().getListData(
                                  context: context,
                                  newData: newData,
                                  callBackDelete: callBackDelete,
                                  callBackEdit: callBackEdit,
                                  callBackView: callBackView,
                                  isiWidget: callBackIsiWidget,
                                  isDeleteOnly: true,
                                  filePNG: "assets/images/widget-icons/sell1.png",
                                  isKlik: isKlik,
                                  warna: Colors.green,
                                  isAktifGantiWarna: true,
                                  fieldGantiWarna: "deleted",
                                  paramGantiWarna: 0,
                                  isAPI: true),
                            ],
                          );
                        }
                        return Center(
                            child: CircularProgressIndicator(),
                          );
                      }))
            ],
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          editData(context, null, false, true);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      bottomNavigationBar: BottomDbNavigationBarApp(
          context, bottomNavigationBarIndex, callBack)
    );
  }
}
