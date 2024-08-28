import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sellart/splashscreen.dart';
import 'OtherPages/login.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}
class AppColor{
  Color primaryColor = const Color(0xfff5e6f6);
  Color secondaryColor = const Color(0xff75438d);
  Color borderColor = Colors.pink;
}
class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AppColor apk = AppColor();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: '',
        colorScheme: ColorScheme.fromSeed(seedColor: apk.borderColor),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}