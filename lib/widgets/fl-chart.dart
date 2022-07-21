// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class flChart{
// grafikLine(
//       {newData,
//       set_flSpot,
//       set_LineTooltipItem,
//       set_leftTitle,
//       set_bottomTitle,
//       set_SideTitles,
//       set_VerticalValues,
//       aspectRatio = 0.60,
//       borderRadius=18.0,
//       paddingTop =45.0,
//       paddingLeft=10.0,
//       paddingBottom=8.0,
//       paddingRight=15.0,
//       backgroundColor=Colors.white}) {
//     /* FL Chart */
//     List<Color> gradientColors = [
//       const Color(0xff23b6e6),
//       const Color(0xff02d39a),
//     ];
//     bool showAvg = false;
//     bool isFirst = true;
//     bool isFirstPakan = true;
//     double nke = 0;
//     int nLoop = 0;
//     int hasilBagi1 = 0;

//     /* End FL Chart */

//     LineChartData mainData(data, set_flSpot, set_LineTooltipItem, set_leftTitle,
//         set_bottomTitle, set_SideTitles,set_VerticalValues) {
//       double jumlahData = double.parse(data.length.toString());
//       List<FlSpot> chartData = [];
//       double maxData = 0;
//       List<int> intData = [];
//       nLoop = 0;
//       nke = 0;
//       double pembagi = 0.0;
//       data.forEach((element) {
//         var dataSpot = set_flSpot(data[nke.toInt()]);
//         chartData.add(FlSpot(nke, dataSpot));
//         if (maxData < dataSpot) {
//           maxData = dataSpot;
//         }
//         if (maxData.toInt() <= 1) {
//           pembagi=0.1;
//         } else if (maxData.toInt() <= 10) {
//           pembagi =1;
//         } else if (maxData.toInt() <= 50) {
//           pembagi = 5;
//         } else if (maxData.toInt() <= 100) {
//           pembagi = 10;
//         } else if (maxData.toInt() <= 1000) {
//           pembagi = 100.0;
//         } else if (maxData.toInt() <= 10000) {
//           pembagi = 1000.0;
//         } else if (maxData.toInt() <= 100000) {
//           pembagi = 10000.0;
//         } else if (maxData.toInt() <= 1000000) {
//           pembagi = 100000.0;
//         } else {
//           pembagi = 1000000.0;
//         }
//         pembagi=pembagi/(jumlahData.toInt()/2);
        
//         if (pembagi.toInt() > 1000000) {
//           pembagi=1000000.0;
//         } else if (pembagi.toInt() <= 1000000) {
//           pembagi = 10000.0; 
//         } else if (pembagi.toInt() <= 100000) {
//           pembagi = 1000.0; 
//         } else if (pembagi.toInt() <= 10000) {
//           pembagi = 100.0; 
//         } else if (pembagi.toInt() <= 1000) {
//           pembagi = 10.0; 
//         } else if (pembagi.toInt() <= 100) {
//           pembagi = 1.0; 
//         } else if (pembagi.toInt() <= 50) {
//           pembagi = 0.5; 
//         } else if (pembagi.toInt() <= 10) {
//           pembagi = 0.1;
//         } else if (pembagi.toInt() <= 1) {
//           pembagi = 0.01;
//         }
//        var jmldata= maxData/pembagi;
       
//        if(jmldata > jmldata.toInt()){
//          maxData= (jmldata.toInt()+1)*pembagi;
//        }

//  nke++;
//  });
     
      
//       return LineChartData(
//         gridData: FlGridData(
//           show: false,
//           drawVerticalLine: true,
//           getDrawingHorizontalLine: (value) {
//             return FlLine(
//               color: const Color(0xff37434d),
//               strokeWidth: 1,
//             );
//           },
//           getDrawingVerticalLine: (value) {
//             return FlLine(
//               color: const Color(0xff37434d),
//               strokeWidth: 1,
//             );
//           },
//         ),
//         axisTitleData: FlAxisTitleData(
//           leftTitle:
//               AxisTitle(showTitle: true, titleText: set_leftTitle, margin: 20),
//           bottomTitle: AxisTitle(
//               showTitle: true, titleText: set_bottomTitle, margin: 15),
//         ),
//         titlesData: FlTitlesData(
//           show: true,
//           bottomTitles: SideTitles(
//             showTitles: true,
//             reservedSize: 10,
//             rotateAngle: -45,
//             textStyle: const TextStyle(
//                 color: Color(0xff68737d),
//                 fontWeight: FontWeight.normal,
//                 fontSize: 12),
//             getTitles: (value) {
//               return set_SideTitles(data[value.toInt()]);
//               // DateTime.parse(data[value.toInt()].tanggal)
//               //     .difference(DateTime.parse(widget.tanggalTebar))
//               //     .inDays
//               //     .toString();
//             },
//             margin: 20,
//           ),
//           leftTitles: SideTitles(
//             showTitles: true,
//             textStyle: const TextStyle(
//               color: Color(0xff67727d),
//               fontWeight: FontWeight.normal,
//               fontSize: 12,
//             ),
//             interval: pembagi,

//             getTitles: (value) {
//               return set_VerticalValues(value);
//               // if (nLoop > hasilBagi1) nLoop = 0;
//               // if (intData[nLoop] == value.toInt()) {
//               //   nLoop++;
//               //   return value.toInt().toString();
//               // }
//               // return '';
//             },
//             reservedSize: 28,
//             margin: 12,
//           ),
//         ),
//         borderData: FlBorderData(
//             show: true,
//             border: Border.all(
//                 color: Colors.blue, width: 1)), //const Color(0xff37434d)
//         minX: 0,
//         maxX: jumlahData - 1, //untuk banyaknya kolom data
//         minY: 0,
//         maxY: maxData, //untuk banyaknya baris data
//         lineTouchData: LineTouchData(
//           touchTooltipData: LineTouchTooltipData(
//             tooltipBgColor: Colors.black38,
//             getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
//               return lineBarsSpot.map((lineBarSpot) {
//                 // var t1 = DateTime.parse(data[lineBarSpot.spotIndex].tanggal)
//                 //     .difference(DateTime.parse(widget.tanggalTebar))
//                 //     .inDays
//                 //     .toString();
//                 return LineTooltipItem(
//                   set_LineTooltipItem(data[lineBarSpot.spotIndex])
//                   // 'Tgl: ' +
//                   //     auth.fmtDate(data[lineBarSpot.spotIndex].tanggal) +
//                   //     '\n' +
//                   //     //'Jam: '+ data[lineBarSpot.spotIndex].jam.toString() + '\n' +
//                   //     'Pakan: ' +
//                   //     lineBarSpot.y.toStringAsFixed(2) +
//                   //     ' kg\nDOC: ' +
//                   //     t1 +
//                   //     ' hari'
//                   ,
//                   const TextStyle(
//                       color: Colors.yellow, fontWeight: FontWeight.bold),
//                 );
//               }).toList();
//             },
//           ),
//         ),
//         lineBarsData: [
//           LineChartBarData(
//             spots: chartData,
//             isCurved: true,
//             colors: gradientColors,
//             barWidth: 3,
//             isStrokeCapRound: true,
//             dotData: FlDotData(
//               show: true,
//             ),
//             belowBarData: BarAreaData(
//               show: true,
//               colors: gradientColors
//                   .map((color) => color.withOpacity(0.3))
//                   .toList(),
//             ),
//           ),
//         ],
//       );
//     }

//     return new Stack(
//       children: <Widget>[
//         AspectRatio(
//           aspectRatio: aspectRatio,
//           child: Container(
//             padding: EdgeInsets.only(top: paddingTop, left: paddingLeft, right: paddingRight),
//             decoration:  BoxDecoration(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(borderRadius),
//                 ),
//                 color: backgroundColor), //Color(0xff232d37)
//             child: Padding(
//               padding: const EdgeInsets.only(
//                   right: 18.0, left: 12.0, top: 10.0, bottom: 12),
//               child: newData.length - 1 >= 0
//                   ? LineChart(
//                       mainData(newData, set_flSpot, set_LineTooltipItem,
//                           set_leftTitle, set_bottomTitle, set_SideTitles,set_VerticalValues),
//                     )
//                   : Container(
//                       alignment: Alignment.center,
//                       child: Column(children: [
//                          Container(
//                   height: 100,
//                   width: 100,
//                   padding: EdgeInsets.all(5),
//                   child: Image.asset(
//                     'assets/images/widget-icons/empty-folder.png',
//                   )),
//                         Text("Tidak ada data")]),
//                     ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   grafikBar(
//       {newData,
//       set_flSpot,
//       set_barTooltipItem,
//       get_touchIndex,
//       set_leftTitle,
//       set_bottomTitle,
//       set_SideTitles,
//       touchedIndex,
//       aspectRatio = 0.60}) {
//     /* FL Bar Chart */
//     bool showAvg = false;
//     double nke = 0;
//     int nLoop = 0;
//     int hasilBagi1 = 0;
//     final Color barBackgroundColor = const Color(0xff72d8bf);
//     final Duration animDuration = const Duration(milliseconds: 250);
//     //int touchedIndex;
//     bool isPlaying = false;
//     /* End FL Bar Chart */

//     /* FLChart Bar */
//     BarChartGroupData makeGroupData(
//       int x,
//       double y, {
//       bool isTouched = false,
//       Color barColor = Colors.blue,
//       double width = 22,
//       List<int> showTooltips = const [],
//       double height = 100.0,
//     }) {
//       return BarChartGroupData(
//         x: x,
//         barRods: [
//           BarChartRodData(
//             y: isTouched ? y + 1 : y,
//             color: isTouched ? Colors.yellow : barColor,
//             width: width,
//             borderRadius: BorderRadius.circular(5),
//             backDrawRodData: BackgroundBarChartRodData(
//               show: true,
//               y: height,
//               color: Colors.blue.withOpacity(0.2), //barBackgroundColor
//             ),
//           ),
//         ],
//         showingTooltipIndicators: showTooltips,
//       );
//     }

//     List<BarChartGroupData> showingGroups(data, jmldata, {height = 0.0}) =>
//         List.generate(jmldata, (i) {
//           return makeGroupData(i, set_flSpot(data[i]),
//               isTouched: i == touchedIndex, height: height);
//         });

//     BarChartData mainBarData(data, set_flSpot, set_barTooltipItem,
//         get_touchIndex, set_leftTitle, set_bottomTitle, set_SideTitles) {
//       int jumlahData = data.length;
//       List<FlSpot> chartData = [];
//       double maxData = 0;
//       List<int> intData = [];
//       nLoop = 0;
//       nke = 0;
//       int pembagi = 0;
//       data.forEach((element) {
//         var dataSpot = set_flSpot(data[nke.toInt()]);
//         chartData.add(FlSpot(nke, dataSpot));
//         if (maxData < dataSpot) {
//           maxData = dataSpot;
//         }

//         if (maxData.toInt() <= 10) {
//           pembagi = 1;
//         } else if (maxData.toInt() <= 50) {
//           pembagi = 5;
//         } else if (maxData.toInt() <= 100) {
//           pembagi = 10;
//         } else if (maxData.toInt() <= 1000) {
//           pembagi = 100;
//         } else if (maxData.toInt() <= 10000) {
//           pembagi = 1000;
//         } else if (maxData.toInt() <= 100000) {
//           pembagi = 10000;
//         } else if (maxData.toInt() <= 1000000) {
//           pembagi = 100000;
//         } else {
//           pembagi = 1000000;
//         }
//         hasilBagi1 = 0;
//         intData = [];
//         hasilBagi1 = maxData ~/ pembagi;
//         int hasilBagi2 = hasilBagi1 * pembagi;
//         if (maxData > hasilBagi2) {
//           maxData = ((hasilBagi1 + 1) * pembagi).toDouble();
//           hasilBagi1 = hasilBagi1 + 1;
//         }
//         print('pembagi=' + hasilBagi1.toString());
//         for (var j = 0; j <= hasilBagi1; j++) {
//           intData.add(j * pembagi);
//         }
//         print('intData=' + intData.toString());
//         nke++;
//       });

//       return BarChartData(
//         barTouchData: BarTouchData(
//           touchTooltipData: BarTouchTooltipData(
//               tooltipBgColor: Colors.blueGrey,
//               getTooltipItem: (group, groupIndex, rod, rodIndex) {
//                 // var tg = DateTime.parse(data[groupIndex].tanggal);
//                 // var selisihHariDOC = tg.difference(widget.tanggaltebar).inDays;
//                 return BarTooltipItem(set_barTooltipItem(data[groupIndex]),
//                     TextStyle(color: Colors.yellow));
//                 // BarTooltipItem(
//                 //     'DOC: ' +
//                 //         selisihHariDOC.toString() +
//                 //         ' Hari\n' +
//                 //         'Tgl: ' +
//                 //         auth.fmtDate(data[groupIndex].tanggal) +
//                 //         '\n' +
//                 //         'Biomas: ' +
//                 //         (rod.y - 1).toStringAsFixed(2) +
//                 //         ' kg',
//                 //     TextStyle(color: Colors.yellow));
//               }),
//           touchCallback: (barTouchResponse) {
//             get_touchIndex(barTouchResponse);
//             // setState(() {
//             //   if (barTouchResponse.spot != null &&
//             //       barTouchResponse.touchInput is! FlPanEnd &&
//             //       barTouchResponse.touchInput is! FlLongPressEnd) {
//             //     touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
//             //   } else {
//             //     touchedIndex = -1;
//             //   }
//             // });
//           },
//         ),
//         gridData: FlGridData(
//           show: false,
//           drawHorizontalLine: true,
//           //drawVerticalLine: true,
//           getDrawingHorizontalLine: (value) {
//             return FlLine(
//               color: Colors.red, //
//               strokeWidth: 1,
//             );
//           },
//           getDrawingVerticalLine: (value) {
//             return FlLine(
//               color: const Color(0xff37434d),
//               strokeWidth: 3,
//             );
//           },
//         ),
//         minY: 0,
//         maxY: maxData, //untuk banyaknya baris data,
//         axisTitleData: FlAxisTitleData(
//           leftTitle:
//               AxisTitle(showTitle: true, titleText: set_leftTitle, margin: 10),
//           bottomTitle: AxisTitle(
//               showTitle: true, titleText: set_bottomTitle, margin: 15),
//         ),
//         titlesData: FlTitlesData(
//           show: true,
//           bottomTitles: SideTitles(
//             showTitles: true,
//             rotateAngle: -45,
//             textStyle: TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.normal,
//                 fontSize: 12),
//             margin: 20,
//             getTitles: (double value) {
//               return set_SideTitles(data[value.toInt()]);

//               //auth.fmtDate(data[value.toInt()].tanggal);
//             },
//           ),
//           leftTitles: SideTitles(
//             showTitles: true,
//             textStyle: TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.normal,
//                 fontSize: 12),
//             margin: 16,
//             getTitles: (double value) {
//               if (nLoop > hasilBagi1) nLoop = 0;
//               if (intData[nLoop] == value.toInt()) {
//                 nLoop++;
//                 return value.toInt().toString();
//               }
//               return '';
//             },
//           ),
//         ),
//         borderData: FlBorderData(
//           show: false,
//         ),
//         barGroups: showingGroups(data, jumlahData, height: maxData),
//       );
//     }

//     // Future<dynamic> refreshState() async {
//     //   //setState(() {});
//     //   await Future<dynamic>.delayed(
//     //       animDuration + const Duration(milliseconds: 50));
//     //   if (isPlaying) {
//     //     refreshState();
//     //   }
//     // }

//     return  Card(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
//           color: Colors.white, //const Color(0xff81e5cd)
//           child: Container(
//             padding: EdgeInsets.only(top: 20, right: 20),
//             child: 
//                 Padding(
//                   padding: const EdgeInsets.all(5),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.max,
//                     children: <Widget>[
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                           child: newData.length - 1 >= 0
//                               ? BarChart(
//                                   mainBarData(
//                                       newData,
//                                       set_flSpot,
//                                       set_barTooltipItem,
//                                       get_touchIndex,
//                                       set_leftTitle,
//                                       set_bottomTitle,
//                                       set_SideTitles),
//                                   swapAnimationDuration: animDuration,
//                                 )
//                               : Container(
//                                   alignment: Alignment.center,
//                                   child: Text("Tidak ada data"),
//                                 ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 12,
//                       ),
//                     ],
//                   ),
//                 ),
              
//           ))
//     ;
//   }


//     grafikBarPagiSiang(
//       {newData,
//       callBack_flSpot,
//       callBack_getMaxData,
//       left_title,
//       bottom_title,
//       callBack_lineTooltipItem,
//       judulData}) {
//     /* FL Chart */
//     List<Color> gradientColors = [
//       const Color(0xff23b6e6),
//       const Color(0xff02d39a),
//     ];
//     double nke_pembelian = 0;
//     double nke_penjualan = 0;
//     double nke1 = 0;
//     int indexKe = 0;
//     int nLoop1 = 0;
//     int hasilBagi1 = 0;
//     // Auth auth = new Auth();
//     /* End FL Chart */

//     LineChartData mainData(
//         List<Map<String, dynamic>> data,
//         callBack_flSpot,
//         callBack_getMaxData,
//         left_title,
//         bottom_title,
//         callBack_lineTooltipItem,
//         judulData) {
//       double jumlahData = double.parse(data.length.toString());
//       List<FlSpot> chartData = [];
//       List<FlSpot> chartData1 = [];
//       List<String> dataPagi = [];
//       List<String> dataSiang = [];
//       double maxData = 0;
//       double maxData_siang = 0;
//       List<int> intData = [];
//       List<LineChartBarData> lineChartBars = [];
//       nLoop1 = 0;
//       nke_pembelian = 0;
//       nke_penjualan = 0;
//       nke1 = 0;
//       int pembagi = 0;
//       //indexKe = 0;

//       data.forEach((element) {
//         FlSpot? flSpot;
//         callBack_flSpot(
//             chartData, flSpot, dataPagi, dataSiang, nke_pembelian, nke_penjualan);
//         if (data[nke1.toInt()]['status'] == 'pembelian') {
//           chartData.add(FlSpot(
//               nke_pembelian,
              
//                   double.parse(data[nke1.toInt()]['total'].toString())));
//           dataPagi.add(data[nke1.toInt()]['tanggal_transaksi']);
//           nke_pembelian++;
//         } else {
//           nke_pembelian++;
//         }
//         if (data[nke1.toInt()]['status'] == 'penjualan') {
//           chartData1.add(FlSpot(
//               nke_penjualan,
//                   double.parse(data[nke1.toInt()]['total'].toString())));
//           dataSiang.add(data[nke1.toInt()]['tanggal_transaksi']);
//           nke_penjualan++;
//         } else {
//           nke_penjualan++;
//         }
//         var nMaxData;
//         nMaxData = callBack_getMaxData();
//         // if (data[nke1.toInt()]['ph_pagi'] > data[nke1.toInt()]['ph_siang']) {
//         //   nMaxData = double.parse(data[nke1.toInt()]['ph_pagi'].toString());
//         // } else {
//         //   nMaxData = double.parse(data[nke1.toInt()]['ph_siang'].toString());
//         // }

//         if (maxData < nMaxData) {
//           maxData = nMaxData;
//         }

//         if (maxData.toInt() <= 10) {
//           pembagi = 1;
//         } else if (maxData.toInt() <= 50) {
//           pembagi = 5;
//         } else if (maxData.toInt() <= 100) {
//           pembagi = 10;
//         } else if (maxData.toInt() <= 1000) {
//           pembagi = 100;
//         } else if (maxData.toInt() <= 10000) {
//           pembagi = 1000;
//         } else if (maxData.toInt() <= 100000) {
//           pembagi = 10000;
//         } else if (maxData.toInt() <= 1000000) {
//           pembagi = 100000;
//         } else {
//           pembagi = 1000000;
//         }
//         hasilBagi1 = 0;
//         intData = [];
//         hasilBagi1 = maxData ~/ pembagi;
//         int hasilBagi1a = hasilBagi1 * pembagi;
//         if (maxData > hasilBagi1a) {
//           maxData = ((hasilBagi1 + 1) * pembagi).toDouble();
//           hasilBagi1 = hasilBagi1 + 1;
//         }

//         print('pembagi=' + hasilBagi1.toString());
//         for (var j = 0; j <= hasilBagi1; j++) {
//           intData.add(j * pembagi);
//         }
//         print('intData=' + intData.toString());
//         nke1++;
//       });

//       if (chartData.length >= 1) {
//         print('jumlah 1=' + (chartData.length).toString());
//         lineChartBars.add(LineChartBarData(
//           spots: chartData,
//           isCurved: true,
//           colors: [
//             const Color(0xffaa4cfc),
//           ],
//           barWidth: 3,
//           isStrokeCapRound: true,
//           dotData: FlDotData(
//             show: true,
//           ),
//           belowBarData: BarAreaData(
//             show: false,
//             // colors: gradientColors
//             //     .map((color) => color.withOpacity(0.3))
//             //     .toList(),
//           ),
//         ));
//       }

//       if (chartData1.length >= 1) {
//         print('jumlah 2=' + (chartData1.length).toString());
//         lineChartBars.add(LineChartBarData(
//           spots: chartData1,
//           isCurved: true,
//           colors: [
//             const Color(0xff4af699),
//           ],
//           barWidth: 3,
//           isStrokeCapRound: true,
//           dotData: FlDotData(
//             show: true,
//           ),
//           belowBarData: BarAreaData(
//             show: false,
//             // colors: gradientColors
//             //     .map((color) => color.withOpacity(0.3))
//             //     .toList(),
//           ),
//         ));
//       }
//       print('LineBars=' + lineChartBars.length.toString());
//       return LineChartData(
//         gridData: FlGridData(
//           show: false,
//           drawVerticalLine: true,
//           getDrawingHorizontalLine: (value) {
//             return FlLine(
//               color: const Color(0xff37434d),
//               strokeWidth: 1,
//             );
//           },
//           getDrawingVerticalLine: (value) {
//             return FlLine(
//               color: const Color(0xff37434d),
//               strokeWidth: 1,
//             );
//           },
//         ),
//         axisTitleData: FlAxisTitleData(
//           leftTitle:
//               AxisTitle(showTitle: true, titleText: left_title, margin: 10),
//           bottomTitle:
//               AxisTitle(showTitle: true, titleText: bottom_title, margin: 15),
//         ),
//         titlesData: FlTitlesData(
//           show: true,
//           bottomTitles: SideTitles(
//             showTitles: true,
//             reservedSize: 10,
//             rotateAngle: -45,
//             textStyle: const TextStyle(
//                 color: Color(0xff68737d),
//                 fontWeight: FontWeight.normal,
//                 fontSize: 12),
//             getTitles: (value) {
//               return judulData(data[value.toInt()]);
//               // DateTime.parse(data[value.toInt()]['tanggal'])
//               //     .difference(DateTime.parse(widget.tanggalTebar))
//               //     .inDays
//               //     .toString();
//               //return auth.fmtDate(data[value.toInt()]['tanggal']);
//             },
//             margin: 20,
//           ),
//           leftTitles: SideTitles(
//             showTitles: true,
//             textStyle: const TextStyle(
//               color: Color(0xff67727d),
//               fontWeight: FontWeight.normal,
//               fontSize: 12,
//             ),
//             interval: pembagi.toDouble(),
//             getTitles: (value) {
//               return value.toInt().toString();
//             },
//             reservedSize: 28,
//             margin: 12,
//           ),
//         ),
//         borderData: FlBorderData(
//             show: true,
//             border: Border.all(
//                 color: Colors.blue, width: 1)), //const Color(0xff37434d)
//         minX: 0,
//         maxX: jumlahData - 1, //untuk banyaknya kolom data
//         minY: 0,
//         maxY: maxData, //untuk banyaknya baris data
//         lineTouchData: LineTouchData(
//           touchTooltipData: LineTouchTooltipData(
//             tooltipBgColor: Colors.black,
//             getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
//               return lineBarsSpot.map((lineBarSpot) {
//                 // if (indexKe < lineBarSpot.spotIndex) {
//                 //   indexKe = lineBarSpot.spotIndex;
//                 // }
//                 // var t1 = DateTime.parse(lineBarSpot.barIndex == 0
//                 //         ? dataPagi[lineBarSpot.spotIndex]
//                 //         : dataSiang[lineBarSpot.spotIndex])
//                 //     .difference(DateTime.parse(widget.tanggalTebar))
//                 //     .inDays
//                 //     .toString();
//                 LineTooltipItem? lineTooltipItem;
//                 return //callBack_lineTooltipItem(lineBarSpot, lineTooltipItem);
//                 LineTooltipItem(
//                   callBack_lineTooltipItem(lineBarSpot.spotIndex, {"data1": dataPagi, "data2": dataSiang})
//                   // (lineBarSpot.barIndex == 0 ? 'Pagi' : 'Siang') +
//                   //     '\nTgl: ' +
//                   //     (lineBarSpot.barIndex == 0
//                   //         ? dataPagi[lineBarSpot.spotIndex]
//                   //         : dataSiang[lineBarSpot.spotIndex]) +
//                   //     '\n' +
//                   //     'DOC: ' +
//                   //     ' hari\n' +
//                   //     'pH: ' +
//                   //     lineBarSpot.y.toStringAsFixed(2) +
//                   //     ''
//                       ,
//                   lineBarSpot.barIndex == 0
//                       ? const TextStyle(
//                           color: const Color(0xffaa4cfc),
//                           fontWeight: FontWeight.bold)
//                       : const TextStyle(
//                           color: const Color(0xff4af699),
//                           fontWeight: FontWeight.bold),
//                 );
//               }).toList();
//             },
//           ),
//           touchCallback: (LineTouchResponse touchResponse) {},
//           handleBuiltInTouches: true,
//         ),
//         lineBarsData: lineChartBars,
//       );
//     }

//     return new Stack(
//       children: <Widget>[
//         AspectRatio(
//           aspectRatio: 1.70,
//           child: Container(
//             padding: EdgeInsets.only(left: 10, right: 15),
//             decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(18),
//                 ),
//                 color: Colors.white), //Color(0xff232d37)
//             child: Padding(
//               padding: const EdgeInsets.only(
//                   right: 18.0, left: 12.0, top: 24, bottom: 12),
//               child: newData.length - 1 >= 0
//                   ? LineChart(
//                       mainData(
//                           newData,
//                           callBack_flSpot,
//                           callBack_getMaxData,
//                           left_title,
//                           bottom_title,
//                           callBack_lineTooltipItem,
//                           judulData),
//                     )
//                   : Container(
//                       alignment: Alignment.center,
//                       child: Text("Tidak ada data"),
//                     ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }