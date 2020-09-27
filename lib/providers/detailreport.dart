import 'dart:convert';

import 'package:Smsvis/models/api.dart';
import 'package:Smsvis/models/detail_mis_report.dart';
import 'package:Smsvis/utils/sharedpreference.dart';
import 'package:Smsvis/utils/variables.dart';
import 'package:Smsvis/widgets/detailreport/carddata.dart';
import 'package:Smsvis/widgets/detailreport/datatable.dart';
import 'package:Smsvis/widgets/detailreport/hintTextFirstPage.dart';
import 'package:Smsvis/widgets/detailreport/loading.dart';
import 'package:Smsvis/widgets/detailreport/nodatafound.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

enum ScreenContent { NoDataFound, HintText, DataReady, IsLoading }

class DetailReportProvider with ChangeNotifier {
  ScreenContent _screenContent;
  ScreenContent get screenContent => _screenContent;
  set screenContent(value) => _screenContent = value;

  Widget _body;
  Widget get body => _body;
  set body(value) => _body = value;

  bool _dataReady = false;
  bool get dataReady => _dataReady;
  set dataReady(value) => _dataReady = value;
  bool _dataIncard = true;
  bool get dataInCard => _dataIncard;
  set dataInCard(value) => _dataIncard = value;
  MisDetailReport jsondataistoRepresent;

  ///--- Methods Start----/////
  init() {
    screenContent = ScreenContent.HintText;
    body = HintTextFirstPage();
  }

  setScreenContent() {
    switch (screenContent) {
      case ScreenContent.NoDataFound:
        body = NoDataFoundDetailReport();
        break;
      case ScreenContent.HintText:
        body = HintTextFirstPage();
        break;
      case ScreenContent.DataReady:
        if (dataInCard)
          body = DetailReportCardData();
        else
          body = DetailReportDataTable();
        break;
      case ScreenContent.IsLoading:
        body = LoadingDetailReport();
        break;
    }
    notifyListeners();
  }

  getDataFromServer(String startdate, String enddate) async {
    String username = await SharedData().username;
    var l = Logger();
    screenContent = ScreenContent.IsLoading;
    setScreenContent();
    var data = await API().fetchdata(username, TypeData.DetailMISReport,
        startdate: startdate, enddate: enddate);
    // l.i(data);
    var jsondata = json.decode(data);
    if (jsondata["status"] == 401.toString()) {
      print("inside 401");
      screenContent = ScreenContent.NoDataFound;
    } else {
      jsondataistoRepresent = misDetailReportFromJson(data);
      dataReady = true;
      print("inside else");
      l.d(jsondataistoRepresent.message[0].toJson());
      screenContent = ScreenContent.DataReady;
    }

    setScreenContent();
  }
}
