import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
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


class ManageBankSampahDialog {
  GlobalKey<FormState>? _key;
  bool autoValidate = false;
  int id = 0;
  bool isAktif = true;
  final txtNamaController = TextEditingController();
  final txtAlamatController = TextEditingController();
  final txtPropinsiController = TextEditingController();
  final txtNamaFocusNode = FocusNode();
  final txtPropinsiFocusNode = FocusNode();
  final txtKotaFocusNode = FocusNode();
  final txtKecamatanFocusNode = FocusNode();
  final txtKelurahanFocusNode = FocusNode();
  final txtAlamatFocusNode = FocusNode();

  bool isFirst = true;

  /* combobox */
  dynamic propinsi;
  dynamic listPropinsi;
  dynamic kota;
  dynamic listKota;
  dynamic kecamatan;
  dynamic listKecamatan;
  dynamic kelurahan;
  dynamic listKelurahan;

  /* checkbox */
  int isActive = 0;

  Future<int> getUserId() async {
    return Prefs.getInt('userId');
  }

  Future<dynamic> getDataPropinsi() async {
              dynamic data;
              final dataPropinsi = await ApiUtilities().getGlobalParamNoLimit(namaApi: "propinsi");
                  return dataPropinsi["data"]["data"] ;
               }

  static const TextStyle linkStyle =  TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );

 /* list Up */
 

  Widget buildAddDialog(BuildContext context, sourceForm, dynamic data,
      bool isEdit, bool isView) {
    _key = GlobalKey();
    //listPropinsi=getDataPropinsi() ;

    if (data != null) {
      /* warna */
      // Color color = new Color(0x12345678);
      // String colorString = color.toString(); // Color(0x12345678)
      // String valueString =
      //     colorString.split('(0x')[1].split(')')[0]; // kind of hacky..
      // int value = int.parse(valueString, radix: 16);
      // Color otherColor = new Color(value);
/* end warna */
      //this.kebun = data;
      //id = data["id"];
      txtNamaController.text = data["bank_nama"];
      txtAlamatController.text=  data["prop_kode"];
     // txtEmail.text = data.email;
    } else {
      txtNamaController.text = '';
      txtAlamatController.text = '';
     // txtLastName.text = '';
    }

    return StatefulBuilder(builder: (context, setState) {
      /* call back */
      change_text(val) {}


      toggle1(val) {
        setState(() {
         // _obscureText1 = !val;
        });
      }

      toggle2(pil, val) {
        //setState(){
        print("pilihan=" + pil.toString() + " - value = " + val.toString());
        if (val) {
          //_obscureText2 = false;
        } else {
        //  _obscureText2 = true;
        }
        //}
      }

      // ignore: non_constant_identifier_names
      changeTextField(pil, val) {
        setState(() {
          print("pilihan=" + pil.toString() + " - value = " + val.toString());
        });
      }

      change_propinsi(val){
       setState((){
           propinsi = val;
       });
      }
      display_propinsi(val){
        return val['prop_nama'];
      }

      change_isactive(val){
        setState((){
          isActive = val;
        });
      }     /* end call back */

      /* list Up */
            listUP(label,BuildContext context) async {
        final res = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ListUpBankSamPahDialog(),
          ),
        );
        if (res != null) {
          setState(() {
            txtPropinsiController.text = res["prop_nama"];
          });
        }
      }

      onClearInputontroller(data) {
        setState(() {});
      }
      /* call back */

      return Form(
          key: _key,
          child: Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                leading:  IconButton(
                  icon:  const Icon(Icons.close, color: Colors.yellow),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: const Text(
                  "Manage Bank Sampah",
                ),
                centerTitle: true,
              ),
              body: StatefulBuilder(builder: (context, setState) {
                return 
                
                FutureBuilder(
        future: getDataPropinsi(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if(isFirst){
               listPropinsi = snapshot.data;
              propinsi = snapshot.data[0];
              isFirst=false;
            }
            return 
         
            //propinsi = snapshot.data[0];
            // tampilkan dvarata
             
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 10,
                    height: MediaQuery.of(context).size.height - 10,
                    padding: const EdgeInsets.all(10),
                    color: Colors.white,
                    child:  SingleChildScrollView(
                      child: Column(
                        children:  <Widget>[
                            TextBox().textboxWithBorderValidate(context,
                          label: "Nama Bank Sampah",
                          textController: txtNamaController,
                          textChange: changeTextField,
                          textFocusNote: txtNamaFocusNode,
                          ),
                          ListUp().listUpWithBorderValidate(context,
                          label: "Propinsi",
                          textController: txtPropinsiController,
                          textFocusNote: txtPropinsiFocusNode,
                          suffixIconOnPressed: listUP
                          ),
                          ListUp().listUpWithBorderValidate(context,
                          label: "Kota",
                          textController: txtPropinsiController,
                          textFocusNote: txtPropinsiFocusNode,
                          suffixIconOnPressed: listUP
                          ),
                          ListUp().listUpWithBorderValidate(context,
                          label: "Kecamatan",
                          textController: txtPropinsiController,
                          textFocusNote: txtPropinsiFocusNode,
                          suffixIconOnPressed: listUP
                          ),
                          ListUp().listUpWithBorderValidate(context,
                          label: "Kelurahan",
                          textController: txtPropinsiController,
                          textFocusNote: txtPropinsiFocusNode,
                          suffixIconOnPressed: listUP
                          ),
                          // ListUp().getListUpValidate(context,100,"Propinsi",txtPropinsiController,callBackShowDialog: listUP, onClearInputontroller: onClearInputontroller),
                          // DropDown().dropDownDbwithBorder(context,
                          // label: "Propinsi",
                          // value: propinsi,
                          // items:listPropinsi,
                          // display: display_propinsi,
                          // cbOnChage:  change_propinsi),
                            TextBox().textboxWithBorderValidate(context,
                          label: "Alamat",
                          textController: txtAlamatController,
                          textChange: changeTextField,
                          textFocusNote: txtAlamatFocusNode,
                          maxlines: 3
                          ),
                          CheckBox().flutterToggleTab(index: isActive,listLabel: ["Active","Not Active"],callbackselectedLabelIndex:change_isactive,isDisable:true),
                        ],
                      ),
                    ),
                  ),
                );
                 }
                 else {
            return Center (
                child: CircularProgressIndicator()
            );
          }
          });
              }),
              bottomNavigationBar: Visibility(
                  visible: isView,
                  child: BottomAppBar(
                      child: Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                    // ignore: deprecated_member_use
                    child: ElevatedButton(
                      // shape: const RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.all(
                      //     Radius.circular(15),
                      //   ),
                      // ),
                      // elevation: 5,
                      // highlightElevation: 10,
                      // textColor: Colors.white,
                      // padding: const EdgeInsets.all(0.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(15)),
                          gradient: LinearGradient(
                            colors: <Color>[
                              Theme.of(context).accentColor,
                              Theme.of(context).primaryColorDark,
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

  Future addRecord(bool isEdit, 
      BuildContext context) async {
//     bool isError = true;
//     ManageUserService profileService = new ManageUserService();
//     String vPassword = randomAlphaNumeric(6);
//     var res;
//     print('isedit=' + isEdit.toString());
//     SweetAlert.show(context,
//         subtitle: AppLocalizations.of(context)
//             .translate('app_please_wait')
//             .toString(),
//         style: SweetAlertStyle.loading);
//     if (isEdit) {
//       var dataRegister = <dynamic, dynamic>{
//         'id': id,
//         'name': txtUserName.text.toString(),
//         'email': txtEmail.text.toString(),
//         'isAktif': isAktif ? '1' : '0',
//       };
//       print('username=' + dataRegister.toString());
//       res = await profileService.update(dataRegister);
//     } else {
//       int ownerId = Prefs.getInt('ownerId');
//       var dataRegister = <dynamic, dynamic>{
//         'name': txtUserName.text.toString(),
//         'email': txtEmail.text.toString(),
//         'role': 'Staff',
//         'isAktif': '1',
//         'isUnlimited': Prefs.getInt('isUnlimited').toString(),
//         'expired_date': Prefs.getString('expiredDate'),
//         'owner_id': ownerId.toString(),
//         'password': vPassword,
//         'c_password': vPassword,
//       };
//       print('username=' + dataRegister.toString());
//       res = await profileService.insert(dataRegister);
//     }

//     String msg = "";
//     print(res.toString());
//     switch (res.toString()) {
//       case "200":
//         {
//           msg = "Data has been saved";
//           isError = false;
//         }
//         break;
//       case "201":
//         {
//           msg = "Data has been saved";
//           isError = false;
//         }
//         break;

//       case "400":
//         {
//           msg = "Username/email address is already exist";
//         }
//         break;

//       case "500":
//         {
//           msg = "Email address is already exist";
//         }
//         break;

//       default:
//         {
//           msg = "Data has not been saved, please check your connection";
//         }
//         break;
//     }
//     print("result = " + res.toString());
//     //YToast.show(context: context, msg: msg);
//     if (isError) {
//       SweetAlert.show(context,
//           subtitle: msg, style: SweetAlertStyle.loadingerror);
//       new Future.delayed(new Duration(seconds: 2), () {
//         Navigator.pop(context);
//         //setState(() {});
//       });
//     } else {
// /* send email */
//       if (isEdit) {
//         SweetAlert.show(
//           context,
//           subtitle: "Data berhasil disimpan",
//           style: SweetAlertStyle.success,
//           onPress: (isConfirm) {
//             Navigator.of(context).pop();
//             //Navigator.of(context).pop();
//           },
//         );
//       } else {
//         var res = await YEmail.send2(
//             txtEmail.text.toString(),
//             '[No Reply] - Email Login dan Password',
//             "<p>Email login dan password anda adalah :</p><p>Email : " +
//                 txtEmail.text.toString() +
//                 " </p><p>password : " +
//                 vPassword +
//                 "</p>");
//         print('email=' + res.toString());
//         if (res == "success") {
//           SweetAlert.show(
//             context,
//             title: "Data berhasil disimpan",
//             subtitle:
//                 "Username dan Password telah dikirimkan\nmelalui email anda",
//             style: SweetAlertStyle.success,
//             onPress: (isConfirm) {
//               Navigator.of(context).pop();
//               //Navigator.of(context).pop();
//             },
//           );
//         } else {
//           SweetAlert.show(
//             context,
//             title: "Data berhasil disimpan",
//             subtitle:
//                 "Tidak dapat mengirimkan password melalui email,\nPastikan email yang didaftarkan valid.",
//             style: SweetAlertStyle.success,
//             onPress: (isConfirm) {
//               Navigator.of(context).pop();
//               //Navigator.of(context).pop();
//             },
//           );
//         }
//       }

//       /* end send email */
//     }
  }
}
