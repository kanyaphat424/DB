//import 'dart:convert';

//ConAd ConAdFromJson(String str) => ConAd.fromJson(json.decode(str));

//String ConAdToJson(ConAd data) => json.encode(data.toJson());

class Ffmo {
    String accountId;
    String name;

    Ffmo({
        required this.accountId,
        required this.name,
    });

    factory Ffmo.fromJson(Map<String, dynamic> json) => Ffmo(
        accountId: json["accountId"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "accountId": accountId,
        "name": name,
    };
}