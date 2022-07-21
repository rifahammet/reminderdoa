import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:doa/widgets/blury-container.dart';
// import 'package:share/share.dart';
// import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String? about;
  bool _condition = true;
  bool isFirst = true;
  int _hit = 0;
  Timer? istimer;
  @override
  Widget build(BuildContext context) {
    // _launchURL(url) async {
    //   //const url = 'https://google.com.br';
    //   if (await canLaunch(url)) {
    //     await launch(url);
    //   } else {
    //     throw 'Could not launch $url';
    //   }
    // }

    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.green[700],
          title: Text(
            "Tentang Kami",
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
        body: Column(
          children: [
           Image.asset('assets/images/about-us.png',
               fit: BoxFit.fitWidth),
          Expanded(
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        flex: 2,
                        child: Hero(
                          tag: 'Clipboard',
                          child: 
                          Image.asset('assets/images/doa.png',width: 200,height: 200,),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),

                      GestureDetector(
                          onTap: () {
                            if (isFirst != true) {
                              if (_condition) {
                                setState(() => _condition = false);
                                Timer(
                                    Duration(seconds: 5),
                                    () => setState(() {
                                          _condition = true;
                                          _hit = 0;
                                          isFirst = true;
                                          istimer = null;
                                        }));

                                // your implementation
                                Clipboard.setData(
                                    new ClipboardData(text: "test"));
                               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                 backgroundColor: Colors.black.withOpacity(0.7),
                                    content: Container(
                                        height: 100,
                                        child: Column(
                                          children: <Widget>[
                                            Text("OneThink Dev."),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 10)),
                                            Text("Created By :"),
                                            Text("Wawan Dharmawan - 081808093717"),
                                            Text("Rifa Hammet - 081288888363")
                                          ],
                                        ))));
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
                                    Duration(seconds: 5),
                                    () => setState(() {
                                          _hit = 0;
                                          print('dari nol lagi ya !!!');
                                        }));

                                setState(() {
                                  _hit = _hit + 1;
                                  print('klik ke -' + _hit.toString());
                                });
                              }
                            } // disable onTap if condition is false
                          },
                          child: Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 1,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "Moslem's Doa Reminder",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      "version 1.0.0",
                                      style: TextStyle(
                                          fontSize: 14,
                                          //fontFamily: 'mononoki',
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Divider(),
                                  Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 5),
                                      child: Text(
                                        'Moslem\'s Doa Reminder merupakan aplikasi yang menyajikan berbagai jenis doa yang digunakan sehari-hari untuk memudahkan para pengguna untuk membaca/menghafal.',
                                        style: new TextStyle(
                                          fontSize: 14.0,
                                        ),
                                        textAlign: TextAlign.center,
                                      )),
                                  Padding(padding: EdgeInsets.only(top: 5)),
                                  // Container(
                                  //     width: 200,
                                  //     height: 70,
                                  //     child: Image.asset(
                                  //         'assets/images/DPN.png',
                                  //         fit: BoxFit.fill)),
                                  Text(
                                    'OneThinkLogic',
                                    style: new TextStyle(
                                        fontSize: 14.0, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  InkWell(
                                    splashColor: Colors.green,
                                    child: Text(
                                      "onethinklogic.com",
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    onTap: () async {
                                      // if (await canLaunch(
                                      //     "http://wawansatriani.ddns.com")) {
                                      //   await launch("http://wawansatriani.ddns.com");
                                      // }
                                    },
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 10)),
                                ],
                              )))
                    ],
                  )

//),

                  ))
        ]));
  }
}
