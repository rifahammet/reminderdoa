import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:date_format/date_format.dart';
// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:image/image.dart' as ImageProcess;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
class Fungsi{
dynamic isVocal(str){
var prefix = str.toString().substring(0,1).toString();
var restPattern = r'[aiueoAIUEO]';
var myRegExp = RegExp(RegExp.escape(prefix) + restPattern);
var string = str;
return !string.startsWith(myRegExp);
}

String format(n, {bool isInteger = true, mataUang = "Rp.", isMataUang = false, isDouble=true}) {
    if (isInteger) {
      final formatter =  NumberFormat("#,###", "en_US");
      return (isMataUang ? mataUang + " ":"")+formatter.format( isDouble? n : double.parse(n));
    } else {
      final formatter =  NumberFormat("#,###.00", "en_US");
      return (isMataUang ? mataUang + " ":"")+formatter.format(isDouble? n : double.parse(n));
    }
  }

  String? validateString(String value) {
    if (value.isEmpty)
      return "Akun tidak boleh kosong";
    else if (value.length < 6) return "Akun minimal harus 6";
    return null;
  }

  String? validateNumber(String value) {
    if (value.isEmpty)
      return "Kata sandi tidak boleh kosong";
    else if (value.length < 6) return "minimal harus 6";
    return null;
  }

  bool StringToBool(data, {parameter ="1"}){
    return data.toString().toLowerCase()==parameter;
  }

  fmtDateDay(val) {
    DateTime todayDate = DateTime.parse(val.toString());
    return formatDate(todayDate, [dd, '-', mm, '-', yyyy]);
  }

  fmtDateYear(val) {
    DateTime todayDate = DateTime.parse(val.toString());
    return formatDate(todayDate, [yyyy, '-', mm, '-', dd]);
  }

    fmtDateTimeDay(val) {
    DateTime todayDate = DateTime.parse(val.toString());
    return formatDate(todayDate, [dd, '-', mm, '-', yyyy, ' ',HH,':',nn,':',ss]);
  }

    fmtDateTimeYear(val) {
    DateTime todayDate = DateTime.parse(val.toString());
    return formatDate(todayDate, [yyyy, '-', mm, '-', dd, ' ',   HH,':',nn,':',ss]);
  }

  fmtDateTimeYearNow(){
    return formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd  , ' ',   HH,':',nn,':',ss]);
  }

      fmtDateTimeDayNow() {
    return formatDate(DateTime.now(), [dd, '-', mm, '-', yyyy, ' ',HH,':',nn,':',ss]);
  }

    fmtDateYearNow(){
    return formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd  ]);
  }

      fmtDateDayNow() {
    return formatDate(DateTime.now(), [dd, '-', mm, '-', yyyy]);
  }

    double fmtStringToInt(val) {
    return double.parse(val.toString().replaceAll(",", ""));
  }

   String? validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex =  RegExp(pattern.toString());
    if (!regex.hasMatch(value)) {
      return "Enter Valid Email";
    } else {
      return null;
    }
  }

  Future<dynamic> fetchData({String? url}) async {
  final response = await http
      .get(Uri.parse(url!));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return jsonDecode(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

getIposMax(limit,jumlahData){
  var n = int.parse (jumlahData.toString())/int.parse(limit.toString());
  if(n > n.toInt()){
   n= n+1;
  }
return n.toInt();
}

getPos(index, iPos, iPosMax) {
    switch (index) {
      case 0:
        {
          return 1;
        }
      // ignore: dead_code
      break;
      case 1:
        {
          return iPos - 1 <= 0 ? 1 : iPos - 1;
        }
        // ignore: dead_code
      break;
      case 2:
        {
          return iPos + 1 > iPosMax ? iPosMax : iPos + 1;
        }
        // ignore: dead_code
      break;
      case 3:
        {
          return iPosMax;
        }
        // ignore: dead_code
      break;
    }
  }


convertListToMap(data){

  dynamic listModel;
  for(Map i in data){
          listModel.add(i);
        }
        return listModel;
}

listToDropDownMenuItem(listData){
 return listData
        .map((String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ))
        .toList();
}

String strToMD5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}

Uint8List FileImageToImage(pickedImage) {
    List<int> imageBytes = pickedImage.readAsBytesSync();
    String imageB64 = base64Encode(imageBytes);
    return Base64Decoder().convert(imageB64);
  }

  String ImageToString(imagePath) {
    //File file = File(imagePath.path);
    final _imageFile = ImageProcess.decodeImage(
      imagePath.readAsBytesSync(),
    );
    return base64Encode(ImageProcess.encodePng(_imageFile));
  }

  Uint8List StringToImage(imageString) {
    return Base64Decoder().convert(imageString);
    //  image = Image.memory(_byteImage);
  }

  String Uint8ListToString(data) {
    return base64Encode(data);
  }

  dynamic findDataInArray({List<dynamic>? listData,field,data}){
    return listData!.firstWhere((element)  => element[field] == data, orElse: () => null);
  }

    Future<String> createFolder(String cow) async {
    final dir = Directory((await getExternalStorageDirectory())!.path + '/$cow');
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if ((await dir.exists())) {
      return dir.path;
    } else {
      dir.create();
      return dir.path;
    }
  }

}