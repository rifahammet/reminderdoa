import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:doa/pages/listups/listupt-bank-sampah..dart';
import 'package:doa/utils/api-utility.dart';
import 'package:doa/utils/api.dart';
import 'package:doa/utils/email_util.dart';
import 'package:doa/utils/function.dart';
import 'package:doa/utils/pref_manager.dart';
import 'package:doa/widgets/checkbox.dart';
import 'package:doa/widgets/dropdown.dart';
import 'package:doa/widgets/listup.dart';
import 'package:doa/widgets/textbox.dart';
import 'package:sweetalert/sweetalert.dart';

class UserPageDialog {
  GlobalKey<FormState>? _key;
  bool autoValidate = false;
  int id = 0;
  bool isAktif = true;
  bool approved_email = false;
  bool isDaftarBaru = false;
  String username = "";
  String passwordDefault = "";
  int isActiveLama = 0;
  final txtNameController = TextEditingController();
  final txtEmailController = TextEditingController();
  final txtPropinsiNamaController = TextEditingController();
  final txtHpController = TextEditingController();
  final txtKecamatanNamaController = TextEditingController();
  final txtKotaNamaController = TextEditingController();

  final txtNameFocusNode = FocusNode();
  final txtEmailFocusNode = FocusNode();
  final txtPropinsiFocusNode = FocusNode();
  final txtkotaFocusNode = FocusNode();
  final txtKecatamanFocusNode = FocusNode();
  final txtHpFocusNode = FocusNode();

  bool isFirst = true;

  /* checkbox */
  int isApproved = 0;
  bool isApprovedOption = false;

  Future<int> getUserId() async {
    return Prefs.getInt('userId');
  }

  Future<dynamic> getData(isEdit, data) async {
    if (isEdit) {
      final vData = await ApiUtilities()
          .getGlobalParamNoLimit(namaApi: "signup", where: {"id": data});
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
          // final res = await Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => ListUpCategoriBarangPage(),
          //   ),
          // );
          // if (res != null) {
          //   setState(() {
          //     txtKecamatanNamaController.text = res["kategori_nama"];
          //     txtKotaNamaController.text = res["id"];
          //   });
          // }
        }

        // ignore: non_constant_identifier_names
        changeTextField(pil, val) {
          setState(() {
            print("pilihan=" + pil.toString() + " - value = " + val.toString());
          });
        }

        change_isApproved(val) {
          setState(() {
            isApproved = val;
          });
        } /* end call back */

        /* call back */

        return Form(
            key: _key,
            child: Scaffold(
                resizeToAvoidBottomInset: true,
                appBar: AppBar(
                  backgroundColor: Colors.green,
                  leading: IconButton(
                    icon: const Icon(Icons.close, color: Colors.yellow),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  title: const Text(
                    "Data User",
                  ),
                  centerTitle: true,
                ),
                body: StatefulBuilder(builder: (context, setState) {
                  return FutureBuilder(
                      future: getData(isEdit, data),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          if (isFirst) {
                            if (isEdit) {
                              txtNameController.text =
                                  snapshot.data["user_fullname"];
                              txtEmailController.text =
                                  snapshot.data["email"];
                              txtPropinsiNamaController.text =
                                  snapshot.data["prop_nama"];
                              txtKotaNamaController.text =
                                  snapshot.data["kota_nama"];
                              txtKecamatanNamaController.text =
                                  snapshot.data["kec_nama"];
                              txtHpController.text =
                                  snapshot.data["hp"];
                              isApproved =
                                  int.parse(snapshot.data["isActive"]) == 1
                                      ? 0
                                      : 1;
                              isActiveLama = isApproved;
                              isApprovedOption =
                                  int.parse(snapshot.data["daftar_baru"]) == 1
                                      ? false
                                      : true;

                              approved_email =
                                  int.parse(snapshot.data["approved_email"]) ==
                                          1
                                      ? true
                                      : false;
                                      isDaftarBaru =int.parse(snapshot.data["daftar_baru"]) ==
                                          1
                                      ? true
                                      : false;
                              username = snapshot.data["email"];
                              passwordDefault =
                                  snapshot.data["password_default"];
                            } else {
                              txtNameController.text = "";
                              txtEmailController.text = "";
                              txtPropinsiNamaController.text = "";
                              txtKotaNamaController.text = "";
                              txtKecamatanNamaController.text = "";
                              txtHpController.text = "";
                              isApproved = 0;
                              isApprovedOption = false;
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
                                    TextBox().textboxWithBorderValidate(context,
                                        label: "Nama User",
                                        textController: txtNameController,
                                        textChange: changeTextField,
                                        textFocusNote: txtNameFocusNode,
                                        isReadOnly: true),
                                    TextBox().textboxWithBorderValidate(context,
                                        label: "Email",
                                        textController: txtEmailController,
                                        textChange: changeTextField,
                                        textFocusNote: txtEmailFocusNode,
                                        isReadOnly: true),
                                    TextBox().textboxWithBorderValidate(context,
                                        label: "HP",
                                        textController:
                                            txtHpController,
                                        textChange: changeTextField,
                                        textFocusNote: txtHpFocusNode,
                                        isMandatory: false,
                                        isReadOnly: true),
                                    TextBox().textboxWithBorderValidate(context,
                                        label: "Propinsi",
                                        textController:
                                            txtPropinsiNamaController,
                                        textChange: changeTextField,
                                        textFocusNote: txtPropinsiFocusNode,
                                        isReadOnly: true,
                                        isMandatory: false),
                                    // ListUp().listUpWithBorderValidate(context,
                                    //     label: "Prop_kode",
                                    //     textController:
                                    //         txtKecamatanNamaController,
                                    //     textFocusNote: txtKategoriNamaFocusNode,
                                    //     suffixIconOnPressed: listUP),

                                    // DropDown().dropDownDbwithBorder(context,
                                    // label: "Kategori Barang",
                                    // value: barang,
                                    // items:listBarang,
                                    // display: display_barang,
                                    // cbOnChage:  change_barang),
                                    TextBox().textboxWithBorderValidate(context,
                                        label: "Kota",
                                        textController: txtKotaNamaController,
                                        textChange: changeTextField,
                                        textFocusNote: txtkotaFocusNode,
                                        isReadOnly: true, isMandatory: false),

                                    // TextBox().textboxWithBorderValidate(context,
                                    //     label: "Kecamatan",
                                    //     textController:
                                    //         txtKecamatanNamaController,
                                    //     textChange: changeTextField,
                                    //     textFocusNote: txtHpFocusNode,
                                    //     isMandatory: false,
                                    //     isReadOnly: true),
                                    TextBox().textboxWithBorderValidate(context,
                                        label: "HP",
                                        textController:
                                            txtHpController,
                                        textChange: changeTextField,
                                        textFocusNote: txtHpFocusNode,
                                        isMandatory: false,
                                        isReadOnly: true),
                                    CheckBox().flutterToggleTab(
                                        index: isApproved,
                                        
                                        listLabel: ["Aktif", "Tidak Aktif"],
                                        width: 60.0,
                                        isActive: false,
                                        callbackselectedLabelIndex:
                                            change_isApproved),
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
                        style: ButtonStyle(
    elevation: MaterialStateProperty.all(5),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  ),
                      padding: MaterialStateProperty.all(EdgeInsets.all(0.0))),
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
                            var dataSave = <dynamic, dynamic>{
                              "id": int.parse(data.toString()),
                              "isActive": isApproved == 0 ? 1 : 0
                            };
                            ApiUtilities().saveUpdateData(
                                    context: context,
                                    data: dataSave,
                                    namaAPI: "signup",
                                    isEdit: true,
                                    setState: setState);
                            // var bodyEmail;
                            // if (!approved_email) {
                            //   bodyEmail =
                            //       "<p>Account anda sudah diaktifkan dan dapat digunakan.</p><p>user name login dan password anda adalah :</p><p>User Name : " +
                            //           username +
                            //           " </p><p>password : " +
                            //           passwordDefault +
                            //           "</p><p>Terima kasih.</p>";
                            // } else {
                            //   if (isApproved != isActiveLama) {
                            //     if (isApproved == 1) {
                            //       bodyEmail =
                            //           "<p>Account anda sudah diaktifkan dan dapat digunakan kembali.</p><p>Terima kasih.</p>";
                            //     } else {
                            //       bodyEmail =
                            //           "<p>Account anda sudah dinonaktifkan.</p><p>Silahkan menghubungi administrator</p>";
                            //     }
                            //   }
                            // }
                            // callBackEmail(isSended) async {
                            //   if (isSended) {
                            //     print('data save='+dataSave.toString());
                            //     print(isEdit.toString());
                            //     ApiUtilities().saveUpdateData(
                            //         context: context,
                            //         data: dataSave,
                            //         namaAPI: "signup",
                            //         isEdit: isEdit,
                            //         setState: setState);
                            //   } else {
                            //     SweetAlert.show(
                            //       context,
                            //       title: "Warning",
                            //       subtitle:
                            //           "Terjadi kesalahan pada saat kirim data, silahkan tekan tombol save kembali",
                            //       style: SweetAlertStyle.loadingerror,
                            //     );
                            //     await Future.delayed(new Duration(seconds: 3),
                            //         () {
                            //       Navigator.of(context).pop();
                            //     });
                            //   }
                            // }

                            // if (!approved_email) {
                            //   EmailUtility().kirimEmail(
                            //       context: context,
                            //       alamatEmail: 'wawansatriani.wd@gmail.com',
                            //       bodyEmail: bodyEmail,
                            //       isEmailOnly: false,
                            //       isNoReply: true,
                            //       judulEmail: "Approval Aplikasi Doa",
                            //       callBack: callBackEmail);
                            // } else {
                            //   if (isApproved != isActiveLama) {
                            //     if (isApproved == 0) {
                            //     EmailUtility().kirimEmail(
                            //         context: context,
                            //         alamatEmail: 'wawansatriani.wd@gmail.com',
                            //         bodyEmail: bodyEmail,
                            //         isEmailOnly: false,
                            //         isNoReply: true,
                            //         judulEmail: "Approval Aplikasi Doa",
                            //         callBack: callBackEmail);
                            //   } else {
                            //     ApiUtilities().saveUpdateData(
                            //         context: context,
                            //         data: dataSave,
                            //         namaAPI: "signup",
                            //         isEdit: isEdit,
                            //         setState: setState);
                            //   }
                            //   } else {
                            //     ApiUtilities().saveUpdateData(
                            //         context: context,
                            //         data: dataSave,
                            //         namaAPI: "signup",
                            //         isEdit: isEdit,
                            //         setState: setState);
                            //   }
                            // }
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
