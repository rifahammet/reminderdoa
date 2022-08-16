import 'dart:convert';
import 'dart:io';
import 'package:doa/utils/api.dart';
import 'package:xml/xml.dart';
import 'package:path_provider/path_provider.dart' as path;

class XML {
  void createAuthXml({baseUrl="",batchUrl=""}) async {
    print("dijalanin");
    Directory appDocDir = Platform.isIOS
        ? await path.getApplicationDocumentsDirectory()
        : (await path.getExternalStorageDirectories(type: path.StorageDirectory.downloads))!.first;
    
      var targetPath = appDocDir.path;
      final bookshelfXml = '''<?xml version="1.0"?>
          <Auth>
            <baseUrl>${baseUrl}</baseUrl>
            <batchUrl>${batchUrl}</batchUrl>
          </Auth>''';
          final document = XmlDocument.parse(bookshelfXml);
          final file=   File(targetPath+'/auth.xml');
          var sink = file.openWrite();
          sink.write(document.toXmlString());
          sink.close();
  }

  void readAuthXml() async {
     Directory appDocDir = Platform.isIOS
        ? await path.getApplicationDocumentsDirectory()
        : (await path.getExternalStorageDirectories(type: path.StorageDirectory.downloads))!.first;
    var targetPath = appDocDir.path;
      final files =  File(targetPath+'/auth.xml');
      if(files.existsSync()){
      final document = XmlDocument.parse(files.readAsStringSync());
      final titles = document.findAllElements('Auth');
      final baseUrl =titles.map((node) => node.findElements('baseUrl').single.text);
      final batchUrl =titles.map((node) => node.findElements('batchUrl').single.text);
      print("readXML "+batchUrl.toString());
      Api.BASE_URL = baseUrl.first.toString();
      Api.BATCH_URL = batchUrl.first.toString();
      }
  }

  void generateXML({namaFile}) async {
    Directory appDocDir = Platform.isIOS
        ? await path.getApplicationDocumentsDirectory()
        : (await path.getExternalStorageDirectories(type: path.StorageDirectory.documents))!.first;
    var targetPath = appDocDir.path;
        final file =  File(targetPath+namaFile);
    final document = XmlDocument.parse(file.readAsStringSync());
    final builder = XmlBuilder();
    buildBook(builder, 'The War of the Worlds', 'en', 12.50);
    buildBook(builder, 'Voyages extraordinaries', 'fr', 18.20);
    document.firstElementChild.children.add(builder.buildFragment());
  }

  void buildBook(XmlBuilder builder, String title, String language, num price) {
  builder.element('book', nest: () {
    builder.element('title', nest: () {
      builder.attribute('lang', language);
      builder.text(title);
    });
    builder.element('price', nest: price);
  });
}


void fileEdit({baseUrl,batchUrl} )async {
  Directory appDocDir = Platform.isIOS
        ? await path.getApplicationDocumentsDirectory()
        : (await path.getExternalStorageDirectories(type: path.StorageDirectory.downloads))!.first;
    
    var targetPath = appDocDir.path;
      final bookshelfXml = '''<?xml version="1.0"?>
          <Auth>
            <baseUrl>${baseUrl}</baseUrl>
            <batchUrl>${batchUrl}</batchUrl>
          </Auth>''';
          final document = XmlDocument.parse(bookshelfXml);
  var file = File(targetPath+"/auth.xml");
  var sink = file.openWrite();
  sink.write(document.toXmlString());
  sink.close();
}
}