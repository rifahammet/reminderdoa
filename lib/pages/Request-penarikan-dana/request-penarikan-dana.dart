// ignore_for_file: prefer_if_null_operators

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:doa/pages/Request-penarikan-dana/form-request-penarikan-dana.dart';
import 'package:doa/utils/api-utility.dart';
import 'package:doa/utils/api.dart';
import 'package:doa/utils/function.dart';
import 'package:doa/utils/pref_manager.dart';
import 'package:doa/widgets/bottomDbNavigation.dart';
import 'package:doa/widgets/datatable.dart';
import 'package:sweetalert/sweetalert.dart';

class RequestPenarikanDanaPage extends StatefulWidget {
  const RequestPenarikanDanaPage({Key? key}) : super(key: key);
  @override
  _RequestPenarikanDanaPageState createState() => _RequestPenarikanDanaPageState();
}

class _RequestPenarikanDanaPageState extends State<RequestPenarikanDanaPage> {
  // ManageUserService kebunService = new ManageUserService();
  List<dynamic>? newData;
  var bottomNavigationBarIndex = 0;
  int iPos = 1;
  int iPosMax = 0;
  bool isKlik = false;
  bool isMatikan = false;
  bool diKlik = false;
  bool isApproved = false;
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
      builder: (BuildContext context) =>  RequestPenarikanDanaDialog()
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
      int userId = Prefs.getInt('userId');
    if (!isFirst) {
      return newData;
    }
    ApiUtilities auth =  ApiUtilities();
    final dataPropinsi = auth.getGlobalParam(
        namaApi: "penarikandanaedit", like: txtFilter.text.toString().trim()!=""? { "user_profile_id":userId, "concat_field": txtFilter.text}:{"user_profile_id":userId}, startFrom: (iPos-1) * int.parse(_selectedType.toString()) , limit: _selectedType);
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
    isApproved = Fungsi().StringToBool(newData?[index]["approved"]);

    editData(context, int.parse(newData?[index]["id"]), true,!isApproved);
  }

  callBackEdit(index) async {
    
  }

  callBackDelete(index) async {
    SweetAlert.show(context,
        subtitle: "please_wait", style: SweetAlertStyle.loading);
    if (Fungsi().StringToBool(newData?[index]["approved"])) {
      SweetAlert.show(context,
        subtitle: "Data has been approved by admin", style: SweetAlertStyle.loadingerror);
      // print("hapus disini");
      // var dataSave = <dynamic, dynamic>{
      //   "deleted": 1,
      //   "id": int.parse(newData?[index]["user_login_id"])
      // };

      // void callBack(data) {
      //   SweetAlert.show(
      //     context,
      //     subtitle: "User has been deleted",
      //     style: SweetAlertStyle.loadingSuccess,
      //   );
        Future.delayed(new Duration(seconds: 3), () {
          setState(() {});
          Navigator.pop(context);
        });
      // }

      // ApiUtilities().saveUpdateData(
      //     context: context,
      //     data: dataSave,
      //     namaAPI: "userlogin",
      //     isEdit: true,
      //     isCustom: true,
      //     callBack: callBack);
    

      
    } else {
print("hapus disana");
      var where = <dynamic, dynamic>{"id": int.parse(newData?[index]["id"])};
      ApiUtilities().hapusData(
          context: context,
          namatabel: "penarikandanaedit",
          where: where,
          setState: setState);
  }}

  callBackIsiWidget(index) {
    Widget wg = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          
        formatDate(DateTime.parse(newData?[index]['tanggal_transaksi']), [dd, '-', mm, '-', yyyy])
          ,
          style: TextStyle(color: Colors.grey[700], fontSize: 12,fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5,),
        Text(
          Fungsi().format(double.parse(newData?[index]['jumlah_dana']), isInteger: false, isMataUang: true)
          ,
          style: TextStyle(color: Colors.grey[700], fontSize: 12),
        ),
        SizedBox(height: 5,),
        Text(
          int.parse(newData?[index]['cash'])==1 ? "Cash" : "Transfer"
          ,
          style: TextStyle(color: Colors.grey[700], fontSize: 12),
        ),
        SizedBox(height: 5,),
        Text(
          newData![index]['keterangan'].toString(),
          style: TextStyle(color: Colors.grey[700], fontSize: 12),
        ),
      ],
    );
    return wg;
  }

  callBack(int index) async {
    SweetAlert.show(context,
        subtitle: "Please Wait", style: SweetAlertStyle.loading);
    setState(() {
      diKlik = true;
      // ignore: unnecessary_this
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
          "Permintaan Penarikan Dana",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
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
                                  filePNG: "assets/images/widget-icons/atm.png",
                                  isKlik: isKlik,
                                  warna: Colors.green,
                                  isAktifGantiWarna: true,
                                  fieldGantiWarna: "approved",
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
          editData(context, Prefs.getInt("userId"), false, true);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      bottomNavigationBar: BottomDbNavigationBarApp(
          context, bottomNavigationBarIndex, callBack)
    );
  }
}
