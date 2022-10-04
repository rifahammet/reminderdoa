// @dart=2.9

import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:doa/pages/onboarding.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PostHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  ResponsiveSizingConfig.instance.setCustomBreakpoints(
    ScreenBreakpoints(desktop: 800, tablet: 550, watch: 200),
  );
  HttpOverrides.global = new PostHttpOverrides();
  runApp(
    Phoenix(
      child: const MyApp(),
    ),
  );
  // runApp(EasyLocalization(
  //   child: MyApp(),
  //   supportedLocales: [
  //     Locale('id', 'ID'),
  //     Locale('en', 'US'),
  //   ],
  //   path: 'assets/langs',
  // ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Moslem's Doa Reminder",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // localizationsDelegates: [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      //   DefaultCupertinoLocalizations.delegate,
      //   EasyLocalization.of(context).delegate,
      // ],
      // supportedLocales: EasyLocalization.of(context).supportedLocales,
      // locale: EasyLocalization.of(context).locale,
      home: Onboarding(),
    );
  }
}
