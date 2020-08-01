import 'package:Smsvis/utils/internetconnection.dart';
import 'package:Smsvis/utils/sharedpreference.dart';
import 'package:flutter/material.dart';

class Scheduledsms extends StatefulWidget {
  Scheduledsms({Key key}) : super(key: key);

  @override
  _ScheduledsmsState createState() => _ScheduledsmsState();
}

class _ScheduledsmsState extends State<Scheduledsms> {
  String connection;
/*
 * 
 * 
 * 
 * 
 * 
 * 
 * 
 * 
 * 
 */
  bool islogin, isfirsttime;
  init() async {
    islogin = await SharedData().islogin();
    isfirsttime = await SharedData().isNotfirsttime;
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            RaisedButton.icon(
                onPressed: () async {
                  if (await InternetConnection().isConnected()) {
                    connection = "Connected";
                  } else
                    connection = "Not Connected";
                  setState(() {});
                },
                icon: Icon(Icons.add),
                label: Text("First")),
            Text("$connection"),
            Text("$islogin"),
            Text("$isfirsttime"),
          ],
        ),
      ),
    );
  }
}
