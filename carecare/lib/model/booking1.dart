// To parse this JSON data, do
//
//     final booking = bookingFromJson(jsonString);

import 'dart:convert';

Booking1 bookingFromJson(String str) => Booking1.fromJson(json.decode(str));

String bookingToJson(Booking1 data) => json.encode(data.toJson());

class Booking1 {
 String bookingDate;
  String bookingId;
  String select;
  String amount;
  String payment;
  String select_payment;
  String price;
  String address;
  String title;
  String file;
  String accountId;
  String path;
  String statee;
  String date;
 

  Booking1({
    required this.bookingDate,
    required this.bookingId,
    required this.select,
    required this.amount,
    required this.payment,
    required this.select_payment,
    required this.price,
    required this.address,
    required this.title,
    required this.file,
    required this.accountId,
    required this.path,
    required this.statee,
    required this.date,
  });

  factory Booking1.fromJson(Map<String, dynamic> json) => Booking1(
        bookingDate: json["bookingDated"],
        bookingId: json["bookingId"],
        select: json["select"],
        amount: json["amount"],
        payment: json["payment"],
        select_payment: json["select_payment"],
        price: json["price"],
        address: json["address"],
        title: json["title"],
        file: json["file"],
        accountId: json["accountId"],
        path: json["path"],
        statee: json["statee"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "bookingDated": bookingDate,
        "bookingId": bookingId,
        "select": select,
        "amount": amount,
        "payment": payment,
        "select_payment": select_payment,
        "price": price,
        "address": address,
        "title": title,
        "file": file,
        "accountId": accountId,
         "path": path,
        "statee": statee,
        "date": date,
      };
}