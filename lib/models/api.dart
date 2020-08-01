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
}
