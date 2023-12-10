
import 'dart:convert';

import 'package:carecare/PaymentPage.dart';
import 'package:carecare/model/token.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class NextPage extends StatefulWidget {
  final Map<String, dynamic> data;
  final String timeSlot;
  final String address;
  final String selectedService;
  final String image;
  final DateTime bookingDate;
  final int selectedQuantity;
  final String quantityUnit;
  final String quantityString;
  final String title;

  NextPage({
    required this.data,
    required this.timeSlot,
    required this.address,
    required this.selectedService,
    required this.image,
    required this.bookingDate,
    required this.selectedQuantity,
    required this.quantityUnit,
    required this.quantityString,
    required this.title,
  });

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  TextEditingController _paymentOption = TextEditingController();

  String paymentOption = ''; // Local variable for payment option

  double calculatePrice() {
    final servicesPrices = {
      "assets/แม่บ้าน.png": {
        "ขนาดพื้นที่ไม่เกิน 35 ตร.ม.": 520.0,
        "ขนาดพื้นที่ 36-80 ตร.ม.": 720.0,
        "ขนาดพื้นที่ 81-100 ตร.ม.": 820.0,
      },
      "assets/ปะปา1.png": {
        "น้ำรั่ว/ท่อตัน": 800.0,
        "ติดตั้งปั๊มน้ำ": 600.0,
      },
      "assets/ไฟ.png": {
        "เดินสายไฟ": 200.0,
        "เช็ค/บำรุงสภาพไฟ": 500.0,
        "ย้ายและติดตั้งสวิตซต์/เบรกเกอร์": 500.0,
      },
      "assets/7.png": {
        "จัดสวน": 500.0,
        "ตัดหญ้า/ตัดแต่งกิ่ง": 50.0,
      },
      "assets/แอร์.png": {
        "ล้างแอร์": 700.0,
        "เติมน้ำยาแอร์": 400.0,
      },
      "assets/cctv.png": {
        "ระยะ 0-25 เมตร": 1250.0,
        "ระยะ 26-40 เมตร": 1950.0,
        "ระยะ 41-50 เมตร": 2200.0,
      },
    };

    final selectedServicePriceMap = servicesPrices[widget.image];
    if (selectedServicePriceMap != null) {
      final price = selectedServicePriceMap[widget.selectedService];
      if (price != null) {
        return price * widget.selectedQuantity;
      }
    }

    return 0.0;
  }

  // Function to create aligned text widgets
  Widget alignedText(String label, String value) {
    return Row(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '$label ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }

  // Function to create aligned rich text for price
  Widget alignedPrice(String label, double price, {double translationX = 0.0}) {
  return FractionalTranslation(
    translation: Offset(translationX, 0.0),
    child: Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$label ',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: '${price.toStringAsFixed(2)} บาท',
              style: TextStyle(
                fontSize: 18,
                color: Colors.green,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ชำระเงินสำหรับการจอง'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'รายละเอียดการจอง:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 3, 103, 185),
                ),
              ),
              alignedText('วันที่:', '${DateFormat('yyyy-MM-dd').format(widget.bookingDate)}'),
              alignedText('เวลาทำงาน:', widget.timeSlot),
              alignedText('สถานที่:', widget.address),
              alignedText('บริการ:', widget.selectedService),
              SizedBox(height: 4.0),
              alignedText('จำนวน:', '${widget.selectedQuantity} ${widget.quantityUnit}'),
              SizedBox(height: 10.0),
              alignedPrice('ราคา:', calculatePrice()),
              SizedBox(height: 20.0),
              Text(
                'วิธีการชำระเงิน:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 3, 103, 185),
                ),
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Radio(
                        value: 'เงินประกัน(100 บาท)',
                        groupValue: paymentOption,
                        onChanged: (value) {
                          setState(() {
                            paymentOption = value as String;
                            print('Selected Payment Option: $paymentOption');
                          });
                        },
                      ),
                      Text('เงินประกัน(100 บาท)', style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Radio(
                        value: 'ชำระเต็ม',
                        groupValue: paymentOption,
                        onChanged: (value) {
                          setState(() {
                            paymentOption = value as String;
                          });
                        },
                      ),
                      Text('ชำระเต็ม', style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: FractionalTranslation(
                  translation: Offset(-0.1, 0.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to the PaymentPage without passing the paymentOption parameter
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(
                            timeSlot: widget.timeSlot,
                            address: widget.address,
                            selectedService: widget.selectedService,
                            bookingDate: widget.bookingDate,
                            selectedQuantity: widget.selectedQuantity,
                            data: {},
                            quantityUnit: widget.quantityUnit,
                            image: widget.image,
                            yourPreferredName: paymentOption,
                            totalPrice: calculatePrice().toString(),
                            selectedPaymentMethod: '',
                            quantityString: widget.quantityString,
                            title: widget.title,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      padding: EdgeInsets.all(12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: Text(
                      "ถัดไป",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
