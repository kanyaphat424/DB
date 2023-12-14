
import 'package:carecare/min/control.dart';
import 'package:carecare/model/customerid.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:carecare/model/token.dart';

class customerdetail extends StatefulWidget {
  final int someValue; // ตัวแปรที่จะใช้เก็บค่าที่รับมา

  const customerdetail({Key? key, required this.someValue}) : super(key: key);

  @override
  State<customerdetail> createState() => _customerdetailState();
}

class _customerdetailState extends State<customerdetail> {
  TextEditingController _name = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _tel = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _birthday = TextEditingController();
  TextEditingController _sex = TextEditingController();
  TextEditingController _accountId = TextEditingController();

  Admincustomerid admincustomerid = Admincustomerid(
    accountId: "",
    name: "",
    birthday: "",
    tel: "",
    email: "",
    address: "",
    sex: "",
  );

  // เพิ่มบรรทัดนี้
  Admincustomerid selectedItem = Admincustomerid(
    accountId: "",
    name: "",
    birthday: "",
    tel: "",
    email: "",
    address: "",
    sex: "",
  );
  Future<void> _postData() async {
    MyGlobalData globalData = MyGlobalData();
    String myValue = globalData.token.trim();
    print(myValue);
    print("-----------");
    try {
      const String apiUrl = 'http://172.20.10.3:8080/api/v1/admin/get-all-member';
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $myValue',
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        String responseBody = utf8.decode(response.bodyBytes);
        List<dynamic> responseData = json.decode(responseBody);

        if (responseData.isNotEmpty) {
          setState(() {
            // Assuming you want to access the first item of the list
            final Map<String, dynamic> customerData = responseData[widget.someValue];

            admincustomerid = Admincustomerid(
              name: customerData['name'],
              address: customerData['address'],
              tel: customerData['tel'],
              birthday: customerData['birthday'],
              sex: customerData['sex'],
              email: customerData['email'],
              accountId: customerData['accountId'],
            );
          });
        } else {
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_circle_left_outlined,
                            color: Colors.black,
                            size: 40,
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return controlpage();
                            }));
                          },
                        ),
                        Text(
                          "\t\t\t\t\t\t\t\t\tรายละเอียดลูกค้า",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1000,
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
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Image(
                              image: AssetImage("assets/profile.png"),
                              width: 140,
                              height: 140,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "ID ลูกค้า",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                size: 24,
                                color: Colors.blue,
                              ),
                              Text(
                                admincustomerid.accountId,
                                style: TextStyle(fontSize: 18, color: Colors.black),
                              ),
                            ],
                          ),
                          Divider(
                            height: 5,
                            thickness: 2,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "ชื่อ",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                size: 24,
                                color: Colors.blue,
                              ),
                              Text(
                                admincustomerid.name,
                                style: TextStyle(fontSize: 18, color: Colors.black),
                              ),
                            ],
                          ),
                          Divider(
                            height: 5,
                            thickness: 2,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "วัน/เดือน/ปีเกิด",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.phone,
                                size: 24,
                                color: Colors.blue,
                              ),
                              Text(
                                admincustomerid.birthday,
                                style: TextStyle(fontSize: 18, color: Colors.black),
                              ),
                            ],
                          ),
                          Divider(
                            height: 5,
                            thickness: 2,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "เบอร์โทรศัพท์",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.mail,
                                size: 24,
                                color: Colors.blue,
                              ),
                              Text(
                                admincustomerid.tel,
                                style: TextStyle(fontSize: 18, color: Colors.black),
                              ),
                            ],
                          ),
                          Divider(
                            height: 5,
                            thickness: 2,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "ที่อยู่",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.home,
                                size: 24,
                                color: Colors.blue,
                              ),
                              Expanded(
                                child: Text(
                                  admincustomerid.address,
                                  style: TextStyle(fontSize: 18, color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            height: 5,
                            thickness: 2,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "เพศ",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                size: 24,
                                color: Colors.blue,
                              ),
                              Text(
                                admincustomerid.sex,
                                style: TextStyle(fontSize: 18, color: Colors.black),
                              ),
                            ],
                          ),
                          Divider(
                            height: 5,
                            thickness: 2,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "อีเมล",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.mail,
                                size: 24,
                                color: Colors.blue,
                              ),
                              Text(
                                admincustomerid.email,
                                style: TextStyle(fontSize: 18, color: Colors.black),
                              ),
                            ],
                          ),
                          Divider(
                            height: 5,
                            thickness: 2,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
