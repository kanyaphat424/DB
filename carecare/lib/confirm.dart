import 'dart:io';
import 'dart:convert';

import 'package:carecare/Users/gade/Desktop/carecare/carecare/lib/Complete.dart';
import 'package:carecare/model/token.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class ConfirmPage extends StatefulWidget {
  final String timeSlot;
  final String address;
  final String selectedService;
  final DateTime bookingDate;
  final int selectedQuantity;
  final String quantityUnit;
  final double totalPrice;
  final String? selectedPaymentMethod;
  final String yourPreferredName;
  final String quantityString;
  final File? file;
  final String title;

  ConfirmPage({
    required this.timeSlot,
    required this.address,
    required this.selectedService,
    required this.bookingDate,
    required this.selectedQuantity,
    required this.quantityUnit,
    required this.totalPrice,
    required this.selectedPaymentMethod,
    required this.yourPreferredName,
    required this.quantityString,
    required this.file,
    required this.title,
  });

  @override
  _ConfirmPageState createState() => _ConfirmPageState(totalPrice: totalPrice);
}

class _ConfirmPageState extends State<ConfirmPage> {
  double totalPrice;
  String? address;

  _ConfirmPageState({required this.totalPrice});

  Future<void> _postData() async {
    final String apiUrl =
        'http://172.20.10.3:8080/api/v1/service/booking'; // Replace with your actual API URL

    // Create a multipart request
    final http.MultipartRequest request =
        http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.headers['Authorization'] = 'Bearer ${MyGlobalData().token}';
    request.headers['Content-Type'] = 'multipart/form-data';

    // Add form fields
    request.fields.addAll({
      'timeslot': widget.timeSlot,
      'bookingDate': widget.bookingDate.toIso8601String(),
      'select': widget.selectedService,
      'price': widget.totalPrice.toString(),
      'select_payment': widget.selectedPaymentMethod ?? '',
      'payment': widget.yourPreferredName,
      'amount': widget.quantityString,
      'title': widget.title,
      // Use the null-aware operator to handle null address
    });

    // Add the image file
    if (widget.file != null) {
      final file = await http.MultipartFile.fromPath('file', widget.file!.path);
      request.files.add(file);
    }

    // Send the request
    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData =
            json.decode(await response.stream.bytesToString());
        MyGlobalData globalData = MyGlobalData();
        globalData.token = responseData['accessToken'];
        print(globalData.token);
      } else {
        print(response.statusCode);
        print("หาทางแก้");
        print(widget.timeSlot);
        print(widget.bookingDate);
        print(widget.selectedService);
        print(totalPrice);
        print(widget.selectedPaymentMethod ?? '');
        print(widget.yourPreferredName);
        print(widget.quantityString);
      }
    } catch (error) {
      print('Error sending data to the backend: $error');
    }
  }

/*

     Future<void> _fetchAddress() async {
    final String apiUrl = 'http://172.20.10.3:8080/api/v1/member/get-location';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print(response.statusCode);
        final Map<String, dynamic> responseData = json.decode(response.body);
        setState(() {
          address = responseData['address'];
        });
      } else {
        print('Failed to fetch address. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching address: $error');
    }
  }*/
  @override
  void initState() {
    /*_postData(); */
    //_fetchAddress();
    super.initState();
  }
/*
  // Encode the query parameters
  String queryString = Uri(queryParameters: queryParams).query;

  // Construct the final URL with the query parameters
  final String apiUrl = '$baseUrl?$queryString';








  try {
    // Send the GET request to the backend
    final response = await http.get(
      Uri.parse(apiUrl),
    );

    // Check the response status
    if (response.statusCode == 200) {
      // Successfully sent
      print('Data sent to the backend successfully');
      // Handle the response from the backend if needed
    } else {
      // Handle error
      print('Failed to send data to the backend. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      // Handle the error response from the backend if needed
    }
  } catch (error) {
    // Handle error
    print('Error sending data to the backend: $error');
  }
}

 */

  @override
  Widget build(BuildContext context) {
    String amount = "${widget.selectedQuantity} ${widget.quantityUnit}";

    return Scaffold(
        appBar: AppBar(
          title: Text('ยืนยันการจอง'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 3, 103, 185),
                  ),
                ),

                  
                Container(
  decoration: BoxDecoration(
    border: Border.all(color: Color.fromARGB(255, 111, 180, 237), width: 1.0), // Blue border
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(10.0),
      bottomRight: Radius.circular(10.0),
      bottomLeft: Radius.circular(10.0),
    ),
  ),
  padding: EdgeInsets.all(16.0),
  
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'รายละเอียดการจอง:',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 3, 103, 185), // Text color outside the border
        ),
      ),
      SizedBox(height: 16.0),
      Row(
        children: [
          FractionalTranslation(
            translation: Offset(0.55, 0.0),
            child: Text(
              'วันที่: ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FractionalTranslation(
            translation: Offset(0.4, 0.0),
            child: Text(
              DateFormat('yyyy-MM-dd').format(widget.bookingDate),
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      Row(
        children: [
          FractionalTranslation(
            translation: Offset(0.25, 0.0),
            child: Text(
              'เวลาทำงาน: ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FractionalTranslation(
            translation: Offset(0.2, 0.0),
            child: Text(
              widget.timeSlot,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      Row(
        children: [
          FractionalTranslation(
            translation: Offset(0.4, 0.0),
            child: Text(
              'สถานที่: ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FractionalTranslation(
            translation: Offset(0.4, 0.0),
            child: Text(
              widget.address,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      Row(
        children: [
          FractionalTranslation(
            translation: Offset(0.4, 0.0),
            child: Text(
              'บริการ: ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FractionalTranslation(
            translation: Offset(0.3, 0.0),
            child: Text(
              widget.selectedService,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 4.0),
      Row(
        children: [
          FractionalTranslation(
            translation: Offset(0.4, 0.0),
            child: Text(
              'จำนวน: ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FractionalTranslation(
            translation: Offset(0.55, 0.0),
            child: Text(
              amount,
              /* '${widget.selectedQuantity} ${widget.quantityUnit}', */
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 10.0),
      FractionalTranslation(
        translation: Offset(0.23, 0.0),
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'ราคา: ',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: '${widget.totalPrice} บาท',
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
    ],
  ),
),

                  SizedBox(height: 10.0),
                Container(
 decoration: BoxDecoration(
    border: Border.all(color: Color.fromARGB(255, 111, 180, 237), width: 1.0), // Blue border
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(10.0),
      bottomRight: Radius.circular(10.0),
      bottomLeft: Radius.circular(10.0),
    ),
  ),
  padding: EdgeInsets.all(16.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'รายละเอียดการชำระเงิน:',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 3, 103, 185), // Text color outside the border
        ),
      ),
      SizedBox(height: 5.0),
      Row(
        children: [
          FractionalTranslation(
            translation: Offset(0.25, 0.0),
            child: Text(
              'เลือกการชำระ: ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          FractionalTranslation(
            translation: Offset(0.5, 0.0),
            child: Text(
              '${widget.yourPreferredName != null ? widget.yourPreferredName : "ไม่ได้ระบุ"}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 5.0),
      Row(
        children: [
          FractionalTranslation(
            translation: Offset(0.3, 0.0),
            child: Text(
              'วิธีการชำระ: ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          FractionalTranslation(
            translation: Offset(0.5, 0.0),
            child: Text(
              '${widget.selectedPaymentMethod != null ? widget.selectedPaymentMethod : "กรุณาเลือกวิธีชำระเงิน"}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    ],
  ),
),

                  SizedBox(height: 380.0),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        _postData();
                        // Handle payment
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Complete(),
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
                        "ยืนยัน",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
