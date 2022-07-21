import 'dart:convert';

import 'package:doa/pages/login/forgot-password.dart';
import 'package:doa/widgets/label.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:doa/pages/change_password/change_password.dart';
import 'package:doa/pages/dashboard.dart';
import 'package:doa/pages/login/signup.dart';
import 'package:doa/utils/api-utility.dart';
import 'package:doa/utils/function.dart';
import 'package:doa/utils/pref_manager.dart';
import 'package:doa/widgets/blury-container.dart';
import 'package:doa/widgets/button.dart';
import 'package:doa/widgets/textbox.dart';
import 'package:flutter/rendering.dart';
// import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:sweetalert/sweetalert.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPagePageState();
  }
}

class _LoginPagePageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  //TabController controller; //tab控制器
  final txtEmail = TextEditingController();
  final txtPassword = TextEditingController();
  var tabs = <Tab>[];
  String btnText = "Login";
  String bottomText = "Tidak punya akun? Daftar";
  bool visible = true;
  final GlobalKey<FormState> _key = GlobalKey();
  bool autoValidate = false;
  String username = '', password = '', rePassword = '';
  bool obscureText = true;
  IconData icon = Icons.visibility;

  double nWidth = 0.0;
  double nHeight = 0.0;

  @override
  void initState() {
    super.initState();
  }

  suffixIconIconOnPressed(value) {
    setState(() {
      obscureText = !value;
      icon = !value ? Icons.visibility : Icons.visibility_off;
    });
  }

  changeTextField(pil, val) {
    setState(() {});
  }

  Future openAddDialog(isRegister) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => isRegister
          ? RegisterDialog().buildAddDialog(context, this, true)
          : ForgotPasswordDialog().buildAddDialog(context, this, true),
    );
  }

  void onPressedButton() async {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      ApiUtilities auth = ApiUtilities();
      print("password:" +
          Fungsi().strToMD5(txtPassword.text).substring(0, 25).toString());
      var data = <dynamic, dynamic>{
        "email": txtEmail.text.toString(),
        "user_password":
            Fungsi().strToMD5(txtPassword.text).substring(0, 25).toString(),
        "isActive": 1
      };
      //print("data login ="+data.toString());
      final dataUser =
          await auth.getGlobalParam(namaApi: "signup", where: data);
      //print("data user=" + dataUser.toString());
      bool isSukses = dataUser["isSuccess"] as bool;
      if (isSukses) {
        var dataUserLogged = dataUser["data"]["data"][0];
        print(dataUserLogged);
        bool isFirstLogged =
            dataUserLogged["isFirst"].toString().toLowerCase() == "1";

        if (dataUserLogged["user_type"].toString().toLowerCase() != "owner") {
          // bool bankAktif = dataUserLogged["bank_active"].toString().toLowerCase()=="1" ;
          // if (bankAktif) {
          Prefs.setString("user_type", dataUserLogged["user_type"]);
          Prefs.setBool("isLogged", true);
          Prefs.setBool("isSaving", false);
          Prefs.setBool("isFirstLogged", isFirstLogged);
          Prefs.setInt("userId", int.parse(dataUserLogged["id"].toString()));
          Prefs.setBool(
              "isExpired",
              int.parse(dataUserLogged["isExpired"].toString()) == 1
                  ? true
                  : false);
          //Fungsi().fmtDateYear(dataUserLogged["expired_date"]);
          Prefs.setString("expired_date",
              Fungsi().fmtDateYear(dataUserLogged["expired_date"]));
          Prefs.setBool("isRefresh", true);
          //Prefs.setInt("userLoginId", int.parse(dataUserLogged["user_login_id"].toString()));
          Prefs.setString("user_name", dataUserLogged["user_fullname"]);
          Prefs.setString("kota_kode", dataUserLogged["api_id"]);
          Prefs.setString("kota_nama", dataUserLogged["kota_nama"]);
          Prefs.setString("user_pass", txtPassword.text);
          // Prefs.setInt(
          //     "bank_id", int.parse(dataUserLogged["bank_id"].toString()));
          print("isFirstLogged=" + isFirstLogged.toString());
          if (isFirstLogged) {
            await showDialog(
              context: context,
              builder: (BuildContext context) => new ChangePasswordDialog()
                  .buildAddDialog(context, this, true, txtPassword.text),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashboardPage()),
            );
          }
          // } else {
          //   SweetAlert.show(
          //                   context,
          //                   subtitle:
          //                       'Bank Sampah is not active\nPlease contact administrator',
          //                   style: SweetAlertStyle.loadingerror,
          //                 );
          //                 Future.delayed(const Duration(seconds: 3), () {
          //                   setState(() {});
          //                   Navigator.pop(context);
          //                 });
          // }
        } else {
          Prefs.setString("user_type", dataUserLogged["user_type"]);
          Prefs.setBool("isLogged", true);
          Prefs.setBool("isFirstLogged", isFirstLogged);
          Prefs.setBool("isSaving", false);
          Prefs.setBool(
              "isExpired",
              int.parse(dataUserLogged["isExpired"].toString()) == 1
                  ? true
                  : false);
          Prefs.setString("expired_date",
              Fungsi().fmtDateYear(dataUserLogged["expired_date"]));
          Prefs.setInt("userId", int.parse(dataUserLogged["id"].toString()));
          Prefs.setString("user_name", dataUserLogged["user_fullname"]);
          Prefs.setString("kota_kode", dataUserLogged["api_id"]);
          Prefs.setString("kota_nama", dataUserLogged["kota_nama"]);
          Prefs.setString("user_pass", txtPassword.text);
          Prefs.setBool("isRefresh", true);
          //Prefs.setInt("userLoginId", int.parse(dataUserLogged["user_login_id"].toString()));
          if (isFirstLogged) {
            await showDialog(
              context: context,
              builder: (BuildContext context) => new ChangePasswordDialog()
                  .buildAddDialog(context, this, true, txtPassword.text),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashboardPage()),
            );
          }
        }
      } else {
        if (dataUser["error"] == "validation error") {
          SweetAlert.show(
            context,
            subtitle: 'User name is not registered\n please sign up first',
            style: SweetAlertStyle.loadingerror,
          );
          Future.delayed(const Duration(seconds: 3), () {
            setState(() {});
            Navigator.pop(context);
          });
        } else {
          SweetAlert.show(
            context,
            subtitle: dataUser["error_message"],
            style: SweetAlertStyle.loadingerror,
          );
          Future.delayed(const Duration(seconds: 3), () {
            setState(() {});
            Navigator.pop(context);
          });
        }
      }
    } else {
      setState(() {
        autoValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   primaryColor: Theme.of(context).primaryColor,
      //   accentColor: Theme.of(context).accentColor,
      //   primaryColorDark: Theme.of(context).primaryColorDark,
      // ),
      home: Container(
        decoration: BoxDecoration(
            // image: DecorationImage(image: AssetImage('assets/images/login-background2.png'), fit: BoxFit.cover),
            // gradient: LinearGradient(
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            //   colors: [
            //     Theme.of(context).accentColor,
            //     Theme.of(context).primaryColorDark,
            //   ],
            // ),
            ),
        child: Scaffold(backgroundColor: Colors.grey[300], body: getBodyView()
            // Stack(
            //   children: [
            //   Image.asset('assets/images/login-background2.png', fit: BoxFit.fitWidth,
            //               ),
            //               getBodyView()
            // ],)
            ),
      ),
    );
  }

  Widget getBodyView() {
    //可滑动布局，避免弹出键盘时会有溢出异常
    return ListView(
      children: <Widget>[
        Stack(
          children: [
            DecoratedBox(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage('assets/images/login-background2.png'),
                        fit: BoxFit.fill)),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                )),
            //     // Image.asset('assets/images/login-background2.png', fit: BoxFit.fill)

            //  ,

            Column(
              children: [
                const SizedBox(height: 220),
                //Text("Kumpulan",style: TextStyle(fontFamily: "Broadway",color: Colors.red[900],  fontWeight: FontWeight.bold, fontSize: 42,)),
                //Label().labelStatus(label: "Doa - Doa" , width: 150.0, fontsize: 36.0, fontfamily:  "brushscript"),

                // Padding(
                //   padding: const EdgeInsets.only(left: 70, right: 70),
                //   child: Image.asset('assets/images/doa_onboarding.png',
                //       height: 200, fit: BoxFit.fill),
                // ),
                const SizedBox(height: 20),
                Stack(alignment: Alignment.topCenter, children: <Widget>[
                  BluryWidget().bluryWidget(context,
                      padding: 20.0,
                      widgetBody: Form(
                          key: _key,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              TextBox().textBoxBorderedIconValidate(
                                context,
                                textName: "Nama User",
                                hint: "username_login".tr(),
                                textController: txtEmail,
                                textChange: changeTextField,
                                icon: Icons.person,
                              ),
                              TextBox().textBoxBorderedIconValidate(context,
                                  textName: "Password",
                                  hint: "password_login".tr(),
                                  obscureText: obscureText,
                                  icon: Icons.vpn_key,
                                  suffixIcon: icon,
                                  suffixIconIconOnPressed:
                                      suffixIconIconOnPressed,
                                  textController: txtPassword,
                                  textChange: changeTextField),
                              GestureDetector(
                                  onTap: () async {
                                    openAddDialog(false);
                                  },
                                  child: Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            "Lupa password ?",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ))))
                            ],
                          ))),
                ]),
                Button().raisedGradientButton(context,
                    label: "Masuk",
                    padding: 60.0,
                    labelColor: Colors.white,
                    onPressed: onPressedButton),
                SizedBox(
                  height: 5,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text("Belum mempunyai akun ? "),
                  GestureDetector(
                      onTap: () async {
                        openAddDialog(true);
                      },
                      child: Text("Daftar",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0)))
                ])
              ],
            )
          ],
        )
      ],
    );
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   controller.dispose();
  // }

  getUserLogin(email) async {
    // SettingService settingService = new SettingService();
    // final data = await settingService.getUser(email);
    // return data;
  }

  String validateUsername(String value) {
    if (value.isEmpty)
      return "Akun tidak boleh kosong";
    else //if (value.length < 5) return "Akun minimal harus 5";
      return "";
  }

  String validatePassword(String value) {
    if (value.isEmpty)
      return "Kata sandi tidak boleh kosong";
    else //if (value.length < 6) return "minimal harus 6";
      return "";
  }

  String validateRePassword(String value) {
    if (value.isEmpty)
      return "Kata sandi tidak boleh kosong";
    else //if (value.length < 6) return "minimal harus 6";
//    else if (value != password) return "两次密码不一致";
      return "";
  }

  Future doRequest() async {
    // var data;
    // try {
    //   Auth auth = new Auth();
    //   final result = await auth.getLogin(username, password);
    //   // print('result =' + result.toString());
    //   if (result == 'logged') {
    //     //     // Locale newLocale = Locale('id', 'ID');
    //     //     // MyAppHome.setLocale(context, newLocale);
    //     var isPasswordChange = Prefs.getInt('isPasswordChange');
    //     if (isPasswordChange == 1) {
    //       Navigator.pushReplacement(
    //         context,
    //         MaterialPageRoute(builder: (context) => DashboardPage()),
    //       );
    //     } else {
    //       await showDialog(
    //         context: context,
    //         builder: (BuildContext context) => new ChangePasswordDialog()
    //             .buildAddDialog(context, this, true,
    //                 AppLocalizations.of(context), password),
    //       );
    //     }
    //     YToast.show(
    //         backgroundColor: Colors.green,
    //         context: context,
    //         msg: "Berhasil masuk");
    //   } else if (result == 'expired') {
    //     YToast.show(
    //         backgroundColor: Colors.redAccent,
    //         context: context,
    //         msg: "Account anda sudah expired\nSilahkan hubungi administrator");
    //   } else if (result == 'not activated') {
    //     YToast.show(
    //         backgroundColor: Colors.redAccent,
    //         context: context,
    //         msg: "Username belum diaktifkan\nSilakan hubungi administrator");
    //   } else if (result == 'not logged') {
    //     YToast.show(
    //         backgroundColor: Colors.redAccent,
    //         context: context,
    //         msg: "Username dan/atau Password Salah\nSilakan periksa kembali");
    //   } else if (result == 'refused') {
    //     YToast.show(
    //         backgroundColor: Colors.redAccent,
    //         context: context,
    //         msg:
    //             "Terjadi kesalahan pada komunikasi ke server\nsilahkan hubungi administrator");
    //   } else if (result == 'internet') {
    //     YToast.show(
    //         backgroundColor: Colors.redAccent,
    //         context: context,
    //         msg:
    //             "Terjadi kesalahan pada koneksi internet\nperiksa kembali jaringan internet anda");
    //   } else if (result == '401') {
    //     YToast.show(
    //         backgroundColor: Colors.redAccent,
    //         context: context,
    //         msg: "Username dan/atau Password Salah\nSilakan periksa kembali");
    //   } else if (result == 'ADMIN') {
    //     YToast.show(
    //         backgroundColor: Colors.redAccent,
    //         context: context,
    //         msg: "User ini tidak mempunyai akses untuk masuk aplikasi");
    //   } else {
    //     print('result login=' + result.toString());
    //     YToast.show(
    //         backgroundColor: Colors.redAccent,
    //         context: context,
    //         msg:
    //             "Terjadi kesalahan pada komunikasi ke server\nsilahkan hubungi administrator");
    //   }
    // } catch (err) {
    //   print('error login=' + err.toString());
    //   YToast.show(
    //       backgroundColor: Colors.red,
    //       context: context,
    //       msg:
    //           "Terjadi kesalahan koneksi/aplikasi\nsilahkan menghubungi administrator");
    // }
  }
}
