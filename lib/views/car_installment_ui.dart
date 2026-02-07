// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CarInstallmentUi extends StatefulWidget {
  const CarInstallmentUi({super.key});

  @override
  State<CarInstallmentUi> createState() => _CarInstallmentUiState();
}

class _CarInstallmentUiState extends State<CarInstallmentUi> {
  final TextEditingController carPriceController = TextEditingController();
  final TextEditingController interestRateController = TextEditingController();

  int? downPaymentPercentage;
  int? loanPeriodMonths;
  double monthlyInstallment = 0.0;

  final List<int> downPaymentOptions = [10, 20, 30, 40, 50];
  final List<int> loanPeriodOptions = [24, 36, 48, 60, 72];

  void calculateInstallment() {
    // Validate inputs
    if (carPriceController.text.isEmpty) {
      showWarningDialog('กรุณาป้อนราคารถ');
      return;
    }

    if (downPaymentPercentage == null) {
      showWarningDialog('กรุณาเลือกจำนวนเงินดาวน์');
      return;
    }

    if (loanPeriodMonths == null) {
      showWarningDialog('กรุณาเลือกระยะเวลาผ่อน');
      return;
    }

    if (interestRateController.text.isEmpty) {
      showWarningDialog('กรุณาป้อนอัตราดอกเบี้ย');
      return;
    }

    try {
      double carPrice = double.parse(carPriceController.text);
      double interestRate = double.parse(interestRateController.text);

      // Calculate outstanding amount (ยอดจัด)
      double outstandingAmount =
          carPrice - (carPrice * downPaymentPercentage! / 100);

      // Calculate total interest (ดอกเบี้ยทั้งหมด)
      double totalInterest =
          (outstandingAmount * interestRate / 100) * (loanPeriodMonths! / 12);

      // Calculate monthly installment (ค่างวดรถต่อเดือน)
      double result = (outstandingAmount + totalInterest) / loanPeriodMonths!;

      setState(() {
        monthlyInstallment = result;
      });
    } catch (e) {
      showWarningDialog('กรุณาป้อนค่าตัวเลขที่ถูกต้อง');
    }
  }

  void resetForm() {
    setState(() {
      carPriceController.clear();
      interestRateController.clear();
      downPaymentPercentage = null;
      loanPeriodMonths = null;
      monthlyInstallment = 0.0;
    });
  }

  void showWarningDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('การแจ้งเตือน'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('ตกลง'),
          ),
        ],
      ),
    );
  }

  String formatNumberWithComma(double value) {
    final formatter = NumberFormat('#,##0.00', 'en_US');
    return formatter.format(value);
  }

  @override
  void dispose() {
    carPriceController.dispose();
    interestRateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CI Calculator',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'คำนวณค่างวดรถ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),

            /// รูปรถ
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color.fromARGB(255, 106, 228, 82),
                  width: 2,
                ),
                image: const DecorationImage(
                  image: AssetImage('assets/images/2.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// ราคารถ
            const Text('ราคารถ (บาท)'),
            const SizedBox(height: 6),
            TextField(
              controller: carPriceController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                hintText: '0.00',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// เงินดาวน์
            const Text('จำนวนเงินดาวน์ (%)'),
            Wrap(
              children: [10, 20, 30, 40, 50].map((e) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<int>(
                      value: e,
                      groupValue: downPaymentPercentage,
                      onChanged: (value) {
                        setState(() {
                          downPaymentPercentage = value!;
                        });
                      },
                    ),
                    Text('$e%'),
                  ],
                );
              }).toList(),
            ),

            SizedBox(height: 16),

            /// ระยะเวลาผ่อน
            const Text('ระยะเวลาผ่อน (เดือน)'),
            const SizedBox(height: 6),
            DropdownButtonFormField<int>(
              value: loanPeriodMonths,
              items: loanPeriodOptions
                  .map((int value) => DropdownMenuItem(
                        value: value,
                        child: Text('$value เดือน'),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  loanPeriodMonths = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'เลือกระยะเวลา',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 16),

            /// ดอกเบี้ย
            const Text('อัตราดอกเบี้ย (%/ปี)'),
            const SizedBox(height: 6),
            TextField(
              controller: interestRateController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                hintText: '0.00',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 20),

            /// ปุ่ม
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 70,
                    width: 70,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 14, 241, 33),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(4), // สี่เหลี่ยมคม
                          side: const BorderSide(
                            color: Color.fromARGB(255, 14, 241, 33),
                            width: 2,
                          ),
                        ),
                      ),
                      onPressed: calculateInstallment,
                      child: const Text(
                        'คำนวณ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 70,
                    width: 70,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 233, 131, 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side: const BorderSide(
                            color: Color.fromARGB(255, 233, 131, 14),
                            width: 2,
                          ),
                        ),
                      ),
                      onPressed: resetForm,
                      child: const Text(
                        'ยกเลิก',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            /// ผลลัพธ์
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green),
              ),
              child: Column(
                children: [
                  const Text(
                    'ค่างวดรถต่อเดือนเป็นเงิน',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    formatNumberWithComma(monthlyInstallment),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  Text('บาทต่อเดือน'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}