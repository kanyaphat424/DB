import 'dart:io';

import 'package:carecare/confirm.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Data {
  final String test;
  final int id;

  Data({required this.test, required this.id});
}

class PaymentPage extends StatefulWidget {
  final Map<String, dynamic> data;
  final String timeSlot;
  final String address;
  final String selectedService;
  final DateTime bookingDate;
final int selectedQuantity;  
 final String quantityUnit; 
  final String image;
  final String selectedPaymentMethod;
  final String totalPrice;
  final String yourPreferredName;
  final String quantityString;
  final String title;

  PaymentPage({
    required this.data,
    required this.timeSlot,
    required this.address,
    required this.selectedService,
    required this.bookingDate,
required this.selectedQuantity, 
  required this.quantityUnit, 
    required this.image,
    required this.selectedPaymentMethod,
    required this.totalPrice,
    required this.yourPreferredName, 
    required this.quantityString,
    required this.title,
   
    
  });

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? selectedPaymentMethod;
  String? selectedPaymentType;
  File? paymentImage; // ย้ายตัวแปร paymentImage มาที่นี่
  String? bankName;

  String accountNumber = "หมายเลขบัญชี";

 /* TextEditingController cardOwnerController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController(); */
 

  final paymentMethods = [

    "พร้อมเพย์",
    "บัญชีธนาคาร",
    
  ];

  final bankInfo = {
  "กสิกร": "123-456-789",
  "ไทยพาณิชย์": "987-654-321",
  // Add more banks as needed
};

final bankLogos = {
  "กสิกร": "assets/bank1.png",
  "ไทยพาณิชย์": "assets/scb.png",
  // Add more bank logos as needed
};


  @override
  Widget build(BuildContext context) {
  /*
    Future<void> _postData() async {
  final String apiUrl = 'http://172.20.10.3:8080/api/v1/member/get-personal-data';

  // Create a multipart request
  var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

  // Add text fields to the request
  request.fields['selectedPaymentMethod'] = _selectedPaymentMethod.text;

  // Add the image file to the request
  if (paymentImage != null) {
    request.files.add(await http.MultipartFile.fromPath('paymentImage', paymentImage!.path));
  }

  try {
    // Send the request
    final response = await request.send();

    // Check the response status
    if (response.statusCode == 200) {
      // Successfully sent
      final Map<String, dynamic> responseData = json.decode(await response.stream.bytesToString());
      MyGlobalData globalData = MyGlobalData();
      globalData.token = responseData['accessToken'];
      print(globalData.token);
    } else {
      // Handle error
      print(response.statusCode);
      print("หาทางแก้");
    }
  } catch (error) {
    // Handle error
    print(error.toString());
  }
}

    
  /*  Future<void> _postData() async {
      final String apiUrl = 'http://172.20.10.3:8080/api/v1/member/get-personal-data';

      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode({
          'selectedPaymentMethod': _selectedPaymentMethod.text,
          
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
*/
*/

    print('Payment Option in PaymentPage: $selectedPaymentMethod');
    return Scaffold(
      appBar: AppBar(
        title: Text('ชำระเงินสำหรับการจอง'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("เลือกวิธีชำระเงิน", 
                   style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 3, 103, 185),
                ),),
                      Column(
                        children: paymentMethods.map((method) {
                          return Row(
                            children: [
                              Radio(
                                value: method,
                                groupValue: selectedPaymentMethod,
                                onChanged: (value) {
                                  setState(() {
                                    selectedPaymentMethod = value as String?;
                                  });
                                },
                              ),
                               Text(
              method,
              style: TextStyle(
                fontSize: 17,  // ปรับขนาดตามที่คุณต้องการ
                
                  // สีตามที่คุณต้องการ
              ),
            ),
                            ],
                          );
                        }).toList(),
                      ),
      if (selectedPaymentMethod == "บัญชีธนาคาร") ...[
  Padding(
    padding: const EdgeInsets.only(left: 50.0),  // ปรับตำแหน่ง Padding ตามต้องการ
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text(
          // Display different text based on whether a bank is selected or not
          bankName == null ? "กรุณาเลือกธนาคาร" : "ธนาคาร: $bankName",
          style: TextStyle(fontSize: 17),
        ),
        DropdownButton<String>(
          value: bankName,
          hint: Text("ธนาคาร"), // Add this line to show a default hint
          onChanged: (String? newValue) {
            setState(() {
              if (newValue != null && bankInfo.containsKey(newValue)) {
                bankName = newValue;
                accountNumber = bankInfo[newValue]!;
              }
            });
          },
          items: bankInfo.keys.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Row(
                children: [
                  Image.asset(bankLogos[value] ?? "assets/default_logo.png", height: 20, width: 20),
                  SizedBox(width: 8),
                  Text(value),
                ],
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 10),
        Text(
          // Display custom message if a bank is not selected
          bankName == null ? "" : "หมายเลขบัญชี: $accountNumber",
          style: TextStyle(fontSize: 17),
        ),
      ],
    ),
  ),
],



                    

                    /*  if (selectedPaymentMethod == "บัตรเดบิต/เครดิต") ...[
                        Text("กรอกข้อมูลบัตร", style: TextStyle(fontSize: 16)),
                        TextFormField(
                          controller: cardOwnerController,
                          decoration:
                              InputDecoration(labelText: 'ชื่อเจ้าของบัตร'),
                        ),
                        TextFormField(
                          controller: cardNumberController,
                          decoration: InputDecoration(labelText: 'หมายเลขบัตร'),
                        ),
                        TextFormField(
                          controller: expiryDateController,
                          decoration:
                              InputDecoration(labelText: 'วันหมดอายุ (MM/YY)'),
                        ),
                        TextFormField(
                          controller: cvvController,
                          decoration: InputDecoration(labelText: 'CVV'),
                          keyboardType: TextInputType.number,
                        ),
                      ],  */
                      SizedBox(height: 20),
                      if (selectedPaymentMethod == "พร้อมเพย์") ...[
  
  Align(
    alignment: FractionalOffset(0.5, 0.7),  // Adjust the values as needed
    child: Image.asset("assets/prompay.png"),
  ),
],


                      SizedBox(height: 20),
                      Text("อัพโหลดรูปยืนยันหลักฐานการโอนเงิน",
                           style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  
                ),),
                      ElevatedButton(
                        onPressed: () {
                          // เพิ่มรูปภาพ - เปิดหน้าต่างเลือกรูป
                          _pickImage();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 120, 167, 207),
                        ),
                        child: Text("เลือกรูป"),
                      ),
                      if (paymentImage != null) ...[
                        SizedBox(height: 10),
                        Image.file(paymentImage!),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(19.0),
              child: ElevatedButton(
                onPressed: () {
                  // Handle payment
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfirmPage(
                        timeSlot: widget.timeSlot,
                        address: widget.address,
                        selectedService: widget.selectedService,
                        bookingDate: widget.bookingDate,
                selectedQuantity: widget.selectedQuantity, 
                 quantityUnit: widget.quantityUnit, 
                        totalPrice: double.parse(widget.totalPrice),
                        yourPreferredName: widget.yourPreferredName,
                        file: paymentImage, 

                        /*  selectedPaymentMethod: widget.selectedPaymentMethod,*/ // Pass the calculated price // ตรวจสอบว่า calculatePrice() คืนค่าถูกต้อง
                        selectedPaymentMethod: selectedPaymentMethod,
                         quantityString: widget.quantityString,
                         title: widget.title,
                      ),
                    ),
                  );
                  
                },
                 style: ElevatedButton.styleFrom(
      primary: Color.fromARGB(255, 42, 146, 243),
      onPrimary: const Color.fromARGB(255, 57, 144, 216),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        
      ),
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
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        paymentImage = File(pickedImage.path);
      });
    }
  }
}
