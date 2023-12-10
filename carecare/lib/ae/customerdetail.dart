import 'package:carecare/min/control.dart';
import 'package:flutter/material.dart';

class customeradmin extends StatefulWidget {
  const customeradmin({Key? key}) : super(key: key);

  @override
  State<customeradmin> createState() => _customeradmin();
}

class _customeradmin extends State<customeradmin> {
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
                      return controlpage();
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
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            // The reservation content you mentioned

            Container(
              width: MediaQuery.of(context).size.width,
              height: 230,
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
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "รายละเอียดลูกค้า",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "คุณแน่ใจหรือไม่ว่าต้องการลบรายละเอียด",
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
                      "ลูกค้าของ C001: กชกร",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                         onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return controlpage();
                    }));
                    
                  },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red.shade300,
                            minimumSize: Size(100, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Adjust the radius as needed
                            ),
                          ),
                          child:
                              const Text("ลบ", style: TextStyle(fontSize: 18)),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                            onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return controlpage();
                    }));
                    
                  },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey.shade400,
                            minimumSize: Size(100, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Adjust the radius as needed
                            ),
                          ),
                          child: const Text(
                            "ยกเลิก",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}