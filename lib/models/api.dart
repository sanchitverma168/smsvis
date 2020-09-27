import 'package:Smsvis/utils/network.dart';
import 'package:Smsvis/utils/variables.dart';

class API {
  String url;
  Future<dynamic> postmesage(String id, String usermessage, String password,
      String number, String userid) async {
    url = "$baseURL" +
        "user_id=$userid&password=$password&sender_id=$id&number=$number&text=$usermessage";
    Network network = new Network(url);
    return (network.sendmsg());
  }

  Future<dynamic> login(String id, String password) async {
    url = "$loginURL" + "user_id=$id&password=$password";
    return (Network(url).sendmsg());
  }

  /// [startdate] and [enddate] for detailReport
  ///
  /// [msgGroupID] for Page DisplayReport in CurrentMISReport Page
  Future<dynamic> fetchdata(String username, TypeData type,
      {String startdate, String enddate, String msgroupid}) {
    switch (type) {
      case TypeData.SenderID:
        url = "$getsenderidURL$username";
        break;
      case TypeData.Credits:
        url = "$getcreditsURL$username";
        break;
      case TypeData.DetailMISReport:
        url = server +
            getdetailReport +
            "user_id=$username&start_date=$startdate&end_date=$enddate";
        break;
      case TypeData.CurrentMISReport:
        url = server + getmisReport + "user_id=" + username;
        break;
      case TypeData.CurrentMISDisplayReport:
        url = server +
            app +
            getsummaryReport +
            "user_id=" +
            username +
            "&msg_group=" +
            msgroupid.toString();
        break;
    }

    return Network(url).sendmsg();
  }
}
