import 'package:carecare/mind/confirmpage.dart';
import 'package:carecare/mind/profilepage.dart';
import 'package:carecare/model/profile.dart';
import 'package:carecare/model/token.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class editpro extends StatefulWidget {
  const editpro({super.key});

  @override
  State<editpro> createState() => _editproState();
}

class _editproState extends State<editpro> {
  TextEditingController _name = TextEditingController();
  TextEditingController _birthday = TextEditingController();
  TextEditingController _sex = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _tel = TextEditingController();
  TextEditingController _age = TextEditingController();

  MyGlobalData globalData = MyGlobalData();
  bool isObscurePassword = true;
  bool isConflict = false;
  var _formKey = GlobalKey<FormState>();

  UserProfile userProfile = UserProfile(
      name: "", 
      address: "", 
      tel: "",
       birthday: "", 
       sex: "", 
       email: "", 
       age: 0);

  @override
  void initState() {
    _postData2().then((value) => {
          _name.text = userProfile.name,
          _address.text = userProfile.address,
          _tel.text = userProfile.tel,
          _birthday.text = userProfile.birthday,
          _sex.text = userProfile.sex,
          _age.text = userProfile.age.toString(),
          _email.text = userProfile.email
        });

    super.initState();
  }

  Future<void> _postData2() async {
    MyGlobalData globalData = MyGlobalData();
    String myValue = globalData.token.trim();
    print(myValue);
    print("-----------");
    try {
      const String apiUrl =
          'http://172.20.10.3:8080/api/v1/member/get-personal-data';
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
  void dispose() {
    _name.dispose();
    _birthday.dispose();
    _sex.dispose();
    //_email.dispose();
    _address.dispose();
    _tel.dispose();
    _age.dispose();
    super.dispose();
  }

  Future<void> _postData() async {
    print("Sending data to API...");
    print("Name: ${_name.text}");
    print("Email: ${_email.text}");
    print("Birthday: ${_birthday.text}");
    print("Sex: ${_sex.text}");
    print("Tel: ${_tel.text}");
    print("Address: ${_address.text}");
    print("Age: ${_age.text}");

    const String apiUrl =
        'http://172.20.10.3:8080/api/v1/member/edit-personal-data';
    final response = await http.put(
      Uri.parse(apiUrl),
      body: jsonEncode({
        'email': _email.text,
        'name': _name.text,
        'address': _address.text,
        'tel': _tel.text,
        'birthday': _birthday.text,
        'sex': _sex.text,
        'age': _age.text,

        //'passwordagain': _passwordagain
      }),
      headers: {
        'Authorization': 'Bearer ${MyGlobalData().token}',
        'Content-Type': 'application/json',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print("ได้แล้วนิ");

      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ConfirmComplete();
      }));
    } else if (response.statusCode == 409) {
      print("ข้อมูลนี้มีผู้ใช้งานแล้ว");
      setState(() {
        isConflict = true; // Update isConflict based on the HTTP response
      });
    } else {
      print(response.statusCode);
      print("หาทางแก้");
    }
  }

  // @override
  // void initState() {
  //   _postData();
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "แก้ไขข้อมูลส่วนตัว",
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
        body: Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'ชื่อ-นามสกุลของกุล',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                        controller: _name,
                        onChanged: (value) {
                          // Update the name in the userProfile instance as the user types
                          userProfile.name = value;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "${userProfile.name}",
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'ที่อยู่',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                        controller: _address,
                        onChanged: (value) {
                          // Update the address in the userProfile instance as the user types
                          userProfile.address = value;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.home),
                          hintText: userProfile.address,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'เบอร์โทรศัพท์',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                        controller: _tel,
                        onChanged: (value) {
                          // Update the telephone number in the userProfile instance as the user types
                          userProfile.tel = value;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          hintText: userProfile.tel,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'วันเกิด',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                        controller: _birthday,
                        onChanged: (value) {
                          // Update the birthday in the userProfile instance as the user types
                          userProfile.birthday = value;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.calendar_month),
                          hintText: userProfile.birthday,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'เพศ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                        controller: _sex,
                        onChanged: (value) {
                          // Update the gender in the userProfile instance as the user types
                          userProfile.sex = value;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "sex : ${userProfile.sex}",
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // const Text(
                      //   'อายุ',
                      //   style: TextStyle(
                      //     fontSize: 18,
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.black,
                      //   ),
                      // ),
                      // SizedBox(height: 5),
                      // TextFormField(
                      //   controller: _age, // Use a separate controller for age
                      //   keyboardType: TextInputType
                      //       .number, // Allow only numeric input for age
                      //   onChanged: (value) {
                      //     // Update the age in the userProfile instance as the user types
                      //     userProfile.age = int.tryParse(value) ??
                      //         0; // Convert to integer; default to 0 if not a valid number
                      //   },
                      //   decoration: InputDecoration(
                      //     prefixIcon: Icon(Icons.person),
                      //     hintText: userProfile.age.toString(),
                      //   ),
                     // ),
                      SizedBox(
                        height: 10,
                      ),
                      // const Text(
                      //   'Email',
                      //   style: TextStyle(
                      //     fontSize: 18,
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.black,
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      // TextFormField(
                      //   //controller: _email,
                      //   onChanged: (value) {
                      //     // Update the email in the userProfile instance as the user types
                      //     userProfile.email = value;
                      //   },
                      //   decoration: InputDecoration(
                      //     prefixIcon: Icon(Icons.mail),
                      //     hintText: "${userProfile.email}",
                      //   ),
                      // ),
                      
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),

                          //color: Colors.blue,
                          width: w * 0.9,
                          height: h * 0.06,
                          child: ElevatedButton(
                            child: const Text(
                              "ยืนยัน",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate() == true) {
                                await _postData();
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return profilepage("token");
                                }));
                              }
                            },
                          )),
                    ],
                  ),
                ))));
  }
}
