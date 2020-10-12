import 'package:Smsvis/models/currentdaymisdisplayReport.dart';
import 'package:Smsvis/widgets/currentdaymis/currentDayMISDisplayReportBody.dart';
import 'package:Smsvis/widgets/currentdaymis/loading.dart';
import 'package:Smsvis/widgets/detailreport/nodatafound.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  /// Number of Data to Show
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

        break;
      case ScreenContent.isLoading:
        body = LoadingDisplayReport();
        break;
      default:
    }
    notifyListeners();
  }
}
