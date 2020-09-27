/// This is Host.
const server = "http://49.50.64.162/";
const app = "sms_app_app/";
const baseURL = "http://49.50.64.162/API/index?";
const databaseName = "app_database.db";
const loginURL = "http://49.50.64.162/sms_app_app/login.php?";

// http://49.50.64.162/sms_app_app/login.php?user_id=demo_app&password=7c9519bd83

const getsenderidURL =
    "http://49.50.64.162/sms_app_app/api_senderid.php?user_id=";
const getcreditsURL =
    "http://49.50.64.162/sms_app_app/credit_left.php?user_id=";
enum TypeData {
  SenderID,
  Credits,
  DetailMISReport,
  CurrentMISReport,
  CurrentMISDisplayReport
}

/// http://49.50.64.162/sms_app_app/details_sms_misreport.php?user_id=trans_demo&start_date=2020-01-01&end_date=2020-09-15
const getdetailReport = "sms_app_app/details_sms_misreport.php?";

/// http://49.50.64.162/sms_app_app/current_day_mis_report.php?user_id=trans_demo
const getmisReport = "sms_app_app/current_day_mis_report.php?";

/// http://49.50.64.162/sms_app_app/sms_summary_report.php?user_id=trans_demo&msg_group=556431
const getsummaryReport = "sms_summary_report.php?";
