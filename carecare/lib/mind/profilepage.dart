import 'dart:convert';
//import 'dart:ui';

import 'package:carecare/ae/Listservice.dart';
import 'package:carecare/homescreen.dart';
import 'package:carecare/mind/editpro.dart';
import 'package:carecare/mind/editsignup.dart';
import 'package:carecare/mind/password.dart';
import 'package:carecare/model/profile.dart';
import 'package:carecare/model/token.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class profilepage extends StatefulWidget {
  String token = "";

  profilepage(this.token, {Key? key}) : super(key: key);

  @override
  State<profilepage> createState() => _profilepageState(token: token);
}

class _profilepageState extends State<profilepage> {
  String token;

  _profilepageState({required this.token});

  TextEditingController _name = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _tel = TextEditingController();
  TextEditingController _birthday = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _age = TextEditingController();

  String selectValue = '';
  String imagePath = "";

  bool isTextObscure1 = true;
  Icon v1 = const Icon(Icons.visibility_rounded);

  UserProfile userProfile = UserProfile(
    name: "",
    address: "",
    tel: "",
    birthday: "",
    sex: "",
    email: "",
    age: 0
  );

  // @override
  // void get() {
  //   _name.dispose();
  //   _address.dispose();
  //   _tel.dispose();
  //   _birthday.dispose();
  //   _email.dispose();
  //   _age.dispose();
  //   super.dispose();
  // }

  Future<void> _postData() async {

    MyGlobalData globalData = MyGlobalData();
    String myValue = globalData.token.trim();
    print(myValue);
    print("-----------");
    try {
      const String apiUrl =  'http://172.20.10.3:8080/api/v1/member/get-personal-data';
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
        //List<dynamic> responseData = json.decode(responseBody);

        final Map<String, dynamic>? responseData = json.decode(responseBody);

        if (responseData != null) {
          setState(() {
            userProfile = UserProfile(
              name: responseData['name'],
              address: responseData['address'],
              tel: responseData['tel'],
              birthday: responseData['birthday'],
              sex: responseData['sex'],
              email: responseData['email'],
              age: responseData['age'],
            );
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // print(token);
    // print("HelloToken");

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 237,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.blueAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(70),
                bottomRight: Radius.circular(70),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_circle_left_outlined,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return MainHomePage();
                          }));
                        },
                      ),
                      Text(
                        "\t\t\t\t\t\t\t\t\tโปรไฟล์ของคุณ",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 140,
                    height: 140,
                    child: Image.asset(
                      userProfile.sex == 'male'
                          ? "assets/man.png"
                          : "assets/woman.png",
                      width: 140,
                      height: 140,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            width: w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "ชื่อ-นามสกุลของคุณ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 24,
                      color: Colors.blue,
                    ),
                    Text(
                      userProfile.name,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ],
                ),
                Divider(
                  height: 5,
                  thickness: 2,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "ที่อยู่",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10,
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
                        userProfile.address,
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
                  height: 10,
                ),
                Text(
                  "เบอร์โทรศัพท์",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.phone,
                      size: 24,
                      color: Colors.blue,
                    ),
                    Text(
                      userProfile.tel,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ],
                ),
                Divider(
                  height: 5,
                  thickness: 2,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "วัน/เดือน/ปีเกิด",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      size: 24,
                      color: Colors.blue,
                    ),
                    Text(
                      userProfile.birthday,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ],
                ),
                Divider(
                  height: 5,
                  thickness: 2,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "เพศ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 24,
                      color: Colors.blue,
                    ),
                    Text(
                      userProfile.sex,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ],
                ),
                Divider(
                  height: 5,
                  thickness: 2,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "อายุ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 24,
                      color: Colors.blue,
                    ),
                    Text(
                      userProfile.age.toString(),
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ],
                ),
                Divider(
                  height: 5,
                  thickness: 2,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "อีเมล",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.mail,
                      size: 24,
                      color: Colors.blue,
                    ),
                    Text(
                      userProfile.email,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ],
                ),
                Divider(
                  height: 5,
                  thickness: 2,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  width: w * 0.8,
                  height: h * 0.06,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey.shade300,
                    ),
                    child: Text("แก้ข้อมูลส่วนตัว",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        )),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return editpro();
                      }));
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  width: w * 0.8,
                  height: h * 0.06,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey.shade300,
                    ),
                    child: Text("แก้ไขรหัสผ่าน",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        )),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return password();
                      }));
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  width: w * 0.8,
                  height: h * 0.06,
                  child: ElevatedButton(
                    child: Text("บันทึก",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                    onPressed: () {
                      // ทำอะไรสักอย่างเมื่อกดปุ่ม "บันทึก"
                      // เช่น เรียก _postData() เพื่ออัปเดตข้อมูล
                      _postData();
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return MainHomePage();
                      }));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}