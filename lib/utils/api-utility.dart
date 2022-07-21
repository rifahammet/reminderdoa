import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:doa/utils/api.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
import 'package:doa/utils/email_util.dart';
import 'package:sweetalert/sweetalert.dart';

class ApiUtilities {
  // Future<Map<String, dynamic>>
  Future<dynamic> getGlobalParam(
      {namaApi, where, whereIn, like, startFrom = 0, limit = 5}) async {
    var token = Api.TOKEN.toString();
    //print(token.toString());
    var datajson;
    if (where != null) {
      if (whereIn != null) {
        if (like != null) {
          datajson = {
            "where": json.encode(where),
            "wherein": json.encode(whereIn),
            "like": json.encode(like),
            "limit": "$startFrom,$limit"
          };
        } else {
          datajson = {
            "where": json.encode(where),
            "wherein": json.encode(whereIn),
            "limit": "$startFrom,$limit"
          };
        }
      } else {
        if (like != null) {
          if (where != null) {
            datajson = {
              "where": json.encode(where),
              "like": json.encode(like),
              "limit": "$startFrom,$limit"
            };
          } else {
            datajson = {
              "like": json.encode(like),
              "limit": "$startFrom,$limit"
            };
          }
        } else {
          datajson = {
            "where": json.encode(where),
            "limit": "$startFrom,$limit"
          };
        }
      }
    } else {
      if (whereIn != null) {
        if (like != null) {
          datajson = {
            "wherein": json.encode(whereIn),
            "like": json.encode(like),
            "limit": "$startFrom,$limit"
          };
        } else {
          datajson = {
            "wherein": json.encode(whereIn),
            "limit": "$startFrom,$limit"
          };
        }
      } else {
        if (whereIn != null) {
          if (like != null) {
            datajson = {
              "wherein": json.encode(whereIn),
              "like": json.encode(like),
              "limit": "$startFrom,$limit"
            };
          } else {
            datajson = {
              "whereIn": json.encode(where),
              "limit": "$startFrom,$limit"
            };
          }
        } else {
          datajson = {"like": json.encode(like), "limit": "$startFrom,$limit"};
        }
      }
    }
    /* sementara
    if (whereIn != null) {
      if (like != null) {
        datajson = {
          "wherein": json.encode(whereIn),
          "like": json.encode(like),
          "limit": "$startFrom,$limit"
        };
      } else {
        datajson = {
          "wherein": json.encode(whereIn),
          "limit": "$startFrom,$limit"
        };
      }
    } else {
      if (like != null) {
        if (where != null) {
          datajson = {"where": json.encode(where), "like": json.encode(like), "limit": "$startFrom,$limit"};
        }else{
            datajson = {"like": json.encode(like), "limit": "$startFrom,$limit"};
        }
        
      } else {
        datajson = {"where": json.encode(where), "limit": "$startFrom,$limit"};
      }
    }
    */
    //print('kondisi=' + datajson.toString());
    try {
      print(Api.BASE_URL + namaApi);
      var resAccount = await http.post(Uri.parse(Api.BASE_URL + namaApi),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/x-www-form-urlencoded'
          },
          body: datajson);
      //print('res='+resAccount.body.toString());
      var res = json.decode(resAccount.body);
      //print('res='+res.toString());
      var isSukses = false;
      if (res['success'] == null) {
        isSukses = false;
      } else {
        if (res['success'] && res['data'].length > 0) {
          isSukses = true;
        } else {
          isSukses = false;
        }
      }
      return {
        'kode': resAccount.statusCode,
        'isSuccess': isSukses,
        'error': 'validation error',
        'error_message': 'Data is Empty',
        'data': res //masalah tadi lemparan disininya res["data"]
      };
    } catch (err) {
      print(err.toString());
      if (err.toString().contains('SocketException: Failed host lookup')) {
        return {
          'kode': 500,
          'isSuccess': false,
          'error': 'Error Connection',
          'error_message':
              'Cannot connect to server\nplease contact your administator'
        };
      } else if (err.toString().contains('Connection refused')) {
        return {
          'kode': 501,
          'isSuccess': false,
          'error': 'Connection Refused',
          'error_message':
              'Connection refused\nplease contact your administator'
        };
      }
      return {
        'kode': 505,
        'isSuccess': false,
        'error': 'Error',
        'error_message': 'Error System'
      };
    }
  }

  Future<dynamic> getGlobalParamBatch(
      {namaApi, where, whereIn, like, startFrom = 0, limit = 5}) async {
    var token = Api.TOKEN.toString();
    var datajson;
    if (whereIn != null) {
      if (like != null) {
        datajson = {
          "wherein": whereIn,
          "like": json.encode(like),
          "limit": "$startFrom,$limit"
        };
      } else {
        datajson = {"wherein": whereIn, "limit": "$startFrom,$limit"};
      }
    } else {
      if (like != null) {
        datajson = {"like": json.encode(like), "limit": "$startFrom,$limit"};
      } else {
        datajson = {"where": json.encode(where), "limit": "$startFrom,$limit"};
      }
    }
    //print('kondisi=' + datajson.toString());
    try {
      var resAccount = await http.post(Uri.parse( Api.BATCH_URL + namaApi),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/x-www-form-urlencoded'
          },
          body: datajson);
      var res = json.decode(resAccount.body);
      var isSukses = false;
      if (res['success'] == null) {
        isSukses = false;
      } else {
        if (res['success'] && res['data'].length > 0) {
          isSukses = true;
        } else {
          isSukses = false;
        }
      }
      return {
        'kode': resAccount.statusCode,
        'isSuccess': isSukses,
        'error': 'validation error',
        'error_message': 'Data is Empty',
        'data': res //masalah tadi lemparan disininya res["data"]
      };
    } catch (err) {
      if (err.toString().contains('SocketException: Failed host lookup')) {
        return {
          'kode': 500,
          'isSuccess': false,
          'error': 'Error Connection',
          'error_message':
              'Cannot connect to server\nplease contact your administator'
        };
      } else if (err.toString().contains('Connection refused')) {
        return {
          'kode': 501,
          'isSuccess': false,
          'error': 'Connection Refused',
          'error_message':
              'Connection refused\nplease contact your administator'
        };
      }
      return {
        'kode': 505,
        'isSuccess': false,
        'error': 'Error',
        'error_message': 'Error System'
      };
    }
  }

  Future<dynamic> getGlobalParamNoLimit({namaApi, where, whereIn, like}) async {
    var token = Api.TOKEN.toString();
    var datajson;
    if (whereIn != null) {
      if (like != null) {
        datajson = {"wherein": whereIn, "like": json.encode(like)};
      } else {
        datajson = {"wherein": whereIn};
      }
    } else {
      if (like != null) {
        datajson = {"like": json.encode(like)};
      } else {
        datajson = {"where": json.encode(where)};
      }
    }
    //print('kondisi=' + datajson.toString());
    try {
      var resAccount = await http.post(Uri.parse(Api.BASE_URL + namaApi),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/x-www-form-urlencoded'
          },
          body: datajson);
      var res = json.decode(resAccount.body);
      var isSukses = false;
      if (res['success'] == null) {
        isSukses = false;
      } else {
        if (res['success'] && res['data'].length > 0) {
          isSukses = true;
        } else {
          isSukses = false;
        }
      }
      return {
        'kode': resAccount.statusCode,
        'isSuccess': isSukses,
        'error': 'validation error',
        'error_message': 'Data is Empty',
        'data': res //masalah tadi lemparan disininya res["data"]
      };
    } catch (err) {
      if (err.toString().contains('SocketException: Failed host lookup')) {
        return {
          'kode': 500,
          'isSuccess': false,
          'error': 'Error Connection',
          'error_message':
              'Cannot connect to server\nplease contact your administator'
        };
      } else if (err.toString().contains('Connection refused')) {
        return {
          'kode': 501,
          'isSuccess': false,
          'error': 'Connection Refused',
          'error_message':
              'Connection refused\nplease contact your administator'
        };
      }
      return {
        'kode': 505,
        'isSuccess': false,
        'error': 'Error',
        'error_message': 'Error System'
      };
    }
  }

  Future<Map<String, dynamic>> saveNewData(data, String namaApi, prefix) async {
    // var datajson = {
    //   'data': json.encode(<dynamic, dynamic>{'nama': 'danish', 'nohp': '021451'}),
    //   'action': 'new'
    // };
    var datajson = {
      "data": json.encode(data),
      "action": "new",
      "prefix": prefix
    };
    // print(datajson.toString());
    var token = Api.TOKEN.toString();
    try {
      var resAccount = await http.post(Uri.parse(Api.BASE_URL + namaApi),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/x-www-form-urlencoded'
          },
          body: datajson);
      var res = json.decode(resAccount.body);
      print('debug =' +
          resAccount.statusCode.toString() +
          ' ' +
          resAccount.body.toString());
      var isSukses = false;
      if (res['success'] == null) {
        isSukses = false;
      } else {
        if (res['success']) {
          isSukses = true;
        }
      }
      return isSukses
          ? {
              'kode': resAccount.statusCode,
              'isSuccess': isSukses,
              'data': res['data'],
              'error': res['error'],
              'error_message': res['error_description']
            }
          : {
              'kode': resAccount.statusCode,
              'isSuccess': isSukses,
              'error': res['error'],
              'error_message': res['error_description']
            };
    } catch (err) {
      if (err.toString().contains('SocketException: Failed host lookup')) {
        return {
          'kode': 500,
          'isSuccess': false,
          'error': 'Error Connection',
          'error_message':
              'Cannot connect to server, please contact your administator'
        };
      } else if (err.toString().contains('Connection refused')) {
        return {
          'kode': 501,
          'isSuccess': false,
          'error': 'Connection Refused',
          'error_message':
              'Cannot connect to server, please contact your administator'
        };
      }
      print(err.toString());
      return {
        'kode': 505,
        'isSuccess': false,
        'error': 'Error',
        'error_message': 'Error System'
      };
    }
  }

  Future<Map<String, dynamic>> saveBatchData(data, {prefix = ""}) async {
    // var datajson = {
    //   'data': json.encode(<dynamic, dynamic>{'nama': 'danish', 'nohp': '021451'}),
    //   'action': 'new'
    // };
    var datajson = {
      "data": json.encode(data),
      "action": "new",
      "prefix": prefix
    };
    // print(datajson.toString());
    var token = Api.TOKEN.toString();
    try {
      print('datajson='+datajson.toString());
      var resAccount = await http.post(Uri.parse(Api.BATCH_URL),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/x-www-form-urlencoded'
          },
          body: datajson);
      // print("error code : " + resAccount.statusCode.toString());
      var res = json.decode(resAccount.body);
      print('debug =' +
          resAccount.statusCode.toString() +
          ' ' +
          resAccount.body.toString());
      var isSukses = false;
      if (res['success'] == null) {
        isSukses = false;
      } else {
        if (res['success']) {
          isSukses = true;
        }
      }
      return {
        'kode': resAccount.statusCode,
        'isSuccess': isSukses,
        'error': res['error'],
        'error_message': res['error_description']
      };
    } catch (err) {
      print('error= '+ err.toString());
      if (err.toString().contains('SocketException: Failed host lookup')) {
        return {
          'kode': 500,
          'isSuccess': false,
          'error': 'Error Connection',
          'error_message':
              'Cannot connect to server, please contact your administator'
        };
      } else if (err.toString().contains('Connection refused')) {
        return {
          'kode': 501,
          'isSuccess': false,
          'error': 'Connection Refused',
          'error_message':
              'Cannot connect to server, please contact your administator'
        };
      }
      return {
        'kode': 505,
        'isSuccess': false,
        'error': 'Error',
        'error_message': 'Error System'
      };
    }
  }

  Future<Map<String, dynamic>> updateData(data, String namaApi,
      {where, whereIn, like, prefix = ""}) async {
    // var datajson = {
    //   'data': json.encode(<dynamic, dynamic>{'nama': 'danish', 'nohp': '021451'}),
    //   'action': 'new'
    // };
    var datajson;
    if (whereIn != null) {
      if (like != null) {
        datajson = {
          "data": json.encode(data),
          "action": "update",
          "where": json.encode(where),
          "wherein": json.encode(whereIn),
          "like": json.encode(like),
          "prefix": prefix
        };
      } else {
        datajson = {
          "data": json.encode(data),
          "action": "update",
          "where": json.encode(where),
          "wherein": json.encode(whereIn),
          "prefix": prefix
        };
      }
    } else {
      datajson = {
        "data": json.encode(data),
        "action": "update",
        "where": json.encode(where),
        "prefix": prefix
      };
    }

    // print(datajson.toString());
    var token = Api.TOKEN.toString();
    try {
      var resAccount = await http.post(Uri.parse( Api.BASE_URL + namaApi),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/x-www-form-urlencoded'
          },
          body: datajson);
      var res = json.decode(resAccount.body);
      print('debug =' +
          resAccount.statusCode.toString() +
          ' ' +
          resAccount.body.toString());
      var isSukses = false;
      if (res['success'] == null) {
        isSukses = false;
      } else {
        if (res['success']) {
          isSukses = true;
        }
      }
      return {
        'kode': resAccount.statusCode,
        'isSuccess': isSukses,
        'error': res['error'],
        'error_message': res['error_description']
      };
    } catch (err) {
      if (err.toString().contains('SocketException: Failed host lookup')) {
        return {
          'kode': 500,
          'isSuccess': false,
          'error': 'Error Connection',
          'error_message':
              'Cannot connect to server, please contact your administator'
        };
      } else if (err.toString().contains('Connection refused')) {
        return {
          'kode': 501,
          'isSuccess': false,
          'error': 'Connection Refused',
          'error_message':
              'Cannot connect to server, please contact your administator'
        };
      }
      return {
        'kode': 505,
        'isSuccess': false,
        'error': 'Error',
        'error_message': 'Error System'
      };
    }
  }

  Future<Map<String, dynamic>> updateBatchData(data,
      {where, whereIn, like}) async {
    // var datajson = {
    //   'data': json.encode(<dynamic, dynamic>{'nama': 'danish', 'nohp': '021451'}),
    //   'action': 'new'
    // };
    var datajson;
    if (whereIn != null) {
      if (like != null) {
        datajson = {
          "data": json.encode(data),
          "action": "update",
          "where": json.encode(where),
          "wherein": json.encode(whereIn),
          "like": json.encode(like)
        };
      } else {
        datajson = {
          "data": json.encode(data),
          "action": "update",
          "where": json.encode(where),
          "wherein": json.encode(whereIn)
        };
      }
    } else {
      datajson = {
        "data": json.encode(data),
        "action": "update",
        "where": json.encode(where)
      };
    }

    print(datajson.toString());
    var token = Api.TOKEN.toString();
    try {
      var resAccount = await http.post(Uri.parse(Api.BATCH_URL),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/x-www-form-urlencoded'
          },
          body: datajson);
      var res = json.decode(resAccount.body);
      print('debug =' +
          resAccount.statusCode.toString() +
          ' ' +
          resAccount.body.toString());
      var isSukses = false;
      if (res['success'] == null) {
        isSukses = false;
      } else {
        if (res['success']) {
          isSukses = true;
        }
      }
      return {
        'kode': resAccount.statusCode,
        'isSuccess': isSukses,
        'error': res['error'],
        'error_message': res['error_description']
      };
    } catch (err) {
      if (err.toString().contains('SocketException: Failed host lookup')) {
        return {
          'kode': 500,
          'isSuccess': false,
          'error': 'Error Connection',
          'error_message':
              'Cannot connect to server, please contact your administator'
        };
      } else if (err.toString().contains('Connection refused')) {
        return {
          'kode': 501,
          'isSuccess': false,
          'error': 'Connection Refused',
          'error_message':
              'Cannot connect to server, please contact your administator'
        };
      }
      return {
        'kode': 505,
        'isSuccess': false,
        'error': 'Error',
        'error_message': 'Error System'
      };
    }
  }

  Future<Map<String, dynamic>> deleteData(data, String namaApi,
      {where, whereIn, like}) async {
    // var datajson = {
    //   'data': json.encode(<dynamic, dynamic>{'nama': 'danish', 'nohp': '021451'}),
    //   'action': 'new'
    // };
    var datajson;
    if (whereIn != null) {
      if (like != null) {
        datajson = {
          "data": json.encode(data),
          "action": "delete",
          "where": json.encode(where),
          "wherein": json.encode(whereIn),
          "like": json.encode(like)
        };
      } else {
        datajson = {
          "data": json.encode(data),
          "action": "delete",
          "where": json.encode(where),
          "wherein": json.encode(whereIn)
        };
      }
    } else {
      datajson = {
        "data": json.encode(data),
        "action": "delete",
        "where": json.encode(where)
      };
    }

    print(datajson.toString());
    var token = Api.TOKEN.toString();
    try {
      var resAccount = await http.post(Uri.parse( Api.BASE_URL + namaApi),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/x-www-form-urlencoded'
          },
          body: datajson);
      var res = json.decode(resAccount.body);
      print('debug =' +
          resAccount.statusCode.toString() +
          ' ' +
          resAccount.body.toString());
      var isSukses = false;
      if (res['success'] == null) {
        isSukses = false;
      } else {
        if (res['success']) {
          isSukses = true;
        }
      }
      return {
        'kode': resAccount.statusCode,
        'isSuccess': isSukses,
        'error': res['error'],
        'error_message': res['error_description']
      };
    } catch (err) {
      if (err.toString().contains('SocketException: Failed host lookup')) {
        return {
          'kode': 500,
          'isSuccess': false,
          'error': 'Error Connection',
          'error_message':
              'Cannot connect to server, please contact your administator'
        };
      } else if (err.toString().contains('Connection refused')) {
        return {
          'kode': 501,
          'isSuccess': false,
          'error': 'Connection Refused',
          'error_message':
              'Cannot connect to server, please contact your administator'
        };
      }
      return {
        'kode': 505,
        'isSuccess': false,
        'error': 'Error',
        'error_message': 'Error System'
      };
    }
  }

  Future<Map<String, dynamic>> deleteBatchData(data,
      {where, whereIn, like}) async {
    // var datajson = {
    //   'data': json.encode(<dynamic, dynamic>{'nama': 'danish', 'nohp': '021451'}),
    //   'action': 'new'
    // };
    var datajson;
    if (whereIn != null) {
      if (like != null) {
        datajson = {
          "data": json.encode(data),
          "action": "delete",
          "where": json.encode(where),
          "wherein": json.encode(whereIn),
          "like": json.encode(like)
        };
      } else {
        datajson = {
          "data": json.encode(data),
          "action": "delete",
          "where": json.encode(where),
          "wherein": json.encode(whereIn)
        };
      }
    } else {
      datajson = {
        "data": json.encode(data),
        "action": "delete",
        "where": json.encode(where)
      };
    }

    print(datajson.toString());
    var token = Api.TOKEN.toString();
    try {
      var resAccount = await http.post(Uri.parse( Api.BATCH_URL),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/x-www-form-urlencoded'
          },
          body: datajson);
      var res = json.decode(resAccount.body);
      print('debug =' +
          resAccount.statusCode.toString() +
          ' ' +
          resAccount.body.toString());
      var isSukses = false;
      if (res['success'] == null) {
        isSukses = false;
      } else {
        if (res['success']) {
          isSukses = true;
        }
      }
      return {
        'kode': resAccount.statusCode,
        'isSuccess': isSukses,
        'error': res['error'],
        'error_message': res['error_description']
      };
    } catch (err) {
      if (err.toString().contains('SocketException: Failed host lookup')) {
        return {
          'kode': 500,
          'isSuccess': false,
          'error': 'Error Connection',
          'error_message':
              'Cannot connect to server, please contact your administator'
        };
      } else if (err.toString().contains('Connection refused')) {
        return {
          'kode': 501,
          'isSuccess': false,
          'error': 'Connection Refused',
          'error_message':
              'Cannot connect to server, please contact your administator'
        };
      }
      return {
        'kode': 505,
        'isSuccess': false,
        'error': 'Error',
        'error_message': 'Error System'
      };
    }
  }

  void hapusData({context, data, namatabel, where, setState}) async {
    FocusScope.of(context).requestFocus(FocusNode());
    Map<String, dynamic> result =
        await deleteData(data, namatabel, where: where);
    // await pr.hide();
    if (result['kode'] == 200) {
      if (result['isSuccess']) {
        SweetAlert.show(
          context,
          subtitle: "Data has been deleted",
          style: SweetAlertStyle.loadingSuccess,
        );
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pop(context);
          setState(() {});
        });
      } else {
        SweetAlert.show(
          context,
          subtitle: result['error_message'],
          style: SweetAlertStyle.loadingerror,
        );
        Future.delayed(const Duration(seconds: 4), () {
          Navigator.pop(context);
        });
      }
    } else {
      SweetAlert.show(
        context,
        subtitle: result['error_message'],
        style: SweetAlertStyle.loadingerror,
      );
      Future.delayed(const Duration(seconds: 4), () {
        Navigator.pop(context);
      });
    }
  }

  void hapusBatchData({context, data, where, setState}) async {
    FocusScope.of(context).requestFocus(FocusNode());
    Map<String, dynamic> result = await deleteBatchData(data, where: where);
    // await pr.hide();
    if (result['kode'] == 200) {
      if (result['isSuccess']) {
        SweetAlert.show(
          context,
          subtitle: "Data has been deleted",
          style: SweetAlertStyle.loadingSuccess,
        );
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pop(context);
          setState(() {});
        });
      } else {
        SweetAlert.show(
          context,
          subtitle: result['error_message'],
          style: SweetAlertStyle.loadingerror,
        );
        Future.delayed(const Duration(seconds: 4), () {
          Navigator.pop(context);
        });
      }
    } else {
      SweetAlert.show(
        context,
        subtitle: result['error_message'],
        style: SweetAlertStyle.loadingerror,
      );
      Future.delayed(const Duration(seconds: 4), () {
        Navigator.pop(context);
      });
    }
  }

  void saveUpdateData(
      {context,
      isEdit,
      data,
      namaAPI,
      where,
      setState,
      isCustom = false,
      callBack,
      prefix = "",
      caption ="",
      isSingleDelete = false,
      isMoreHide = false}) async {
    FocusScope.of(context).requestFocus(FocusNode());
    Map<String, dynamic> result = isEdit
        ? await updateData(data, namaAPI, where: where)
        : await saveNewData(data, namaAPI, prefix);
    // await pr.hide();
    print('result=' + result.toString());
    if (result['kode'] == 200) {
      if (result['isSuccess']) {
        if (isCustom) {
          callBack(result);
        } else {
          SweetAlert.show(
            context,
            subtitle: caption != "" ? caption : isEdit ? "Data has been updated" : "Data has been saved",
            style: SweetAlertStyle.loadingSuccess,
          );
          Future.delayed(new Duration(seconds: 3), () {
            setState(() {});
            Navigator.pop(context);
            if (isMoreHide) {
              Navigator.pop(context);
            }
            if (!isSingleDelete) {
              Navigator.pop(context, true);
            }
            
          });
        }
        // Future.delayed(new Duration(seconds: 4), () {

        // });
      } else {
        SweetAlert.show(
          context,
          subtitle: result['error_message'],
          style: SweetAlertStyle.loadingerror,
        );
        new Future.delayed(new Duration(seconds: 4), () {
          Navigator.pop(context);
        });
      }
    } else {
      SweetAlert.show(
        context,
        subtitle: result['error_message'],
        style: SweetAlertStyle.loadingerror,
      );
      new Future.delayed(new Duration(seconds: 4), () {
        Navigator.pop(context);
      });
    }
  }

  void saveUpdateBatchData(
      {context,
      isEdit,
      data,
      setState,
      isCustom = false,
      callBack,
      prefix = "",
      isSingleDelete = false}) async {
    FocusScope.of(context).requestFocus(FocusNode());
    Map<String, dynamic> result = await saveBatchData(data, prefix: prefix);
    if (result['kode'] == 200) {
      if (result['isSuccess']) {
        if (isCustom) {
          callBack();
        } else {
          SweetAlert.show(
            context,
            subtitle: isEdit ? "Data has been updated" : "Data has been saved",
            style: SweetAlertStyle.loadingSuccess,
          );
          Future.delayed(new Duration(seconds: 3), () {
            setState(() {});
            Navigator.pop(context);
            if(!isSingleDelete){
              Navigator.pop(context, true);
            }
          });
        }
        // Future.delayed(new Duration(seconds: 4), () {

        // });
      } else {
        SweetAlert.show(
          context,
          subtitle: result['error_message'],
          style: SweetAlertStyle.loadingerror,
        );
        new Future.delayed(new Duration(seconds: 4), () {
          Navigator.pop(context);
        });
      }
    } else {
      SweetAlert.show(
        context,
        subtitle: result['error_message'],
        style: SweetAlertStyle.loadingerror,
      );
      new Future.delayed(new Duration(seconds: 4), () {
        Navigator.pop(context);
      });
    }
  }

  Future<dynamic> getDataBatch(data) async {
    var token = Api.TOKEN.toString();
    var datajson = {"data": json.encode(data)};
    print(datajson.toString());
    //print('kondisi=' + datajson.toString());
    try {
      var resAccount = await http.post(Uri.parse(Api.BATCH_URL),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/x-www-form-urlencoded'
          },
          body: datajson);
      var res = json.decode(resAccount.body);
      var isSukses = false;
      if (res['success'] == null) {
        isSukses = false;
      } else {
        if (res['success'] && res['data'].length > 0) {
          isSukses = true;
        } else {
          isSukses = false;
        }
      }
      return {
        'kode': resAccount.statusCode,
        'isSuccess': isSukses,
        'error': 'validation error',
        'error_message': 'Data is Empty',
        'data': res //masalah tadi lemparan disininya res["data"]
      };
    } catch (err) {
      if (err.toString().contains('SocketException: Failed host lookup')) {
        return {
          'kode': 500,
          'isSuccess': false,
          'error': 'Error Connection',
          'error_message':
              'Cannot connect to server\nplease contact your administator'
        };
      } else if (err.toString().contains('Connection refused')) {
        return {
          'kode': 501,
          'isSuccess': false,
          'error': 'Connection Refused',
          'error_message':
              'Connection refused\nplease contact your administator'
        };
      }
      return {
        'kode': 505,
        'isSuccess': false,
        'error': 'Error',
        'error_message': 'Error System'
      };
    }
  }
}
