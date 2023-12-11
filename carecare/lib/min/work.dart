import 'dart:convert';

import 'package:carecare/AdminPage.dart';
import 'package:carecare/ae/addmincompletework.dart';
import 'package:carecare/model/token.dart';
import 'package:carecare/model/workmo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;




class workpage extends StatefulWidget {
  const workpage({super.key});

  @override
  State<workpage> createState() => _workpageState();
}

 class _workpageState extends State<workpage> {
//   TextEditingController _bookid = TextEditingController();
//   TextEditingController _service = TextEditingController();
//   TextEditingController _date = TextEditingController();
 
//    Detailmodel detailmodel = Detailmodel(
//     bookid: "",
//     service: "",
//     date: ""
//   );

  List<Wwmo> workLists = [];
  Wwmo selectedItem = Wwmo(
    bookingId: "",
    title: "",
    bookingDate: "",
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
          workLists = responseData
              .map((data) => Wwmo(
                    bookingId: data['bookingId'],
                    title: data['title'],
                    bookingDate: data['bookingDate'],
                  ))
              .toList();
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
void initState() {
  super.initState();
  _postData(); // เรียกใช้ _postData เพื่อดึงข้อมูลทันทีเมื่อ widget ถูกสร้าง
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
    body: SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: workLists.length,
            itemBuilder: (context, int index) {
              return buildCard(workLists[index]);
            },
          ),
        ],
      ),
    ),
  );
}

Widget buildCard(Wwmo workList) {
  return Container(
    height: 100, //
  child: Card(
    margin: EdgeInsets.only(top: 5),
    child: Padding(
      padding: const EdgeInsets.all(4),
      child: ListTile(
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                workList.title,
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
            Text('หมายเลขการจอง',),
            SizedBox(width: 5),
            Text(
              workList.bookingId,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
        trailing: Column(
          children: [
            Text(
              workList.bookingDate,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
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
  setState(() {
    selectedItemIndex = workLists.indexOf(workList);
    selectedItem = workList;
  });
  // Navigate to customerdetail page
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => addmincompletework(somevi: workLists.indexOf(workList)),
    ),
  );
},

    child: Text(
      'View details',
      style: TextStyle(fontSize: 13),
    ),
  ),
),
          ],
        ),
      ),
    ),
  )
  );
}
 }