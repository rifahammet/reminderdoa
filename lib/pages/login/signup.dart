import 'dart:async';
import 'package:date_format/date_format.dart';
import 'package:doa/utils/email_util.dart';
import 'package:doa/widgets/datepicker.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:doa/pages/listups/listup-kecamatan.dart';
import 'package:doa/pages/listups/listup-kelurahan.dart';
import 'package:doa/pages/listups/listup-kota.dart';
import 'package:doa/pages/listups/listup-propinsi.dart';
import 'package:doa/pages/login/login.dart';
import 'package:doa/utils/api-utility.dart';
import 'package:doa/utils/api.dart';
import 'package:doa/utils/function.dart';
import 'package:doa/widgets/dropdown.dart';
import 'package:doa/widgets/listup.dart';
import 'package:doa/widgets/textbox.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';
// import 'package:easy_localization/easy_localization.dart';

class RegisterDialog {
  GlobalKey<FormState>? _key;
  bool autoValidate = false;
  String? tanggalLahir;
  final txtTanggalLahirController = TextEditingController();
  final txtNamaController = TextEditingController();
  final txtUserNameController = TextEditingController();
  final txtBankNameController = TextEditingController();
  final txtAddressController = TextEditingController();
  final txtPhoneController = TextEditingController();
  final txtEmailController = TextEditingController();
  final txtPropinsiNamaController = TextEditingController();
  final txtKotaNamaController = TextEditingController();
  final txtKecamatanNamaController = TextEditingController();
  final txtKelurahanNamaController = TextEditingController();
  final txtPropinsiKodeController = TextEditingController();
  final txtKotaKodeController = TextEditingController();
  final txtKecamatanKodeController = TextEditingController();
  final txtKelurahanKodeController = TextEditingController();

  final txtNamaFocusNode = FocusNode();
  final txtUserNameFocusNode = FocusNode();
  final txtBankNameFocusNode = FocusNode();
  final txtAddressFocusNode = FocusNode();
  final txtPhoneFocusNode = FocusNode();
  final txtEmailFocusNode = FocusNode();
  final txtPropinsiNamaFocusNode = FocusNode();
  final txtKotaNamaFocusNode = FocusNode();
  final txtKecamatanNamaFocusNode = FocusNode();
  final txtKelurahanNamaFocusNode = FocusNode();

  String lokasi = 'Jakarta';
  dynamic propinsi;
  dynamic listSeafood;
  bool isFirst = true;

  Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId');
  }

  Future<dynamic> getDataPropinsi() async {
    final dataPropinsi =
        await Fungsi().fetchData(url: Api.BASE_URL + "propinsi");
    return dataPropinsi["data"];
  }

  Widget buildAddDialog(BuildContext context, _myHomePageState, bool isView) {
    _key = GlobalKey();
    txtBankNameController.text = '';
    txtAddressController.text = '';
    txtPhoneController.text = '';
    txtUserNameController.text = '';
    txtEmailController.text = '';
    txtPropinsiNamaController.text = '';
    txtTanggalLahirController.text = formatDate(
                                  DateTime.now(), [dd, '-', mm, '-', yyyy]);
                              tanggalLahir = Fungsi().fmtDateTimeYearNow();

    // ignore: avoid_print
    return StatefulBuilder(builder: (context, setState) {
      listUPPropinsi(label, BuildContext context) async {
        print(label);
        final res = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ListUpPropinsiDialog()),
        );
        setState(() {
          if (res != null) {
            txtPropinsiNamaController.text = res["prop_nama"];
            txtPropinsiKodeController.text = res["prop_kode"];
          }
        });
      }

      listUPKota(label, BuildContext context) async {
        // ignore: prefer_typing_uninitialized_variables
        print(txtPropinsiKodeController.text);
        final res = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ListUpKotaDialog(
                    propinsi_kode: txtPropinsiKodeController.text,
                  )),
        );
        setState(() {
          if (res != null) {
            txtKotaNamaController.text = res["kota_nama"];
            txtKotaKodeController.text = res["kota_kode"];
          }
        });
      }

      listUPKecamatan(label, BuildContext context) async {
        // ignore: prefer_typing_uninitialized_variables
        final res = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ListUpKecamatanDialog(
                    kota_kode: txtKotaKodeController.text,
                  )),
        );

        if (res != null) {
          txtKecamatanNamaController.text = res["kec_nama"];
          txtKecamatanKodeController.text = res["kec_kode"];
        }
      }

      listUPKelurahan(label, BuildContext context) async {
        // ignore: prefer_typing_uninitialized_variables
        final res = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ListUpKelurahanDialog(
                    kecamatan_kode: txtKecamatanKodeController.text,
                  )),
        );

        if (res != null) {
          txtKelurahanNamaController.text = res["kel_nama"];
          txtKelurahanKodeController.text = res["kel_kode"];
        }
      }

displayTanggallahir(formatDate, formatYear) {
          setState(() {
            tanggalLahir = formatYear.toString();
            txtTanggalLahirController.text = formatDate.toString();
            print('tanggal=' + formatDate.toString());
          });
        }

      changeTextField(pil, val) {
        setState(() {});
      }

      change_propinsi(val) {
        setState(() {
          propinsi = val;
        });
      }

      display_propinsi(val) {
        return val['prop_nama'];
      }

      change_lokasi(val) {
        setState(() {
          lokasi = val;
        });
      }

        callBackButton(data) async {
                            SweetAlert.show(context,
                                subtitle: "please_wait",
                                style: SweetAlertStyle.loading);
                            var bodyEmail;
                              bodyEmail =
                                  "<p>Account anda sudah diaktifkan dan dapat digunakan.</p><p>user name login dan password anda adalah :</p><p>User Name : " +
                                      data['email'].toString() +
                                      " </p><p>password : " +
                                      data['password_default'].toString() +
                                      "</p><p>Silahkan login menggunakan username dan password tersebut. Terima kasih.</p>";
                            callBackEmail(isSended) async {
                              if (isSended) {
                                print('data save='+data.toString());
                               // print(isEdit.toString());
                                ApiUtilities().saveUpdateData(
                                    context: context,
                                    data: data,
                                    namaAPI: "signup",
                                    isEdit: false,
                                    setState: setState,
                                  isMoreHide: true);
                              } else {
                                SweetAlert.show(
                                  context,
                                  title: "Warning",
                                  subtitle:
                                      "Terjadi kesalahan pada saat kirim data, silahkan tekan tombol save kembali",
                                  style: SweetAlertStyle.loadingerror,
                                );
                                await Future.delayed(new Duration(seconds: 3),
                                    () {
                                  Navigator.of(context).pop();
                                });
                              }
                            }
                              EmailUtility().kirimEmail(
                                  context: context,
                                  alamatEmail: data['email'].toString(),
                                  bodyEmail: bodyEmail,
                                  isEmailOnly: false,
                                  isNoReply: true,
                                  judulEmail: "Validasi Aplikasi Doa",
                                  callBack: callBackEmail);
  }
      /* end call back */

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
                title:  Text("Pendaftaran User"),
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
                // return
                // FutureBuilder(
                //   future: getDataPropinsi(),
                //   builder: (context, AsyncSnapshot snapshot) {
                //     if (snapshot.hasData) {
                //       if (isFirst) {
                //         listSeafood = snapshot.data;
                //         propinsi = snapshot.data[0];
                //         isFirst = false;
                //       }
                //propinsi = snapshot.data[0];
                // tampilkan dvarata
                return Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 10,
                    height: MediaQuery.of(context).size.height - 40,
                    padding: EdgeInsets.all(20),
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          TextBox().textboxWithBorderValidate(
                            context,
                            label: "Nama Lengkap",
                            textController: txtBankNameController,
                            textChange: changeTextField,
                            textFocusNote: txtBankNameFocusNode,
                          ),
                          ListUp().listUpWithBorderValidate(context,
                              label: "Propinsi",
                              textController: txtPropinsiNamaController,
                              textFocusNote: txtPropinsiNamaFocusNode,
                              suffixIconOnPressed: listUPPropinsi),
                          ListUp().listUpWithBorderValidate(context,
                              label: "Kota/Kab.",
                              textController: txtKotaNamaController,
                              textFocusNote: txtKotaNamaFocusNode,
                              suffixIconOnPressed: listUPKota),
                          DatePicker().datePickerBorder(
                                      context,
                                      textController:
                                          txtTanggalLahirController,
                                      label: "Tanggal Lahir" + " *",
                                      fungsiCallback: displayTanggallahir,
                                      formatDate: tanggalLahir,
                                      
                                    ),
                          TextBox().textboxWithBorderValidate(context,
                              label: "Email",
                              textController: txtEmailController,
                              textChange: changeTextField,
                              textFocusNote: txtEmailFocusNode,
                              isEmail: true),
                          TextBox().textboxWithBorderValidate(context,
                              label: "Nomor Handphone",
                              textController: txtPhoneController,
                              textChange: changeTextField,
                              textFocusNote: txtPhoneFocusNode,
                              isMandatory: true),
                              SizedBox(height: 5,),
                              Padding(padding: EdgeInsets.only(left: 10,right: 10), child:
                              Container(
                              
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.red[100],
                        border: Border.all(
                          color: Colors.red,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(children: [
Text(
                        '*** Perhatian ***',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red[900],fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 3,),
                      Text(
                        'User Name dan Password dikirim melalui email anda',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.red[900]),
                      ),
                      ],)
                      
                    ))
                          // const Divider(
                          //   thickness: 1.0,
                          // ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          // TextBox().textboxWithBorderValidate(
                          //   context,
                          //   label: "User Name",
                          //   textController: txtUserNameController,
                          //   textChange: changeTextField,
                          //   textFocusNote: txtUserNameFocusNode,
                          // ),

                        
                          
                          
                          // ListUp().listUpWithBorderValidate(context,
                          //     label: "Kecamatan",
                          //     textController: txtKecamatanNamaController,
                          //     textFocusNote: txtKecamatanNamaFocusNode,
                          //     suffixIconOnPressed: listUPKecamatan),
                          // ListUp().listUpWithBorderValidate(context,
                          //     label: "Kelurahan",
                          //     textController: txtKelurahanNamaController,
                          //     textFocusNote: txtKelurahanNamaFocusNode,
                          //     suffixIconOnPressed: listUPKelurahan),
                          // TextBox().textboxWithBorderValidate(context,
                          //     label: "Alamat",
                          //     textController: txtAddressController,
                          //     textChange: changeTextField,
                          //     textFocusNote: txtAddressFocusNode,
                          //     maxlines: 3),

                          //DropDown().dropDownwithBorder(context,label: "Lokasi",items: ["Jakarta","Bogor","Depok","Tangerang","Bekasi"],value: lokasi, cbOnChage:change_lokasi )
                        ],
                      ),
                    ),
                  ),
                );
                //     } else {
                //       return Center(child: CircularProgressIndicator());
                //     }
                //   },
                // );
              }),
              bottomNavigationBar: Visibility(
                  visible: isView,
                  child: BottomAppBar(
                      child: Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
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
                              Colors.black87,
                            ],
                          ),
                        ),
                        padding: EdgeInsets.all(10.0),
                        child:  Text(
                          "Daftar",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      onPressed: () async {
                        if (_key!.currentState!.validate()) {
                          _key!.currentState!.save();
                              SweetAlert.show(context,
        subtitle: "please_wait", style: SweetAlertStyle.loading);
        String vPassword = randomAlphaNumeric(5);
    // var dataSave = <dynamic, dynamic>{
    //             "user_password": Fungsi().strToMD5(vPassword).substring(0, 25).toString(),
    //             "user_fullname" : txtBankNameController.text,
    //             "password_default": vPassword,
    //             "hp" : txtPhoneController.text,
    //             "email" : txtEmailController.text,
    //             "birthday" : tanggalLahir,
    //             "prop_kode" : txtPropinsiKodeController.text,
    //             "kota_kode" : txtKotaKodeController.text,
    //             "user_type" : "user"
      
    // };
    var dataSave = <dynamic, dynamic>{
                "user_password": Fungsi().strToMD5(vPassword).toString(),
                "user_fullname" : txtBankNameController.text,
                "password_default": vPassword,
                "hp" : txtPhoneController.text,
                "email" : txtEmailController.text,
                "birthday" : tanggalLahir,
                "prop_kode" : txtPropinsiKodeController.text,
                "kota_kode" : txtKotaKodeController.text,
                "user_type" : "user",
                "approved": 1,
                "approved_email": 1,
                "daftar_baru" : 0,
                "isActive": 1,
      
    };
    callBackButton(dataSave);
    // ApiUtilities().saveUpdateData(
    //                             context: context,
    //                             data: dataSave,
    //                             namaAPI: "signup",
    //                             isEdit: false,
    //                             setState: setState);
                          // Navigator.of(context).pop();
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
