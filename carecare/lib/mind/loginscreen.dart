import 'dart:convert';

import 'package:carecare/AdminPage.dart';
import 'package:carecare/homescreen.dart';
import 'package:carecare/mind/customerid.dart';
import 'package:carecare/mind/profilepage.dart';
import 'package:carecare/mind/signupscreen.dart';
import 'package:carecare/model/token.dart';
import 'login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class loginscreen extends StatefulWidget {
  const loginscreen({super.key});

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  MyGlobalData globalData = MyGlobalData();
  bool passwordObscured = true;
  bool emailObscured = true;
  bool admin = true;
  // bool emilVaiid = RegExp(
  //         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_{}~]+@[a-zA-Z0-9] +\.[a-zA-Z]+")
  //     .hasMatch(value);

  var _formKey = GlobalKey<FormState>();
  // void _submitFunc() {
  //   var isValid = _formKey.currentState?.validate();
  //   if (isValid != null && isValid) {
  //     _formKey.currentState?.save();
  //     print('email: $_email, password: $_password ');
  //   }
  // }

  Future<void> _postData() async {
    try {
      final String apiUrl = 'http://172.20.10.3:8080/api/v1/member/login';
      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode({'email': _email.text, 'password': _password.text}),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        globalData.token = responseData['accessToken'];

        print(globalData.token);
        if (responseData['admin']) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AdminPage();
          }));
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return MainHomePage();
          }));
        }
      } else {
        print("หาทางแก้");
      }
    } catch (error) {
      print('Error fetching data: $error');
      return null;
    }
  }

//   Future<void> _postData() async {
//     try {
//       final String apiUrl = 'http://172.20.10.3:8080/api/v1/member/login';
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         body: jsonEncode({'email': _email.text, 'password': _password.text}),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//       );
//       print(response.statusCode);
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> responseData = json.decode(response.body);
//         globalData.token = responseData['accessToken'];
//         print(globalData.token);

//         Navigator.push(context, MaterialPageRoute(builder: (context) {
//           return profilepage(globalData.token);
//         }));
//       }else {
//       print("เกิดข้อผิดพลาด: ${response.statusCode}");
//       // จัดการข้อผิดพลาดที่นี่ (ตัวอย่างเช่น แสดงข้อความผิดพลาด)
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('เกิดข้อผิดพลาด: ${response.statusCode}'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   } catch (error) {
//     print('Error fetching data: $error');
//     // จัดการข้อผิดพลาดที่นี่ (ตัวอย่างเช่น แสดงข้อความผิดพลาด)
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('เกิดข้อผิดพลาด: $error'),
//         backgroundColor: Colors.red,
//       ),
//     );
//   }
// }
  //else {
  //       print("หาทางแก้");
  //     }
  //   } catch (error) {
  //     print('Error fetching data: $error');
  //     return null;
  //   }
  // }

  // Login _dataFromAPI;
  // final _email = TextEditingController();
  // final _password = TextEditingController();
  //@override
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    // final _email = TextEditingController();
    // final _password = TextEditingController();
    // Future<void> _postData() async {
    //   try {
    //     final String apiUrl = 'http://172.20.10.3:8080/api/v1/member/login';
    //     final response = await http.post(
    //       Uri.parse(apiUrl),
    //       body: jsonEncode({
    //         'email': _email.text,
    //         'password': _password.text
    //       }), // Replace 'text' with your API parameter
    //       headers: {
    //         'Content-Type': 'application/json', // Adjust content type as needed
    //       },
    //     );
    //     if (response.statusCode == 200) {
    //       final Map<String, dynamic> responseData = json.decode(response.body);
    //       // globalData = (token: responseData['accessToken']);
    //       MyGlobalData globalData = MyGlobalData();
    //       globalData.token = responseData['accessToken'];
    //       print(globalData.token);
    //       // MyGlobalData globalData = MyGlobalData();
    //       // String myValue = globalData.token;
    //     } else {
    //       print(response.statusCode);
    //       print("หาทางแก้");
    //     }
    //   } catch (error) {
    //     print('Error fetching data: $error');
    //     return null;
    //   }
    // }

    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
                    decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(60),
          bottomRight: Radius.circular(60),
        ),
      ),
              width: w,
              height: h * 0.25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  const Text(
                    "\tยินดีต้อนรับกลับ!",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  RichText(
                    text: TextSpan(
                      text: "\t\tคุณยังไม่มีบัญชี ใช่หรือไม่ ?",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(
                          text: "ลงทะเบียน",
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.yellowAccent,
                            decorationThickness: 2.0,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellowAccent,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('object');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        signupscreen()), // Replace RegistrationPage with the destination page you want to navigate to
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: w,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      // const Text(
                      //   "อีเมลล์",
                      //   style: TextStyle(
                      //       fontSize: 20,
                      //       fontWeight: FontWeight.bold,
                      //       color: Colors.black),
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        // decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     borderRadius: BorderRadius.circular(20),
                        //     boxShadow: [
                        //       BoxShadow(
                        //           blurRadius: 10,
                        //           spreadRadius: 7,
                        //           offset: const Offset(1, 1),
                        //           color: Colors.grey.withOpacity(0.3))
                        //     ]),
                        child: TextFormField(
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          key: ValueKey('email'),
                          //obscureText: emailObscured,
                          decoration: InputDecoration(
                            labelText: "อีเมล",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            prefixIcon: Icon(Icons.email),
                            // hintText: "ป้อนที่อยู่ของอีเมลล์",
                            // focusedBorder: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(20),
                            //     borderSide: const BorderSide(
                            //         color: Colors.white, width: 1.0)),
                          ),
                          validator: (value) {
                            bool emilVaiid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_{}~]+@[a-zA-Z0-9] +\.[a-zA-Z]+")
                                .hasMatch(value!);
                            if (value!.isEmpty) {
                              return "โปรดป้อนอีเมลของคุณ";
                            } 
                          },
                         
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // const Text(
                      //   "รหัสผ่าน",
                      //   style: TextStyle(
                      //       fontSize: 20,
                      //       fontWeight: FontWeight.bold,
                      //       color: Colors.black),
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        // decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     borderRadius: BorderRadius.circular(20),
                        //     boxShadow: [
                        //       BoxShadow(
                        //           blurRadius: 10,
                        //           offset: const Offset(1, 1),
                        //           color: Colors.grey.withOpacity(0.3))
                        //     ]),
                        child: TextFormField(
                          controller: _password,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.key,
                              ),
                              hintText: "ป้อนรหัสผ่าน",
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      passwordObscured = !passwordObscured;
                                    });
                                  },
                                  icon: Icon(passwordObscured
                                      ? Icons.visibility_off
                                      : Icons.visibility)),
                              // focusedBorder: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(20),
                              //     borderSide: const BorderSide(
                              //         color: Colors.white, width: 1.0)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          validator: (value) {
                            var response;
                            if (value!.isEmpty) {
                              return "โปรดป้อนรหัสผ่านของคุณ";
                            } 
                            // if (response.statusCode != 200) {
                            //     return "รหัสผ่านไม่ถูกต้อง";
                            // }
                            
                            
                          },
                          obscureText: passwordObscured,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),

              //color: Colors.blue,
              width: w * 0.9,
              height: h * 0.06,

              child: ElevatedButton(
                child: const Text("เข้าสู่ระบบ",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    print("สำเร็จ");
                  }

                  // // ตรวจสอบเงื่อนไขของผู้ใช้งาน
                  // if (_email == 'admin' && _password == 'adminpassword') {
                  //   // เชื่อมต่อไปยังหน้า adminpage
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => customerdetail()),
                  //   );
                  // } else {
                  //   // เชื่อมต่อไปยัง homepage (สำหรับลูกค้า)
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => onboarding()),
                  //   );
                  // }
                  await _postData();
                },
              ),
            ),
          ],
        ));
  }
}