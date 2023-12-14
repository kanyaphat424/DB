import 'dart:convert';
import 'package:carecare/ae/addmincompletework.dart';
import 'package:carecare/ae/canceled.dart';
import 'package:carecare/ae/reservation.dart';
import 'package:carecare/ae/reservationagain.dart';
import 'package:carecare/homescreen.dart';
import 'package:carecare/model/reseve.dart';
import 'package:carecare/model/token.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Listservice extends StatefulWidget {
  const Listservice({Key? key}) : super(key: key);

  @override
  State<Listservice> createState() => _ListserviceState();
}

class _ListserviceState extends State<Listservice> {
  List<Reseve> completedDetails = [];
  List<Reseve> canceledDetails = [];
  bool showCompletedDetails = true;

  List<Reseve> detailLists = [];

  Future<void> _postData() async {
    MyGlobalData globalData = MyGlobalData();
    String myValue = globalData.token.trim();
    print(myValue);
    print("-----------");
    try {
      const String apiUrl = 'http://172.20.10.3:8080/api/v1/member/get-history-booking';
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
              return Reservation('token');
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
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: showCompletedDetails
                        ? completedDetails.length
                        : canceledDetails.length,
                    itemBuilder: (context, i) {
                      final detail = showCompletedDetails
                          ? completedDetails[i]
                          : canceledDetails[i];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        width: MediaQuery.of(context).size.width,
                        height: 275,
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
                          padding: const EdgeInsets.only(left: 20, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
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
                                detail.bookingDate.toString(),
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
                                detail.address,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  _buildButton("ดูรายละเอียด", () {
                                    print('View Details');
                                     if (detail.statee == 'Success') {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return reserveagain(somev: i);
                                    }));
                                   } else if (detail.statee == 'Cancel') {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return canclereserved(somev: i); // แทน CanceledPage() ด้วยหน้าที่คุณต้องการ
                                  }));
                                  }
                                  }),
                                  const SizedBox(width: 30),
                                  _buildButton("จองอีกครั้ง", () {
                                    print('Reserve Again');
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return MainHomePage();
                                }));
                                  }),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 20), // ปรับตำแหน่งตามความต้องการ
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(330, 50),
                    ),
                    onPressed: () {
                      // ทำสิ่งที่คุณต้องการเมื่อปุ่มถูกกด
                    },
                    child: Text(
                      "จองอีกครั้ง", // แก้ไขข้อความตามที่ต้องการ
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue.shade400,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
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