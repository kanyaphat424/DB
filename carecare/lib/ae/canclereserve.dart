import 'dart:convert';
import 'dart:io';

import 'package:carecare/ae/reservation.dart';
import 'package:carecare/homescreen.dart';
import 'package:carecare/model/booking.dart';
import 'package:carecare/model/token.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class canclereserve extends StatefulWidget {
  //late String token = "";

  //final String token;

  final int somev; // ตัวแปรที่จะใช้เก็บค่าที่รับมา

  const canclereserve({Key? key, required this.somev}) : super(key: key);

  // reserveagain({Key? key}) : super(key: key);

  @override
  State<canclereserve> createState() => _canclereserveState();
}

class _canclereserveState extends State<canclereserve> {
  late String token;
  String file = ""; //กำหนดตัวแปร path here

  //_reserveagainState({required this.token});

  TextEditingController _bookingDate = TextEditingController();
  TextEditingController _bookingId = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _select = TextEditingController();
  TextEditingController _payment = TextEditingController();
  TextEditingController _title = TextEditingController();
  TextEditingController _file = TextEditingController();
  TextEditingController _amount = TextEditingController();
  TextEditingController _select_payment = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _accountId = TextEditingController();

  bool isTextObscure1 = true;
  Icon v1 = const Icon(Icons.visibility_rounded);

  Booking booking = Booking(
      bookingDate: "",
      bookingId: "",
      address: "",
      select: "",
      payment: "",
      title: "",
      select_payment: "",
      amount: "",
      file: "",
      price: "",
      accountId: "",
      path: "",
      date: "",);

  Booking currentItem = Booking(
      bookingDate: "",
      bookingId: "",
      address: "",
      select: "",
      payment: "",
      title: "",
      select_payment: "",
      amount: "",
      file: "",
      price: "",
      accountId: "",
      path: "",
      date: "",);

//สำหรับดึงรูป//
  Future<void> fetchImagePath() async {
    try {
      const String apiUrl =
          'http://172.20.10.3:8080/api/v1/upload/image/{filename}'; // แทนที่ด้วย URL ของ backend ที่ให้ path รูป
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        // กำหนด path ที่ได้รับมาจาก backend
        setState(() {
          file = responseData['file']; //ตัวแปรข้างบน
        });
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }
//ถึงนี่//

  Future<void> fetchData() async {
    const String apiUrl =
        'http://172.20.10.3:8080/api/v1/member/get-history-booking';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // ใช้ json.decode เพื่อแปลงข้อมูล JSON ที่ได้จาก response body
        try {
          final decodedResponse = json.decode(response.body);
          // ใช้ decodedResponse ที่ได้ต่อไป
          print(decodedResponse);
        } catch (e) {
          print('Error decoding JSON response: $e');
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _postData() async {
    MyGlobalData globalData = MyGlobalData();
    String myValue = globalData.token.trim();
    print(myValue);
    print("-----------");
    try {
      const String apiUrl =
          'http://172.20.10.3:8080/api/v1/member/get-history-booking';
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $myValue',
        },
        // headers: {
        //   'Authorization': 'Bearer ${MyGlobalData().token}',
        //   'Content-Type': 'multipart/form-data',
        // },
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        // List<dynamic> responseData = json.decode(response.body);
        String responseBody = utf8.decode(response.bodyBytes);
        List<dynamic> responseData = json.decode(responseBody);

        if (responseData.isNotEmpty) {
          setState(() {
            // Assuming you want to access the first item of the list
            final Map<String, dynamic> reserveagainData =
                responseData[widget.somev];

            booking = Booking(
                bookingDate: reserveagainData['bookingDate'] ?? "",
                bookingId: reserveagainData['bookingId'] ?? "",
                select: reserveagainData['select'] ?? "",
                amount: reserveagainData['amount'] ?? "",
                payment: reserveagainData['payment'] ?? "",
                select_payment: reserveagainData['select_payment'] ?? "",
                price: reserveagainData['price'] ?? "",
                address: reserveagainData['address'] ?? "",
                title: reserveagainData['title'] ?? "",
                file: reserveagainData['file'] ?? "",
                accountId: reserveagainData['accountId'] ?? "",
                path: reserveagainData['path'] ?? "",
                date: reserveagainData['date']?? "",);
          });
        } else {
          // กรณี API ส่งข้อมูลที่ไม่ถูกต้อง
          print("Invalid JSON data");
        }
      } else {
        print("Error: ${response.statusCode}");
        print("Error: ${response.body}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }

  @override
  void initState() {
    _postData();
    fetchData();
    super.initState();
  }

  MyGlobalData globalData = MyGlobalData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "รายละเอียดการจอง",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Reservation('token');
            }));
          },
          icon: const Icon(
            Icons.arrow_circle_left_outlined,
            color: Colors.blue,
            size: 40,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: ListView(
          children: [
            Stack(
              children: [
                // Container เพื่อให้ Divider อยู่ในนี้
                Container(
                  height: 30, // ส่วนสูงของ Container ตรงกับ height ของ Divider
                  child: Divider(
                    color: Colors.red.shade50,
                    thickness: 5,
                  ),
                ),
                // วงกลมที่ต้นเส้น
                Positioned(
                  top: 7,
                  left: 0, // ปรับตำแหน่งตามต้องการ
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.yellow, // สีของวงกลม
                    ),
                  ),
                ),
                // วงกลมที่กลางเส้น
                Positioned(
                  top: 7,
                  left: 180, // ปรับตำแหน่งตามต้องการ
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red.shade50, // สีของวงกลม
                    ),
                  ),
                ),
                // วงกลมที่ปลายเส้น
                Positioned(
                  top: 7,
                  right: 0, // ปรับตำแหน่งตามต้องการ
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red.shade50, // สีของวงกลม
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            // The reservation content you mentioned

            Container(
              width: MediaQuery.of(context).size.width,
              height: 680,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.blue.shade300),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "รหัสลูกค้า",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        booking.accountId,
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "วันที่จอง",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        booking.bookingDate,
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "เวลาการทำงาน",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        booking.date,
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "สถานที่",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        booking.address,
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "บริการที่เลือก",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        booking.select,
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "จำนวน",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        booking.amount,
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "ราคา",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        booking.price,
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "ตัวเลือกวิธีการชำระเงิน",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        booking.select_payment,
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "วิธีการชำระเงิน",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        booking.payment,
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Image(
                                  image: NetworkImage(
                                      'http://172.20.10.3:8080/api/v1/upload/image/${booking.path}'),
                                  fit: BoxFit.contain,
                                ),
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue.shade300,
                          minimumSize: Size(100, 45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "ดูสลิป",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red.shade100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(330, 50),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MainHomePage();
                }));
              },
              child: Text(
                "ยกเลิกการจอง",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
