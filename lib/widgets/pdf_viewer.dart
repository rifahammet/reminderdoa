// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
// import 'package:flutter/material.dart';

// class PDFViewers extends StatefulWidget {
//   final File path;
//   final String? judulReport;
//   // ,
//   const PDFViewers(Key? key, this.path, this.judulReport)
//       : super(key: key);
//   @override
//   _PDFViewersState createState() => _PDFViewersState();
// }

// class _PDFViewersState extends State<PDFViewers>
//     with SingleTickerProviderStateMixin {
//   AnimationController? _controller;
//   PDFDocument? document;
//   bool _isLoading = true;
//   loadDocument() async {
//     document = await PDFDocument.fromFile(widget.path);
//     // document = await PDFDocument.fromURL(
//     //   "http://conorlastowka.com/book/CitationNeededBook-Sample.pdf",
//     //   /* cacheManager: CacheManager(
//     //       Config(
//     //         "customCacheKey",
//     //         stalePeriod: const Duration(days: 2),
//     //         maxNrOfCacheObjects: 10,
//     //       ),
//     //     ), */
//     // );
//     setState(() => _isLoading = false);
//   }

//   changePDF(value) async {
//     setState(() => _isLoading = true);
//     if (value == 1) {
//       // document = await PDFDocument.fromFile(widget.path);
//     } else if (value == 2) {
//       document = await PDFDocument.fromURL(
//         "http://conorlastowka.com/book/CitationNeededBook-Sample.pdf",
//         /* cacheManager: CacheManager(
//           Config(
//             "customCacheKey",
//             stalePeriod: const Duration(days: 2),
//             maxNrOfCacheObjects: 10,
//           ),
//         ), */
//       );
//     } else {
//       document = await PDFDocument.fromAsset('assets/sample.pdf');
//     }
//     setState(() => _isLoading = false);
//   }

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(vsync: this);
//     loadDocument();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controller?.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.judulReport!),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: _isLoading
//             ? Center(child: CircularProgressIndicator())
//             : PDFViewer(
//                 document: document,
//                 zoomSteps: 1,
//                 //uncomment below line to preload all pages
//                 // lazyLoad: false,
//                 // uncomment below line to scroll vertically
//                 // scrollDirection: Axis.vertical,

//                 //uncomment below code to replace bottom navigation with your own
//                 /* navigationBuilder:
//                       (context, page, totalPages, jumpToPage, animateToPage) {
//                     return ButtonBar(
//                       alignment: MainAxisAlignment.spaceEvenly,
//                       children: <Widget>[
//                         IconButton(
//                           icon: Icon(Icons.first_page),
//                           onPressed: () {
//                             jumpToPage()(page: 0);
//                           },
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.arrow_back),
//                           onPressed: () {
//                             animateToPage(page: page - 2);
//                           },
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.arrow_forward),
//                           onPressed: () {
//                             animateToPage(page: page);
//                           },
//                         ),
//                         IconButton(
//                           icon: Icon(Icons.last_page),
//                           onPressed: () {
//                             jumpToPage(page: totalPages - 1);
//                           },
//                         ),
//                       ],
//                     );
//                   }, */
//               ),
//       ),
//     );
//   }
// }
