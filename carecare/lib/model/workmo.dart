import 'dart:convert';

Wwmo wwmoFromJson(String str) => Wwmo.fromJson(json.decode(str));

String wwmoToJson(Wwmo data) => json.encode(data.toJson());

class Wwmo {
    String bookingId;
    String bookingDate;
    String accountId;
    String title;

    Wwmo({
        required this.bookingId,
        required this.accountId,
        required this.bookingDate,
        required this.title,
    });

    factory Wwmo.fromJson(Map<String, dynamic> json) => Wwmo(
        bookingId: json["bookingId"],
        bookingDate: json["bookingDate"],
        title: json["title"],
        accountId: json["accountId"],
    );

    Map<String, dynamic> toJson() => {
        "bookingId": bookingId,
        "bookingDate": bookingDate,
        "accountId": accountId,
        "title": title,
    };
}