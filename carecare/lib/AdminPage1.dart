import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class AdminPage1 extends StatelessWidget {
  final String title;

  AdminPage1({required this.title});

  String? selectedTime;
  DateTime selectedDate = DateTime.now();
  String? selectedLocation;
  String? selectedService;
  String quantityUnit = "ต่อครั้ง";
  String? customServiceText;

  final timeOptions = ["เช้า (9.00-12.00)", "บ่าย (13.00-15.00)"];

  final CategoryCard1 = [
    "ขนาดพื้นที่ไม่เกิน 35 ตร.ม.",
    "ขนาดพื้นที่ 36-80 ตร.ม.",
    "ขนาดพื้นที่ 81-100 ตร.ม."
  ];

  final CategoryCard2 = [
    "น้ำรั่ว/ท่อตัน",
    "ติดตั้งปั๊มน้ำ"
  ];

  final servicesForImage3 = [
    "เดินสายไฟ",
    "เช็ค/บำรุงสภาพไฟ",
    "ย้ายและติดตั้งสวิตซต์/เบรกเกอร์"
  ];

  final servicesForImage5 = ["ล้างแอร์", "เติมน้ำยาแอร์"];
  final servicesForImage4 = ["จัดสวน", "ตัดหญ้า/ตัดแต่งกิ่ง"];
  final servicesForImage6 = ["ระยะ 0-25 เมตร", "ระยะ 26-40 เมตร", "ระยะ 41-50 เมตร"];

  Future<void> _selectDate(BuildContext context) async {

   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: [
          SizedBox(height: 16.0),
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15),
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Color.fromARGB(255, 206, 202, 202).withOpacity(0.3),
                  ),
                ),
              ],
            ),
          ),
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
                  ElevatedButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    child: Text("วันที่จอง"),
                  ),
                  Text("วันที่ถูกเลือก: ${DateFormat('dd-MM-yyyy').format(selectedDate)}"),
                ],
              ),
            ),
          ),
          // คำสั่งอื่น ๆ ในส่วนของหน้าจอ
        ],
      ),
      floatingActionButton: InkWell(
       
        child: Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Text(
            "ถัดไป",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildServiceRadioButtons(String image) {
    List<String> services = [];

    if (image == 'assets/แม่บ้าน.png') {
      services = servicesForImage3;
      quantityUnit = "ห้อง";
    } else if (image == 'assets/ปะปา1.png') {
      services = servicesForImage3;
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
      Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 25),
          child: Text(
            "เลือกบริการ",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      ...services.map((service) {
        return Row(
          children: [
            FractionalTranslation(
              translation: Offset(0.2, 0.0),
             
            ),
            Text(service),
          ],
        );
      }).toList(),
    ];
  }
}
