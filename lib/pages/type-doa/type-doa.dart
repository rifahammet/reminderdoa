import 'package:doa/pages/type-doa/form-type-doa.dart';
import 'package:flutter/material.dart';
import 'package:doa/services/pdf_service.dart';
import 'package:doa/utils/api-utility.dart';
import 'package:doa/utils/api.dart';
import 'package:doa/utils/function.dart';
import 'package:doa/utils/pref_manager.dart';
import 'package:doa/widgets/bottomDbNavigation.dart';
import 'package:doa/widgets/datatable.dart';
import 'package:sweetalert/sweetalert.dart';
// import 'package:easy_localization/easy_localization.dart';

class TypeDoaPage extends StatefulWidget {
  const TypeDoaPage({Key? key}) : super(key: key);
  @override
  _TypeDoaPageState createState() => _TypeDoaPageState();
}

class _TypeDoaPageState extends State<TypeDoaPage> {
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
      builder: (BuildContext context) => TypeDoaDialog()
          .buildAddDialog(context, this, data, isEdit, isView),
    );
        if(x!= null && x){
      print('setstate');
    setState(() {
    });
    }
  }

  void printReport(){
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
            <h2>Report Sampling</h2>
             
             <table >
               <tr>
                 <th align="left">Nama Kolam</th>
                 <th>:</th>
                 <td></td>
               </tr> 
               <tr>
                 <th align="left">Luas Kolam (m²)</th>
                 <th>:</th>
                <td></td>
               </tr>          
                <tr>
                 <th align="left">Asal Benur</th>
                 <th>:</th>
                <td></td>
               </tr> 
                <tr>
                 <th align="left">Tanggal tebar</th>
                 <th>:</th>
                <td></td>
               </tr> 
               <tr>
                 <th align="left">Jumlah Tebar (ekor)</th>
                 <th>:</th>
                <td></td>
               </tr> 
                <tr>
                 <th align="left">Padat tebar (ekor/m²)</th>
                 <th>:</th>
               
               </tr> 
             </table>
             <br>
            <table style="width:100%">
              <caption></caption>
              <tr>
                <th rowspan="2">No.</th>
                <th align="center" rowspan="2">DOC (Hari)</th>
                <th align="center"  rowspan="2">Tanggal</th>
                <th align="center"  rowspan="2">MBW (gr)</th>
                <th align="center"  rowspan="2">Size (ekor/kg)</th>
                <th align="center"  colspan="2">ADG</th>
                <th align="center"  colspan="2">Pakan (kg)</th>
                <th align="center"  colspan="3">Estimasi</th>
                <th align="center"  rowspan="2">Ket</th>
              </tr>
              <tr>
                <th align="center" >Sampling</th>
                <th align="center" >Kumulatif</th>
                <th align="center" >Rata2</th>
                <th align="center" >Kumulatif</th>
                <th align="center" >Biomas (kg)</th>
                <th align="center" >FCR</th>
                <th align="center" >SR (%)</th>  
              </tr>  
              """;
              // PDFService().generatePdf(htmlContent:htmlContent, context: context, judulReport: "test", filename: "test" );
  }

  Future getDataKebun(
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
    final dataPropinsi =  auth.getGlobalParam(
        namaApi: "typesdoa",
        like: txtFilter.text.toString().trim() != ""
            ? {"concat_field": txtFilter.text}
            : {},
        startFrom: (iPos - 1) * int.parse(_selectedType.toString()),
        limit: _selectedType);
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
    final x = await getDataKebun(isCount: true, ket: 'callBackButtonSearch');
    setState(() {
      newData = x;
    });
  }

  callBackView(index) async {
    editData(context, int.parse(newData?[index]["id"]), true, true);
  }

  callBackEdit(index) async {}

  callBackDelete(index) async {
//     SweetAlert.show(context,
//         subtitle: "please_wait", style: SweetAlertStyle.loading);
//     if (newData?[index]["used"]!="0") {
//       void callBack(data) {
//         SweetAlert.show(
//           context,
//           subtitle: "User has been deleted",
//           style: SweetAlertStyle.loadingSuccess,
//         );
//         Future.delayed(new Duration(seconds: 3), () {
//           setState(() {});
//           Navigator.pop(context);
//         });
//        }
//  var dataSave = <dynamic, dynamic>{
//         "deleted": 1,
//         "kategori_kode": int.parse(newData?[index]["kategori_kode"]),
//         "dt_deleted": Fungsi().fmtDateTimeYearNow()
//       };

//       ApiUtilities().saveUpdateData(
//           context: context,
//           data: dataSave,
//           namaAPI: "kategori",
//           isEdit: true,
//           isCustom: true,
//           callBack: callBack);
    

      
//     } else {
//       var where = <dynamic, dynamic>{"kategori_kode": int.parse(newData?[index]["kategori_kode"])};
//       ApiUtilities().hapusData(
//           context: context,
//           namatabel: "kategori",
//           where: where,
//           setState: setState);
//   }
  }

  callBackIsiWidget(index) {
    Widget wg = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          newData?[index]['name'],
          style: TextStyle(
              color: Colors.grey[700],
              fontSize: 12,
              fontWeight: FontWeight.bold),
        ),
        // SizedBox(
        //   height: 5,
        // ),
        // Text(
        //   newData?[index]['kategori_nama'],
        //   style: TextStyle(
        //       color: Colors.grey[700],
        //       fontSize: 12,
        //       fontWeight: FontWeight.bold),
        // ),
        // SizedBox(
        //   height: 5,
        // ),
        // Text(
        //   newData![index]['keterangan'].toString(),
        //   style: TextStyle(color: Colors.grey[700], fontSize: 12),
        // ),
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
      print("current page=" +
          iPos.toString() +
          " page maximum=" +
          iPosMax.toString());
    });
    final tList = await getDataKebun(isCount: false, ket: 'callBack');
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
          title:  Text(
            "Kategori",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          // actions: [IconButton(
          //     //iconSize: 48,
          //     icon: Icon( Icons.visibility_off_outlined),
          //     onPressed: () {
          //       setState(() {
          //         printReport();
          //       });
          //     },
          //   )],
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
                        future: getDataKebun(isCount: true, isFirst: true),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasError) print(snapshot.error);
                          print('future builder');
                          if (snapshot.hasData) {
                            var jmlData = snapshot.data == null
                                ? 0
                                : snapshot.data?["isSuccess"] == false
                                    ? 0
                                    : snapshot.data?["data"]["total_data"] ==
                                            null
                                        ? 0
                                        : snapshot.data?["data"]["total_data"];
                            Fungsi fungsi = new Fungsi();
                            iPosMax = fungsi.getIposMax(_selectedType, jmlData);
                            List<dynamic>? list =
                                snapshot.data?["isSuccess"] == false
                                    ? []
                                    : snapshot.data?["data"]["data"];

                            // if (list == null) {
                            //   newData = [];
                            // } else {
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
                                    filePNG:
                                        "assets/images/widget-icons/list.png",
                                    isKlik: isKlik,
                                    warna: Colors.brown,
                                    isAktifGantiWarna: true,
                                    fieldGantiWarna: "is_active",
                                    isAPI: true),
                              ],
                            );
                            //}
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
            // var db = await openDB();
            //editData(context, null, false, true, AppLocalizations.of(context));
            editData(context, null, false, true);
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
        bottomNavigationBar: BottomDbNavigationBarApp(
            context, bottomNavigationBarIndex, callBack));
  }
}
