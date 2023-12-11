import 'package:carecare/homescreen.dart';
import 'package:flutter/material.dart';


class reservecomplete extends StatelessWidget {
  const reservecomplete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_rounded,
              size: 120,
              color: Colors.green,
            ),
            SizedBox(height: 15),
            Text(
              "สำเร็จ!",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "ตอนนี้คุณสามารถกลับไปที่หน้าการจองได้แล้ว",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 100),
            ElevatedButton(
               onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MainHomePage();
                    }));
                    
                  },
              style: ElevatedButton.styleFrom(
                primary: Colors.blue.shade400,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10), // Adjust the value as needed
                ),
                minimumSize: const Size(100, 50),
              ),
              child: Text(
                "หน้าการจอง",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}