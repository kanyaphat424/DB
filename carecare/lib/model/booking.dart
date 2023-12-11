// To parse this JSON data, do
//
//     final booking = bookingFromJson(jsonString);

import 'dart:convert';

Booking bookingFromJson(String str) => Booking.fromJson(json.decode(str));

String bookingToJson(Booking data) => json.encode(data.toJson());

class Booking {
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

  Booking({
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
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
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
      };
}