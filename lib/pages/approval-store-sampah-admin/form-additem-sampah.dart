import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:doa/pages/listups/listup-barang.dart';
import 'package:doa/pages/listups/listupt-bank-sampah..dart';
import 'package:doa/utils/api-utility.dart';
import 'package:doa/utils/api.dart';
import 'package:doa/utils/function.dart';
import 'package:doa/utils/pref_manager.dart';
import 'package:doa/widgets/checkbox.dart';
import 'package:doa/widgets/detail-item.dart';
import 'package:doa/widgets/dropdown.dart';
import 'package:doa/widgets/listup.dart';
import 'package:doa/widgets/textbox.dart';
import 'package:sweetalert/sweetalert.dart';


class AddItemSampahDialog {
  GlobalKey<FormState>? _key;
  bool autoValidate = false;
  int id = 0;
  bool isAktif = true;
  int barangId=0;
  String barangKode ="";
  double barangHarga =0.00;
  String satuan="";
  double qty = 0.00;

  final txtNamaBarangController = TextEditingController();
  final txtNamaBarangFocusNode = FocusNode();

  final txtQtyController = TextEditingController();
  final txtQtyFocusnode = FocusNode();

  final txtHargaBeliController = TextEditingController();
  final txtHargaBeliFocusnode = FocusNode();

    final txtTotalController = TextEditingController();
  final txtTotalFocusnode = FocusNode();

  final txtKeteranganController = TextEditingController();
  final txtKeteranganFocusnode = FocusNode();



  bool isFirst = true;
  bool isNewData = false;

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
              final dataPropinsi = await ApiUtilities().getGlobalParamNoLimit(namaApi: "barang");
                  return dataPropinsi["data"]["data"] ;
               }

  static const TextStyle linkStyle =  TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );

 /* list Up */
 

  Widget buildAddDialog({BuildContext? context, sourceForm, List<dynamic>? data, index,
      bool? isEdit, bool isView=true}) {
    _key = GlobalKey();
    //listPropinsi=getDataPropinsi() ;



    if (isEdit!) {
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
      id =data?[index]["id"];
      print("id="+id.toString());
      barangKode=data?[index]["barang_nama"];
      barangHarga=data?[index]["harga_beli"];
      qty = data?[index]["qty"];
      barangId=data?[index]["barang_id"];
      txtNamaBarangController.text = data?[index]["barang_nama"];
      txtKeteranganController.text=  data?[index]["keterangan"];
      txtHargaBeliController.text=  Fungsi().format(barangHarga,  isInteger: false);
      txtQtyController.text = Fungsi().format(qty,  isInteger: false);
      txtTotalController.text = Fungsi().format(qty * barangHarga,  isInteger: false); 
      satuan =data?[index]["satuan"];
      isNewData=data?[index]["isEdit"];
     // txtEmail.text = data.email;
    } else {
      txtNamaBarangController.text = '';
      txtKeteranganController.text = '';
       txtHargaBeliController.text="0.00";
      txtQtyController.text ="0.00";
      txtTotalController.text = "0.00";
      satuan="";
     // txtLastName.text = '';
    }

    return StatefulBuilder(builder: (context, setState) {
      /* call back */

      // ignore: non_constant_identifier_names
      changeTextField(pil, val) {
        setState(() {
          if(pil == "Qty"){
            qty = double.parse(Fungsi().fmtStringToInt(val).toString());
            
            txtTotalController.text = Fungsi().format(barangHarga * double.parse(Fungsi().fmtStringToInt(val).toString()),  isInteger: false); //(barangHarga * double.parse(val.toString())).toString();
          }
          print("pilihan=" + pil.toString() + " - value = " + val.toString());
        });
      }


   /* end call back */

      /* list Up */
            listUP(label,BuildContext context) async {
        final res = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ListUpBarangPage(),
          ),
        );
        if (res != null) {
          setState(() {
            barangKode = res["barang_kode"];
            barangId =int.parse(res["id"]);
            txtNamaBarangController.text = res["barang_nama"];
            txtHargaBeliController.text = Fungsi().format(double.parse(res["harga_beli"]),  isInteger: false); 
            barangHarga = double.parse(res["harga_beli"]);
            satuan =res["satuan"];
          });
        }
      }

      onClearInputontroller(data) {
        setState(() {});
      }
      /* call back */

      /* detail */
      callBackAddData (List<dynamic>  s){
        Map<String, dynamic> json = {
    "barang_id": barangId,
    "nama_barang":txtNamaBarangController.text,
    "value": true,
 };
 setState((){
s.add(json);
 });


      }

      // callBackDelete (isAPI,index) {
      //   // setState(() {
      //   //   print("id="+dataDetails[index]["id"].toString());
      //   //           dataDetails
      //   //               .removeWhere((item) => item["id"] == dataDetails[index]["id"]);
      //   //          });
      //   if(isAPI){
      //     Navigator.pop(context);
      //   }
      // }

      // callBackView(data){

      // }

      //  isiWidget(index) {
      //   return Column(
      //     children: [
      //       Container(
      //         child: Text(dataDetails[index]["label"]),
      //       )
      //     ],
      //   );
      // }

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
                  "Add Detail Item",
                ),
                centerTitle: true,
              ),
              body: StatefulBuilder(builder: (context, setState) {
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

                          ListUp().listUpWithBorderValidate(context,
                          label: "Item Barang",
                          textController: txtNamaBarangController,
                          textFocusNote: txtNamaBarangFocusNode,
                          suffixIconOnPressed: listUP
                          ),
                          TextBox().textboxWithBorderValidate(context,
                          label: "Qty",
                          textController: txtQtyController,
                          textChange: changeTextField,
                          textFocusNote: txtQtyFocusnode,
                          isNumber: true,
                          textSuffix: " "+satuan
                          ),
                          TextBox().textboxWithBorderValidate(context,
                          label: "Harga",
                          textController: txtHargaBeliController,
                          textChange: changeTextField,
                          textFocusNote: txtHargaBeliFocusnode,
                          isNumber: true,
                          textSuffix: " /"+satuan,
                          isReadOnly: true
                          ),
                          TextBox().textboxWithBorderValidate(context,
                          label: "Total",
                          textController: txtTotalController,
                          textChange: changeTextField,
                          textFocusNote: txtTotalFocusnode,
                          isNumber: true,
                          isReadOnly: true
                          ),
                          TextBox().textboxWithBorderValidate(context,
                          label: "Keterangan",
                          textController: txtKeteranganController,
                          textChange: changeTextField,
                          textFocusNote: txtKeteranganFocusnode,
                          isMandatory: false,
                          maxlines: 3
                          ),
                        ],
                      ),
                    ),
                  ),
                );
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
                        if (_key!.currentState!.validate())  {
                          _key!.currentState!.save();
                            Map<String, dynamic> json;
                            if(isEdit){
                            json =  {
                              "id":id,
                              "barang_id": barangId,
                              "barang_kode": barangKode,  
                              "barang_nama": txtNamaBarangController.text,
                              "satuan": satuan, 
                              "harga_beli": barangHarga,
                              "qty": qty,
                              "keterangan":txtKeteranganController.text,
                              "isEdit" : isNewData,
                              "isChanged": true 
                              };
                            }
                            else{
                              json =  {
                              "barang_id": barangId,
                              "barang_kode": barangKode,  
                              "barang_nama": txtNamaBarangController.text,
                              "satuan": satuan, 
                              "harga_beli": barangHarga,
                              "qty": qty,
                              "keterangan":txtKeteranganController.text,
                              "isEdit" : false,
                              "isChanged": false
                              };
                            }
                              print(json.toString());
                          Navigator.of(context).pop(json);
                          
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
