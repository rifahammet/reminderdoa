import 'dart:async';
import 'dart:convert';
import 'package:doa/pages/listups/listup-type-doa.dart';
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

class MasterDoaDialog {
  GlobalKey<FormState>? _key;
  bool autoValidate = false;
  int id = 0;
  bool isAktif = true;
  final txtArabController = TextEditingController();
  final txtNameController = TextEditingController();
  final txtLatinController = TextEditingController();
  final txtTypeNameController = TextEditingController();
  final txtTypeIdController = TextEditingController();
  final txtArtiController = TextEditingController();

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

  /* dbcombobox */
  List<dynamic>? listSatuan;
  dynamic satuan;

  /* checkbox */
  int isActive = 0;

  Future<int> getUserId() async {
    return Prefs.getInt('userId');
  }



  Future<dynamic> getData(isEdit, data) async {
    // if(firstLoad){
    //             final data = await ApiUtilities().getGlobalParamNoLimit(namaApi: "satuan", where: {"active" : 1, "deleted" : 0, "bank_id": Prefs.getInt("bank_id")});
    //             listSatuan=data["data"]["data"];
                
    //              firstLoad = false;
    // }
    if (isEdit) {
      final vData = await ApiUtilities()
          .getGlobalParamNoLimit(namaApi: "masterdoa", where: {"id": data});
      return vData["data"]["data"][0];
    } else {
      return [];
    }
  }

  static const TextStyle linkStyle = TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );

  /* list Up */

  Widget buildAddDialog(BuildContext context, sourceForm, dynamic data,
      bool isEdit, bool isView) {
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

        listUP(label, BuildContext context) async {
          final res = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ListUpTypeDoaPage(),
            ),
          );
          if (res != null) {
            setState(() {
              txtTypeNameController.text = res["name"];
              txtTypeIdController.text = res["id"];
            });
          }
        }

        display_satuan(data){
          return data["satuan"];
        }
        change_satuan(data){
          setState((){
            satuan = data;
          });
          
        }
        // ignore: non_constant_identifier_names
        changeTextField(pil, val) {
          setState(() {
            print("pilihan=" + pil.toString() + " - value = " + val.toString());
          });
        }

        change_isactive(val) {
          setState(() {
            isActive = val;
          });
        } /* end call back */

        cbOnChange(val) {
          setState(() {
            satuan = val;
          });
        }

        /* call back */

        return Form(
            key: _key,
            child: Scaffold(
                resizeToAvoidBottomInset: true,
                appBar: AppBar(
                  backgroundColor: Colors.green[700],
                  leading: IconButton(
                    icon: const Icon(Icons.close, color: Colors.yellow),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  title: const Text(
                    "Form masterdoa",
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
                      future: getData(isEdit, data),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          if (isFirst) {
                            if (isEdit) {
                              txtArabController.text =
                                  snapshot.data["arab"];
                              txtNameController.text =
                                  snapshot.data["name"];
                              txtTypeNameController.text =
                                  snapshot.data["type_name"];
                              txtTypeIdController.text =
                                  snapshot.data["type_id"];
                              txtLatinController.text =
                                  snapshot.data["latin"];
                                  txtArtiController.text =
                                  snapshot.data["arti"];
                              isActive = int.parse(snapshot.data["is_active"]) == 1
                                  ? 0
                                  : 1;
                              
                            } else {
                              txtArabController.text = "";
                              txtNameController.text = "";
                              txtTypeIdController.text = "";
                              
                              txtTypeNameController.text = "";
                              txtLatinController.text = "";
                              
                              isActive = 0;
                              txtArtiController.text = "";
                            }
                            isFirst = false;
                          }
                          return Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width - 10,
                              height: MediaQuery.of(context).size.height - 10,
                              padding:
                                  const EdgeInsets.fromLTRB(10, 20, 10, 10),
                              color: Colors.white,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    TextBox().textboxWithBorderValidate(
                                      context,
                                      label: "name",
                                      textController: txtNameController,
                                      textChange: changeTextField,
                                      textFocusNote: txtNameFocusNode,
                                      isMandatory: true
                                    ),
                                    ListUp().listUpWithBorderValidate(context,
                                        label: "tipe",
                                        textController:
                                            txtTypeNameController,
                                        textFocusNote: txtTypeNameFocusNode,
                                        suffixIconOnPressed: listUP,
                                        isMandatory: true),

                                    
                                    // DropDown().dropDownwithBorder(context,
                                    //     label: 'Satuan',
                                    //     items: <String>['Pcs', 'Kg','Unit'],
                                    //     value: satuan,
                                    //     cbOnChage: cbOnChange,
                                    //     comboFocusNode: txtSatuanFocusNode),
                                    // TextBox().textboxWithBorderValidate(
                                    //   context,
                                    //   label: "Satuan",
                                    //   textController: txtSatuanController,
                                    //   textChange: changeTextField,
                                    //   textFocusNote: txtSatuanFocusNode,
                                    // ),
                                    TextBox().textboxWithBorderValidate(
                                      context,
                                      label: "arab",
                                      textController: txtArabController,
                                      textChange: changeTextField,
                                      textFocusNote: txtArabFocusNode,
                                    ),
                                    SizedBox(height: 5,),
                                    TextBox().textboxWithBorderValidate(context,
                                        label: "arti",
                                        textController: txtArtiController,
                                        textChange: changeTextField,
                                        textFocusNote: txtArtiFocusNode,
                                        maxlines: 3,
                                        isMandatory: true),
                                    TextBox().textboxWithBorderValidate(context,
                                        label: "latin",
                                        textController: txtLatinController,
                                        textChange: changeTextField,
                                        textFocusNote: txtLatinFocusNode,
                                        isMandatory: true,
                                        maxlines: 3),
                                    CheckBox().flutterToggleTab(
                                        index: isActive,
                                        listLabel: ["Active", "Not Active"],
                                        callbackselectedLabelIndex:
                                            change_isactive),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      });
                }),
                bottomNavigationBar: Visibility(
                    visible: isView,
                    child: BottomAppBar(
                        child: Container(
                      color: Colors.transparent,
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        elevation: 5,
                        highlightElevation: 10,
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            gradient: LinearGradient(
                              colors: <Color>[
                                Colors.green,
                                Colors.green,
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.all(10.0),
                          child: const Text(
                            "Save",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        onPressed: () async {
                          if (_key!.currentState!.validate()) {
                            _key!.currentState!.save();
                            SweetAlert.show(context,
                                subtitle: "please_wait",
                                style: SweetAlertStyle.loading);

                            var dataSave;
                            dataSave = isEdit
                                ? <dynamic, dynamic>{
                                    "arab": txtArabController.text,
                                    "name": txtNameController.text,
                                    "arti": txtArtiController.text,
                                    "latin": txtLatinController.text,
                                    "type_id" : txtTypeIdController.text,
                                    "is_active": isActive == 0 ? 1 : 0,
                                    "dt_updated": Fungsi().fmtDateTimeYearNow()
                                  }
                                : <dynamic, dynamic>{
                                  "arab": txtArabController.text,
                                    "name": txtNameController.text,
                                    "arti": txtArtiController.text,
                                    "type_id" : txtTypeIdController.text,
                                    "latin": txtLatinController.text,
                                    "is_active": isActive == 0 ? 1 : 0
                                  };
                            var where = isEdit
                                ? <dynamic, dynamic>{
                                    "id": int.parse(data.toString())
                                  }
                                : null;
                            print("prefix:" + txtTypeIdController.text);
                            print(dataSave.toString());
                            ApiUtilities().saveUpdateData(
                                context: context,
                                data: dataSave,
                                namaAPI: "masterdoa",
                                isEdit: isEdit,
                                where: where,
                                setState: setState);
                          } else {
                            setState(() {
                              autoValidate = true;
                            });
                          }
                        },
                      ),
                    )))));
      });
    }
  }
}
