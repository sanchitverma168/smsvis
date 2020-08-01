class QuickSendResponse {
  int status;
  String statusMessage;
  Null data;

  QuickSendResponse({this.status, this.statusMessage, this.data});

  QuickSendResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusMessage = json['status_message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status_message'] = this.statusMessage;
    data['data'] = this.data;
    return data;
  }
}
