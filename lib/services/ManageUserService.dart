import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:doa/utils/api.dart';
import 'package:doa/utils/pref_manager.dart';

class ManageUserService {
  // Future<int> insert(dataRegister) async {
  //   var url = Api.BASE_URL + 'register';
  //   var res = await http.post(url,
  //       headers: {'Accept': 'application/json'}, body: dataRegister);
  //   var resCode = res.statusCode;
  //   Map<String, dynamic> body = json.decode(res.body);
  //   var _token = body['id_token'];
  //   int iduser = 0;
  //   if (res.statusCode == 201) {
  //   } else {}
  //   return resCode;
  // }

  // Future<int> update(dataRegister) async {
  //   var _token = Prefs.getString('token');
  //   var url = Api.BASE_URL + 'api/updateUser';
  //   print('dataregister=' + json.encode(dataRegister).toString());
  //   var res = await http.post(url,
  //       headers: {
  //         'Content-type': 'application/json',
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer $_token'
  //       },
  //       body: json.encode(dataRegister));
  //   var resCode = res.statusCode;
  //   Map<String, dynamic> body = json.decode(res.body);

  //   int iduser = 0;
  //   if (res.statusCode == 201) {
  //   } else {}
  //   print(resCode.toString());
  //   return resCode;
  // }

  // Future<int> usersCount(
  //     {kondisi = '', selectedType = '3', ownerId = ''}) async {
  //   var _token = Prefs.getString('token');
  //   var url = Api.BASE_URL + 'api/listAllUsersCount';
  //   var res = await http.post(url,
  //       headers: {
  //         'Content-type': 'application/json',
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer $_token'
  //       },
  //       body: json.encode({'kondisi': kondisi, 'owner_id': ownerId}));
  //   var body = json.decode(res.body);
  //   if (res.statusCode == 201 || res.statusCode == 200) {
  //     int nRow = body['total'];
  //     return (nRow / int.parse(selectedType)) >
  //             ((nRow / int.parse(selectedType)).toInt()).toDouble()
  //         ? (nRow / int.parse(selectedType)).toInt() + 1
  //         : (nRow / int.parse(selectedType)).toInt();
  //   } else {
  //     return 0;
  //   }
  // }

  // Future<List<User>> usersPage(
  //     {page = 1, limit = 3, kondisi = '', ownerId = ''}) async {
  //   var _token = Prefs.getString('token');
  //   var url = Api.BASE_URL + 'api/listAllUsersPage';
  //   var res = await http.post(url,
  //       headers: {
  //         'Content-type': 'application/json',
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer $_token'
  //       },
  //       body: json.encode({
  //         'page': page,
  //         'limit': limit,
  //         'kondisi': kondisi,
  //         'owner_id': ownerId
  //       }));

  //   var body = json.decode(res.body);
  //   if (res.statusCode == 201 || res.statusCode == 200) {
  //     return List<User>.generate(body['success'].length, (int index) {
  //       final user = User(
  //         id: body['success'][index]['id'],
  //         name: body['success'][index]['name'],
  //         email: body['success'][index]['email'],
  //         isAktif: body['success'][index]['isAktif'],
  //         foto: body['success'][index]['foto'],
  //         isUnlimited: body['success'][index]['isUnlimited'],
  //         lead_time: body['success'][index]['lead_time'],
  //         expired_date: body['success'][index]['expired_date'],
  //         role: body['success'][index]['role'],
  //         isDeleted: body['success'][index]['isDeleted'],
  //         isExpired: body['success'][index]['isExpired'],
  //         first_password: body['success'][index]['first_password'],
  //         isEmail: body['success'][index]['isEmail'],
  //       );

  //       return user;
  //     });
  //   } else {
  //     return [];
  //   }
  // }

  // Future<int> changePassword(
  //     {old_password, new_password, confirm_password}) async {
  //   var _token = Prefs.getString('token');
  //   var url = Api.BASE_URL + 'api/changePassword';
  //   var res = await http.post(url,
  //       headers: {
  //         'Content-type': 'application/json',
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer $_token'
  //       },
  //       body: json.encode({
  //         'old_password': old_password,
  //         'new_password': new_password,
  //         'confirm_password': confirm_password,
  //         'change_password': 1
  //       }));
  //   if (res.statusCode == 200) {
  //     var body = json.decode(res.body);
  //     return body['status'];
  //   }
  //   return res.statusCode;
  // }
}
