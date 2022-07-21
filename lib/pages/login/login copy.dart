// import 'dart:convert';

// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:doa/pages/change_password/change_password.dart';
// import 'package:doa/pages/dashboard.dart';
// import 'package:doa/pages/login/signup.dart';
// import 'package:doa/utils/api-utility.dart';
// import 'package:doa/utils/function.dart';
// import 'package:doa/utils/pref_manager.dart';
// import 'package:doa/widgets/blury-container.dart';
// import 'package:doa/widgets/button.dart';
// import 'package:doa/widgets/textbox.dart';
// // import 'package:proste_bezier_curve/proste_bezier_curve.dart';
// import 'package:sweetalert/sweetalert.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _LoginPagePageState();
//   }
// }

// class _LoginPagePageState extends State<LoginPage>
//     with SingleTickerProviderStateMixin {
//   //TabController controller; //tab控制器
//   final txtEmail = TextEditingController();
//   final txtPassword = TextEditingController();
//   var tabs = <Tab>[];
//   String btnText = "Login";
//   String bottomText = "Tidak punya akun? Daftar";
//   bool visible = true;
//   final GlobalKey<FormState> _key = GlobalKey();
//   bool autoValidate = false;
//   String username = '', password = '', rePassword = '';
//   bool obscureText = true;
//   IconData icon = Icons.visibility;

//   @override
//   void initState() {
//     super.initState();
//   }

//   suffixIconIconOnPressed(value) {
//     setState(() {
//       obscureText = !value;
//       icon = !value ? Icons.visibility : Icons.visibility_off;
//     });
//   }

//   changeTextField(pil, val) {
//     setState(() {});
//   }

//   Future openAddDialog() async {
//     await showDialog(
//       context: context,
//       builder: (BuildContext context) =>
//           RegisterDialog().buildAddDialog(context, this, true),
//     );
//   }

//   void onPressedButton() async {
//     if (_key.currentState!.validate()) {
//       _key.currentState!.save();
//       ApiUtilities auth = ApiUtilities();
//       print("password:"+Fungsi().strToMD5(txtPassword.text).substring(0, 25).toString());
//       var data = <dynamic, dynamic>{
//         "email": txtEmail.text.toString(),
//         "user_password":
//             Fungsi().strToMD5(txtPassword.text).substring(0, 25).toString(),
//         "isActive": 1
//       };
//      print("data login ="+data.toString());
//       final dataUser =
//           await auth.getGlobalParam(namaApi: "signup", where: data);
//  //print("data="+dataUser.toString());
//       bool isSukses = dataUser["isSuccess"] as bool;
//       if (isSukses) {
//         var dataUserLogged = dataUser["data"]["data"][0];
//         print(dataUserLogged);
//         bool isFirstLogged = dataUserLogged["isFirst"].toString().toLowerCase()=="1" ;

//         if (dataUserLogged["user_type"].toString().toLowerCase() != "owner") {
//           // bool bankAktif = dataUserLogged["bank_active"].toString().toLowerCase()=="1" ;
//           // if (bankAktif) {
//             Prefs.setString("user_type", dataUserLogged["user_type"]);
//             Prefs.setBool("isLogged", true);
//             Prefs.setBool("isSaving", false);
//             Prefs.setBool("isFirstLogged", isFirstLogged);
//             Prefs.setInt("userId", int.parse(dataUserLogged["id"].toString()));
//             //Prefs.setInt("userLoginId", int.parse(dataUserLogged["user_login_id"].toString()));
//             Prefs.setString("user_name", dataUserLogged["user_fullname"]);
//             Prefs.setString("user_pass", txtPassword.text);
//             // Prefs.setInt(
//             //     "bank_id", int.parse(dataUserLogged["bank_id"].toString()));
//                 print("isFirstLogged="+isFirstLogged.toString());
//             if (isFirstLogged) {
//               await showDialog(
//             context: context,
//             builder: (BuildContext context) => new ChangePasswordDialog()
//                 .buildAddDialog(context, this, true, txtPassword.text),
//           );
//             } else {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => DashboardPage()),
//               );
//             }
//           // } else {
//           //   SweetAlert.show(
//           //                   context,
//           //                   subtitle:
//           //                       'Bank Sampah is not active\nPlease contact administrator',
//           //                   style: SweetAlertStyle.loadingerror,
//           //                 );
//           //                 Future.delayed(const Duration(seconds: 3), () {
//           //                   setState(() {});
//           //                   Navigator.pop(context);
//           //                 });
//           // }
//         } else {
//           Prefs.setString("user_type", dataUserLogged["user_type"]);
//           Prefs.setBool("isLogged", true);
//           Prefs.setBool("isFirstLogged", isFirstLogged);
//           Prefs.setBool("isSaving", false);
//           Prefs.setInt("userId", int.parse(dataUserLogged["id"].toString()));
//           Prefs.setString("user_name", dataUserLogged["user_fullname"]);
//           Prefs.setString("user_pass", txtPassword.text);
//           //Prefs.setInt("userLoginId", int.parse(dataUserLogged["user_login_id"].toString()));
//           if (isFirstLogged) {
//             await showDialog(
//             context: context,
//             builder: (BuildContext context) => new ChangePasswordDialog()
//                 .buildAddDialog(context, this, true, txtPassword.text),
//           );
//           } else {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => DashboardPage()),
//             );
//           }
//         }
//       } else {
//         if (dataUser["error"] == "validation error") {
//           SweetAlert.show(
//                             context,
//                             subtitle:
//                                 'User name is not registered\n please sign up first',
//                             style: SweetAlertStyle.loadingerror,
//                           );
//                           Future.delayed(const Duration(seconds: 3), () {
//                             setState(() {});
//                             Navigator.pop(context);
//                           });
//         } else {
//           SweetAlert.show(
//                             context,
//                             subtitle:
//                                 dataUser["error_message"],
//                             style: SweetAlertStyle.loadingerror,
//                           );
//                           Future.delayed(const Duration(seconds: 3), () {
//                             setState(() {});
//                             Navigator.pop(context);
//                           });
//         }
//       }
//     } else {
//       setState(() {
//         autoValidate = true;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primaryColor: Theme.of(context).primaryColor,
//         accentColor: Theme.of(context).accentColor,
//         primaryColorDark: Theme.of(context).primaryColorDark,
//       ),
//       home: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Theme.of(context).accentColor,
//               Theme.of(context).primaryColorDark,
//             ],
//           ),
//         ),
//         child: Scaffold(
//           backgroundColor: Colors.grey[300],
//           body: getBodyView(),
//         ),
//       ),
//     );
//   }

//   Widget getBodyView() {
//     //可滑动布局，避免弹出键盘时会有溢出异常
//     return ListView(
//       children: <Widget>[
//         Stack(
//           children: [
//             // Image.asset('assets/images/login-background.png',
//             //             fit: BoxFit.fill),
            
//             Padding(
//                 padding: EdgeInsets.only(top: 5),
//                 child: ClipPath(
//                   clipper: ProsteBezierCurve(
//                     position: ClipPosition.bottom,
//                     list: [
//                       BezierCurveSection(
//                         start: Offset(0, 125),
//                         top: Offset(MediaQuery.of(context).size.width / 4, 150),
//                         end: Offset(MediaQuery.of(context).size.width / 2, 125),
//                       ),
//                       BezierCurveSection(
//                         start:
//                             Offset(MediaQuery.of(context).size.width / 2, 125),
//                         top: Offset(
//                             MediaQuery.of(context).size.width / 4 * 3, 100),
//                         end: Offset(MediaQuery.of(context).size.width, 150),
//                       ),
//                     ],
//                   ),
//                   child: Container(
//                     height: 150,
//                     color: Colors.brown[700],
//                   ),
//                 )),
//             ClipPath(
//                 clipper: ProsteBezierCurve(
//                   position: ClipPosition.bottom,
//                   list: [
//                     BezierCurveSection(
//                       start: const Offset(0, 125),
//                       top: Offset(MediaQuery.of(context).size.width / 4, 150),
//                       end: Offset(MediaQuery.of(context).size.width / 2, 125),
//                     ),
//                     BezierCurveSection(
//                       start: Offset(MediaQuery.of(context).size.width / 2, 125),
//                       top: Offset(
//                           MediaQuery.of(context).size.width / 4 * 3, 100),
//                       end: Offset(MediaQuery.of(context).size.width, 150),
//                     ),
//                   ],
//                 ),
//                 child: Container(
//                     height: 150,
//                     width: MediaQuery.of(context).size.width,
//                     color: Colors.green[900],
//                     child: Image.asset('assets/images/background-header.png',
//                         fit: BoxFit.fill))),
//           ],
//         ),
//         const SizedBox(height: 40),
//         Padding(
//           padding: const EdgeInsets.only(left: 70, right: 70),
//           child: Image.asset('assets/images/recycle.png',
//               height: 79, fit: BoxFit.fill),
//         ),
//         const SizedBox(height: 20),
//         Stack(alignment: Alignment.topCenter, children: <Widget>[
//           BluryWidget().bluryWidget(context,
//               widgetBody: Form(
//                   key: _key,
//                   child: Column(
//                     children: [
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       TextBox().textBoxBorderedIconValidate(
//                         context,
//                         textName: "User Name",
//                         hint: "username_login".tr(),
//                         textController: txtEmail,
//                         textChange: changeTextField,
//                         icon: Icons.person,
//                       ),
//                       TextBox().textBoxBorderedIconValidate(context,
//                           textName: "password".tr(),
//                           hint: "password_login".tr(),
//                           obscureText: obscureText,
//                           icon: Icons.vpn_key,
//                           suffixIcon: icon,
//                           suffixIconIconOnPressed: suffixIconIconOnPressed,
//                           textController: txtPassword,
//                           textChange: changeTextField),
//                       const Padding(
//                           padding: EdgeInsets.only(right: 10),
//                           child: Align(
//                               alignment: Alignment.centerRight,
//                               child: Text(
//                                 "Forgot password ?",
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               )))
//                     ],
//                   ))),

//           // Container(
//           //   margin: EdgeInsets.only(top: 120),
//           //   padding: EdgeInsets.all(40),
//           //   child: Card(
//           //     elevation: 5,
//           //     shape: RoundedRectangleBorder(
//           //       borderRadius: BorderRadius.all(Radius.circular(15)),
//           //     ),
//           //     color: Colors.white,
//           //     child: Padding(
//           //       padding: EdgeInsets.all(20),
//           //       child: Form(
//           //         autovalidate: autoValidate,
//           //         key: _key,
//           //         child: Column(
//           //           crossAxisAlignment: CrossAxisAlignment.start,
//           //           children: <Widget>[
//           //             TextFormField(
//           //               //键盘类型，即输入类型
//           //               //keyboardType: TextInputType.number,
//           //               textInputAction: TextInputAction.next,
//           //               decoration: InputDecoration(
//           //                 icon: Icon(Icons.mail_outline),
//           //                 labelText: 'Masukan Email',
//           //               ),
//           //               onSaved: (text) {
//           //                 setState(() {
//           //                   username = text!;
//           //                 });
//           //               },
//           //             ),
//           //             SizedBox(height: 20),
//           //             TextFormField(
//           //               //是否显示密码类型
//           //               obscureText: true,
//           //               //keyboardType: TextInputType.number,
//           //               decoration: InputDecoration(
//           //                 icon: Icon(Icons.lock_outline),
//           //                 labelText: 'Masukan Password',
//           //               ),
//           //               onSaved: (text) {
//           //                 setState(() {
//           //                   password = text!;
//           //                 });
//           //               },
//           //             ),
//           //             SizedBox(height: 20),
//           //             Offstage(
//           //               offstage: visible,
//           //               child: Column(
//           //                 children: <Widget>[
//           //                   TextFormField(
//           //                     obscureText: true,
//           //                     keyboardType: TextInputType.number,
//           //                     decoration: InputDecoration(
//           //                       icon: Icon(Icons.lock_outline),
//           //                       labelText: 'Konfirmasi Password',
//           //                     ),
//           //                     onSaved: (text) {
//           //                       setState(() {
//           //                         rePassword = text!;
//           //                       });
//           //                     },
//           //                   ),
//           //                   SizedBox(height: 20),
//           //                 ],
//           //               ),
//           //             ),
//           //             SizedBox(height: 10),
//           //           ],
//           //         ),
//           //       ),
//           //     ),
//           //   ),
//           // ),
//           // Positioned(
//           //   bottom: -20,
//           //   left: 130,
//           //   right: 130,
//           //   child: RaisedButton(
//           //     shape: RoundedRectangleBorder(
//           //       borderRadius: BorderRadius.all(
//           //         Radius.circular(50),
//           //       ),
//           //     ),
//           //     elevation: 5,
//           //     highlightElevation: 10,
//           //     textColor: Colors.white,
//           //     padding: EdgeInsets.all(0.0),
//           //     child: Container(
//           //       width: MediaQuery.of(context).size.width,
//           //       alignment: Alignment.center,
//           //       decoration: BoxDecoration(
//           //         borderRadius: BorderRadius.all(Radius.circular(50)),
//           //         gradient: LinearGradient(
//           //           colors: <Color>[
//           //             Theme.of(context).accentColor,
//           //             Theme.of(context).primaryColorDark,
//           //           ],
//           //         ),
//           //       ),
//           //       padding: EdgeInsets.all(10.0),
//           //       child: Text(
//           //         btnText,
//           //         style: TextStyle(fontSize: 20),
//           //       ),
//           //     ),
//           //     onPressed: () {
//           //       // if (_key.currentState.validate()) {
//           //       //   _key.currentState.save();
//           //       //   //doRequest();
//           //       // } else {
//           //       //   setState(() {
//           //       //     autoValidate = true;
//           //       //   });
//           //       // }
//           //     },
//           //   ),
//           // ),
//         ]),
//         Button().raisedGradientButton(context,
//             label: "Log in",
//             padding: 10.0,
//             labelColor: Colors.white,
//             onPressed: onPressedButton),
//         SizedBox(
//           height: 5,
//         ),
//         Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//           Text("Does not have account ? "),
//           GestureDetector(
//               onTap: () async {
//                 openAddDialog();
//               },
//               child: Text("Sign Up",
//                   style:
//                       TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)))
//         ])
//       ],
//     );
//   }

//   // @override
//   // void dispose() {
//   //   super.dispose();
//   //   controller.dispose();
//   // }

//   getUserLogin(email) async {
//     // SettingService settingService = new SettingService();
//     // final data = await settingService.getUser(email);
//     // return data;
//   }

//   String validateUsername(String value) {
//     if (value.isEmpty)
//       return "Akun tidak boleh kosong";
//     else //if (value.length < 5) return "Akun minimal harus 5";
//       return "";
//   }

//   String validatePassword(String value) {
//     if (value.isEmpty)
//       return "Kata sandi tidak boleh kosong";
//     else //if (value.length < 6) return "minimal harus 6";
//       return "";
//   }

//   String validateRePassword(String value) {
//     if (value.isEmpty)
//       return "Kata sandi tidak boleh kosong";
//     else //if (value.length < 6) return "minimal harus 6";
// //    else if (value != password) return "两次密码不一致";
//       return "";
//   }

//   Future doRequest() async {
//     // var data;
//     // try {
//     //   Auth auth = new Auth();
//     //   final result = await auth.getLogin(username, password);
//     //   // print('result =' + result.toString());
//     //   if (result == 'logged') {
//     //     //     // Locale newLocale = Locale('id', 'ID');
//     //     //     // MyAppHome.setLocale(context, newLocale);
//     //     var isPasswordChange = Prefs.getInt('isPasswordChange');
//     //     if (isPasswordChange == 1) {
//     //       Navigator.pushReplacement(
//     //         context,
//     //         MaterialPageRoute(builder: (context) => DashboardPage()),
//     //       );
//     //     } else {
//     //       await showDialog(
//     //         context: context,
//     //         builder: (BuildContext context) => new ChangePasswordDialog()
//     //             .buildAddDialog(context, this, true,
//     //                 AppLocalizations.of(context), password),
//     //       );
//     //     }
//     //     YToast.show(
//     //         backgroundColor: Colors.green,
//     //         context: context,
//     //         msg: "Berhasil masuk");
//     //   } else if (result == 'expired') {
//     //     YToast.show(
//     //         backgroundColor: Colors.redAccent,
//     //         context: context,
//     //         msg: "Account anda sudah expired\nSilahkan hubungi administrator");
//     //   } else if (result == 'not activated') {
//     //     YToast.show(
//     //         backgroundColor: Colors.redAccent,
//     //         context: context,
//     //         msg: "Username belum diaktifkan\nSilakan hubungi administrator");
//     //   } else if (result == 'not logged') {
//     //     YToast.show(
//     //         backgroundColor: Colors.redAccent,
//     //         context: context,
//     //         msg: "Username dan/atau Password Salah\nSilakan periksa kembali");
//     //   } else if (result == 'refused') {
//     //     YToast.show(
//     //         backgroundColor: Colors.redAccent,
//     //         context: context,
//     //         msg:
//     //             "Terjadi kesalahan pada komunikasi ke server\nsilahkan hubungi administrator");
//     //   } else if (result == 'internet') {
//     //     YToast.show(
//     //         backgroundColor: Colors.redAccent,
//     //         context: context,
//     //         msg:
//     //             "Terjadi kesalahan pada koneksi internet\nperiksa kembali jaringan internet anda");
//     //   } else if (result == '401') {
//     //     YToast.show(
//     //         backgroundColor: Colors.redAccent,
//     //         context: context,
//     //         msg: "Username dan/atau Password Salah\nSilakan periksa kembali");
//     //   } else if (result == 'ADMIN') {
//     //     YToast.show(
//     //         backgroundColor: Colors.redAccent,
//     //         context: context,
//     //         msg: "User ini tidak mempunyai akses untuk masuk aplikasi");
//     //   } else {
//     //     print('result login=' + result.toString());
//     //     YToast.show(
//     //         backgroundColor: Colors.redAccent,
//     //         context: context,
//     //         msg:
//     //             "Terjadi kesalahan pada komunikasi ke server\nsilahkan hubungi administrator");
//     //   }
//     // } catch (err) {
//     //   print('error login=' + err.toString());
//     //   YToast.show(
//     //       backgroundColor: Colors.red,
//     //       context: context,
//     //       msg:
//     //           "Terjadi kesalahan koneksi/aplikasi\nsilahkan menghubungi administrator");
//     // }
//   }
// }
