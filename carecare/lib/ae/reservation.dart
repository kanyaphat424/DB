import 'package:carecare/ae/canclereserve.dart';
import 'package:carecare/ae/reservationagain.dart';
import 'package:carecare/ae/reservecomplete.dart';
import 'package:carecare/homescreen.dart';
import 'package:carecare/mind/profilepage.dart';
import 'package:carecare/model/token.dart';
import 'package:flutter/material.dart';


class Reservation extends StatefulWidget {
  const Reservation({Key? key}) : super(key: key);

  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  MyGlobalData globalData = MyGlobalData();
  
  bool isReservationContentVisible = false;

  void toggleReservationContentVisibility() {
    setState(() {
      isReservationContentVisible = !isReservationContentVisible;
    });
  }

  int currentIndex = 1;

  // Function to handle tab selection
  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Building Reservation");
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MainHomePage();
                    }));
                    ;
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
        child: ListView(
          children: [
            const Row(
              children: [
                Text(
                  "กำลังดำเนินการ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            // The reservation content you mentioned
            Visibility(
              visible: isReservationContentVisible,
              child: _ReservationContent(),
            ),
            Container(
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
                    const Text(
                      "หมายเลขการจอง #12KL23",
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
                    const Text(
                      "จันทร์ - 22 พฤศจิกายน 2021 - 12:30 PM",
                      style: TextStyle(color: Colors.grey, fontSize: 18),
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
                    const Text(
                      "ห้อง 3/11 (ใส่โลเคชัน)",
                      style: TextStyle(color: Colors.grey, fontSize: 18),
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
                        minimumSize: const Size(330, 55),
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return canclereserve();
                        }));
                        // toggleReservationContentVisibility();
                      },
                      child: Text(
                        "ดูรายละเอียด",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.blue.shade400,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        // isReservationContentVisible = true;
                      });
                    },
                    child: const Text(
                      "รายการที่เสร็จสิ้น",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        // Underline by default
                      ),
                    ),
                  ),
                  const SizedBox(width: 60), // Add some spacing here
                  Container(
                    child: InkWell(
                      onTap: () {
                        // Add your action for "รายการที่ยกเลิก" here
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
            ),
            const SizedBox(
              height: 20,
            ),
            _ReservationContent()
          ],
        ),
      ),
       bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'หน้าหลัก',
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'การจอง',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'บัญชี',
          ),
          
        ],
       currentIndex: currentIndex,
  selectedItemColor: Colors.blue, // Make sure this is set to the desired color
  unselectedItemColor: Colors.grey,
       onTap: (int index) {
  if (index == 0) {
    // Navigate to the MainHomePage
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MainHomePage();
    }));
  } else if (index == 1) {
    // Navigate to the Confirm page (Reservation)
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Reservation();
    }));
  } else if (index == 2) {
    // Navigate to the NextPage (profilepage)
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return profilepage(globalData.token);
    }));
  }
}
 ));
  }
}
    
  


class _ReservationContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildReservationItem(context, "กำลังดำเนินการ", "#12KL23",
            "จันทร์ - 22 พฤศจิกายน 2021 - 12:30 PM", "ห้อง 3/11 (ใส่โลเคชัน)"),
        const SizedBox(height: 20),
        _buildReservationItem(context, "รายการที่เสร็จสิ้น", "#12KL23",
            "จันทร์-13 ตุลาคม 2021-12:30 PM", "ห้อง 3/11 (ใส่โลเคชัน)"),
        const SizedBox(height: 20),
        _buildReservationItem(context, "รายการที่ยกเลิก", "#12KL213",
            "จันทร์-13 ตุลาคม 2021-12:30 PM", "ห้อง 3/11 (ใส่โลเคชัน)"),
        const SizedBox(height: 20),
        _buildReservationItem(context, "รายการที่ยกเลิก", "#12KL213",
            "จันทร์-33 ตุลาคม 2521-12:30 PsM", "ห้อง 5/11 (ใส่โลเคชัน)"),
      ],
    );
  }

  Widget _buildReservationItem(BuildContext context, String title,
      String reservationNumber, String dateTime, String location) {
    return Container(
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
              "หมายเลขการจอง $reservationNumber",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 15),
           const Text(
              "เวลาการทำงาน",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              dateTime,
              style: const TextStyle(color: Colors.grey, fontSize: 18),
            ),
            const SizedBox(height: 15),
            const Text(
              "สถานที่",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              location,
              style: const TextStyle(color: Colors.grey, fontSize: 18),
            ),
            const SizedBox(height: 35),
            Row(
              children: [
                _buildButton("ดูรายละเอียด", () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return reserveagain();
                  }));
                  print('View Details');
                }),
                const SizedBox(width: 30),
                _buildButton("จองอีกครั้ง", () {
                  Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return reservecomplete();
                        }));
                  print('Reserve Again');
                }),
              ],
            ),
          ],
        ),
      ),
    );
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
}