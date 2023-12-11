import 'dart:convert';

import 'package:carecare/AdminPage.dart';
import 'package:carecare/ae/addminaccept.dart';
import 'package:carecare/model/detailmo.dart';
import 'package:carecare/model/token.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class detailpage extends StatefulWidget {
  const detailpage({super.key});

  @override
  State<detailpage> createState() => _detailpageState();
}

class _detailpageState extends State<detailpage> {
  List<Ddmo> completedDetails = [];
  List<Ddmo> canceledDetails = [];
  bool showCompletedDetails = true;

  List<Ddmo> detailLists = [];
  Ddmo selectedItem = Ddmo(
    bookingId: "",
    title: "",
    bookingDate: "",
    statee: ""
  );

  int selectedItemIndex = -1;

  Future<void> _postData() async {
    MyGlobalData globalData = MyGlobalData();
    String myValue = globalData.token.trim();
    print(myValue);
    print("-----------");
    try {
      const String apiUrl = 'http://172.20.10.3:8080/api/v1/admin/get-all-booking';
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $myValue',
        },
      );

      if (response.statusCode == 200) {
        // final Map<String, dynamic> responseData = json.decode(response.body);

        // if (responseData.containsKey('data')) {
          List<dynamic> responseData = json.decode(response.body);

      if (responseData != null && responseData.isNotEmpty) {
          setState(() {
            detailLists = responseData
                .map((data) => Ddmo(
                    bookingId: data['bookingId'],
                    title: data['title'],
                    bookingDate: data['bookingDate'],
                    statee: data['statee'],
                    ))
                .toList();
            // แยกข้อมูลเป็นรายการที่เสร็จสิ้นและยกเลิก
            completedDetails =
            detailLists.where((detail) => detail.statee == 'Success').toList();
            canceledDetails =
            detailLists.where((detail) => detail.statee == 'Cancel').toList();

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
    super.initState();
    _postData();
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
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
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      showCompletedDetails = true;
                    });
                  },
                  child: const Text(
                    "รายการที่เสร็จสิ้น",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 100),
                Container(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        showCompletedDetails = false;
                      });
                    },
                    child: const Text(
                      "รายการที่ยกเลิก",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: showCompletedDetails
                    ? completedDetails.length
                    : canceledDetails.length,
                itemBuilder: (context, i) {
                  final detail = showCompletedDetails
                      ? completedDetails[i]
                      : canceledDetails[i];
                  return SizedBox(
                    width: 30,
                    height: 100,
                    child: Card(
                      margin: EdgeInsets.only(top: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: ListTile(
                          title: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  detail.title,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'หมายเลขการจอง',
                              ),
                              SizedBox(width: 5),
                              Text(
                                detail.bookingId,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          trailing: Column(
                            children: [
                              Text(
                                detail.bookingDate,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
  width: 120,
  height: 30,
  child: ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: Color.fromARGB(255, 216, 232, 247),
      onPrimary: const Color.fromARGB(255, 57, 144, 216),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    ),
    onPressed: () {
      Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context) => addminaccept(somevii: i),
                    ));
    },
    child: Text(
      'View details',
      style: TextStyle(fontSize: 14),
    ),
  ),
),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}