import 'package:Smsvis/utils/enum.dart';
import 'package:Smsvis/utils/network.dart';
import 'package:Smsvis/utils/urls.dart';

class API {
  String url;
  Future<dynamic> postmesage(String id, String usermessage, String password,
      String number, String userid) async {
    url = MYURL.server +
        MYURL.messageSend +
        MYURL.user_id +
        userid +
        MYURL.amperSand +
        MYURL.password +
        password +
        MYURL.amperSand +
        MYURL.sender_id +
        id +
        MYURL.amperSand +
        MYURL.number +
        number +
        MYURL.amperSand +
        MYURL.text +
        usermessage;
    return Network(url).sendmsg();
  }

  Future<dynamic> login(String id, String password) async {
    url = MYURL.server +
        MYURL.app +
        MYURL.loginURl +
        MYURL.user_id +
        id +
        MYURL.amperSand +
        MYURL.password +
        password;
    return Network(url).sendmsg();
  }

  Future<dynamic> register(
      String fullname, String mobile, String email, String location) {
    url = MYURL.server +
        MYURL.app +
        MYURL.registerURl +
        MYURL.user_name +
        fullname +
        MYURL.amperSand +
        MYURL.mobile +
        mobile +
        MYURL.amperSand +
        MYURL.email +
        email +
        MYURL.amperSand +
        MYURL.location +
        location;
    return (Network(url).sendmsg());
  }

  /// [startdate] and [enddate] for detailReport
  /// [msgGroupID] for Page DisplayReport in CurrentMISReport Page
  Future<dynamic> fetchdata(String username, TypeData type,
      {String startdate, String enddate, String msgroupid}) {
    switch (type) {
      case TypeData.SenderID:
        url = MYURL.server +
            MYURL.app +
            MYURL.getSenderID +
            MYURL.user_id +
            username;
        break;
      case TypeData.Credits:
        url = MYURL.server +
            MYURL.app +
            MYURL.getCredits +
            MYURL.user_id +
            username;
        break;
      case TypeData.DetailMISReport:
        url = MYURL.server +
            MYURL.app +
            MYURL.detailReport +
            MYURL.user_id +
            username +
            MYURL.amperSand +
            MYURL.start_date +
            startdate +
            MYURL.amperSand +
            MYURL.end_date +
            enddate;
        break;
      case TypeData.CurrentMISReport:
        url = MYURL.server +
            MYURL.app +
            MYURL.misReport +
            MYURL.user_id +
            username;
        break;
      case TypeData.CurrentMISDisplayReport:
        url = MYURL.server +
            MYURL.app +
            MYURL.summaryReport +
            MYURL.user_id +
            username +
            MYURL.amperSand +
            MYURL.msg_group +
            msgroupid.toString();
        break;
    }

    return Network(url).sendmsg();
  }
}
