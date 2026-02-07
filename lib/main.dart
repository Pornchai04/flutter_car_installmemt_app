// ignore_for_file: unused_element_parameter

import 'package:flutter/material.dart';
import 'package:flutter_car_installmemt_app/views/splash_screen_ui.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
      const _fluttercarinstallmemtappState());
}
class _fluttercarinstallmemtappState extends StatefulWidget {
  const _fluttercarinstallmemtappState({super.key});

  @override
  State<_fluttercarinstallmemtappState> createState() => __fluttercarinstallmemtappStateState();
}

class __fluttercarinstallmemtappStateState extends State<_fluttercarinstallmemtappState> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //ซ่อนป้าย debug คาดสีแดง
      debugShowCheckedModeBanner: false,
      //กำหนดหน้าจอแรก
      home: SplashScreenUi(),
      //กำหนด Theme
      theme: ThemeData(
        textTheme: GoogleFonts.kanitTextTheme(Theme.of(context).textTheme),
      ),
    );
  }
}