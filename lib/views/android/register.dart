import 'package:Smsvis/providers/routehandler.dart';
import 'package:Smsvis/utils/stringtext.dart';
import 'package:Smsvis/widgets/loginpage/bezierContainer.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formRegisterKey = GlobalKey<FormState>();
  bool processing = false;
  String _fullname, _mobile, _email, _location;
  Future<void> onRegister() async {
    final form = _formRegisterKey.currentState;
    if (form.validate()) {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        processing = true;
        setState(() {});
        bool data = await Provider.of<RouteHandler>(context, listen: false)
            .register(_fullname, _mobile, _email, _location);
        if (data) {
          processing = false;
          print(true);
          _formRegisterKey.currentState.reset();
          setState(() {});
        }
      } else {
        Toast.show("No Internet Connection", context,
            gravity: 2,
            duration: 2,
            backgroundColor: Colors.white,
            textColor: Colors.black);
      }
    }
  }

  /// App Logo
  Widget applogo() {
    return Align(
        alignment: Alignment.center,
        child: Container(
          color: Colors.transparent,
          height: MediaQuery.of(context).size.height * 0.15,
          width: MediaQuery.of(context).size.height * 0.55,
          child: Image.asset("assets/png/app_logo.png"),
        ));
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

  Widget _entryField(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
                validator: (value) {
                  switch (title) {
                    case TextData.fullname:
                      _fullname = value.trim();
                      break;
                    case TextData.mobile:
                      _mobile = value.trim();
                      break;
                    case TextData.email:
                      _email = value.trim();
                      break;
                    case TextData.location:
                      _location = value.trim();
                      break;
                  }
                  // email = value.trim();
                  if (value.isEmpty) return "Enter " + title;
                  return null;
                },
                onSaved: (value) {},
                decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Color(0xfff3f3f4),
                    filled: true,
                    hintText: title))
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField(TextData.fullname),
        _entryField(TextData.mobile),
        _entryField(TextData.email),
        _entryField(TextData.location),
      ],
    );
  }

  Widget _successmsg() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(TextData.registrationSuccess,
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          )),
    );
  }

  Widget _errormsg() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(TextData.registrationError,
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
          )),
    );
  }

  Widget _submitButton() {
    // return RaisedButton(onPressed: onRegister, child: Text("Register"));
    return GestureDetector(
      onTap: onRegister,
      child: Card(
        elevation: 10,
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
            'Register',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var routeHandler = Provider.of<RouteHandler>(context, listen: false);
    return Scaffold(
        body: Container(
      height: size.height,
      width: size.width,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: -size.height * .15,
              right: -size.width * .5,
              child: BezierContainer()),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                    SizedBox(height: size.height * 0.15),
                    applogo(),
                    progressonlogin(),
                    routeHandler.registrationSuccess == true
                        ? _successmsg()
                        : _errormsg(),
                    // msg == null ? SizedBox(height: 30) : SizedBox(height: 10),
                    // msg == null ? SizedBox(height: 0) : _errorBox,
                    Form(key: _formRegisterKey, child: _emailPasswordWidget()),
                    SizedBox(height: 20),
                    _submitButton()
                  ]))),
          Positioned(
              top: size.height * .07,
              left: size.width * .07,
              child: Card(elevation: 10, child: BackButton())),
        ],
      ),
    ));
  }
}
