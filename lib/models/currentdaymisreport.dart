// To parse this JSON data, do
//
//     final currentDayMisReport = currentDayMisReportFromJson(jsonString);

import 'dart:convert';

CurrentDayMisReport currentDayMisReportFromJson(String str) =>
    CurrentDayMisReport.fromJson(json.decode(str));

String currentDayMisReportToJson(CurrentDayMisReport data) =>
    json.encode(data.toJson());

class CurrentDayMisReport {
  CurrentDayMisReport({
    this.message,
    this.status,
  });

  List<Message> message;
  String status;

  factory CurrentDayMisReport.fromJson(Map<String, dynamic> json) =>
      CurrentDayMisReport(
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
    this.splitCount,
    this.senderid,
    this.sent,
    this.delivered,
    this.smsc,
    this.failed,
    this.ndnc,
    this.reject,
    this.msgTag,
    this.userId,
    this.msgGroup,
    this.totalCount,
  });

  String splitCount;
  String senderid;
  String sent;
  String delivered;
  String smsc;
  String failed;
  String ndnc;
  String reject;
  String msgTag;
  String userId;
  String msgGroup;
  int totalCount;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        splitCount: json["split_count"],
        senderid: json["senderid"],
        sent: json["sent"],
        delivered: json["delivered"],
        smsc: json["smsc"],
        failed: json["failed"],
        ndnc: json["NDNC"],
        reject: json["reject"],
        msgTag: json["msg_tag"],
        userId: json["user_id"],
        msgGroup: json["msgGroup"],
        totalCount: json["total_count"],
      );

  Map<String, dynamic> toJson() => {
        "split_count": splitCount,
        "senderid": senderid,
        "sent": sent,
        "delivered": delivered,
        "smsc": smsc,
        "failed": failed,
        "NDNC": ndnc,
        "reject": reject,
        "msg_tag": msgTag,
        "user_id": userId,
        "msgGroup": msgGroup,
        "total_count": totalCount,
      };
}
