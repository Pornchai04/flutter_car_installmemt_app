// ignore_for_file: must_call_super

import 'package:flutter/material.dart';
import 'package:flutter_car_installmemt_app/views/car_installment_ui.dart';

class SplashScreenUi extends StatefulWidget {
  const SplashScreenUi({super.key});

  @override
  State<SplashScreenUi> createState() => _SplashScreenUiState();
}

class _SplashScreenUiState extends State<SplashScreenUi> {
  @override
  void initState() {
    // ให้หน่วงเวลา 3 วินาที กแล้วเปิดไปหน้า HomeUi แบบย้อนกลับไม่ได้
    Future.delayed(
      //เวลาที่หน่วง
      Duration(seconds: 3),
      //เมื่อครบเวลาแล้วให้ทำงานอะไร ณ ที่นี้จะให้เปิดหน้า HomeUi แบบย้อนกลับไม่ได้
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => CarInstallmentUi(),
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 200.0,
            ),
            Image.asset(
              'assets/images/1.png',
              width: MediaQuery.of(context).size.width * 0.60,
              height: MediaQuery.of(context).size.width * 0.20,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 50.0,
            ),
            Text(
              '     Car lnstallment \nคำนวณค่างวดรถยนต์',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.030,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 130, 250, 61),
              ),
            ),

            SizedBox(
              height: 50.0,
            ),
            CircularProgressIndicator(
              color: Colors.white,
            ),
            SizedBox(
              height: 50.0,
            ),
            Text(
              'Created by Pornchai DTI-SAU',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.020,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 130, 250, 61),
              ),
            ),
            Center(
              child: Text(
                'Version 1.0.0',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.020,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 130, 250, 61),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
