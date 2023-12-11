import 'dart:convert';

Reseve reseveFromJson(String str) => Reseve.fromJson(json.decode(str));

String reseveToJson(Reseve data) => json.encode(data.toJson());

class Reseve {
  String bookingId;
  String accountId;
  String bookingDate;
  String address;
  String statee;

  Reseve({
    required this.bookingId,
    required this.accountId,
    required this.bookingDate,
    required this.address,
    required this.statee,
  });

  factory Reseve.fromJson(Map<String, dynamic> json) => Reseve(
    bookingId: json["bookingId"],
        accountId: json["accountId"],
        bookingDate: json["bookingDate"],
        address: json["address"],
        statee: json["statee"],
      );

  Map<String, dynamic> toJson() => {
    "bookingId": bookingId,
        "accountId": accountId,
        "bookingDate": bookingDate,
        "address": address,
        "statee": statee,
      };
}