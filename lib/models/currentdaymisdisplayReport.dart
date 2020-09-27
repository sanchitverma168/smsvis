class CurrentDayMISDisplayReport {
  List<Message> message;
  String status;

  CurrentDayMISDisplayReport({this.message, this.status});

  CurrentDayMISDisplayReport.fromJson(Map<String, dynamic> json) {
    if (json['message'] != null) {
      message = new List<Message>();
      json['message'].forEach((v) {
        message.add(new Message.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.message != null) {
      data['message'] = this.message.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Message {
  String userId;
  String mobile;
  String sentDate;
  String lastUpdate;
  String finalStatus;
  String text;
  String msgTag;

  Message(
      {this.userId,
      this.mobile,
      this.sentDate,
      this.lastUpdate,
      this.finalStatus,
      this.text,
      this.msgTag});

  Message.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    mobile = json['mobile'];
    sentDate = json['sent_date'];
    lastUpdate = json['last_update'];
    finalStatus = json['final_status'];
    text = json['text'];
    msgTag = json['msg_tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['mobile'] = this.mobile;
    data['sent_date'] = this.sentDate;
    data['last_update'] = this.lastUpdate;
    data['final_status'] = this.finalStatus;
    data['text'] = this.text;
    data['msg_tag'] = this.msgTag;
    return data;
  }
}
