import 'dart:convert';

import 'package:carecare/CategoryCard.dart';
import 'package:carecare/Users/gade/Desktop/carecare/carecare/lib/address.dart';
import 'package:carecare/ae/reservation.dart';
import 'package:carecare/mind/loginscreen.dart';
import 'package:carecare/mind/profilepage.dart';
import 'package:carecare/model/token.dart';
import 'package:flutter/material.dart';
import 'NextPage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  _MainHomePageState createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  MyGlobalData globalData = MyGlobalData();

  // Function to handle tab selection
  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: NavigationDrawer(),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 158,
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          "สวัสดี คุณจอห์น",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "วันนี้ต้องการบริการด้านไหนดีคะ?",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'หมวดหมู่',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: CategoryCard(
                            image: 'assets/แม่บ้าน.png',
                            title: 'ทำความสะอาด',
                          ),
                        ),
                        Container(
                          child: CategoryCard(
                            image: 'assets/ปะปา1.png',
                            title: 'ช่างปะปา',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: CategoryCard(
                            image: 'assets/ไฟ.png',
                            title: 'ช่างไฟ',
                          ),
                        ),
                        Container(
                          child: CategoryCard(
                            image: 'assets/7.png',
                            title: 'ช่างสวน',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: CategoryCard(
                            image: 'assets/แอร์.png',
                            title: 'ช่างแอร์',
                          ),
                        ),
                        Container(
                          child: CategoryCard(
                            image: 'assets/cctv.png',
                            title: 'ติดตั้งกล้องวงจรปิด',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        /*ปุ่มสีฟ้าข้างบน*/
        floatingActionButtonLocation:
            FloatingActionButtonLocation.startTop, // ตำแหน่งของ FAB
        floatingActionButton: Align(
          alignment: Alignment(0.85, -0.96), // ตำแหน่งด้านขวาบน
          child: FloatingActionButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            child: Icon(Icons.menu),
            backgroundColor: Color.fromARGB(255, 115, 188, 237),
            elevation: 0.0,
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
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            onTap: (int index) {
              if (index == 0) {
                // Navigate to the MainHomePage
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MainHomePage();
                }));
              } else if (index == 1) {
                // Navigate to the Confirm page
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Reservation();
                }));
              } else if (index == 2) {
                // Navigate to the NextPage
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return profilepage(globalData.token);
                }));
              }
            }));
  }
}

class NavigationDrawer extends StatelessWidget {
  final MyGlobalData globalData = MyGlobalData();
  NavigationDrawer({Key? key}) : super(key: key);
  // const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenuItem(context),
            ],
          ),
        ),
      );

  Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
      );
  Widget buildMenuItem(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
              leading: const Icon(
                Icons.home_outlined,
                color: Colors.blue,
                size: 35,
              ),
              title: const Text(
                'Home',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              //เชื่อมปุ่มhomeไปหน้าhome
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return MainHomePage();
                }));
              },
            ),
            const Divider(
              height: 5,
              thickness: 1,
            ),
            const SizedBox(height: 30),
            ListTile(
              leading: const Icon(
                Icons.person,
                color: Colors.blue,
                size: 35,
              ),
              title: const Text(
                'ข้อมูลส่วนตัว',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return profilepage(globalData.token);
                }));
              },
            ),
            const Divider(
              height: 5,
              thickness: 1,
            ),
            const SizedBox(height: 30),
            ListTile(
              leading: const Icon(
                Icons.door_front_door_outlined,
                color: Colors.redAccent,
                size: 35,
              ),
              title: const Text(
                'ออกจากระบบ',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return loginscreen();
                }));
              },
            ),
            const Divider(
              height: 5,
              thickness: 1,
            ),
            const SizedBox(height: 30),
          ],
        ),
      );
}

// ignore: must_be_immutable
class CategoryDetailPage extends StatefulWidget {
  final String title;
  final String image;

  CategoryDetailPage(
      {required this.title, required this.image, required this.address});

  String? selectedService;
  String customServiceText = "";
  String? address;
  int selectedQuantity = 1;

  @override
  _CategoryDetailPageState createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  final _timeSlot = TextEditingController();
  TextEditingController _bookingDate = TextEditingController();
  final _address = TextEditingController();
  final _selectedService = TextEditingController();
  final _quantityUnit = TextEditingController();

  String? timeSlot;
  DateTime bookingDate = DateTime.now();
  String? selectedaddress;
  String? selectedService;
  String quantityUnit = "ต่อครั้ง";

  final timeOptions = ["เช้า(9.00-12.00)", "บ่าย (13.00-15.00)"];

  final servicesForImage1 = [
    "ขนาดพื้นที่ไม่เกิน35ตร.ม.",
    "ขนาดพื้นที่ 36-80 ตร.ม.",
    "ขนาดพื้นที่ 81-100 ตร.ม."
  ];

  final servicesForImage2 = ["น้ำรั่ว/ท่อตัน", "ติดตั้งปั๊มน้ำ"];

  final servicesForImage3 = [
    "เดินสายไฟ",
    "เช็ค/บำรุงสภาพไฟ",
    "ย้ายและติดตั้งสวิตซต์/เบรกเกอร์"
  ];

  final servicesForImage5 = ["ล้างแอร์", "เติมน้ำยาแอร์"];
  final servicesForImage4 = ["จัดสวน", "ตัดหญ้า/ตัดแต่งกิ่ง"];
  final servicesForImage6 = [
    "ระยะ 0-25 เมตร",
    "ระยะ 26-40 เมตร",
    "ระยะ 41-50 เมตร"
  ];

  Future<void> _selectBookingDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: bookingDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != bookingDate) {
      setState(() {
        bookingDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch address when the page is initialized
    _fetchAddress();
  }
  Welcome welcome = Welcome(
    address: ""
  );

  Future<void> _fetchAddress() async {
    MyGlobalData globalData = MyGlobalData();
    String myValue = globalData.token.trim();
    try{
     String apiUrl = 'http://172.20.10.3:8080/api/v1/member/get-location';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization' : 'Bearer $myValue',
          },
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData!=null){
          setState(() {
            welcome = Welcome(
              address :responseData['address'],
            );
           // Use '' if selectedaddress is null
        });

        }
        
      } else {
        print('Failed to fetch address. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching address: $error');
    }
  }
  /*

@override
  Future<void> _postData() async {
      final String apiUrl =
          'http://172.20.10.3:8080/api/v1/member/get-personal-data';

      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode({
          'timeSlot': _timeSlot.text,
          'bookingDate': _bookingDate.text,
        /*  'address': _address.text,  */
          'selectedService': _selectedService.text,
          'quantityUnit': _quantityUnit.text,
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


/*ส่งค่าที่เหลือ*/
*/

  @override
  Widget build(BuildContext context) {
    String quantityString = "${widget.selectedQuantity} $quantityUnit";
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title}'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 15.0),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Color.fromARGB(255, 206, 202, 202).withOpacity(0.3),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    width: 80,
                    height: 80,
                    child: Image.asset(
                      widget.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(5), // Adjust padding as needed
                    child: Text(
                      ' ${widget.title}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    // Set the background color for the text container
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 5),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "เลือกวันที่จอง",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () {
                          _selectBookingDate(context);
                        },
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border:
                                Border(bottom: BorderSide(color: Colors.black)),
                          ),
                          child: TextField(
                            controller: _bookingDate,
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText:
                                  "${DateFormat('yyyy-MM-dd').format(bookingDate)}",
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],

                /*     children: [
                  Text(
                    "เลือกวันที่จอง",
                    style: 
                    TextStyle(
                      fontSize: 16, 
                      fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {
                     _selectBookingDate(context);
                    },
                    child: Text("วันที่จอง",
                    ),
                  ),
                  Text("วันที่ถูกเลือก: ${DateFormat('dd-MM-yyyy').format(bookingDate)}"),
                ],  */
              ),
            ),
          ),

          /*alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "เลือกวันที่จอง",
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  TextField(
                    controller: _bookingDate,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today_rounded),
                        labelText: "วันที่จองคือ",
                        labelStyle: TextStyle(fontSize: 16)),

                    onTap: () async {
                      DateTime? pickeddate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100));

                      if (pickeddate != null) {
                        setState(() {
                          _bookingDate.text =
                              DateFormat('dd-MM-yyyy').format(pickeddate);
                        });
                      }
                    },

                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
          */
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                "เลือกเวลาที่จอง",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Column(
            children: timeOptions.map((time) {
              return Row(
                children: [
                  FractionalTranslation(
                    translation: Offset(0.2, 0.0),
                    child: Radio(
                      value: time,
                      groupValue: timeSlot,
                      onChanged: (value) {
                        setState(() {
                          timeSlot = value as String?;
                        });
                      },
                    ),
                  ),
                  Text(
                    time,
                    style: TextStyle(
                        fontSize: 17), // Add this line to set the font size
                  ),
                ],
              );
            }).toList(),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: FractionalTranslation(
              translation: Offset(0.5, 0.0),
              child: Text(
                "สถานที่",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 19,
                ),
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Stack(
                          children: [
                            Text(
                             welcome.address,
                             style: TextStyle(fontSize: 18,color: Colors.black),
                              // decoration: InputDecoration(
                              //   hintText: "กรอกข้อมูลที่อยู่",
                              //   contentPadding: EdgeInsets.symmetric(
                              //       vertical: 10, horizontal: 50),
                              //   border: InputBorder.none,
                              // ),
                              // onChanged: (value) {
                              //   setState(() {
                              //     selectedaddress = value;
                              //   });
                              // },
                            ),
                            Positioned(
                              left: 0,
                              top: 0,
                              bottom: 0,
                              child: Icon(Icons.location_on),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Column(
            children: _buildServiceRadioButtons(widget.image),
          ),
          if (widget.selectedService == "กรอกเอง")
            _buildCustomServiceTextField(),
          SizedBox(height: 12.0),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "เลือกจำนวน",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (widget.selectedQuantity > 1) {
                              widget.selectedQuantity--;
                            }
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.black),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(
                                horizontal: 0.0,
                                vertical:
                                    5.0), // ปรับความกว้างและความสูงของปุ่ม
                          ),
                        ),
                        child: Icon(Icons.remove),
                      ),
                      SizedBox(width: 12),
                      /*ตรงบวกลบ */
                      Text(
                        "${widget.selectedQuantity} $quantityUnit",
                        style: TextStyle(fontSize: 17),
                      ),
                      SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            widget.selectedQuantity++;
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.black),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(
                                horizontal: 0.0,
                                vertical:
                                    4.0), // ปรับความกว้างและความสูงของปุ่ม
                          ),
                        ),
                        child: Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NextPage(
                timeSlot: timeSlot ?? '',
                address: selectedaddress ?? widget.address ?? '',
                selectedService:
                    selectedService ?? widget.selectedService ?? '',
                bookingDate: bookingDate,
                selectedQuantity: widget.selectedQuantity,
                data: {},
                quantityUnit: quantityUnit,
                image: widget.image,
                quantityString: quantityString,
                 title: widget.title,
              ),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(23.0),
          ),
          child: Text(
            "ถัดไป",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildServiceRadioButtons(String image) {
    List<String> services = [];

    if (image == 'assets/แม่บ้าน.png') {
      services = servicesForImage1;
      quantityUnit = "ห้อง";
    } else if (image == 'assets/ปะปา1.png') {
      services = servicesForImage2;
      quantityUnit = "จุด";
    } else if (image == 'assets/ไฟ.png') {
      services = servicesForImage3;
      quantityUnit = "จุด";
    } else if (image == 'assets/7.png') {
      services = servicesForImage4;
      quantityUnit = "ตร.ม.";
    } else if (image == 'assets/แอร์.png') {
      services = servicesForImage5;
      quantityUnit = "เครื่อง";
    } else if (image == 'assets/cctv.png') {
      services = servicesForImage6;
      quantityUnit = "จุด";
    }

    return [
      /* เลือกบริการ */
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 25),
          child: Text(
            "เลือกบริการ",
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      ...services.map((service) {
        return Row(
          children: [
            FractionalTranslation(
              translation: Offset(0.2, 0.0),
              child: Radio(
                value: service,
                groupValue: widget.selectedService,
                onChanged: (value) {
                  setState(() {
                    widget.selectedService = value as String?;
                  });
                },
              ),
            ),
            Text(
              service,
              style:
                  TextStyle(fontSize: 17), // Add this line to set the font size
            ),
          ],
        );
      }).toList(),
    ];
  }

  Widget _buildCustomServiceTextField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        decoration: InputDecoration(
          labelText: "บริการที่คุณต้องการ",
        ),
        onChanged: (value) {
          setState(() {
            widget.customServiceText = value;
          });
        },
      ),
    );
  }
}

/*),
          TextField(
            decoration: const InputDecoration(
              hintText: "กรอกข้อมูลที่อยู่",
              prefixIcon: Icon(Icons.location_on),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            ),
            onChanged: (value) {
              setState(() {
                selectedLocation = value;
              });
            },
            maxLines: 1,
          ), */
          /* TextField(
                    controller: _bookingDate,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today_rounded),
                        labelText: "วันที่จองคือ",
                        labelStyle: TextStyle(fontSize: 16)),
                    onTap: () async {
                      DateTime? pickeddate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100));

                      if (pickeddate != null) {
                        setState(() {
                          _bookingDate.text =
                              DateFormat('dd-MM-yyyy').format(pickeddate);
                        });
                      }
                    },
                  ), */