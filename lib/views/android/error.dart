import 'dart:async';

import 'package:Smsvis/providers/routehandler.dart';
import 'package:Smsvis/utils/colors.dart';
import 'package:Smsvis/utils/stringtext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ErrorPage extends StatefulWidget {
  ErrorPage({Key key}) : super(key: key);

  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  bool showProgress = false;
  Widget progress() {
    return Container(
      child: CircularProgressIndicator(backgroundColor: UIColors.scolor),
    );
  }

  Widget errorshow() {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(TextData.noInternetConnection),
            Text(TextData.checkYourInternet),
            OutlineButton(
                color: Colors.red,
                onPressed: () {
                  Toast.show(TextData.retrying, context);
                  showProgress = true;
                  Provider.of<RouteHandler>(context, listen: false)
                      .initAuthProvider();
                  setState(() {});
                  Timer(Duration(seconds: 10), () {
                    showProgress = false;
                    setState(() {});
                  });
                },
                child: Text(TextData.retry))
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: showProgress == true ? progress() : errorshow(),
        ),
      ),
    );
  }
}
