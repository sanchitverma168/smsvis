import 'package:Smsvis/providers/routehandler.dart';
import 'package:Smsvis/views/android/dashboard/dashboard.dart';
import 'package:Smsvis/views/android/error.dart';
import 'package:Smsvis/views/android/loading.dart';
import 'package:Smsvis/views/android/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: RouteHandler().scolor));
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => RouteHandler()),
    ],
    child: new MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => new Router(),
        }),
  ));
}

class Router extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<RouteHandler>(
      builder: (context, user, child) {
        // print(user.status);
        switch (user.status) {
          case Status.Uninitialized:
            return AndroidLoading();
          case Status.Unauthenticated:
            return LoginPage(
              title: "LoginPage",
            );
          case Status.Authenticated:
            return AndroidDashboard();
          case Status.NOINTERNETCONNECTION:
            return ErrorPage();
          default:
            return LoginPage(title: "LoginPage");
        }
      },
    );
  }
}
