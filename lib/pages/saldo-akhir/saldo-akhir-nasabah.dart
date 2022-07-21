// ignore_for_file: prefer_if_null_operators

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:doa/pages/approval-penarikan-dana/form-approval-penarikan-dana.dart';
import 'package:doa/utils/api-utility.dart';
import 'package:doa/utils/api.dart';
import 'package:doa/utils/function.dart';
import 'package:doa/utils/pref_manager.dart';
import 'package:doa/widgets/bottomDbNavigation.dart';
import 'package:doa/widgets/button.dart';
import 'package:doa/widgets/datatable.dart';
import 'package:sweetalert/sweetalert.dart';

class SaldoAkhirNasabahPage extends StatefulWidget {
  final bool? isViewOnly;
  const SaldoAkhirNasabahPage({Key? key, this.isViewOnly}) : super(key: key);
  @override
  _SaldoAkhirNasabahPageState createState() => _SaldoAkhirNasabahPageState();
}

class _SaldoAkhirNasabahPageState extends State<SaldoAkhirNasabahPage> {
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
    final dataPropinsi = auth.getGlobalParam(
        namaApi: "postingsisasaldonasabah",
        // where: {
        //   "sisa>": 0,
        // },
        where: {"bank_id": Prefs.getInt("bank_id")},
        like: txtFilter.text.toString().trim() != ""
            ? {
                "concat_field": txtFilter.text
              }
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
            {"posted_nasabah": 1,
            "posted":1}
          ],
          "where": {
            "posted_nasabah": 0,
            "approved": 1,
            "bank_id": Prefs.getInt("bank_id"),
            "user_profile_id": data["id"]
          }
        }
      },
      {
        "penarikandananew": {
          "action": "update",
          "data": [
            {"posted_nasabah": 1,
            "posted": 1}
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
    Widget wg = Container(
      margin: EdgeInsets.fromLTRB(10, index == 0 ? 15 : 0, 10, 15),
      padding: EdgeInsets.fromLTRB(5, 13, 5, 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10),
            padding: EdgeInsets.all(5),
            child: Image.asset("assets/images/widget-icons/archive.png"),
            width: 60,
            height: 60,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  newData?[index]['nama_lengkap'],
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  Fungsi().format(double.parse(newData?[index]['sisa']),
                      isInteger: false, isMataUang: true),
                  style: TextStyle(color: Colors.grey[700], fontSize: 12),
                ),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(right: 10),
              child: Column(
                children: <Widget>[
                  Center(
                      child: Button().RaisedButon(
                          data: newData?[index],
                          callBack: callBackButton,
                          label: "Posting",
                          color1: Colors.orange[400],
                          color2: Colors.orange)),
                ],
              ))
        ],
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          stops: [0.015, 0.015],
          colors: [Colors.green, Colors.white],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 2.0,
            spreadRadius: 2.0,
            offset: Offset(0.0, 0.0),
          ),
        ],
      ),
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

  @override
  void initState() {
    super.initState();
    _initDropDowns();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            color: Colors.grey[100],
            child: Column(
              children: <Widget>[
                Expanded(
                    child: FutureBuilder(
                        future: getData(isCount: true, isFirst: true),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasError) print(snapshot.error);
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
                                    isCustom: true,
                                    isEditOnly: true,
                                    filePNG:
                                        "assets/images/widget-icons/note.png",
                                    isKlik: isKlik,
                                    warna: Colors.green,
                                    isAktifGantiWarna: false,
                                    //fieldGantiWarna: "active",
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
        floatingActionButton: IgnorePointer(
            ignoring: true,
            child: FloatingActionButton(
              onPressed: () async {
                editData(context, null, false, true);
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.grey[400],
            )),
        bottomNavigationBar: BottomDbNavigationBarApp(
            context, bottomNavigationBarIndex, callBack));
  }
}
