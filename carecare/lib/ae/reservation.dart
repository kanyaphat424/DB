import 'package:carecare/ae/Listservice.dart';
import 'package:carecare/ae/canclereserve.dart';
import 'package:carecare/ae/reservationagain.dart';
import 'package:carecare/homescreen.dart';
import 'package:carecare/model/booking1.dart';
import 'package:carecare/model/reseve.dart';
import 'package:carecare/model/token.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Reservation extends StatefulWidget {
  const Reservation(String token, {Key? key}) : super(key: key);

  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  List<Reseve> detailLists = [];
  
  Reseve currentItem = Reseve(
      bookingDate: "",
      bookingId: "",
      address: "",
      statee: "",
      accountId: "");

  Future<void> _postData() async {
    MyGlobalData globalData = MyGlobalData();
    String myValue = globalData.token.trim();
    print(myValue);
    print("-----------");
    try {
      const String apiUrl =
          'http://172.20.10.3:8080/api/v1/member/get-history-booking';
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $myValue',
        },
      );
      if (response.statusCode == 200) {
        String responseBody = utf8.decode(response.bodyBytes);
        List<dynamic> responseData = json.decode(responseBody);

        //List<dynamic> responseData = json.decode(response.body);

      if (responseData != null && responseData.isNotEmpty) {
  setState(() {
    detailLists = responseData
        .map((data) {
          // ตรวจสอบและแปลงค่าตามความเหมาะสม
          String accountId = data['accountId'] != null ? data['accountId'].toString() : '';
          return Reseve(
            bookingId: data['bookingId'] ?? '',
            accountId: accountId,
            bookingDate: data['bookingDate'] ?? '',
            address: data['address'] ?? '',
            statee: data['statee'] ?? '',
          );
        })
        .toList();

          });
        } else {
          print("Invalid or empty JSON data");
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

  bool isReservationContentVisible = false;

  void toggleReservationContentVisibility() {
    setState(() {
      isReservationContentVisible = !isReservationContentVisible;
    });
  }

  int currentIndex = 0;

  // Function to handle tab selection
  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "การจอง",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return MainHomePage();
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
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: ListView(children: [
          const Row(
            children: [
              Text(
                "กำลังดำเนินการ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize:20,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
         
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: detailLists.length,
                  itemBuilder: (context, i) {
                    final detail = detailLists[i];
                    return Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        width: MediaQuery.of(context).size.width,
                        height: 350,
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
                        child: Container(
                          padding: const EdgeInsets.only(left: 30, top: 10, right: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                //ตรงนี้บอกbookingID
                                detail.accountId,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                "เวลาการทำงาน",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                //ตรงนี้จะบอกเวลา
                                detail.bookingDate,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                "สถานที่",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                //ตรงนี้บอกโล
                                detail.address,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue.shade100,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  minimumSize: const Size(300, 55),
                                ),
                                onPressed: () {
                                  setState(() {
                  currentIndex = i;
                  currentItem = detailLists[i];
                });
                                  Navigator.push(
                                context,
                                MaterialPageRoute(
                               builder: (context) => canclereserve(somev: i),
                  ),);
  },
                                child: Text(
                                  "ดูรายละเอียด",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue.shade400,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),SizedBox(height: 10,),
                               ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red.shade100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(300, 55),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Listservice();
                }));
                // toggleReservationContentVisibility();
              },
              child: Text(
                "ดูประวัติการจอง",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
                            ],
                          ),
                        ));
                  }),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ]),
      ),
    );
  }
}

Widget _buildButton(String text, VoidCallback onPressed) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: Colors.blue.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      minimumSize: const Size(150, 50),
    ),
    onPressed: onPressed,
    child: Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          color: Colors.blue.shade400,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}