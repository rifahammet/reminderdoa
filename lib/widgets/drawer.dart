// import 'package:onelogic/Utilities/app_localizations.dart';
// import 'package:onelogic/Utilities/pref_manager.dart';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
// import 'package:image_cropper/image_cropper.dart';
import 'package:doa/pages/about-us/about-us.dart';
import 'package:doa/pages/login/login.dart';
import 'package:doa/utils/function.dart';
import 'package:doa/utils/pref_manager.dart';

/* crop */
enum AppState {
  free,
  picked,
  cropped,
}
/* end crop */

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool isExpired = 0 == 1 ? false : true;
  bool isKlik = false;
  bool isFoto = false;
  Uint8List? vImage;
  String imageData = '';
  File? val;
  AppState? state;
  File? imageFile;
  Fungsi auth = Fungsi();
  void _clearImage() {
    imageFile = null;
    setState(() {
      state = AppState.free;
    });
  }

  saveImage(data) async {
    String _token = '';
    int userId = 1;
    //var url = Api.BASE_URL + 'api/updateUser';
    // var res = await http.post(url,
    //     headers: {
    //       'Content-type': 'application/json',
    //       'Accept': 'application/json',
    //       'Authorization': 'Bearer $_token'
    //     },
    //     body: json.encode({"id": userId, "foto": data}));
    // print('status=' + res.statusCode.toString());
    // if (res.statusCode == 200 || res.statusCode == 201) {
    //   if (mounted) {
    //     setState(() {
    //       isKlik = true;
    //     });
    //   }
    // } else {
    //   if (mounted) {
    //     setState(() {
    //       isKlik = false;
    //     });
    //   }
    // }
  }

  // Future<Null> _cropImage() async {
  //   File? croppedFile = await ImageCropper.cropImage(
  //       sourcePath: val!.path,
  //       aspectRatioPresets: Platform.isAndroid
  //           ? [
  //               CropAspectRatioPreset.square,
  //               CropAspectRatioPreset.ratio3x2,
  //               CropAspectRatioPreset.original,
  //               CropAspectRatioPreset.ratio4x3,
  //               CropAspectRatioPreset.ratio16x9
  //             ]
  //           : [
  //               CropAspectRatioPreset.original,
  //               CropAspectRatioPreset.square,
  //               CropAspectRatioPreset.ratio3x2,
  //               CropAspectRatioPreset.ratio4x3,
  //               CropAspectRatioPreset.ratio5x3,
  //               CropAspectRatioPreset.ratio5x4,
  //               CropAspectRatioPreset.ratio7x5,
  //               CropAspectRatioPreset.ratio16x9
  //             ],
  //       androidUiSettings: AndroidUiSettings(
  //           toolbarTitle: 'Cropper',
  //           toolbarColor: Colors.deepOrange,
  //           toolbarWidgetColor: Colors.white,
  //           initAspectRatio: CropAspectRatioPreset.original,
  //           lockAspectRatio: false),
  //       iosUiSettings: IOSUiSettings(
  //         title: 'Cropper',
  //       ));
  //   if (croppedFile != null) {
  //     imageFile = croppedFile;
  //     // imageData = auth.ImageToString(imageFile);
  //     saveImage(imageData);
  //     setState(() {
  //       state = AppState.cropped;
  //     });
  //   } else {
  //     // imageData = auth.ImageToString(imageFile);
  //     saveImage(imageData);
  //   }
  // }

  @override
  void initState() {
    super.initState();
    var data = '';
    print('foto=' + data);
    if (data != 'null') {
      setState(() {
        isFoto = true;
        imageData = '';
        vImage = Fungsi().StringToImage(imageData);
      });
    } else {
      setState(() {
        isFoto = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        _createHeader(context),
        _createDrawerItem(
                      icon: Icons.home,
                      text: 'Dashboard',
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Container()),
                        );
                      },
                    ),
                    Divider(),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Visibility(
                  visible: isExpired,
                  child: Column(children: [
                    
                  ])),
              _createDrawerItem(
                icon: Icons.info,
                text: 'About Us',
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage()),
                  );
                },
              ),
              _createDrawerItem(
                icon: Icons.info,
                text: 'About Us',
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage()),
                  );
                },
              ),
              _createDrawerItem(
                icon: Icons.info,
                text: 'About Us',
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage()),
                  );
                },
              ),
              _createDrawerItem(
                icon: Icons.info,
                text: 'About Us',
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage()),
                  );
                },
              ),
              _createDrawerItem(
                icon: Icons.info,
                text: 'About Us',
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage()),
                  );
                },
              ),
              _createDrawerItem(
                icon: Icons.info,
                text: 'About Us',
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage()),
                  );
                },
              ),
              _createDrawerItem(
                icon: Icons.info,
                text: 'About Us',
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage()),
                  );
                },
              ),
              _createDrawerItem(
                icon: Icons.info,
                text: 'About Us',
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage()),
                  );
                },
              ),
              _createDrawerItem(
                icon: Icons.info,
                text: 'About Us',
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage()),
                  );
                },
              ),
              _createDrawerItem(
                icon: Icons.info,
                text: 'About Us',
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage()),
                  );
                },
              ),
              _createDrawerItem(
                icon: Icons.info,
                text: 'About Us',
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage()),
                  );
                },
              ),
              _createDrawerItem(
                icon: Icons.info,
                text: 'About Us',
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage()),
                  );
                },
              ),
              _createDrawerItem(
                icon: Icons.info,
                text: 'About Us',
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutPage()),
                  );
                },
              ),
            ],
          ),
        ),
        Divider(),
        _createDrawerItem(
            icon: Icons.logout,
            text: 'Logout',
            onTap: () {
              Prefs.clear();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            }),
      ],
    ));
  }

  Widget _createHeader(context) {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(color: Colors.green[400]
            // image: DecorationImage(
            //     fit: BoxFit.fill,
            //     image: AssetImage('assets/images/tomato.png'))
            ),
        child: Stack(children: <Widget>[
          Positioned(
              bottom: 6.0,
              left: 210.0,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey[100]),
                child: Ink(
                  decoration: ShapeDecoration(
                    color: Colors.green,
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.camera_alt),
                    color: Colors.orange[200],
                    onPressed: () async {
                      // val = await showDialog(
                      //     context: context,
                      //     builder: (context) => Camera(
                      //           mode: CameraMode.normal,

                      //           //initialCamera: CameraSide.front,
                      //           //enableCameraChange: false,
                      //           //  orientationEnablePhoto: CameraOrientation.landscape,
                      //           // onChangeCamera: (direction, _) {
                      //           //   print('--------------');
                      //           //   print('$direction');
                      //           //   print('--------------');
                      //           // },
                      //           imageMask: CameraFocus.square(
                      //             color: Colors.black.withOpacity(0.5),
                      //           ),
                      //         ));
                      // if (val != null) {
                      //   setState(() {
                      //     imageFile = val;
                      //     isKlik = true;
                      //     state = AppState.picked;
                      //     _cropImage();
                      //   });
                      // }
                    },
                  ),
                ),
              )),
          Positioned(
              bottom: 12.0,
              left: 80.0,
              child: CircleAvatar(
                radius: 70,
                backgroundColor: Colors.green[100],
                child: CircleAvatar(
                  radius: 65,
                  // backgroundImage: isKlik
                  //     ? FileImage(this.imageFile)
                  //     : !isFoto
                  //         ? AssetImage('assets/images/petani3.png')
                  //         : MemoryImage(vImage),
                ),
              )),
        ]));
  }

  Widget _createDrawerItem(
      {IconData? icon, String? text, GestureTapCallback? onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text.toString()),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
