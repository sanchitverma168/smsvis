import 'dart:async';

import 'package:Smsvis/providers/routehandler.dart';
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
      child: CircularProgressIndicator(
        backgroundColor: Colors.orange,
      ),
    );
  }

  Widget errorshow() {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("No Internet Connection"),
            Text("Check Your Internet"),
            OutlineButton(
              color: Colors.red,
              onPressed: () {
                Toast.show("Retrying", context);
                showProgress = true;
                Provider.of<RouteHandler>(context, listen: false)
                    .initAuthProvider();
                setState(() {});
                Timer(Duration(seconds: 10), () {
                  showProgress = false;
                  setState(() {});
                });
              },
              child: Text("Retry"),
            )
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("building");
    return Scaffold(
      body: Container(
        child: Center(
          child: showProgress == true ? progress() : errorshow(),
        ),
      ),
    );
  }
}
