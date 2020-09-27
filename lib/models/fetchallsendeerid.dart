// To parse this JSON data, do
//
//     final senderId = senderIdFromMap(jsonString);

import 'dart:convert';

List<SenderId> senderIdFromMap(String str) =>
    List<SenderId>.from(json.decode(str).map((x) => SenderId.fromMap(x)));

String senderIdToMap(List<SenderId> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class SenderId {
  SenderId({
    this.senderid,
  });

  String senderid;

  factory SenderId.fromMap(Map<String, dynamic> json) => SenderId(
        senderid: json["senderid"],
      );

  Map<String, dynamic> toMap() => {
        "senderid": senderid,
      };
}
// To parse this JSON data, do
//
//     final credits = creditsFromMap(jsonString);

Credits creditsFromMap(String str) => Credits.fromMap(json.decode(str));

String creditsToMap(Credits data) => json.encode(data.toMap());

class Credits {
  Credits({
    this.creditLeft,
  });

  String creditLeft;

  factory Credits.fromMap(Map<String, dynamic> json) => Credits(
        creditLeft: json["credit_left"],
      );

  Map<String, dynamic> toMap() => {
        "credit_left": creditLeft,
      };
}
