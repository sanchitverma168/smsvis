class MYURL {
  MYURL._();
  static const String server = "http://49.50.64.162/";
  static const String app = "sms_app_app/";

  /// Used To Send Message;
  static const String messageSend = "API/index?";
  static const String user_id = "user_id=";
  static const String password = "password=";
  static const String amperSand = "&";
  static const String sender_id = "sender_id";
  static const String number = "number=";
  static const String text = "text=";

  /// Local database Name;
  static const String databaseName = "app_database.db1";

  /// http://49.50.64.162/sms_app_app/mail_api.php?user_name=Ravi kumar&mobile=7007695081&email=sanchit.verma.167@gmail.com&location=Lucknow
  static const String registerURl = "mail_api.php?";
  static const String user_name = "user_name=";
  static const String mobile = "mobile=";
  static const String email = "email=";
  static const String location = "location=";

  /// http://49.50.64.162/sms_app_app/login.php?user_id=demo_app&password=7c9519bd83
  static const String loginURl = "login.php?";

  /// http://49.50.64.162/sms_app_app/api_senderid.php?user_id=trans_demo
  static const String getSenderID = "api_senderid.php?";

  /// http://49.50.64.162/sms_app_app/credit_left.php?user_id=
  static const String getCredits = "credit_left.php?";

  /// http://49.50.64.162/sms_app_app/details_sms_misreport.php?user_id=trans_demo&start_date=2020-01-01&end_date=2020-09-15
  static const String detailReport = "details_sms_misreport.php?";
  static const String start_date = "start_date=";
  static const String end_date = "end_date=";

  /// http://49.50.64.162/sms_app_app/current_day_mis_report.php?user_id=trans_demo
  static const String misReport = "current_day_mis_report.php?";

  /// http://49.50.64.162/sms_app_app/sms_summary_report.php?user_id=trans_demo&msg_group=556431
  static const String summaryReport = "sms_summary_report.php?";
  static const String msg_group = "msg_group=";
}
