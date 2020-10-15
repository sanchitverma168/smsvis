import 'package:Smsvis/providers/routehandler.dart';
import 'package:Smsvis/utils/animation.dart';
import 'package:Smsvis/utils/colors.dart';
import 'package:Smsvis/utils/stringtext.dart';
import 'package:Smsvis/views/android/register.dart';
import 'package:Smsvis/widgets/loginpage/bezierContainer.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formloginKey = GlobalKey<FormState>();
  AnimationController helpanimationController;
  bool processing = false;
  @override
  void initState() {
    _askPermissions();
    super.initState();
    helpanimationController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    helpanimationController.dispose();
    super.dispose();
  }

  bool isPassword = true;

  bool showerrorbox = false;

  String email, password, message;
  Future<void> onlogin() async {
    var routehandler = Provider.of<RouteHandler>(context, listen: false);
    final form = _formloginKey.currentState;
    if (form.validate()) {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        routehandler.setProcessingonLoginScreen = true;
        setState(() {});
        routehandler.login(email, password);
      } else {
        Toast.show(TextData.noInternetConnection, context,
            gravity: 2,
            duration: 2,
            backgroundColor: Colors.white,
            textColor: Colors.black);
      }
    }
  }

  Widget progressonlogin() {
    if (Provider.of<RouteHandler>(context, listen: false)
        .getProcessingonLoginScreen) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.5,
        child: LinearProgressIndicator(),
      );
    } else
      return SizedBox();
  }

  Future<void> _askPermissions() async {
    var status = await Permission.contacts.status;
    if (status.isUndetermined ||
        status.isDenied ||
        status.isPermanentlyDenied ||
        status.isRestricted) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.contacts,
        Permission.storage,
        Permission.notification
      ].request();

      if (status.isUndetermined ==
              statuses[Permission.contacts].isUndetermined ||
          status.isDenied == statuses[Permission.contacts].isDenied ||
          status.isPermanentlyDenied ==
              statuses[Permission.contacts].isPermanentlyDenied ||
          status.isRestricted == statuses[Permission.contacts].isRestricted) {
        Permission.contacts.request();
      }
    }
  }

  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: (value) {
              email = value.trim();
              if (value.isEmpty) return TextData.enterUsername;
              return null;
            },
            obscureText: isPassword,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true,
                hintText: TextData.username),
          )
        ],
      ),
    );
  }

  Widget _submitButton() {
    return GestureDetector(
      onTap: () {
        onlogin();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xfffbb448),
              Color(
                0xfff7892b,
              ),
            ],
          ),
        ),
        child: Text(
          TextData.login,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget applogo() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        color: Colors.transparent,
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.height * 0.55,
        child: Image.asset(
          TextData.app_logo,
        ),
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField(TextData.username),
        _entryFieldPassword(TextData.password),
      ],
    );
  }

  Widget _entryFieldPassword(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 10),
          Stack(
            children: [
              TextFormField(
                  obscureText: isPassword,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: Color(0xfff3f3f4),
                      filled: true,
                      hintText: TextData.typePassword),
                  validator: (value) {
                    password = value.trim();
                    if (password.isEmpty) return TextData.enterPassword;
                    return null;
                  }),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: Icon(Icons.remove_red_eye),
                  onPressed: () {
                    isPassword = !isPassword;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _errorBox() {
    var routehandler = Provider.of<RouteHandler>(context, listen: false);
    if (routehandler.getMessageLoginScreen == null)
      return SizedBox(height: 5);
    else {
      return Text(
        routehandler.getMessageLoginScreen,
        style: TextStyle(
          color: Colors.red,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }

  Widget _signup() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FlatButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Register()));
          },
          child: Text(
            TextData.dontHaveAccountRegister,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * 0.2),
                    applogo(),
                    progressonlogin(),
                    _errorBox(),
                    Form(
                      key: _formloginKey,
                      child: _emailPasswordWidget(),
                    ),
                    SizedBox(height: 20),
                    _submitButton(),
                    _signup()
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedBuilder(
                animation: helpanimationController,
                builder: (context, child) {
                  return Container(
                    color: backgroundOnQuickSendSmsPageHelp.evaluate(
                      AlwaysStoppedAnimation(
                        helpanimationController.value,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(TextData.help24x7),
                        FlatButton(
                          onPressed: () async {
                            String url = "tel:" + TextData.helpNumber;
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {}
                          },
                          child: Row(
                            children: [
                              QuickSendIcon(
                                Icons.call,
                                iconColor: Colors.white,
                              ),
                              Text(
                                TextData.helpNumber,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class QuickSendIcon extends StatelessWidget {
  final IconData ic;
  final Color iconColor;
  QuickSendIcon(this.ic, {this.iconColor = UIColors.scolor, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.0, right: 4.0),
      child: Icon(ic, color: iconColor),
    );
  }
}
