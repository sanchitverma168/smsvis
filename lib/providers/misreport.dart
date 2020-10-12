import 'dart:convert';
import 'package:Smsvis/models/api.dart';
import 'package:Smsvis/models/detail_mis_report.dart';
import 'package:Smsvis/utils/sharedpreference.dart';
import 'package:Smsvis/utils/variables.dart';
import 'package:Smsvis/widgets/detailreport/datatable.dart';
import 'package:Smsvis/widgets/detailreport/hintTextFirstPage.dart';
import 'package:Smsvis/widgets/misreport/carddata.dart';
import 'package:Smsvis/widgets/misreport/loading.dart';
import 'package:Smsvis/widgets/misreport/nodatafound.dart';
import 'package:flutter/cupertino.dart';

enum ScreenContent { NoDataFound, HintText, DataReady, IsLoading }

class MISReportProvider with ChangeNotifier {
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
  init(String from, String end) {
    screenContent = ScreenContent.IsLoading;
    body = LoadingMISReport();
    getDataFromServer(from, end);
  }

  getDataFromServer(String startdate, String enddate) async {
    String username = await SharedData().username;
    screenContent = ScreenContent.IsLoading;
    setScreenContent();
    var data;
    try {
      data = await API().fetchdata(username, TypeData.DetailMISReport,
          startdate: startdate, enddate: enddate);
    } catch (e) {
      print(e);
    }
    if (json.decode(data)["status"] == 401.toString()) {
      screenContent = ScreenContent.NoDataFound;
    } else {
      jsondataistoRepresent = misDetailReportFromJson(data);
      dataReady = true;
      screenContent = ScreenContent.DataReady;
    }
    setScreenContent();
  }

  setScreenContent() {
    switch (screenContent) {
      case ScreenContent.NoDataFound:
        body = NoDataFoundMISReport();
        break;
      case ScreenContent.HintText:
        body = HintTextFirstPage();
        break;
      case ScreenContent.DataReady:
        if (dataInCard)
          body = MISReportCardData();
        else
          body = DetailReportDataTable();
        break;
      case ScreenContent.IsLoading:
        body = LoadingMISReport();
        break;
    }
    notifyListeners();
  }
}
