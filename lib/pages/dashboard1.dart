import 'package:date_format/date_format.dart';
// import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:doa/pages/onboarding.dart';
import 'package:doa/utils/function.dart';
import 'package:doa/widgets/blury-container.dart';
import 'package:doa/widgets/datepicker.dart';
import 'package:doa/widgets/fl-chart.dart';
import 'package:doa/widgets/textbox.dart';
import 'package:easy_localization/easy_localization.dart';
// ignore: import_of_legacy_library_into_null_safe
// import 'package:sticky_headers/sticky_headers/widget.dart';

// ignore: use_key_in_widget_constructors
class Dashboard1Page extends StatefulWidget {
  @override
  _Dashboard1PageState createState() => _Dashboard1PageState();
}

class _Dashboard1PageState extends State<Dashboard1Page> {

  String? tanggalAwal;
String? tanggalAkhir;
  List<String> listHeader = ['Dashboard'];
  bool isAdmin = false;
  List<String> listTitleAdmin = [
    'Setor Sampah',
    'List Pembayaran',
    'Pembayaran',
    'Approval User Baru',
    'Rekening Koran',
  ];
  List<String> listTitleUser = [
    'Penarikan Saldo',
    'Rekening Koran',
  ];
   List<String> listTitle=[];
  List<String> listImage = ['baca-quran.png', 'adzan.png', 'doa.png'];
  List<dynamic> listPage = [Onboarding()];
  final txtAwal = TextEditingController();
  final txtAkhir = TextEditingController();

  bool isDisplay = true;



    @override
  void initState() {
    listTitle=isAdmin?listTitleAdmin : listTitleUser;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: Text("Dashboard"),
        centerTitle: true,
      ),
      backgroundColor: Colors.lightGreen[400],
      body: gridHeader(),
    );
  }

  Widget gridHeader() {

  txtAwal.text = Fungsi().fmtDateDayNow();
  tanggalAwal = Fungsi().fmtDateTimeYearNow();
  txtAkhir.text = Fungsi().fmtDateDayNow();
  tanggalAkhir = Fungsi().fmtDateTimeYearNow();

    displayTanggalAwal(formatDate, formatYear) {
          setState(() {
            tanggalAwal = formatYear.toString();
            txtAwal.text = formatDate.toString();
          });
        }
        displayTanggalAkhir(formatDate, formatYear) {
          setState(() {
            tanggalAkhir = formatYear.toString();
            txtAkhir.text = formatDate.toString();
          });
        }

        fungsiCallbackButton(){}

    return DatePicker().rangeDatePickerBorder(
      context: context, 
      inputBoxControllerAwal: txtAwal, 
      inputBoxControllerAkhir: txtAkhir, 
      fungsiCallbackAwal: displayTanggalAwal, 
      fungsiCallbackAkhir: displayTanggalAkhir , 
      fungsiCallbackButton:fungsiCallbackButton, 
      formatDateAwal: tanggalAwal, 
      formatDateAkhir: tanggalAkhir, buttonColor1: Colors.blueAccent, buttonColor2: Colors.blue[700] );

    // Stack(children: [
    //   Container(
    //       color: Colors.transparent,
    //       width: MediaQuery.of(context).size.width,
    //       child: Image.asset('assets/images/background-login.png',
    //           height: MediaQuery.of(context).size.height, fit: BoxFit.fill)),
     
    // ]);
  }
}
