import 'package:flutter/material.dart';
import 'package:doa/pages/bank-sampah/form-manage-bank-sampah.dart';
import 'package:doa/utils/api-utility.dart';
import 'package:doa/utils/api.dart';
import 'package:doa/utils/function.dart';
import 'package:doa/utils/pref_manager.dart';
import 'package:doa/widgets/bottomDbNavigation.dart';
import 'package:doa/widgets/datatable.dart';
import 'package:sweetalert/sweetalert.dart';

class ManageBankSampahPage extends StatefulWidget {
  final bool? isViewOnly;
  const ManageBankSampahPage({Key? key, this.isViewOnly}) : super(key: key);
  @override
  _ManageBankSampahPageState createState() => _ManageBankSampahPageState();
}

class _ManageBankSampahPageState extends State<ManageBankSampahPage> {
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

  editData(BuildContext context, dynamic data, bool isNew, bool isView) async {
    FocusScope.of(context).requestFocus(FocusNode());
    final x = await showDialog(
      context: context,
      builder: (BuildContext context) => new ManageBankSampahDialog()
          .buildAddDialog(context, this, data, isNew, isView),
    );
        if(x!= null && x){
      print('setstate');
    setState(() {
    });
    }
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
    ApiUtilities auth = new ApiUtilities();
    final dataPropinsi = auth.getGlobalParam(
        namaApi: "propinsi", like: txtFilter.text.toString().trim()!=""? { "active": "1","concat_field": txtFilter.text}:{ "active": "1"}, startFrom: (iPos-1) * int.parse(_selectedType.toString()) , limit: _selectedType);
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
      print(x.toString());
      newData = x;
    });
  }

  callBackView(index) async {
    
  }

  callBackEdit(index) async {
    editData(context, newData?[index], true, true);
  }

  callBackDelete(index) async {
    bool isError = false;
  }

  callBackIsiWidget(index) {
    Widget wg = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          newData?[index]['prop_kode'],
          style: TextStyle(
              color: Colors.grey[700],
              fontSize: 12,
              fontWeight: FontWeight.bold),
        ),
        Text(
          newData?[index]['prop_nama'],
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
      print("current page="+iPos.toString()+ " page maximum="+iPosMax.toString());
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
          "Manage Bank Sampah",
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
                      future: getDataKebun(isCount: true, isFirst: true),
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
                                  isEditOnly: true,
                                  isKlik: isKlik,
                                  warna: Colors.green,
                                  isAktifGantiWarna: true,
                                  fieldGantiWarna: "active",
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
  ignoring: widget.isViewOnly!,
  child:FloatingActionButton(
        onPressed: () async {
          // var db = await openDB();
          //editData(context, null, false, true, AppLocalizations.of(context));
        },
        child: Icon(Icons.add),
        backgroundColor: widget.isViewOnly! ? Colors.grey[400] : Colors.green ,
      )),
      bottomNavigationBar: BottomDbNavigationBarApp(
          context, bottomNavigationBarIndex, callBack)
    );
  }
}
