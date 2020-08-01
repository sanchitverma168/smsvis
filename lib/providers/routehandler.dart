import 'dart:convert';

import 'package:Smsvis/models/api.dart';
import 'package:Smsvis/models/quicksendresponse.dart';
import 'package:Smsvis/utils/sharedpreference.dart';
import 'package:flutter/cupertino.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }
enum ErrorType { INCORRECT_LOGIN, LOGIN_SUCESS }
Map msg = {
  ErrorType.INCORRECT_LOGIN: "Incorrect Login",
  ErrorType.LOGIN_SUCESS: "Login Success"
};

Map errorCode = {ErrorType.INCORRECT_LOGIN: 401, ErrorType.LOGIN_SUCESS: 202};

class RouteHandler with ChangeNotifier {
  List<Color> _maincolor = [Color(0xfffbb448), Color(0xfff7892b)];
  List<Color> get maincolor => _maincolor;
  Color get fcolor => _maincolor.first;
  Color get scolor => _maincolor[1];

  Status _status = Status.Uninitialized;
  Status get status => _status;

  String _responsemsg = msg[ErrorType.LOGIN_SUCESS];
  String get responsemsg => _responsemsg;

  initAuthProvider() async {
    _status = await SharedData().islogin()
        ? Status.Authenticated
        : Status.Unauthenticated;
    notifyListeners();
  }

  Future<bool> login(String id, String password) async {
    _status = Status.Authenticating;
    bool _login = true;
    var response = await API().login(id, password);
    var jsondata = json.decode(response);
    var responsemsg = QuickSendResponse.fromJson(jsondata);
    print(responsemsg.status);
    print(responsemsg.statusMessage);

    if (responsemsg.status == errorCode[ErrorType.INCORRECT_LOGIN]) {
      _login = false;
      _responsemsg = msg[ErrorType.INCORRECT_LOGIN];
    } else if (responsemsg.status == errorCode[ErrorType.LOGIN_SUCESS]) {
      _status = Status.Authenticated;
      SharedData().setlogincredentials(id, password);
    }
    if (_login) {
      print("notify print");
      notifyListeners();
    }
    print(_login);
    return _login;
  }

  Future<void> logout() async {
    SharedData().logout();
    _status = Status.Unauthenticated;
    notifyListeners();
  }
}
