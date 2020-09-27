import 'package:Smsvis/models/currentdaymisreport.dart';
import 'package:Smsvis/widgets/currentdaymis/contentReady.dart';
import 'package:Smsvis/widgets/detailreport/loading.dart';
import 'package:Smsvis/widgets/detailreport/nodatafound.dart';
import 'package:flutter/cupertino.dart';

enum ScreenContent { isLoading, isDataReady, isDataError }

class CurrentDayMISProvider with ChangeNotifier {
  ScreenContent _screenContent;
  ScreenContent get screenContent => _screenContent;
  set screenContent(value) => _screenContent = value;

  Widget _body;
  Widget get body => _body;
  set body(value) => _body = value;

  bool _dataReady = false;
  bool get dataReady => _dataReady;
  set dataReady(value) => _dataReady = value;

  CurrentDayMisReport currentDayMisReport;

  ///--- Methods Start----/////
  init() {
    screenContent = ScreenContent.isLoading;
    body = LoadingDetailReport();
  }

  setScreenContent() {
    switch (screenContent) {
      case ScreenContent.isDataError:
        body = NoDataFoundDetailReport();
        break;
      case ScreenContent.isDataReady:
        body = ContetReady();
        break;
      case ScreenContent.isLoading:
        body = LoadingDetailReport();
        break;
      default:
    }
    notifyListeners();
  }
}
