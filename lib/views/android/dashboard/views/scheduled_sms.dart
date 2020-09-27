import 'package:Smsvis/utils/sharedpreference.dart';
import 'package:flutter/material.dart';

class Scheduledsms extends StatefulWidget {
  Scheduledsms({Key key}) : super(key: key);

  @override
  _ScheduledsmsState createState() => _ScheduledsmsState();
}

class _ScheduledsmsState extends State<Scheduledsms> {
  String connection;
  bool islogin, isfirsttime;
  init() async {
    islogin = await SharedData().islogin();
    isfirsttime = await SharedData().isNotfirsttime;
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Container(
      child: Center(child: Text("Page Not Made yet")),
    );
  }
}
