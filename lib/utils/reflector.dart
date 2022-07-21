// import 'package:reflectable/reflectable.dart';

// class MyReflectable extends Reflectable {
//   const MyReflectable()
//       : super(invokingCapability, declarationsCapability,
//             instanceInvokeCapability, reflectedTypeCapability, typeCapability);
// }

// const myReflectable = MyReflectable();

/* error : Reflecting on un-marked type "Pemupukan"  
  solusi : tambahin @myRefrlectable di model
*/

/* perintah di terminal : flutter packages pub run build_runner build lib  atau flutter packages pub run build_runner build lib --delete-conflicting-outputs and fix*/

/* contoh reflect basic*/
// KebunList list = new KebunList();
// InstanceMirror instanceMirror = myReflectable.reflect(list);
// ClassMirror classMirror =
//     instanceMirror.type; //myReflectable.reflectType(KebunList);
// //for (var v in classMirror.declarations.entries) {}
// for (var v in classMirror.declarations.values) {
//   print('nama='+v.simpleName.toString());
//   if (v is VariableMirror) {
//     Type type = v.dynamicReflectedType;
//     if (type.toString() == 'int') {
//       print('int');
//     } else if (type.toString() == 'double') {
//       print('double');
//     } else {
//       print('lainnya');
//     }
//   }
// }
/* end contoh reflect */
