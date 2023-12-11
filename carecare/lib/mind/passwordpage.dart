import 'dart:convert';
import 'package:carecare/mind/confirmpage.dart';
import 'package:carecare/mind/profilepage.dart';
import 'package:carecare/model/token.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class password extends StatefulWidget {
  const password({super.key});

  @override
  State<password> createState() => _passwordState();
}

class _passwordState extends State<password> {
  TextEditingController _oldPassword = TextEditingController();
  TextEditingController _newPassword= TextEditingController();
  
  //TextEditingController _passwordagain = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? _passwordagain;

  MyGlobalData globalData = MyGlobalData();
  bool passwordObscured1 = true;
  bool passwordObscured2 = true;
  bool passwordObscured3 = true;
  
  var _formKey = GlobalKey<FormState>();
    @override
  void dispose() {
    _oldPassword.dispose();
    _newPassword.dispose();
    super.dispose();
  }


  // void _submitFunc() {
  //   var isValid = _formKey.currentState?.validate();
  //   if (isValid != null && isValid) {
  //     _formKey.currentState?.save();
  //     print(' oldPassword: $_passwordold,newPassword: $_passwordnew ');
  //   }
  // }

  Future<void> _postData() async {
    
      print(_oldPassword.text);
      print(_newPassword.text);
      print(_passwordagain);

      const String apiUrl =
          'http://172.20.10.3:8080/api/v1/member/reset-password';
      final response = await http.put(
        Uri.parse(apiUrl),
        body: jsonEncode({
          'oldPassword': _oldPassword.text,
          'newPassword': _newPassword.text,
          //'passwordagain': _passwordagain
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print(response.statusCode);
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

  @override
  void initState() {
    _postData();
    super.initState();
  }
 

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    // Future<void> _postData() async {
    //   try {
    //     final String apiUrl = '';
    //     final response = await http.post(
    //       Uri.parse(apiUrl),
    //       body: jsonEncode({
    //         'passwordnew': _passwordnew.text,
    //         'passwordagain': _passwordagain.text
    //       }),
    //       headers: {
    //         'Content-Type': 'application/json',
    //       },
    //     );
    //     if (response.statusCode == 200) {
    //       final Map<String, dynamic> responseData = json.decode(response.body);
    //       MyGlobalData globalData = MyGlobalData();
    //       globalData.token = responseData['accessToken'];
    //       print(globalData.token);
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
      appBar: AppBar(
        title: Text(
          "รหัสผ่านของคุณ",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
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
      body: (Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.start,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const Text(
                  //   'รหัสผ่านเดิมของคุณ',
                  //   style: TextStyle(
                  //       fontSize: 22,
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.black),
                  // ),
                  // TextFormField(
                  //   keyboardType: TextInputType.visiblePassword,
                  //   key: ValueKey(
                  //     'passwordold',
                  //   ),
                  //   obscureText: passwordObscured1,
                  //   decoration: InputDecoration(
                  //     prefixIcon: Icon(
                  //       Icons.key,
                  //     ),
                  //     suffixIcon: IconButton(
                  //         onPressed: () {
                  //           setState(() {
                  //             passwordObscured1 = !passwordObscured1;
                  //           });
                  //         },
                  //         icon: Icon(passwordObscured1
                  //             ? Icons.visibility_off
                  //             : Icons.visibility)),
                  //   ),
                  //   onSaved: (newValue) {
                  //     _passwordold = newValue;
                  //   },
                  //   validator: (value) {
                  //     value = value?.trim();
                  //     if (value!.isEmpty) {
                  //       return "โปรดพิมพ์รหัสผ่านของคุณ";
                  //     }
                  //     if (value!.length < 8) {
                  //       return "โปรดใส่รหัสผ่าน 8 ตัวอักษร";
                  //     }
                  //     // if(value != _password){
                  //     //   return 'รหัสผ่านไม่ถูกต้อง';
                  //     // }

                  //     return null;
                  //   },
                  // ),
                  // SizedBox(height: 10,),
                  const Text(
                    'รหัสผ่านเดิม',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  TextFormField(
                    controller: _oldPassword,
                    keyboardType: TextInputType.visiblePassword,
                    key: ValueKey('oldPassword'),
                    obscureText: passwordObscured1,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.key,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              passwordObscured1= !passwordObscured1;
                            });
                          },
                          icon: Icon(passwordObscured1
                              ? Icons.visibility_off
                              : Icons.visibility)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'รหัสผ่านใหม่',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  TextFormField(
                    controller: _newPassword,
                    keyboardType: TextInputType.visiblePassword,
                    key: ValueKey('newPassword'),
                    obscureText: passwordObscured2,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.key,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              passwordObscured2 = !passwordObscured2;
                            });
                          },
                          icon: Icon(passwordObscured2
                              ? Icons.visibility_off
                              : Icons.visibility)),
                    ),
                    onSaved: (newValue) {
                      if (newValue != null) {
                        _newPassword.text = newValue;
                      }
                    },
                    validator: (value) {
                      if (value != null) {
                        _newPassword.text = value;
                        value = value?.trim();
                        if (value!.isEmpty) {
                          return "โปรดใส่รหัสผ่านอันใหม่";
                        }
                        if (value!.length < 8) {
                          return "โปรดใส่รหัสผ่าน 8 ตัวอักษร";
                        }
                      }

                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'พิมพ์รหัสของคุณอีกครั้ง',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    key: ValueKey('passwordagain'),
                    obscureText: passwordObscured3,
                    
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.key,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              passwordObscured3 = !passwordObscured3;
                            });
                          },
                          icon: Icon(passwordObscured3
                              ? Icons.visibility_off
                              : Icons.visibility)),
                    ),
                    onSaved: (newValue) {
                      _passwordagain = newValue;
                    },
                    validator: (value) {
                      value = value?.trim();
                      if (value!.isEmpty) {
                        return "โปรดพิมพ์รหัสผ่านใหม่อีกครั้ง";
                      }
                      if (value!.length < 8) {
                        return "โปรดใส่รหัสผ่าน 8 ตัวอักษร";
                      }
                      if (value != _newPassword.text) {
                        return 'รหัสผ่านไม่ถูกต้อง';
                      }

                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),

                    //color: Colors.blue,
                    width: w * 0.9,
                    height: h * 0.06,

                    child: ElevatedButton(
                      child: const Text("ยืนยัน",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      onPressed: () {
                        if (_formKey.currentState!.validate() == true) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ConfirmComplete();
                          }));
                          _postData();
                        }
                      },
                    ),
                  ),
                ]),
          ),
        ),
      )),
    );
  }
}
