import 'dart:async';

import 'package:doa/pages/login/forgot-password.dart';
import 'package:doa/pages/login/google-info.dart';

import 'package:doa/utils/authentication.dart';
import 'package:doa/utils/email_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:easy_localization/easy_localization.dart';
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
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:location/location.dart';
import 'package:random_string/random_string.dart';
// import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:sweetalert/sweetalert.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPagePageState();
  }
}

class GoogleSignInButton extends StatefulWidget {
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: OutlinedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
        onPressed: () async {
          if (await _initLocationService(context)) {
            googleLogin(context);
          }
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage("assets/images/google_logo.png"),
                height: 35.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Sign in with Google',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

_getAddressFromLatLng(BuildContext context, currentPosition) async {
  try {
    List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
        currentPosition.latitude, currentPosition.longitude);

    geo.Placemark place = placemarks[0];
    print(
        "${place.subAdministrativeArea}, ${place.postalCode}, ${place.country}");
    String kota = place.subAdministrativeArea!
        .replaceAll("Kabupaten ", "")
        .replaceAll("Kota ", "")
        .replaceAll(" Regency", "")
        .toUpperCase();
    var data = <dynamic, dynamic>{"kota_nama": kota};
    // ApiUtilities auth = ApiUtilities();
    final dataDoa =
        await ApiUtilities().getGlobalParam(namaApi: "kotas", where: data);
    bool isSukses = dataDoa["isSuccess"] as bool;
    if (isSukses) {
      var record = dataDoa["data"]["data"][0];
      Prefs.setString("kota_nama", record['kota_nama']);
      Prefs.setString("kota_kode", record['kota_kode']);
      Prefs.setString("prop_kode", record['prop_kode']);
      Prefs.setString("api_id", record['api_id']);
      // googleLogin(context);
    }
  } catch (e) {
    print(e);
  }
}

Future<bool> _initLocationService(BuildContext context) async {
  var location = Location();

  if (!await location.serviceEnabled()) {
    if (!await location.requestService()) {
      return false;
    }
  }

  var permission = await location.hasPermission();
  if (permission == PermissionStatus.denied) {
    permission = await location.requestPermission();
    if (permission != PermissionStatus.granted) {
      return false;
    } else {
      final loc = await location.getLocation();
      _getAddressFromLatLng(context, loc);
    }
  } else {
    final loc = await location.getLocation();
    _getAddressFromLatLng(context, loc);
  }
  return true;
}

void googleLogin(BuildContext context) async {
  bool isFirstLogged = false;
  var now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd');
  String formattedDate = formatter.format(now);

  User? user = await Authentication.signInWithGoogle(context: context);

  if (user != null) {
    String vPassword = randomAlphaNumeric(5);
    var data = <dynamic, dynamic>{"email": user.email, "isActive": 1};

    var dataUser =
        await ApiUtilities().getGlobalParam(namaApi: "alluser", where: data);

    bool isSukses = dataUser["isSuccess"] as bool;
    if (!isSukses) {
      isFirstLogged = true;
      var dataSave = <dynamic, dynamic>{
        "user_fullname": user.displayName,
        "user_password": Fungsi().strToMD5(vPassword),
        "password_default": vPassword,
        "hp": user.phoneNumber,
        "email": user.email,
        "user_type": "user",
        "prop_kode": Prefs.getString("prop_kode"),
        "kota_kode": Prefs.getString("kota_kode"),
        "birthday": formattedDate,
        "isFirst": 1,
        "approved": 1,
        "approved_email": 1,
        "daftar_baru": 0,
        "isActive": 1,
      };
      await ApiUtilities().saveNewData(dataSave, "signup", "");

      data = <dynamic, dynamic>{"email": user.email, "isActive": 1};

      dataUser =
          await ApiUtilities().getGlobalParam(namaApi: "alluser", where: data);
      isSukses = dataUser["isSuccess"] as bool;
    }
    if (isSukses) {
      var dataUserLogged = dataUser["data"]["data"][0];
      Prefs.setString("user_type", "user");
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
      Prefs.setString(
          "expired_date", Fungsi().fmtDateYear(dataUserLogged["expired_date"]));
      Prefs.setBool("isRefresh", true);
      //Prefs.setInt("userLoginId", int.parse(dataUserLogged["user_login_id"].toString()));
      Prefs.setString("user_name", dataUserLogged["user_fullname"]);
      Prefs.setString("user_pass", dataUserLogged["password_default"]);
      Prefs.setString('curdate', '');
      if (dataUserLogged['isFirst'] == "1") {
        final bodyEmail =
            "<p>Account anda sudah diaktifkan dan dapat digunakan.</p><p>user name login dan password anda adalah :</p><p>User Name : " +
                dataUserLogged['email'].toString() +
                " </p><p>password : " +
                dataUserLogged['password_default'].toString() +
                "</p><p>Silahkan login menggunakan username dan password tersebut. Terima kasih.</p>";
        EmailUtility().kirimEmail(
            context: context,
            alamatEmail: dataUserLogged['email'].toString(),
            bodyEmail: bodyEmail,
            isEmailOnly: false,
            isNoReply: true,
            judulEmail: "Validasi Aplikasi Doa",
            callBack: callBackEmail);
      }
      // Phoenix.rebirth(context);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => UserInfoScreen(user: user),
        ),
      );
    }
  }
}

callBackEmail(isSended) async {
  var dataSave = <dynamic, dynamic>{"isFirst": 0};
  var where = <dynamic, dynamic>{"id": Prefs.getInt("userId")};
  ApiUtilities().updateData(dataSave, "signup", where: where);
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
      // print("password:" +
      //     Fungsi().strToMD5(txtPassword.text).toString());
      var data = <dynamic, dynamic>{
        "email": txtEmail.text.toString(),
        "user_password": Fungsi().strToMD5(txtPassword.text).toString(),
        "isActive": 1
      };
      //print("data login ="+data.toString());
      final dataUser =
          await auth.getGlobalParam(namaApi: "signup", where: data);
      //print("data user=" + dataUser.toString());
      bool isSukses = dataUser["isSuccess"] as bool;
      if (isSukses) {
        var dataUserLogged = dataUser["data"]["data"][0];
        // print(dataUserLogged);
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
          Prefs.setString("kota_kode", dataUserLogged["kota_kode"]);
          Prefs.setString("api_id", dataUserLogged["api_id"]);
          Prefs.setString("kota_nama", dataUserLogged["kota_nama"]);
          Prefs.setString('curdate', '');
          Prefs.setString("user_pass", txtPassword.text);
          // Prefs.setInt(
          //     "bank_id", int.parse(dataUserLogged["bank_id"].toString()));
          // print("isFirstLogged=" + isFirstLogged.toString());
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
          Prefs.setString("kota_kode", dataUserLogged["kota_kode"]);
          Prefs.setString("api_id", dataUserLogged["api_id"]);
          Prefs.setString("kota_nama", dataUserLogged["kota_nama"]);
          Prefs.setString("user_pass", txtPassword.text);
          Prefs.setString('curdate', '');
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

                FutureBuilder(
                  future: Authentication.initializeFirebase(context: context),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error initializing Firebase');
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return GoogleSignInButton();
                    }
                    return CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                    );
                  },
                ),

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
                                hint: "Username",
                                textController: txtEmail,
                                textChange: changeTextField,
                                icon: Icons.person,
                              ),
                              TextBox().textBoxBorderedIconValidate(context,
                                  textName: "Password",
                                  hint: "Password",
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
                ]),
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
}
