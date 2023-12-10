
import 'package:carecare/min/control.dart';
import 'package:carecare/model/customerid.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:carecare/model/token.dart';

class customerdetail extends StatefulWidget {
 // String token = "";
 const customerdetail({super.key});
//  String token = "";
//  customerdetail(this.token,{Key? key}):super(key:key);

  @override
  State<customerdetail> createState() => _customerdetailState();
}

class _customerdetailState extends State<customerdetail> {
  //String token;
  //_customerdetailState({required this.token});
  TextEditingController _name = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _tel = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _birthday = TextEditingController();
  TextEditingController _sex= TextEditingController();
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
   Future<void> _postData() async {

    MyGlobalData globalData = MyGlobalData();
    String myValue = globalData.token.trim();
    print(myValue);
    print("-----------");
    try {
      const String apiUrl =  'http://172.20.10.3:8080/api/v1/admin/get-all-member';
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $myValue',
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic>? responseData = json.decode(response.body);

        if (responseData != null) {
          setState(() {
            admincustomerid = Admincustomerid(
              name: responseData['name'],
              address: responseData['address'],
              tel: responseData['tel'],
              birthday: responseData['birthday'],
              sex: responseData['sex'],
              email: responseData['email'],
              accountId: responseData['accountId']

             
            );
          });
        } else {
          // กรณี API ส่งข้อมูลที่ไม่ถูกต้อง
          print("Invalid JSON data");
          print(admincustomerid);
        }
      } else {
        print("Error: ${response.statusCode}");
        print("Error: ${response.body}");
        print(admincustomerid);
      }
    } catch (error) {
      print("Error: $error");
      print(admincustomerid);
    }
  }

  @override
  void initState() {
    _postData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    //double h = MediaQuery.of(context).size.height;
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
                children: [
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_circle_left_outlined,
                          color: Colors.black,
                          size: 40,
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return controlpage();
                          }));
                        },
                      ),
                      // SizedBox(height: 20),
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
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                      //     Image(
                      //   image: AssetImage("assets/woman.png"),
                      //   width: 140,
                      //   height: 140,
                      // ),
                      
                        ),

                        Center(
                          child: Image(
                          image: AssetImage("assets/profile.png"),
                          width: 140,
                          height: 140,
                                              ),
                        ),
                        SizedBox(height: 20,),
                        
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
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
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
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
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
                       
                       
                        //เบอร์โทรศัพท์
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
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
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
                        //เมลล์
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
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
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
                                                //เบอร์โทรศัพท์
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
                            Text(
                              admincustomerid.address,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ],
                        ),
                        Divider(
                          height: 5,
                          thickness: 2,
                        ),
                        SizedBox(
                          height: 20,
                        ),                        //เบอร์โทรศัพท์
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
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ],
                        ),
                        Divider(
                          height: 5,
                          thickness: 2,
                        ),
                        SizedBox(
                          height: 20,
                        ),                        //เบอร์โทรศัพท์
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
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ],
                        ),
                        Divider(
                          height: 5,
                          thickness: 2,
                        ),
                        SizedBox(
                          height: 20,
                        ),                        //เบอร์โทรศัพท์
                        // Text(
                        //   "สถานะ",
                        //   style: TextStyle(
                        //       fontSize: 20,
                        //       fontWeight: FontWeight.bold,
                        //       color: Colors.black),
                        // ),
                        // SizedBox(
                        //   height: 15,
                        // ),
                        // Row(
                        //   children: [
                        //     Icon(
                        //       Icons.phone,
                        //       size: 24,
                        //       color: Colors.blue,
                        //     ),
                        //     Text(
                        //       admincustomerid.active,
                        //       style:
                        //           TextStyle(fontSize: 18, color: Colors.black),
                        //     ),
                        //   ],
                        // ),
                        // Divider(
                        //   height: 5,
                        //   thickness: 2,
                        // ),
                      //   SizedBox(
                      //     height: 20,
                      //   ),
                      ],
                      // Image(
                      //   image: AssetImage("assets/woman.png"),
                      //   width: 140,
                      //   height: 140,
                      // )
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),)
    );
  }
}