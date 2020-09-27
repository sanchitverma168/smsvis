import 'package:Smsvis/providers/routehandler.dart';
import 'package:Smsvis/widgets/loginpage/bezierContainer.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formloginKey = GlobalKey<FormState>();
  bool processing = false;
  @override
  void initState() {
    _askPermissions();
    updateErrorBox();
    super.initState();
  }

  bool showerrorbox = false;

  String email, password, message;
  Future<void> onlogin() async {
    final form = _formloginKey.currentState;
    // print("onlogin");
    if (form.validate()) {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        processing = true;
        setState(() {});
        // print("validation correct");
        var result = await Provider.of<RouteHandler>(context, listen: false)
            .login(email, password);
        if (result == false) {
          processing = false;
          showerrorbox = true;
          // print(showerrorbox);
          message = "Invalid Credentials";
          updateErrorBox();
          setState(() {});
        }
        // print(showerrorbox);
      } else {
        Toast.show("No Internet Connection", context,
            gravity: 2,
            duration: 2,
            backgroundColor: Colors.white,
            textColor: Colors.black);
      }
    }
  }

  Widget progressonlogin() {
    if (processing) {
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
      // print(statuses[Permission.contacts]);

      if (status.isUndetermined ==
              statuses[Permission.contacts].isUndetermined ||
          status.isDenied == statuses[Permission.contacts].isDenied ||
          status.isPermanentlyDenied ==
              statuses[Permission.contacts].isPermanentlyDenied ||
          status.isRestricted == statuses[Permission.contacts].isRestricted) {
        // print("inside pop context");
        Permission.contacts.request();
      }
      // print("hello");
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
              if (value.isEmpty) return "Enter Username";
              return null;
            },
            obscureText: isPassword,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true,
                hintText: "Username"),
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
            borderRadius: BorderRadius.all(Radius.circular(5)),
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
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.white),
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
          child: Image.asset("assets/icon/app_icon.jpg"),
        ));
  }

  // Widget _title() {
  //   return RichText(
  //     textAlign: TextAlign.center,
  //     text: TextSpan(
  //         text: 'sms',
  //         style: GoogleFonts.portLligatSans(
  //           textStyle: Theme.of(context).textTheme.headline4,
  //           fontSize: 30,
  //           fontWeight: FontWeight.w700,
  //           color: Color(0xffe46b10),
  //         ),
  //         children: [
  //           TextSpan(
  //             text: 'vis',
  //             style: TextStyle(color: Colors.black, fontSize: 30),
  //           ),
  //         ]),
  //   );
  // }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Username"),
        _entryFieldPassword("Password", isPassword: true),
      ],
    );
  }

  Widget _entryFieldPassword(String title, {bool isPassword = false}) {
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
            obscureText: isPassword,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true,
                hintText: "Type Password"),
            validator: (value) {
              password = value.trim();
              if (password.isEmpty) return "Enter Password";
              return null;
            },
          )
        ],
      ),
    );
  }

  Widget _errorBox;
  updateErrorBox() {
    if (message == null)
      _errorBox = SizedBox(height: 5);
    else {
      _errorBox = Text(
        "$message",
        style: TextStyle(
            color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
      );
      // print("error text box enabled");
    }
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
              child: BezierContainer()),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * 0.2),
                  applogo(),
                  // _title(),
                  progressonlogin(),
                  msg == null ? SizedBox(height: 30) : SizedBox(height: 10),
                  msg == null ? SizedBox(height: 0) : _errorBox,

                  Form(
                    key: _formloginKey,
                    child: _emailPasswordWidget(),
                  ),
                  // _errorBox,
                  SizedBox(height: 20),
                  _submitButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
