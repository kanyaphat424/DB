import 'dart:convert';

Ddmo ddmoFromJson(String str) => Ddmo.fromJson(json.decode(str));

String ddmoToJson(Ddmo data) => json.encode(data.toJson());

class Ddmo {
    String bookingId;
    String bookingDate;
    String title;
    String statee;

    Ddmo({
        required this.bookingId,
        required this.bookingDate,
        required this.title,
        required this.statee,
    });

    factory Ddmo.fromJson(Map<String, dynamic> json) => Ddmo(
        bookingId: json["bookingId"],
        bookingDate: json["bookingDate"],
        title: json["title"],
        statee: json["statee"],
    );

    Map<String, dynamic> toJson() => {
        "bookingId": bookingId,
        "bookingDate": bookingDate,
        "title": title,
        "statee": statee,
    };
}