import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:doa/pages/dashboard.dart';
import 'package:doa/pages/login/login.dart';
import 'package:doa/utils/api.dart';
import 'package:doa/utils/pref_manager.dart';
import 'package:doa/utils/xml_util.dart';
import 'package:doa/widgets/show-dialog.dart';
import 'package:doa/widgets/textbox.dart';

class Onboarding extends StatefulWidget {
  Onboarding({Key? key}) : super(key: key);

  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  onLoad() async {
    await Prefs.load();
    if (Prefs.getBool("isLogged")) {
      if (!Prefs.getBool("isExpired")) {
        var expired_date = DateTime.parse(Prefs.getString('expired_date'));
        var now = new DateTime.now();
        if (expired_date.compareTo(now) <= 0) Prefs.setBool("isExpired", true);
      }
      Timer(
          const Duration(seconds: 3),
          () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => DashboardPage())));
    } else {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginPage())));
    }
  }

  int progress = 0;
  ReceivePort receivePort = ReceivePort();
  String? about;
  bool _condition = true;
  bool isFirst = true;
  int _hit = 0;
  Timer? istimer;
  final txtBaseUrlController = TextEditingController();
  final txtBatchUrlController = TextEditingController();
  final txtBaseUrlFocusNode = FocusNode();
  final txtBatchUrlFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    onLoad();
    XML().readAuthXml();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onPressedButton() async {
    //XML().readAuthXml();

    if (Prefs.getBool("isLogged")) {
      if (Prefs.getBool("isExpired")) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardPage()),
        );
      } else {
        //print("expired :"+Prefs.getString('expired_date'));
        var expired_date = DateTime.parse(Prefs.getString('expired_date'));
        var now = new DateTime.now();
        if (expired_date.compareTo(now) <= 0) {
          Prefs.setBool("isExpired", true);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DashboardPage()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DashboardPage()),
          );
        }
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  changeTextField(pil, val) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 1.2,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 40,
              ),
              Expanded(
                flex: 6,
                child: Hero(
                  tag: 'Clipboard',
                  child: Image.asset(
                    'assets/images/doa.png',
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 10),
                    const Text(
                      'Moslem\'s',
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                          color: Colors.brown),
                    ),
                    //SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        if (isFirst != true) {
                          if (_condition) {
                            setState(() => _condition = false);
                            Timer(
                                const Duration(seconds: 5),
                                () => setState(() {
                                      _condition = true;
                                      _hit = 0;
                                      isFirst = true;
                                      istimer = null;
                                    }));
                            print("muncul");
                            //txtPasswordController.text = "";
                            //data.keys
                            var data = "";
                            onPressedDialog(data) {
                              XML().createAuthXml(
                                  baseUrl: txtBaseUrlController.text,
                                  batchUrl: txtBatchUrlController.text);
                              Navigator.of(context).pop();
                            }

                            showDialogWidget(data, setState) {
                              txtBaseUrlController.text = Api.BASE_URL;
                              txtBatchUrlController.text = Api.BATCH_URL;
                              Widget wg = Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    TextBox().textboxWithBorderValidate(context,
                                        label: "Base Url",
                                        textController: txtBaseUrlController,
                                        textChange: changeTextField,
                                        textFocusNote: txtBaseUrlFocusNode,
                                        isMandatory: false,
                                        maxlines: 3),
                                    TextBox().textboxWithBorderValidate(context,
                                        label: "Batch Url",
                                        textController: txtBatchUrlController,
                                        textChange: changeTextField,
                                        textFocusNote: txtBatchUrlFocusNode,
                                        isMandatory: false,
                                        maxlines: 3),
                                  ]);
                              return wg;
                            }

                            ShowDialog().showDialogs(
                                data: data,
                                contek: context,
                                isiwidget: showDialogWidget,
                                judul: "Setting API",
                                onPressed: onPressedDialog,
                                isExpanded: true,
                                labelButton: "Submit");
                          }
                        } else {
                          if (_hit > 3) {
                            setState(() {
                              isFirst = false;
                              //_condition = true;
                            });
                          } else {
                            if (istimer != null) {
                              istimer!.cancel();
                            }
                            istimer = Timer(
                                const Duration(seconds: 5),
                                () => setState(() {
                                      _hit = 0;
                                      print('dari nol lagi ya !!!');
                                    }));

                            setState(() {
                              _hit = _hit + 1;
                            });
                          }
                        } // disable onTap if condition is false
                      },
                      child: const Text(
                        'Doa Reminder',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                            color: Colors.brown,
                            fontFamily: 'opensans'),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
