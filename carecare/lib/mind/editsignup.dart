
import 'package:carecare/mind/passwordpage.dart';
import 'package:carecare/mind/profilepage.dart';
import 'package:carecare/model/token.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class editsignup extends StatefulWidget {
  const editsignup({super.key});

  @override
  State<editsignup> createState() => _editsignupState();
}

class _editsignupState extends State<editsignup> {
  TextEditingController textFormFieldEmailedit = TextEditingController();
  TextEditingController textFormFieldPasswordedit = TextEditingController();
  final _nameedit = TextEditingController();
  final _addressedit = TextEditingController();
  final _teledit = TextEditingController();
  final formKey = GlobalKey<FormState>();

  MyGlobalData globalData = MyGlobalData();
  String selectValue = '';
  String imagePath = "";

  @override
  void dispose() {
    textFormFieldEmailedit.dispose();
    textFormFieldPasswordedit.dispose();
    super.dispose();
  }

  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    Future<void> _postData() async {
      final String apiUrl = 'http://172.20.10.3:8080/api/v1/member/register';

      final response = await http.put(
        Uri.parse(apiUrl),
        body: jsonEncode({
          'name': _nameedit.text,
          'address': _addressedit.text,
          'tel': _teledit.text,
          'sex': selectValue,
         
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
       appBar: AppBar(
        title: Text(
          "แก้ไขข้อมูล",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return profilepage(globalData.token); 
            }));
          },
          icon: Icon(
            Icons.arrow_circle_left_outlined,
            color: Colors.white,
            size: 40,
          ),
        ),
        //backgroundColor: Theme.of(context).backgroundColor,
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
      body :
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
                          controller: _nameedit,
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
                            } else if (_nameedit.text.length < 5) {
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
                          controller: _addressedit,
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
                          controller: _teledit,
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
                            }else if (_teledit.text.length < 10) {
                              return "เบอร์โทรศัพท์ของคุณไม่ถูกต้อง";
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
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
                  child: const Text("แก้ไขข้อมุล",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  onPressed: () {
                    if (_formKey.currentState!.validate() == true) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return password();
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

           
               ])))));
  }
}