// To parse this JSON data, do
//
//     final misDetailReport = misDetailReportFromJson(jsonString);

import 'dart:convert';

MisDetailReport misDetailReportFromJson(String str) =>
    MisDetailReport.fromJson(json.decode(str));

String misDetailReportToJson(MisDetailReport data) =>
    json.encode(data.toJson());

class MisDetailReport {
  MisDetailReport({
    this.message,
    this.status,
  });

  List<Message> message;
  String status;

  factory MisDetailReport.fromJson(Map<String, dynamic> json) =>
      MisDetailReport(
        message:
            List<Message>.from(json["message"].map((x) => Message.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": List<dynamic>.from(message.map((x) => x.toJson())),
        "status": status,
      };
}

class Message {
  Message({
    this.userId,
    this.mobile,
    this.sentDate,
    this.lastUpdate,
    this.finalStatus,
    this.text,
    this.msgTag,
  });

  String userId;
  String mobile;
  DateTime sentDate;
  DateTime lastUpdate;
  String finalStatus;
  String text;
  String msgTag;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        userId: json["user_id"],
        mobile: json["mobile"],
        sentDate: DateTime.parse(json["sent_date"]),
        lastUpdate: DateTime.parse(json["last_update"]),
        finalStatus: json["final_status"],
        text: json["text"],
        msgTag: json["msg_tag"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "mobile": mobile,
        "sent_date": sentDate.toIso8601String(),
        "last_update": lastUpdate.toIso8601String(),
        "final_status": finalStatus,
        "text": text,
        "msg_tag": msgTag,
      };
}
