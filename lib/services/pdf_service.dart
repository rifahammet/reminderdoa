// import 'dart:io';


// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
// import 'package:path_provider/path_provider.dart' as path;
// import 'package:doa/widgets/pdf_viewer.dart';

// class PDFService {
//   String? generatedPdfFilePath;
//   Future<void> generatePdf(
//       {htmlContent, context, filename, judulReport}) async {
//     //     var status = await Permission.storage.status;
//     // if (!status.isGranted) {
//     //   await Permission.storage.request();
//     // }

//         final directory = (await path.getExternalStorageDirectories(type: path.StorageDirectory.downloads)).first!;

// Directory appDocDir = Platform.isIOS
//         ? await path.getApplicationDocumentsDirectory()
//         : await path.getExternalStorageDirectory();
        
// final folderName="doa";
// final paths= Directory("storage/emulated/0/$folderName");

//     // Directory appDocDir = Platform.isIOS
//     //     ? await path.getApplicationDocumentsDirectory()
//     //     : await path.getExternalStorageDirectory(); // (await path.getExternalStorageDirectories(type: path.StorageDirectory.documents)).first!;
//     print('dir:' + paths.path);
//     var targetPath = appDocDir.path;
//     //var targetFileName = "report_pakan";
//     var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
//         htmlContent, targetPath, filename);
//     generatedPdfFilePath = generatedPdfFile.path;
//     print('posisi file =' + generatedPdfFile.path.toString());
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) =>
//               PDFViewers(null, generatedPdfFile, judulReport)),
//     );
//   }
// }
