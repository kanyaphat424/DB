import 'dart:convert';

import 'package:carecare/AdminPage.dart';
import 'package:carecare/min/control.dart';
import 'package:carecare/model/controlmo.dart';
import 'package:carecare/model/token.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class customeraddetails extends StatefulWidget {
  final int someValue;
  const customeraddetails({Key? key, required this.someValue})
      : super(key: key);

  @override
  State<customeraddetails> createState() => _customeraddetails();
}

class _customeraddetails extends State<customeraddetails> {
  List<Ffmo> aclist = [];

  TextEditingController _accountId = TextEditingController();
  TextEditingController _name = TextEditingController();

  Ffmo adcustomer = Ffmo(
    accountId: "",
    name: "",
  );

  // เพิ่มบรรทัดนี้
  Ffmo selectedItem = Ffmo(
    accountId: "",
    name: "",
  );

  final formKey = GlobalKey<FormState>();
  var _formKey = GlobalKey<FormState>();

  Future<void> _postData() async {
    MyGlobalData globalData = MyGlobalData();
    String myValue = globalData.token.trim();
    print(myValue);
    print("-----------");
    try {
      const String apiUrl =
          'http://172.20.10.3:8080/api/v1/admin/get-all-member';
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $myValue',
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        // final Map<String, dynamic> responseData = json.decode(response.body);

        // if (responseData.containsKey('data')) {
          String responseBody = utf8.decode(response.bodyBytes);
        List<dynamic> responseData = json.decode(responseBody);

        //List<dynamic> responseData = json.decode(response.body);

        if (responseData.isNotEmpty) {
          setState(() {
            final Map<String, dynamic> adcustomerData =
                responseData[widget.someValue];

            adcustomer = Ffmo(
              accountId: adcustomerData['accountId'] ?? "",
              name: adcustomerData['name'] ?? "",
            );
          });

          //   aclist = responseData
          //       .map((data) => Ffmo(
          //          accountId: data['accountId'],
          //             name: data['name'],
          //           ))
          //       .toList();
          // });
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

  Future<void> _deleteDataToApi() async {
    // MyGlobalData globalData = MyGlobalData();
    // String myValue = globalData.token.trim();

    try {
      const String deleteApiUrl =
          'http://172.20.10.3:8080/api/v1/member/delete'; // แทนที่ URL ด้วย URL ของ API ที่รองรับการลบ
      // final Map<String, dynamic> deleteData = {
      //    'name': _name.text,
      //    'accountId': _accountId.text,// แทนที่ yourIndexValue ด้วยค่า index ที่ต้องการลบ
      //   // Add other keys as needed
      // };

      final response = await http.delete(
        Uri.parse(deleteApiUrl),
        body: jsonEncode({
          'accountId': _accountId.text,
        }),
        headers: {
          'Authorization': 'Bearer ${MyGlobalData().token}',
          'Content-Type': 'multipart/form-data',
        },
      );

      print(response.statusCode);
      if (response.statusCode == 200) {
        print("Delete successful");
        // Handle success
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
    super.initState();
    _postData(); // เรียกใช้ _postData เพื่อดึงข้อมูลทันทีเมื่อ widget ถูกสร้าง
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "รายละเอียดลูกค้า",
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
              return AdminPage();
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
            const SizedBox(
              height: 20,
            ),
            // The reservation content you mentioned

            Container(
              width: MediaQuery.of(context).size.width,
              height: 230,
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
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "รายละเอียดลูกค้า",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "คุณแน่ใจหรือไม่ว่าต้องการลบรายละเอียด",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      adcustomer.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _deleteDataToApi();
                            // Handle payment
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => controlpage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red.shade300,
                            minimumSize: Size(100, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Adjust the radius as needed
                            ),
                          ),
                          child:
                              const Text("ลบ", style: TextStyle(fontSize: 18)),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () {
                            // Add your cancel action here
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey.shade400,
                            minimumSize: Size(100, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Adjust the radius as needed
                            ),
                          ),
                          child: const Text(
                            "ยกเลิก",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
