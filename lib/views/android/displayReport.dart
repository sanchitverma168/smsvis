import 'dart:convert';

import 'package:Smsvis/models/api.dart';
import 'package:Smsvis/models/currentdaymisdisplayReport.dart';
import 'package:Smsvis/providers/currentDayMISDisplayReportProvider.dart';
import 'package:Smsvis/utils/sharedpreference.dart';
import 'package:Smsvis/utils/stringtext.dart';
import 'package:Smsvis/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrentDayMISReporttoDisplayReport extends StatefulWidget {
  final String msgroupId;
  CurrentDayMISReporttoDisplayReport(this.msgroupId, {Key key})
      : super(key: key);

  @override
  _CurrentDayMISReporttoDisplayReportState createState() =>
      _CurrentDayMISReporttoDisplayReportState();
}

class _CurrentDayMISReporttoDisplayReportState
    extends State<CurrentDayMISReporttoDisplayReport> {
  @override
  void initState() {
    var cdp =
        Provider.of<CurrentDayMISDisplayReportProvider>(context, listen: false);
    cdp.init();
    getdatafromserver(cdp);
    super.initState();
  }

  getdatafromserver(CurrentDayMISDisplayReportProvider cdp) async {
    String username = await SharedData().username;
    var data = await API().fetchdata(username, TypeData.CurrentMISDisplayReport,
        msgroupid: widget.msgroupId);
    var jsondata = json.decode(data);
    var _status = jsondata["status"];
    if (_status == "202") {
      cdp.currentDayMISDisplayReport =
          CurrentDayMISDisplayReport.fromJson(jsondata);
      cdp.screenContent = ScreenContent.isDataReady;
    } else
      cdp.screenContent = ScreenContent.isError;

    cdp.setScreenContent();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentDayMISDisplayReportProvider>(
        builder: (context, value, child) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(TextData.displayReport),
          ),
          body: value.body);
    });
  }
}
