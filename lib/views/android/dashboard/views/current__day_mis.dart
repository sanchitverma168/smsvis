import 'dart:convert';
import 'package:Smsvis/models/api.dart';
import 'package:Smsvis/models/currentdaymisreport.dart';
import 'package:Smsvis/providers/currentdaymis.dart';
import 'package:Smsvis/utils/sharedpreference.dart';
import 'package:Smsvis/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrentDayMIS extends StatefulWidget {
  CurrentDayMIS({Key key}) : super(key: key);
  @override
  _CurrentDayMISState createState() => _CurrentDayMISState();
}

class _CurrentDayMISState extends State<CurrentDayMIS> {
  @override
  void initState() {
    final cdmp = Provider.of<CurrentDayMISProvider>(context, listen: false);
    cdmp.init();

    getDataFromServer(cdmp);
    super.initState();
  }

  getDataFromServer(CurrentDayMISProvider cdmp) async {
    String username = await SharedData().username;
    var data = await API().fetchdata(username, TypeData.CurrentMISReport);
    var jsondata = json.decode(data);
    print(jsondata);
    if (jsondata["status"] == 202.toString()) {
      cdmp.currentDayMisReport = currentDayMisReportFromJson(data);
      cdmp.screenContent = ScreenContent.isDataReady;
    } else {
      cdmp.screenContent = ScreenContent.isDataError;
    }
    cdmp.setScreenContent();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentDayMISProvider>(builder: (context, value, child) {
      // value.getDataFromServer();
      return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 0.9,
              child: value.body,
            )),
      );
    });
  }
}
