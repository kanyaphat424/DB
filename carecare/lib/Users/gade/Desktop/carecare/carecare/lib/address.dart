// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
    String address;

    Welcome({
        required this.address,
    });

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "address": address,
    };
}
