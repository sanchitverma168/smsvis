import 'dart:convert';
import 'package:Smsvis/models/api.dart';
import 'package:Smsvis/models/quicksendresponse.dart';
import 'package:Smsvis/utils/internetconnection.dart';
import 'package:Smsvis/utils/sharedpreference.dart';
import 'package:Smsvis/utils/stringtext.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

enum Status {
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated,
  NOINTERNETCONNECTION
}
enum ErrorType { INCORRECT_LOGIN, LOGIN_SUCESS }
Map msg = {
  ErrorType.INCORRECT_LOGIN: TextData.incorrectLogin,
  ErrorType.LOGIN_SUCESS: TextData.loginSucess
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

  /// This is used for the message displayed on Register page.
  bool registrationSuccess = false;

  /// This is used for the message displayed on Register page.
  bool registrationError = false;

  /// This is used for the message displayed on Register page.
  bool messageShow = false;

  /// This is used to show message on login Screen.
  bool messageonLoginScreen;
  bool get getMessageonLoginScreen => messageonLoginScreen;

  set setMessageonLoginScreen(bool messageonLoginScreen) =>
      this.messageonLoginScreen = messageonLoginScreen;

  /// This is used to show Processing bar on login Screen.
  bool processingonLoginScreen = false;
  bool get getProcessingonLoginScreen => processingonLoginScreen;

  set setProcessingonLoginScreen(bool processingonLoginScreen) =>
      this.processingonLoginScreen = processingonLoginScreen;

  /// This is for Message On LoginScreen;
  String messageLoginScreen;
  String get getMessageLoginScreen => messageLoginScreen;

  set setMessageLoginScreen(String messageLoginScreen) =>
      this.messageLoginScreen = messageLoginScreen;

  initAuthProvider() async {
    if (await InternetConnection().isConnected()) {
      _status = await SharedData().islogin()
          ? await isUsernameandpasswordCorrect()
              ? Status.Authenticated
              : Status.Unauthenticated
          : Status.Unauthenticated;
    } else {
      _status = Status.NOINTERNETCONNECTION;
    }

    notifyListeners();
  }

  Future login(String id, String password) async {
    _status = Status.Authenticating;
    bool _login = true;
    var response = await API().login(id, password);
    var jsondata = json.decode(response);
    var responsemsg = QuickSendResponse.fromJson(jsondata);
    if (responsemsg.status == errorCode[ErrorType.INCORRECT_LOGIN]) {
      _login = false;
      _responsemsg = msg[ErrorType.INCORRECT_LOGIN];
    } else if (responsemsg.status == errorCode[ErrorType.LOGIN_SUCESS]) {
      _status = Status.Authenticated;
      setMessageLoginScreen = null;
      SharedData().setlogincredentials(id, password);
    }
    if (!_login) {
      setMessageLoginScreen = TextData.invalidCredentails;
      setMessageonLoginScreen = true;
    } else
      _status = Status.Authenticated;

    setProcessingonLoginScreen = false;
    notifyListeners();
  }

  Future<bool> register(
      String fullname, String mobile, String email, String location) async {
    var response = await API().register(fullname, mobile, email, location);
    if (json.decode(response)["status"] == 202.toString()) {
      registrationSuccess = true;
    } else
      registrationError = true;
    messageShow = true;
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    SharedData().logout();
    _status = Status.Unauthenticated;
    notifyListeners();
  }

  Future<bool> isUsernameandpasswordCorrect() async {
    String id, password;
    id = await SharedData().username;
    password = await SharedData().password;
    var response;
    try {
      response = await API().login(id, password);
    } on ClientException {
      print("Exception Occured");
    }
    var jsondata = json.decode(response);
    var responsemsg = QuickSendResponse.fromJson(jsondata);
    if (responsemsg.status == errorCode[ErrorType.INCORRECT_LOGIN]) {
      setMessageLoginScreen = TextData.passwordsHaveBeenChange;
      setMessageonLoginScreen = true;
      return false;
    } else
      return true;
  }
}
