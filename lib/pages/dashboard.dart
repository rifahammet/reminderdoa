import 'dart:convert';
import 'dart:io';

import 'package:bordered_text/bordered_text.dart';
import 'package:doa/main.dart';
import 'package:doa/pages/approval-users/approval-users.dart';
import 'package:doa/pages/detail-doa/form-doa.dart';
import 'package:doa/pages/master-doa/master-doa.dart';
import 'package:doa/pages/type-doa/type-doa.dart';
import 'package:doa/pages/user/user.dart';
import 'package:doa/widgets/button.dart';
import 'package:doa/widgets/datatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:location/location.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';

import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:doa/pages/Request-penarikan-dana/request-penarikan-dana.dart';
import 'package:doa/pages/about-us/about-us.dart';
import 'package:doa/pages/approval-penarikan-dana/approval-penarikan-dana.dart';
import 'package:doa/pages/approval-store-sampah-admin/approval-store-sampah-admin.dart';
import 'package:doa/pages/approval-store-sampah/approval-store-sampah.dart';
import 'package:doa/pages/cash-bank/cash-bank.dart';
import 'package:doa/pages/change_password/change_password.dart';
import 'package:doa/pages/dashboard1.dart';
import 'package:doa/pages/login/login.dart';
import 'package:doa/pages/onboarding.dart';
// import 'package:doa/pages/pembayaran-penarikan-dana/pembayaran-penarikan-dana.dart';
import 'package:doa/pages/pendaftaran-anggota/pendaftaran-anggota.dart';
import 'package:doa/pages/penjualan/penjualan.dart';
import 'package:doa/pages/profile/profile.dart';
import 'package:doa/pages/rekening-koran/rekening-koran-nasabah.dart';
import 'package:doa/pages/rekening-koran/rekening-koran.dart';
import 'package:doa/pages/saldo-akhir/saldo-akhir.dart';
import 'package:doa/pages/saldo-awal/saldo-awal.dart';
import 'package:doa/pages/satuan/satuan.dart';
import 'package:doa/pages/store-sampah/store-sampah.dart';
import 'package:doa/utils/api-utility.dart';
import 'package:doa/utils/function.dart';
import 'package:doa/utils/pref_manager.dart';
import 'package:doa/widgets/blury-container.dart';
import 'package:doa/widgets/checkbox.dart';
import 'package:doa/widgets/datepicker.dart';
import 'package:doa/widgets/drawer.dart';
import 'package:doa/widgets/dropdown.dart';
import 'package:doa/widgets/fl-chart.dart';
import 'package:doa/widgets/future-builder.dart';
import 'package:doa/widgets/horizontal-widget.dart';
import 'package:doa/widgets/label.dart';
import 'package:doa/widgets/pdf_viewer.dart';
import 'package:doa/widgets/popupmenubutton.dart';
import 'package:doa/widgets/textbox.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:date_format/date_format.dart';
import 'package:path_provider/path_provider.dart';
// ignore: import_of_legacy_library_into_null_safe
//import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:sweetalert/sweetalert.dart';
// import 'package:workmanager/workmanager.dart';

String? selectedNotificationPayload;
// late Position _currentPosition;
// late String _currentAddress;
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'Notofication Reminder Doa', // Description
  importance: Importance.high,
);
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     _getCurrentLocation();
//     return Future.value(true);
//   });
// }

// _getCurrentLocation() {
//   Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.best,
//           forceAndroidLocationManager: true)
//       .then((Position position) {
//     _currentPosition = position;
//     _getAddressFromLatLng();
//   }).catchError((e) {
//     print(e);
//   });
// }

// _getAddressFromLatLng() async {
//   try {
//     List<Placemark> placemarks = await placemarkFromCoordinates(
//         _currentPosition.latitude, _currentPosition.longitude);

//     Placemark place = placemarks[0];

//     print("${place.locality}, ${place.postalCode}, ${place.country}");
//   } catch (e) {
//     print(e);
//   }
// }

// ignore: use_key_in_widget_constructors
class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late final FirebaseMessaging _messaging;

  PushNotification? _notificationInfo;

  List<String> listHeader = ['Menus'];

  List<String> listTitleOwner = [
    'Approval Bank Sampah',
  ];

  List<String> listTitleAdmin = [
    'Kategori Barang',
    'Satuan Barang',
    'Item Barang',
    'Saldo Awal',
    'Setor Sampah',
    'Approval Store Sampah',
    'Approval Penarikan Dana',
    'Pembayaran',
    'Pendaftaran Anggota',
    'Rekening Koran',
    'Penjualan',
    'Cash Bank',
    'Posting'
  ];
  List<String> listTitleUser = [
    'Penarikan Saldo',
    'Approval Store Sampah',
    'Rekening Koran',
  ];
  Future<dynamic>? dataOld;

  bool isPembelian = true;
  final txtEmailController = TextEditingController();
  final txtEmailFocusNote = FocusNode();
  final txtPasswordController = TextEditingController();
  final txtPasswordFocusNote = FocusNode();
  final txtTestController = TextEditingController();
  final txtTestFocusNote = FocusNode();
  bool isOwner = false;
  bool isAdmin = false;
  bool isDisplay = false;
  bool isExpired = false;
  dynamic contek;

  String doaKategori = "All";

  String namaBank = 'BCA';
  List<dynamic>? newData;
  dynamic newDataSholat;
  var bottomNavigationBarIndex = 0;
  int iPos = 1;
  int iPosMax = 0;
  bool isKlik = false;
  bool isMatikan = false;
  bool diKlik = false;
  var _typeItems = <String>['3', '5', '10', '15', '25'];
  var _selectedType = '1000';
  List<DropdownMenuItem<String>>? _dropDownType;
  final txtFilter = TextEditingController();

  /* datePicker */
  final txtTanggalTransferController = TextEditingController();
  String? tanggalTransfer;

  /* switch */
  bool isSwitch = true;

  /* toggle switch */
  List<String> listLabelToggle = ["Male", "Female"];
  List<IconData> listIconToggle = [Icons.male, Icons.female];

  /* fSwitch */
  bool isOpen = false;
  bool isFirst = true;
  //bool isSukses = false;
  String sisaSaldoNasabah = "";
  String sisaSaldoBank = "";
  List<dynamic> dataGrafikNasabah = [];
  dynamic dataDashboard;
  List<dynamic> dataDashboardBarang = [];
  List<dynamic> dataGrafikPenjualanBank = [];
  List<dynamic> dataNotifikasi = [];
  int dataStoreBarang = 0;
  int dataPenarikan = 0;
  int dataPembayaran = 0;
  bool isPertama = true;
  bool isPertamaSholat = true;
  List<PopupMenuItem<int>> listPopDashboard = [];
  List<PopupMenuItem<int>> listPopKategori = [];
  bool isViewlistPopKategori = false;

  @override
  void initState() {
    _initLocationService();
    // Workmanager().initialize(
    //     callbackDispatcher, // The top level function, aka callbackDispatcher
    //     isInDebugMode:
    //         true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
    //     );
    // Workmanager().registerOneOffTask("task-Location", "Location");
    registerNotification();
    isOwner = Prefs.getString("user_type").toString().toLowerCase() == "owner"
        ? true
        : false;
    isAdmin = Prefs.getString("user_type").toString().toLowerCase() == "admin"
        ? true
        : false;
    // listTitle = isOwner
    //     ? listTitleOwner
    //     : isAdmin
    //         ? listTitleAdmin
    //         : listTitleUser;
    txtEmailController.text = "0";
    txtTestController.text = "0.00";
    txtTanggalTransferController.text =
        formatDate(DateTime.now(), [dd, '-', mm, '-', yyyy]);
    tanggalTransfer = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);
    //getData();
    //isFirst = true;
    listPopKategori = [
      PopUpMenuButtons()
          .popupMenuItem(value: 0, label: "All", icon: Icons.account_circle),
      PopUpMenuButtons()
          .popupMenuItem(value: 1, label: "Favorit", icon: Icons.account_circle)
    ];
    listPopDashboard = [
      PopUpMenuButtons().popupMenuItem(
          value: 1, label: "Profile", icon: Icons.account_circle),
      PopUpMenuButtons().popupMenuItem(
          value: 2, label: "Ubah Password", icon: Icons.vpn_key_rounded),
      PopUpMenuButtons()
          .popupMenuItem(value: 0, isLine: true, isVisible: isOwner),
      PopUpMenuButtons().popupMenuItem(
          value: 6,
          label: "Approval Users",
          icon: Icons.admin_panel_settings_rounded,
          isVisible: isOwner),
      PopUpMenuButtons().popupMenuItem(
          value: 9,
          label: "List Users",
          icon: Icons.admin_panel_settings_rounded,
          isVisible: isOwner),
      PopUpMenuButtons().popupMenuItem(value: 0, isLine: true),
      PopUpMenuButtons().popupMenuItem(
          value: 3, label: "Tentang Kami", icon: Icons.info_outlined),
      PopUpMenuButtons()
          .popupMenuItem(value: 4, label: "Log Out", icon: Icons.exit_to_app),
      PopUpMenuButtons().popupMenuItem(value: 0, isLine: true),
      PopUpMenuButtons()
          .popupMenuItem(value: 5, label: "Keluar", icon: Icons.close_outlined),
    ];
    super.initState();
  }

  @override
  void dispose() {
    txtEmailController.dispose();
    txtEmailFocusNote.dispose();
    super.dispose();
  }

  _getAddressFromLatLng(_currentPosition) async {
    try {
      List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      geo.Placemark place = placemarks[0];
      print(
          "${place.subAdministrativeArea}, ${place.postalCode}, ${place.country}");
      String kota = place.subAdministrativeArea
          .replaceAll("Kabupaten", "kab.")
          .toUpperCase();
      if (kota != Prefs.getString("kota_nama")) {
        var data = <dynamic, dynamic>{"kota_nama": kota};
        ApiUtilities auth = ApiUtilities();
        final dataDoa =
            await auth.getGlobalParam(namaApi: "kotas", where: data);
        bool isSukses = dataDoa["isSuccess"] as bool;
        if (isSukses) {
          var record = dataDoa["data"]["data"][0];
          setState(() {
            Prefs.setString("kota_nama", kota);
            Prefs.setString("kota_kode", record['api_id']);

            // newDataSholat = snapshot.ge;
            // print(newDataSholat);
          });

          dynamic newJadwal = await getJadwalSholat();

          setState(() {
            newDataSholat = newJadwal['data'];
            Prefs.setString("kota_nama", kota);
            Prefs.setString("kota_kode", record['api_id']);            
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future _initLocationService() async {
    var location = Location();

    if (!await location.serviceEnabled()) {
      if (!await location.requestService()) {
        return;
      }
    }

    var permission = await location.hasPermission();
    if (permission == PermissionStatus.DENIED) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.GRANTED) {
        return;
      }
    }

    var loc = await location.getLocation();
    print("${loc.latitude} ${loc.longitude}");
    _getAddressFromLatLng(loc);
    location.onLocationChanged().listen((LocationData loc) {
      _getAddressFromLatLng(loc);
    });
  }

  void registerNotification() async {
    WidgetsFlutterBinding.ensureInitialized();
    // 1. Initialize the Firebase app
    await Firebase.initializeApp();

    // 2. Instantiate Firebase Messaging
    _messaging = FirebaseMessaging.instance;
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    _messaging.subscribeToTopic('topic');
    _messaging.getToken().then((token) => setState(() {
          debugPrint(token);
        }));

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      // TODO: handle the received notifications
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        NotificationService.showNotification(message);
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }

  getJadwalSholat() async {
    // if (!isPertamaSholat) {
    //   return newDataSholat;
    // }
    print(Prefs.getString('kota_nama'));
    var url = Uri.parse("https://api.myquran.com/v1/sholat/jadwal/" +
        Prefs.getString('kota_kode') +
        "/" +
        formatDate(DateTime.now(), [yyyy, '/', mm, '/', dd]));
    //print("https://api.myquran.com/v1/sholat/jadwal/1202/" +
    //  formatDate(DateTime.now(), [yyyy, '/', mm, '/', dd]));
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
      // success
    } else if (response.statusCode == 404) {
      return [];
      // not found
    } else if (response.statusCode == 500) {
      return [];
      // server not responding.
    } else {
      return [];
      // some other error or might be CORS policy error. you can add your url in CORS policy.
    }
  }

  Future<dynamic> getData({bool isFirst = false}) async {
    // if (!isFirst) {
    // // if (!Prefs.getBool("isSaving")) {
    //     return 'ada';
    //   // } else {
    //   //   Prefs.setBool("isSaving", false);
    //   // }
    // }

    if (!isFirst) {
      return newData;
    }

    isFirst = false;
    ApiUtilities auth = ApiUtilities();
    final dataPropinsi = await auth.getGlobalParam(
        namaApi: "masterdoa",
        where: doaKategori.toLowerCase() == "favorit"
            ? {"isfavorit": 1, "user_id": Prefs.getInt("userId")}
            : {},
        like: txtFilter.text.toString().trim() != ""
            ? {"concat_field": txtFilter.text}
            : {},
        startFrom: (iPos - 1) * int.parse(_selectedType.toString()),
        limit: _selectedType);
    //print(txtFilter.text);
    //print('data propinsi='+dataPropinsi.toString());

    return dataPropinsi?["isSuccess"] == false
        ? []
        : dataPropinsi?["data"]["data"];
    // return  "ada";
  }

  textBoxOnChange(label, value) {}
  prefixIconOnPressed() {
    print('diklik');
  }

  displayTanggalTransfer(formatDate, formatYear) {
    setState(() {
      tanggalTransfer = formatYear.toString();
      txtTanggalTransferController.text = formatDate.toString();
      print('tanggal=' + formatDate.toString());
    });
  }

/* dropdown */
  change_nama_bank(val) {
    setState(() {
      namaBank = val;
    });
  }

  callbackSwitch(val) {
    setState(() {
      isSwitch = val;
    });
  }

  onChangeSSwitch(value) {
    isOpen = value;
  }

  callbackselectedLabelIndex(index) {
    setState(() {
      // ignore: avoid_print
      print(listLabelToggle[index]);
    });
  }

  isKeluar(context) async {
    {
      SweetAlert.show(context,
          title: "Keluar Program",
          subtitle: "Apakah yakin ingin keluar dari program",
          style: SweetAlertStyle.confirm,
          showCancelButton: true,
          cancelButtonColor: Colors.red,
          confirmButtonColor: Colors.blue,
          cancelButtonText: "Batal",
          confirmButtonText: "Ok", onPress: (confirm) {
        if (confirm) {
          exit(0);
        }
        return true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isFirst) {
      NotificationService.initialize(context);

      isFirst = false;
    }
    return WillPopScope(
        onWillPop: () => isKeluar(context),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.green[900],
          body: gridHeader(context),
        ));
  }

  Widget gridHeader(context) {
    editData(
        BuildContext context, dynamic data, bool isEdit, bool isView) async {
      FocusScope.of(context).requestFocus(FocusNode());
      final x = await showDialog(
        context: context,
        builder: (BuildContext context) =>
            DoaDialog().buildAddDialog(context, this, data, isEdit, isView),
      );
      if (x != null && x) {
        print('setstate');
        Prefs.setBool("isRefresh", true);
        setState(() {
          // isFirst= true;
        });
      }
    }

    callBackDelete(index) {}
    callBackEdit(index) {}
    callBackView(index) {
      editData(context, int.parse(newData?[index]["id"]), true, false);
    }

    callBackIsiWidget(index) {
      Widget wg = Container(
          height: 80,
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset("assets/images/frame-card.png", fit: BoxFit.fill),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 50, right: 50),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  newData?[index]['name'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ))),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ));

      return wg;
    }

    callBackComboBox(value) {
      setState(() {
        iPos = 1;
        _selectedType = value;
      });
    }

    callBackButtonSearch() async {
      iPos = 1;
      final x = await getData(isFirst: true);
      setState(() {
        newData = x;
      });
    }

    callBackSelectedKategori(value) async {
      setState(() {
        print('value=' + value.toString());
        doaKategori = value == 0
            ? 'All'
            : value == 1
                ? 'Favorit'
                : 'Scheduled';
      });
      iPos = 1;
      final x = await getData(isFirst: true);
      setState(() {
        newData = x;
      });
    }

    callBackSelectedDashboard(value) async {
      switch (value) {
        case 0:
          break;
        case 1:
          await showDialog(
            context: context,
            builder: (BuildContext context) => new ProfileDialog()
                .buildAddDialog(
                    context, this, Prefs.getInt("userId"), true, true),
          );
          break;
        case 2:
          await showDialog(
            context: context,
            builder: (BuildContext context) => new ChangePasswordDialog()
                .buildAddDialog(
                    context, this, true, Prefs.getString("user_pass")),
          );
          break;
        case 3:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AboutPage()),
          );
          break;
        case 4:
          Prefs.clear();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
          break;
        case 5:
          exit(0);
        // do something else

        case 6:
          // do something else
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ApprovalUsersPage(
                      isViewOnly: true,
                    )),
          );
          break;
        case 7:
          // do something else
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TypeDoaPage()),
          );
          break;
        case 8:
          // do something else
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MasterDoaPage()),
          );
          break;
        case 9:
          // do something else
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const UserPage(
                      isViewOnly: true,
                    )),
          );
          break;
      }
    }

    return Column(children: [
      Container(
          color: Colors.transparent,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Image.asset('assets/images/dashboard1.png', fit: BoxFit.fitWidth),
              SizedBox(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
                      child: Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xFFF05A22),
                                  style: BorderStyle.solid,
                                  width: 1.0,
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              height: 40,
                              width: 100,
                              child: Row(
                                children: [
                                  PopUpMenuButtons().selectPopup(
                                      listPopupMenuItem: listPopDashboard,
                                      x: 5.0,
                                      callBackSelected:
                                          callBackSelectedDashboard,
                                      iconColor: Colors.red,
                                      backgroundColor: Colors.yellow[100],
                                      icon: Icons.account_circle),
                                  Text(
                                    "Menu",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
                          Expanded(
                            child: Container(),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xFFF05A22),
                                  style: BorderStyle.solid,
                                  width: 1.0,
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              height: 40,
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                    //iconSize: 48,
                                    icon: Icon(!isDisplay
                                        ? Icons.remove_red_eye
                                        : Icons.visibility_off_outlined),
                                    onPressed: () {
                                      setState(() {
                                        isDisplay = !isDisplay;
                                      });
                                    },
                                  ),
                                  Text(
                                    "Find",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
                        ],
                      ))),
              Column(
                children: [
                  SizedBox(height: 110),
                  Align(
                      alignment: Alignment.center,
                      child: Text("Jadwal Sholat",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.yellow.shade700)))
                ],
              ),
            ],
          )),
      const SizedBox(
        height: 10,
      ),
      FutureBuilder(
          future: getJadwalSholat(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            // print('future builder');
            if (snapshot.hasData) {
              dynamic vdata = snapshot.data['data'];
              //isSukses =  snapshot.data['status'];
              if (isPertamaSholat) {
                newDataSholat = snapshot.data['data'];
                isPertamaSholat = false;
              }
              //print(vdata.toString());
              return Column(children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  color: Colors.transparent,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 5.0,
                      ),
                      Expanded(
                          child: Container(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Subuh",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      newDataSholat['jadwal']['subuh'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ]),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.brown,
                                  style: BorderStyle.solid,
                                  width: 2.0,
                                ),
                                color: Colors.yellow[200],
                                borderRadius: BorderRadius.circular(7.0),
                              ))),
                      SizedBox(
                        width: 5.0,
                      ),
                      Expanded(
                          child: Container(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Dzuhur",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      newDataSholat['jadwal']['dzuhur'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ]),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.brown,
                                  style: BorderStyle.solid,
                                  width: 2.0,
                                ),
                                color: Colors.yellow[200],
                                borderRadius: BorderRadius.circular(7.0),
                              ))),
                      SizedBox(
                        width: 5.0,
                      ),
                      Expanded(
                          child: Container(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Ashar",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      newDataSholat['jadwal']['ashar'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ]),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.brown,
                                  style: BorderStyle.solid,
                                  width: 2.0,
                                ),
                                color: Colors.yellow[200],
                                borderRadius: BorderRadius.circular(7.0),
                              ))),
                      SizedBox(
                        width: 5.0,
                      ),
                      Expanded(
                          child: Container(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Maghrib",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      newDataSholat['jadwal']['maghrib'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ]),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.brown,
                                  style: BorderStyle.solid,
                                  width: 2.0,
                                ),
                                color: Colors.yellow[200],
                                borderRadius: BorderRadius.circular(7.0),
                              ))),
                      SizedBox(
                        width: 5.0,
                      ),
                      Expanded(
                          child: Container(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Isya\'",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      newDataSholat['jadwal']['isya'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ]),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.brown,
                                  style: BorderStyle.solid,
                                  width: 2.0,
                                ),
                                color: Colors.yellow[200],
                                borderRadius: BorderRadius.circular(7.0),
                              ))),
                      SizedBox(
                        width: 5.0,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "Untuk wilayah " +
                      Prefs.getString("kota_nama") +
                      " dan sekitarnya",
                  style: TextStyle(color: Colors.yellow),
                ),
                SizedBox(height: 10.0),
              ]);
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
      Expanded(
          child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width - 40,
            decoration: BoxDecoration(
              // border: Border.all(
              //   color: Color(0xFFF05A22),
              //   style: BorderStyle.solid,
              //   width: 1.0,
              // ),

              color: Colors.yellow.withOpacity(0.5),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(20.0)),
            ),
            child: SizedBox(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                    child: Column(
                      children: [
                        Row(children: [
                          Text(
                            "Daftar Doa",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.red[900],
                            ),
                          ),
                          Expanded(
                            child: SizedBox(),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xFFF05A22),
                                  style: BorderStyle.solid,
                                  width: 1.0,
                                ),
                                color: Colors.yellow[50],
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              height: 40,
                              width: 170,
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            doaKategori,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ))),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isViewlistPopKategori !=
                                              isViewlistPopKategori;
                                          print("isViewlistPopKategori=" +
                                              isViewlistPopKategori.toString());
                                        });
                                      },
                                      child: PopUpMenuButtons().selectPopup(
                                          listPopupMenuItem: listPopKategori,
                                          posisi: "kanan",
                                          x: 0.0,
                                          y: 95.0,
                                          callBackSelected:
                                              callBackSelectedKategori,
                                          iconColor: Colors.green[700],
                                          backgroundColor: Colors.white,
                                          icon: Icons
                                              .arrow_drop_down_circle_sharp)),
                                ],
                              )),
                        ]),
                        SizedBox(
                          height: 5.0,
                        ),
                        Visibility(
                            visible: isDisplay,
                            child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xFFF05A22),
                                    style: BorderStyle.solid,
                                    width: 1.0,
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                height: 40,
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 8.0, right: 8.0),
                                            child: TextField(
                                              textAlign: TextAlign.center,
                                              controller: txtFilter,
                                              maxLines: 1,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: 'Enter a search',
                                              ),
                                            ))),
                                    IconButton(
                                        onPressed: () {
                                          txtFilter.text = "";
                                          callBackButtonSearch();
                                          print("test");
                                        },
                                        icon: Icon(Icons.close_rounded)),
                                    IconButton(
                                        onPressed: () {
                                          callBackButtonSearch();
                                          print("test");
                                        },
                                        icon: Icon(Icons.search)),
                                  ],
                                )))
                      ],
                    ))),
          ),

          // DataTablet().getSearchForm(context,
          //                     txtFilter: txtFilter,
          //                     returnComboBox: callBackComboBox,
          //                     // dropDownData: _dropDownType,
          //                     comboSelected: _selectedType,
          //                     returnButtonSearch: callBackButtonSearch),
          Expanded(
              child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.asset('assets/images/pngwing.png', fit: BoxFit.fitWidth),
              Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Container(
                      width: MediaQuery.of(context).size.width - 40,
                      padding: EdgeInsets.all(10.0),
                      //color: Colors.red,
                      decoration: BoxDecoration(
                        // border: Border.all(
                        //   color: Color(0xFFF05A22),
                        //   style: BorderStyle.solid,
                        //   width: 1.0,
                        // ),

                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0)),
                      ),
                      child: FutureBuilder(
                          future: getData(isFirst: isPertama),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasError) print(snapshot.error);
                            if (snapshot.hasData) {
                              // if(isPertama==true){
                              // var jmlData = snapshot.data==null ? 0 : snapshot.data?["isSuccess"]==false? 0: snapshot.data?["data"]["total_data"]==null ? 0 :snapshot.data?["data"]["total_data"];
                              // Fungsi fungsi = new Fungsi();
                              // iPosMax = fungsi.getIposMax(_selectedType, jmlData);
                              // }
                              //List<dynamic>? list = snapshot.data?["isSuccess"]==false? [] : snapshot.data?["data"]["data"];

                              newData = snapshot.data;
                              isPertama = false;
                              return Column(
                                children: <Widget>[
                                  DataTablet().getListData(
                                      context: context,
                                      newData: newData,
                                      callBackDelete: callBackDelete,
                                      callBackEdit: callBackEdit,
                                      callBackView: callBackView,
                                      isiWidget: callBackIsiWidget,
                                      isSeperateLine: false,
                                      isDeleteOnly: true,
                                      isKlik: isKlik,
                                      warna: Colors.green,
                                      isAktifGantiWarna: false,
                                      filePNG: "assets/images/list-card.png",
                                      isCustom: true,
                                      isNoDecoration: true,
                                      isAPI: true),
                                ],
                              );
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          })))
            ],
          ))
        ],
      ))
      // Container(
      //     height: 38.0,
      //     padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5),
      //     alignment: Alignment.centerLeft,
      //     child: Label().labelStatus(
      //         label: "Daftar Menu",
      //         borderRadius: 15.0,
      //         width: 140.0,
      //         warna: Colors.orange,
      //         warnaBorder: Colors.yellow)),
      // Expanded(
      //     child: ListView.builder(
      //   itemCount: listHeader.length,
      //   itemBuilder: (context, index) {
      //     return StickyHeader(
      //         // header: Container(
      //         //   height: 38.0,

      //         //   color: Colors.grey[300],
      //         //   padding:  const EdgeInsets.only(left: 5,top: 5, bottom: 5),
      //         //   alignment: Alignment.centerLeft,
      //         //   child:  Label().labelStatus(label: "Daftar Menu", borderRadius: 15.0,width: 100.0, warna: Colors.orange, warnaBorder: Colors.yellow)
      //         //   ),
      //         header: Container(),

      //         // ignore: avoid_unnecessary_containers
      //         // header: Container(
      //         //   height: 7.0,
      //         // ),
      //         // ignore: avoid_unnecessary_containers
      //         content: GridView.builder(
      //           shrinkWrap: true,
      //           physics: const NeverScrollableScrollPhysics(),
      //           itemCount: listTitle.length,
      //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //             crossAxisCount: 4,
      //             childAspectRatio: 1,
      //           ),
      //           itemBuilder: (contxt, indx) {
      //             return GestureDetector(
      //                 onTap: () async {
      //                   await Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (context) => isOwner
      //                             ? listPageOwner[index]
      //                             : isAdmin
      //                                 ? listPageAdmin[indx]
      //                                 : listPageUser[indx]),
      //                   );
      //                   setState(() {});
      //                   print('diklik');
      //                 },
      //                 child: Card(
      //                     color: Colors.grey[100],
      //                     child: Column(children: [
      //                       Expanded(
      //                           child: Padding(
      //                         padding: EdgeInsets.all(5.0),
      //                         child: ClipRRect(
      //                           borderRadius: BorderRadius.circular(10),
      //                           // ignore: sized_box_for_whitespace
      //                           child: Container(
      //                               height: 5.0,
      //                               child: Stack(
      //                                 alignment: Alignment.center,
      //                                 children: [
      //                                   Column(
      //                                     mainAxisAlignment:
      //                                         MainAxisAlignment.center,
      //                                     crossAxisAlignment:
      //                                         CrossAxisAlignment.center,
      //                                     children: <Widget>[
      //                                       Container(
      //                                         width: 40,
      //                                         height: 40,
      //                                         child: Image.asset(
      //                                             'assets/images/widget-icons/' +
      //                                                 listImageAdmin[indx]),
      //                                       ),
      //                                       SizedBox(height: 7),
      //                                       Text(listTitle[indx],
      //                                           textAlign: TextAlign.center,
      //                                           style: TextStyle(
      //                                               fontSize: 10,
      //                                               fontWeight: FontWeight.bold,
      //                                               color: Colors.purple[700])),
      //                                     ],
      //                                   ),
      //                                   listTitle[indx].toLowerCase() ==
      //                                               "approval penarikan dana" ||
      //                                           listTitle[indx].toLowerCase() ==
      //                                               "pembayaran"
      //                                       ? dataPenarikan > 0 &&
      //                                               listTitle[indx]
      //                                                       .toLowerCase() ==
      //                                                   "approval penarikan dana"
      //                                           ? Align(
      //                                               alignment:
      //                                                   Alignment.topRight,
      //                                               child: Label()
      //                                                   .labelNotifikasi(
      //                                                       label: dataPenarikan
      //                                                           .toString()))
      //                                           : dataPembayaran > 0 &&
      //                                                   listTitle[indx]
      //                                                           .toLowerCase() ==
      //                                                       "pembayaran"
      //                                               ? Align(
      //                                                   alignment:
      //                                                       Alignment.topRight,
      //                                                   child: Label()
      //                                                       .labelNotifikasi(
      //                                                           label: dataPembayaran
      //                                                               .toString()))
      //                                               : SizedBox()
      //                                      : SizedBox()
      //                                 ],
      //                               )),
      //                         ),
      //                       )),
      //                     ])));
      //           },
      //         ));
      //   },
      //   shrinkWrap: true,
      // ))
    ]);
  }
}

class PushNotification {
  PushNotification({
    this.id,
    this.title,
    this.body,
  });

  String? id;
  String? title;
  String? body;
}

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Background Notification');
  await Firebase.initializeApp();
  NotificationService.showNotification(message);
}

class NotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future initialize(context) async {
    print('initialize Notification!');
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        debugPrint('payload $payload');
        await showDialog(
          context: context,
          builder: (BuildContext context) => DoaDialog()
              .buildAddDialog(context, DashboardPage(), payload, true, false),
        );
      }
    });
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    print('payload=');
    String? payload = notificationAppLaunchDetails!.payload;
    if (payload != null) {
      await showDialog(
        context: context,
        builder: (BuildContext context) => DoaDialog()
            .buildAddDialog(context, DashboardPage(), payload, true, false),
      );
    }
  }

  static Future showNotification(RemoteMessage message) async {
    var data = <dynamic, dynamic>{"id": message.data['id']};
    ApiUtilities auth = ApiUtilities();
    final dataDoa =
        await auth.getGlobalParam(namaApi: "masterdoa", where: data);
    bool isSukses = dataDoa["isSuccess"] as bool;
    if (isSukses) {
      var record = dataDoa["data"]["data"][0];

      PushNotification notification = PushNotification(
          id: message.data['id'], title: record['name'], body: record['arab']);

      Future<String> _downloadAndSaveFile(String url, String fileName) async {
        final Directory? directory = await getApplicationDocumentsDirectory();
        final String filePath = '${directory!.path}/$fileName.png';
        final http.Response response = await http.get(Uri.parse(url));
        final File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        return filePath;
      }

      final String largeIconPath = await _downloadAndSaveFile(
        'https://katalogdoa.com/doa.png',
        'largeIcon',
      );
      final String bigPicturePath = await _downloadAndSaveFile(
        'https://katalogdoa.com/doa.png',
        'bigPicture',
      );

      _flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              playSound: true,
              sound: const RawResourceAndroidNotificationSound('auzubillah'),
              importance: Importance.max,
              priority: Priority.high,
              enableLights: true,
              color: Colors.blue,
              largeIcon: FilePathAndroidBitmap(largeIconPath),
              styleInformation: BigPictureStyleInformation(
                FilePathAndroidBitmap(bigPicturePath),
                hideExpandedLargeIcon: false,
                htmlFormatContent: true,
                htmlFormatTitle: true,
              ),
              icon: "@mipmap/launcher_icon",
            ),
          ),
          payload: notification.id);
    }
  }
}
