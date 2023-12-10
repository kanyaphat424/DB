import 'package:carecare/mind/profilepage.dart';
import 'package:carecare/model/token.dart';
import 'package:flutter/material.dart';

class ConfirmComplete extends StatelessWidget {
  final MyGlobalData globalData = MyGlobalData();
  ConfirmComplete({Key? key}) : super(key: key);
 // const ConfirmComplete({Key? key}) : super(key: key);
 

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
              "รหัสผ่านได้รับการเปลี่ยนแปลงสำเร็จ",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return profilepage(globalData.token);
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
                "หน้าโปรไฟล์",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
