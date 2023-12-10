import 'dart:convert';

import 'package:carecare/mind/loginscreen.dart';
import 'package:carecare/mind/profilepage.dart';
import 'package:carecare/model/token.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class signupscreen extends StatefulWidget {
  const signupscreen({super.key});

  @override
  State<signupscreen> createState() => _signupscreenState();
}

class _signupscreenState extends State<signupscreen> {
  TextEditingController textFormFieldEmail = TextEditingController();
  TextEditingController textFormFieldPassword = TextEditingController();
  TextEditingController _birthday = TextEditingController();
  final _name = TextEditingController();
  final _address = TextEditingController();
  final _tel = TextEditingController();
  final _sex = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  MyGlobalData globalData = MyGlobalData();
  bool passwordObscured = true;
  Icon iconPic = const Icon(Icons.visibility_rounded);
  String selectValue = '';
  String imagePath = "";

  @override
  void dispose() {
    textFormFieldEmail.dispose();
    textFormFieldPassword.dispose();
    super.dispose();
  }

  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    Future<void> _postData() async {
      const String apiUrl = 'http://172.20.10.3:8080/api/v1/member/register';

      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode({
          'name': _name.text,
          'address': _address.text,
          'tel': _tel.text,
          'birthday': _birthday.text,
          'sex': selectValue,
          'email': _email.text,
          'password': _password.text,
        }), // Replace 'text' with your API parameter
        headers: {
          'Content-Type': 'application/json', // Adjust content type as needed
        },
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        MyGlobalData globalData = MyGlobalData();
        globalData.token = responseData['accessToken'];
        print(globalData.token);
      } else {
        print(response.statusCode);
        print("หาทางแก้");
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            //SizedBox(height: 20,),
            Container(
                  decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(60),
          bottomRight: Radius.circular(60),
        ),
      ),
              width: w,
              height: h * 0.22,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("           "),
                  const Text("           "),
                  const Text("           "),
                  const Text(
                    "\tลงทะเบียน",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  //Text("หากคุณมีบัญชีแล้ว?",style: TextStyle(fontSize: 20 ,fontWeight: FontWeight.bold,color:Colors.white),),
                  RichText(
                    text: TextSpan(
                        text: "\t\tหากคุณมีบัญชีแล้ว?",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        children: [
                          TextSpan(
                            text: "เข้าสู่ระบบ",
                            style: const TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.yellowAccent,
                                decorationThickness: 2.0,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellowAccent),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // print('object');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const loginscreen()), // Replace RegistrationPage with the destination page you want to navigate to
                                );
                              },
                          ),
                        ]),
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.all(20.0),
              // margin: const EdgeInsets.only(left: 20, right: 20),
              // width: w,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "ชื่อ",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
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
                          controller: _name,
                          //validator:RequiredValidator(errorText : "โปรดป้อนข้อมูลให้ครบ"),
                          decoration: InputDecoration(
                              hintText: "กำหนดชื่อของคุณ",
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1.0)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              prefixIcon: Icon(Icons.person)),
                          validator: (value) {
                            bool nameVaiid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_{}~]+@[a-zA-Z0-9] +\.[a-zA-Z]+")
                                .hasMatch(value!);
                            if (value!.isEmpty) {
                              return "โปรดป้อนชื่อของคุณ";
                            } else if (_name.text.length < 5) {
                              return "ชื่อของคุณไม่ถูกต้อง";
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "ที่อยู่",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
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
                          controller: _address,
                          decoration: InputDecoration(
                              hintText: "ป้อนที่อยู่ของคุณ",
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1.0)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              prefixIcon: Icon(Icons.add_home_outlined)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "โปรดป้อนที่อยู่ของคุณ";
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "เบอร์โทรศัพท์",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
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
                          controller: _tel,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              hintText: "ป้อนเบอร์โทรศัพท์ของคุณ",
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1.0)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              prefixIcon: Icon(Icons.phone_android_outlined)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "โปรดป้อนเบอร์โทรศัพท์ของคุณ";
                            }else if (_tel.text.length < 10) {
                              return "เบอร์โทรศัพท์ของคุณไม่ถูกต้อง";
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "วัน/เดือน/ปีเกิด",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _birthday,
                        decoration: const InputDecoration(
                            icon: Icon(Icons.calendar_today_rounded),
                            labelText: "เลือกวัน/เดือน/ปีเกิดของคุณ",
                            labelStyle: TextStyle(fontSize: 16)),
                        onTap: () async {
                          DateTime? pickeddate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now());

                          if (pickeddate != null) {
                            setState(() {
                              _birthday.text =
                                  DateFormat('yyyy-MM-dd').format(pickeddate);
                            });
                           }
                          // else{
                          //     return "โปรดป้อนวัน/เดือน/ปีเกิดของคุณ";
                          //     }
                          
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "เพศ",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Column(
                          children: [
                            RadioListTile(
                                title: Text("Male"),
                                value: 'male',
                                groupValue: selectValue,
                                onChanged: (value) {
                                  setState(() {
                                    selectValue = value.toString();
                                    imagePath = "assets/man.png";
                                  });
                                }),
                            RadioListTile(
                              title: Text("Female"),
                              value: "Female",
                              groupValue: selectValue,
                              onChanged: (value) {
                                setState(() {
                                  selectValue = value.toString();
                                  imagePath = "assets/woman.png";
                                });
                              },
                            ),
                            Image.asset(
                              selectValue == 'male'
                                  ? "assets/man.png"
                                  : "assets/woman.png",
                              width: 140,
                              height: 140,
                            ),
                            // selectValue == 'male'
                            // ?Image.asset('assets/man.pmg',width: 100,height: 100,)
                            // :selectValue == 'female'
                            // ?Image.asset('assets/female.png',width: 100,height: 100,)
                            // :Container(),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "อีเมล",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
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
                          decoration: InputDecoration(
                              hintText: "ป้อนอีเมลของคุณ",
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1.0)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                                  prefixIcon: Icon(Icons.email_outlined)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "โปรดป้อนที่อยู่ของคุณ";
                            }if(!value.contains('@')){
                              return "อีเมลไม่ถูกต้อง โปรดใส่ '@' ในอีเมลของคุณ";
                            } 
                          },),
                        ),
                      
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "รหัสผ่าน",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
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
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      passwordObscured = !passwordObscured;
                                    });
                                  },
                                  icon: Icon(passwordObscured
                                      ? Icons.visibility_off
                                      : Icons.visibility)),
                              hintText: "ป้อนรหัสผ่าน",
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1.0)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                                  validator: (value) {
                            if (value!.isEmpty) {
                              return "โปรดป้อนรหัสผ่านของคุณ";
                            } else if (_password.text.length < 8) {
                              return "รหัสผ่านต้องมี 8 อักขระ";
                            }
                          },
                          obscureText: passwordObscured,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          
            SizedBox(height: 20,),
             Container(
              margin: const EdgeInsets.only(left: 20, right: 20),

              //color: Colors.blue,
              width: w * 0.9,
              height: h * 0.06,
              

              child: ElevatedButton(
                  child: const Text("ลงทะเบียน",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  onPressed: () {
                    if (_formKey.currentState!.validate() == true) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return loginscreen();
                      }));
                      _postData();
                    }
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) {
                    //   return loginscreen();
                    // }));
                    // _postData();
                  }),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 7,
                        offset: const Offset(1, 1),
                        color: Colors.grey.withOpacity(0.3)),
                  ]),
            ),
            SizedBox(height: 40,),
          ],
        ));
  }
}