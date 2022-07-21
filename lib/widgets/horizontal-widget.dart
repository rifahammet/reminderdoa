// import 'package:excel/excel.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:doa/widgets/label.dart';

// class HorizontalListWidget {


//   Widget getItemKategoriImage({String? gambar, String? itemText, warnaText = Colors.grey,warnaBorder =Colors.grey}) {
//     var wg = Container(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Container(
//                 width: 35,
//                 height: 35,
//                 child: Image.asset(gambar!),
//               ),
//               SizedBox(height: 5),
              
//               Text(
//                 itemText!,
//                 style: TextStyle(
//                     fontSize: 11,
//                     color: warnaText,
//                     fontWeight: FontWeight.w600),
//               ),
//             ],
//           ),
//         ),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(
//             Radius.circular(5.0),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: warnaBorder,
//               blurRadius: 1.0,
//               spreadRadius: 1.0,
//               offset: Offset(0.0, 0.0),
//             ),
//           ],
//           color: Colors.white,
//         ),
//         margin: EdgeInsets.all(10),
//         height: 150.0);
//     return wg;
//   }

//     Widget getItemKategoriTextOnly({String? number,fontSizeNumber = 24.0,fontColorNumber = Colors.red , String? itemText,fontSizeText=11.0,  warnaText = Colors.grey,warnaBorder =Colors.grey,additionalText="", additionalNumberText="",warnaAdditionalNumberText = Colors.grey }) {
//     var wg = Container(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                 number!,
//                 style: TextStyle(
//                     fontSize: fontSizeNumber,
//                     color: fontColorNumber,
//                     fontWeight: FontWeight.w600),
//               ),
//               SizedBox(width: 3,),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child:
//               Text(
//                 additionalNumberText,
//                 style: TextStyle(
//                     fontSize: 11,
//                     color: warnaAdditionalNumberText),
//               ))
//               ],)
// ,
//               SizedBox(height: 5),
//               Container(
//                 height: 30,
//                 padding: EdgeInsets.only(left: 3,right: 3),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [

// Text(

//                 itemText!,
//                   textAlign: TextAlign.center,
//                 style: TextStyle(
//                     fontSize: fontSizeText,
//                     color: warnaText,
//                     fontWeight: FontWeight.bold),
                    
//               ),
//               Visibility(
//                 visible: additionalText==""?false:true,
//                 child: Column(
//                 children: [
// SizedBox(height: 5),
//               Text(
//                 additionalText,
//                 style: TextStyle(
//                     fontSize: 11,
//                     color: Colors.grey),
//               ),
//                 ],
//               ))
//                 ],),
//               )
              
              
//             ],
//           ),
//         ),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(
//             Radius.circular(5.0),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: warnaBorder,
//               blurRadius: 1.0,
//               spreadRadius: 1.0,
//               offset: Offset(0.0, 0.0),
//             ),
//           ],
//           color: Colors.white,
//         ),
//         margin: EdgeInsets.all(10),
//         height: 150.0);
//     return wg;
//   }

//   Widget horizontalListWidget(
//       {context,
//       newData,
//       isKlik,
//       isiWidget,
//       Axis scrollDirection = Axis.vertical,
//       bool isForKategori = false,
//       int crossAxisCount = 2,
//       height = 135,
//       warnaBackground=Colors.grey,
//       labelTitle=""
//       }) {
//     Widget wg = isForKategori
//         ? new Container(
//             color: warnaBackground,
//             height:labelTitle==""? height : height+33.0,
//             child: Column(children: [
//               Visibility(
//                 visible: labelTitle==""?false :true,
//                 child: 
//               Container(
//                 height: 33.0,
//                 padding:  const EdgeInsets.only(left: 5,top: 5),
//                 alignment: Alignment.centerLeft,
//                 child:  Label().labelStatus(label: labelTitle, borderRadius: 15.0,width: 140.0, warna: Colors.orange, warnaBorder: Colors.yellow)
//                 )),
//               Expanded(child: 

//               newData.length >0 ? CustomScrollView(
//               scrollDirection: scrollDirection,
//               slivers: <Widget>[
//                 SliverGrid(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: crossAxisCount),
//                   delegate: SliverChildBuilderDelegate(
//                     (BuildContext context, int index) {
//                       return isiWidget(index);
//                     },
//                     childCount: newData.length, // Your desired amount of children here
//                   ),
//                 ),
//               ],
//             ): Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//               // Container(
//               //     height: 70,
//               //     width: 70,
//               //     padding: EdgeInsets.all(5),
//               //     child: Image.asset(
//               //       'assets/images/widget-icons/empty-folder.png',
//               //     )),
//                         Text("Tidak ada data")],) 
//             )
//             ],) 
            
//             )
//         : new Expanded(
//             child: CustomScrollView(
//             scrollDirection: scrollDirection,
//             slivers: <Widget>[
//               SliverGrid(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     childAspectRatio: 0.8,
//                     crossAxisSpacing: 0.1,
//                     crossAxisCount: crossAxisCount),
//                 delegate: SliverChildBuilderDelegate(
//                   (BuildContext context, int index) {
//                     return isiWidget(index);
//                   },
//                   childCount:
//                       newData.length, // Your desired amount of children here
//                 ),
//               ),
//             ],
//           ));
//     return wg;
//   }
// }