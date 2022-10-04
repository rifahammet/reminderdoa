import 'package:doa/pages/detail-doa/form-multi-doa.dart';
import 'package:flutter/material.dart';
import 'package:doa/utils/api-utility.dart';
import 'package:doa/utils/function.dart';
import 'package:doa/utils/pref_manager.dart';
import 'package:doa/widgets/bottomDbNavigation.dart';
import 'package:doa/widgets/datatable.dart';
import 'package:sweetalert/sweetalert.dart';

class ListUpNotifDialog extends StatefulWidget {
  const ListUpNotifDialog({Key? key}) : super(key: key);
  @override
  _ListUpNotifDialogState createState() => _ListUpNotifDialogState();
}

class _ListUpNotifDialogState extends State<ListUpNotifDialog> {
  // ManageUserService kebunService = new ManageUserService();
  List<dynamic>? newData;
  var bottomNavigationBarIndex = 0;
  int iPos = 1;

  int iPosMax = 0;
  bool isKlik = false;
  bool isMatikan = false;
  bool diKlik = false;
  var _typeItems = <String>['3', '5', '10', '15', '25'];
  var _selectedType = '25';
  List<DropdownMenuItem<String>>? _dropDownType;
  final txtFilter = TextEditingController();

  _initDropDowns() {
    _dropDownType = _typeItems
        .map((String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ))
        .toList();

    //Fungsi().listToDropDownMenuItem(_typeItems);
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
    if (isCount) {}

    ApiUtilities auth = new ApiUtilities();
    final dataPropinsi = auth.getGlobalParam(
        namaApi: "usernotif",
        like: txtFilter.text.toString().trim() != ""
            ? {
                "user_id": Prefs.getInt("userId"),
                "concat_field": txtFilter.text
              }
            : {"user_id": Prefs.getInt("userId")},
        startFrom: (iPos - 1) * int.parse(_selectedType.toString()),
        limit: _selectedType);
    //final dataPropinsi =  await Fungsi().fetchData(url: Api.BASE_URL+ "propinsi");
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
    var where = <dynamic, dynamic>{};
    void callBack(data) async {

      Navigator.pop(context);
      await showDialog(
        context: context,
        builder: (BuildContext context) => MultiDoaDialog().buildAddDialog(
            context, this, true, false, newData?[index]["topic"]),
      );
    }
    if(newData![index]['click'].toString()=='0') {
      SweetAlert.show(context,
          subtitle: "please_wait",
          style: SweetAlertStyle.loading);

      if (newData![index]["topic"].toString().contains("Time")) {
        where = <dynamic, dynamic>{
          "user_id": Prefs.getInt("userId"),
          "waktu": newData?[index]["waktu"],
          "date": newData?[index]["date"],
          "time": newData?[index]["time"],
        };
      } else {
        where = <dynamic, dynamic>{
          "user_id": Prefs.getInt("userId"),
          'kota_kode': newData?[index]["kota_kode"],
          "waktu": newData?[index]["waktu"],
          "date": newData?[index]["date"]
        };
      }

      var dataSave = <dynamic, dynamic>{
        "click": 1,
        "clicked_date": Fungsi().fmtDateTimeYearNow()
      };

      ApiUtilities().saveUpdateData(
          context: context,
          data: dataSave,
          namaAPI: "userreminderlog",
          where: where,
          isEdit: true,
          setState: setState,
          isCustom: true,
          callBack: callBack);
    } else {
      await showDialog(
        context: context,
        builder: (BuildContext context) => MultiDoaDialog().buildAddDialog(
            context, this, true, false, newData?[index]["topic"]),
      );
    }
  }

  callBackEdit(index) async {
    Navigator.of(context).pop(newData![index]);
  }

  callBackDelete(index) async {}

  callBackIsiWidget(index) {
    Widget wg = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          newData?[index]['title'],
          style: TextStyle(
              color: Colors.grey[700],
              fontSize: 12,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          newData?[index]['body'],
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
      this.bottomNavigationBarIndex = index;
      Fungsi formating = new Fungsi();
      iPos = formating.getPos(index, iPos, iPosMax);
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
          title: const Text(
            "Notifikasi Hari ini",
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
        body: WillPopScope(
          onWillPop: () {
            Navigator.pop(context, false);
            return new Future(() => false);
          },
          child: Container(
              color: Colors.grey[100],
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: FutureBuilder(
                          future: getDataKebun(isCount: true, isFirst: true),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasError) print(snapshot.error);
                            var jmlData =
                                snapshot.data?["data"]["total_data"] == null
                                    ? 0
                                    : snapshot.data?["data"]["total_data"];
                            Fungsi fungsi = new Fungsi();
                            iPosMax = fungsi.getIposMax(_selectedType, jmlData);

                            //print();
                            List<dynamic>? list =
                                snapshot.data?["data"]["data"];
                            if (list == null) {
                              newData = [];
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              newData = list;
                              return Column(
                                children: <Widget>[
                                  DataTablet().getSearchForm(context,
                                      txtFilter: txtFilter,
                                      returnComboBox: callBackComboBox,
                                      //dropDownData: _dropDownType,
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
                                      isKlik: isKlik,
                                      isClosed: true,
                                      warna: Colors.green,
                                      isAktifGantiWarna: true,
                                      fieldGantiWarna: "click",
                                      isAPI: true),
                                ],
                              );
                            }
                          }))
                ],
              )),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // var db = await openDB();
            //editData(context, null, false, true, AppLocalizations.of(context));
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
        bottomNavigationBar: BottomDbNavigationBarApp(
            context, bottomNavigationBarIndex, callBack));
  }
}
