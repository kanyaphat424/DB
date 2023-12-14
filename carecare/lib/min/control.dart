import 'dart:convert';

import 'package:carecare/AdminPage.dart';
import 'package:carecare/ae/canclecomplete.dart';
import 'package:carecare/ae/adcustomer.dart';
import 'package:carecare/mind/customerid.dart';
import 'package:carecare/model/controlmo.dart';
import 'package:carecare/model/token.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class controlpage extends StatefulWidget {
  const controlpage({super.key});

  @override
  State<controlpage> createState() => _controlpageState();
}

class _controlpageState extends State<controlpage> {
  List<Ffmo> filteredLists = [];
  Ffmo selectedItem = Ffmo(accountId: "", name: "");

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
        String responseBody = utf8.decode(response.bodyBytes);
        List<dynamic> responseData = json.decode(responseBody);

        //   print(response.body);
        // List<dynamic> responseData = json.decode(response.body);

        if (responseData != null && responseData.isNotEmpty) {
          setState(() {
            // allData เก็บทั้งหมด
            allData = responseData
                .map((data) => Ffmo(
                      accountId: data['accountId'],
                      name: data['name'],
                    ))
                .toList();
            // filteredLists กำหนดค่าเริ่มต้นเป็น allData
            filteredLists = List.from(allData);
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

  void filterList(String text) {
    setState(() {
      filteredLists = allData
          .where((item) => item.name.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  List<Ffmo> allData = [];

  @override
  void initState() {
    _postData();
    super.initState();
    filterList('');
  }

  int selectedItemIndex = -1;
  // void filterList(String text) {
  //   setState(() {
  //     filteredLists = filteredLists
  //         .where((item) => item.first_name.toLowerCase().contains(text.toLowerCase()))
  //         .toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "การจัดการลูกค้า",
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
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                prefixIcon: Icon(Icons.search, color: Colors.blue),
                hintText: 'ค้นหาที่นี้',
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(15),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (text) {
                filterList(text);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredLists.length,
              itemBuilder: (context, int index) {
                return Card(
                  margin: EdgeInsets.only(top: 4),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: ListTile(
                      leading: Text(filteredLists[index].accountId),
                      title: InkWell(
                        onTap: () {
                          setState(() {
                            selectedItemIndex = index;
                            selectedItem = filteredLists[index];
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  customerdetail(someValue: index),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(Icons.person),
                            SizedBox(width: 8),
                            Text(filteredLists[index].name),
                          ],
                        ),
                      ),
                      trailing: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  customeraddetails(someValue: index),
                            ),
                          );
                        },
                        child: Icon(Icons.delete),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
