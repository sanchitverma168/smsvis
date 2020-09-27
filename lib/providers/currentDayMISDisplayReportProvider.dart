import 'package:Smsvis/models/currentdaymisdisplayReport.dart';
import 'package:Smsvis/widgets/currentdaymis/currentDayMISDisplayReportBody.dart';
import 'package:Smsvis/widgets/currentdaymis/loading.dart';
import 'package:Smsvis/widgets/detailreport/nodatafound.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

enum ScreenContent { isDataReady, isError, isLoading }

class CurrentDayMISDisplayReportProvider extends ChangeNotifier {
  ///ScreenContent what to show on Screen;
  ScreenContent _screenContent;
  ScreenContent get screenContent => _screenContent;
  set screenContent(value) => _screenContent = value;
  Widget _body;
  Widget get body => _body;
  set body(value) => _body = value;

  CurrentDayMISDisplayReport currentDayMISDisplayReport;

  /// Refers to the Widget Which will be shown.
  List<Widget> _widgetlist;
  List<Widget> get widgetlist => _widgetlist;

  /// Number of Data to Show
  // static const int maxCount = 10;
  // int baseindex;
  // int upperindex;
  int currentMax = 10;

  ///--- Methods Start----/////

  init() {
    screenContent = ScreenContent.isLoading;
    body = LoadingDisplayReport();
  }

  setScreenContent() {
    switch (screenContent) {
      case ScreenContent.isError:
        body = NoDataFoundDetailReport();
        break;
      case ScreenContent.isDataReady:
        body = CurrentDayMISDisplayReportBody();
        initializefirstdataintolist();
        break;
      case ScreenContent.isLoading:
        body = LoadingDisplayReport();
        break;
      default:
    }
    notifyListeners();
  }

  initializefirstdataintolist() {
    _widgetlist = new List();
    for (int i = 0; i < currentMax; i++) {
      _widgetlist.add(Text("Hello"));
    }
    var l = Logger();

    l.i(currentDayMISDisplayReport.message.toList());
  }

  setwidgetlist() {
    var data = currentDayMISDisplayReport.message;
    var bodyLength = data.length;
  }
}
