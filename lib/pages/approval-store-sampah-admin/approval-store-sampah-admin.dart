// ignore_for_file: prefer_if_null_operators

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:doa/pages/store-sampah/form-strore-sampah.dart';
import 'package:doa/services/pdf_service.dart';
import 'package:doa/utils/api-utility.dart';
import 'package:doa/utils/api.dart';
import 'package:doa/utils/function.dart';
import 'package:doa/utils/pref_manager.dart';
import 'package:doa/widgets/bottomDbNavigation.dart';
import 'package:doa/widgets/button.dart';
import 'package:doa/widgets/datatable.dart';
import 'package:doa/widgets/label.dart';
import 'package:doa/widgets/show-dialog.dart';
import 'package:doa/widgets/textbox.dart';
import 'package:sweetalert/sweetalert.dart';

class ApprovalStoreSampahAdminPage extends StatefulWidget {
  const ApprovalStoreSampahAdminPage({Key? key}) : super(key: key);
  @override
  _ApprovalStoreSampahAdminPageState createState() =>
      _ApprovalStoreSampahAdminPageState();
}

class _ApprovalStoreSampahAdminPageState
    extends State<ApprovalStoreSampahAdminPage> {
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
  var namaBarangOld = "";
  List<DropdownMenuItem<String>>? _dropDownType;
  final txtFilter = TextEditingController();

  final txtPasswordController = TextEditingController();

  final txtPasswordFocusNode = FocusNode();

  bool obscureText = true;
  IconData icon = Icons.visibility;

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
      builder: (BuildContext context) => StoreSampahDialog()
          .buildAddDialog(context, this, data, isEdit, isView),
    );
    if (x != null && x) {
      //print('setstate');
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
        namaApi: "storesampahheader",
        where: {"bank_id": Prefs.getInt("bank_id")},
        like: txtFilter.text.toString().trim() != ""
            ? {
                "permanent_deleted": 0,
                "approved": 0,
                "posted": 0,
                "concat_field": txtFilter.text
              }
            : {"permanent_deleted": 0, "approved": 0, "posted": 0},
        startFrom: (iPos - 1) * int.parse(_selectedType.toString()),
        limit: _selectedType);
    return dataPropinsi;
  }

  refresh() async {
    setState(() {
      isKlik = !isKlik;
    });
  }

  changeTextField(pil, val) {
    setState(() {
      print("pilihan=" + pil.toString() + " - value = " + val.toString());
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



  callBackEdit(index) async {}
  callBackDelete(index) async {}
  callBackView(index){}



  onPressedDialog(data) {
    if (Fungsi()
            .strToMD5(txtPasswordController.text)
            .toString() ==
        data["user_pass"]) {
      SweetAlert.show(context,
          subtitle: "please_wait", style: SweetAlertStyle.loading);
      var dataSave = [
        {
          "storesampahheader": {
            "action": "update",
            "data": [
              {"nomor_transaksi": data["nomor_transaksi"]
              , "approved": 1
              , "first_approved":1
              , "total_approved": data["total"]
              ,  "dt_approved" : Fungsi().fmtDateTimeYearNow()
              , "approved_user_profile_id" : data["user_profile_id"]
              }
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
    } else {
      SweetAlert.show(context,
          subtitle: "Password tidak sesuai",
          style: SweetAlertStyle.loadingerror);
      Future.delayed(new Duration(seconds: 3), () {
        setState(() {});
        txtPasswordController.text = "";
        Navigator.pop(context);
      });
    }
  }

  // callBackButton(data) async {
//         SweetAlert.show(context,
//         subtitle: "please_wait", style: SweetAlertStyle.loading);
//     var dataSave = [
//   {
//     "penarikandanaedit": {
//       "action": "update",
//       "data": [
//         {
//           "id": data["id"],
//           "approved": 1
//         }
//       ]
//     }
//   },
//   {
//     "approvalpenarikandana": {
//       "action": "new",
//       "data": [
//         {
//           "approved_user_profile_id": Prefs.getInt("userId"),
//           "jumlah_dana": data["jumlah_dana"],
//           "penarikan_dana_id": data["id"]
//         }
//       ]
//     }
//   }
// ];
//     void callBack() {
//       SweetAlert.show(
//         context,
//         subtitle: "Data has been Approved",
//         style: SweetAlertStyle.loadingSuccess,
//       );
//       Prefs.setBool("isSaving", true);
//       Future.delayed(new Duration(seconds: 3), () {
//         setState(() {});
//         Navigator.pop(context);
//       });

//     }

//     ApiUtilities().saveUpdateBatchData(
//         context: context,
//         data: dataSave,
//         isEdit: true,
//         setState: setState,
//         isCustom: true,
//         callBack: callBack);
  // }

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
      showDialogWidget(data,setState) {

          suffixIconIconOnPressed(value) {
        setState(() {
          obscureText = !value;
          this.icon = obscureText? Icons.visibility : Icons.visibility_off;
          print(obscureText.toString());
        });
  }

    Widget wg =
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      TextBox().textBoxBorderedIconValidate(context,
          textName: "Password",
          hint: "Password",
          obscureText: obscureText,
          icon: Icons.vpn_key,
          suffixIcon: icon,
          suffixIconIconOnPressed: suffixIconIconOnPressed,
          textController: txtPasswordController,
          textChange: changeTextField),
    ]);
    return wg;
  }
    callBackButton(data) async {
      txtPasswordController.text = "";
      print('data : $data');
      //data.keys
      ShowDialog().showDialogs(
          data: data,
          contek: context,
          isiwidget: showDialogWidget,
          judul: "Approval User",
          onPressed: onPressedDialog,
          labelButton: "Approve");
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
              child: Image.asset("assets/images/widget-icons/note.png"),
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
                    newData?[index]['nomor_transaksi'],
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    Fungsi().fmtDateDay(newData?[index]['tanggal_transaksi']),
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
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
                    Fungsi().format(double.parse(newData?[index]['total']),
                        isMataUang: true, isInteger: false, mataUang: "Rp."),
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
                            data: newData?[index], callBack: callBackButton)),
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

      // Widget wg = Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: <Widget>[
      //     Text(
      //       newData?[index]['nomor_transaksi'],
      //       style: TextStyle(color: Colors.grey[700], fontSize: 12,fontWeight: FontWeight.bold),
      //     ),
      //     SizedBox(height: 5,),
      //     Text(
      //       Fungsi().fmtDateDay(newData?[index]['tanggal_transaksi']) ,
      //       style: TextStyle(color: Colors.grey[700], fontSize: 12),
      //     ),
      //     SizedBox(height: 5,),
      //     Text(
      //       newData?[index]['nama_lengkap'],
      //       style: TextStyle(color: Colors.grey[700], fontSize: 12),
      //     ),
      //     SizedBox(height: 5,),
      //     Text(
      //       Fungsi().format(double.parse( newData?[index]['total']), isMataUang: true, isInteger: false, mataUang: "Rp.")
      //        ,
      //       style: TextStyle(color: Colors.grey[700], fontSize: 12),
      //     ),
      //     SizedBox(height: 5,),
      //     Visibility(
      //       visible: Fungsi().StringToBool(newData![index]['approved']),
      //       child:
      //     Label().labelStatus(label: "Approved" , width: 75.0))
      //   ],
      // );
      // return wg;
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        //drawer: AppDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.green[700],
          title: const Text(
            "Approval Store Sampah",
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
                                    isEditOnly: true,
                                    isCustom: true,
                                    filePNG:
                                        "assets/images/widget-icons/deposit.png",
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
        floatingActionButton: IgnorePointer(
  ignoring: true,
  child:FloatingActionButton(
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
