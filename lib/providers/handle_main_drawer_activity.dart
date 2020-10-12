import 'package:Smsvis/models/quicksendresponse.dart';
import 'package:Smsvis/utils/stringtext.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

enum PageControl {
  QUICK_SEND,
  SCHEDULED_SMS,
  CURRENT_DAY_MIS,
  MIS_REPORT,
  DETAIL_REPORT,
  FILE_UPLOAD_STATUS,
  DOWNLOAD_CENTRE,
  MANAGE_GROUP,
  MANAGE_CONTACT,
  CREDIT_HISTORY,
  TEMPLATE,
  GENERAL,
  PROFILE,
  HELP,
  Error,
  Dashboard
}

class HandleDrawerActivity with ChangeNotifier {
  List<Color> _maincolor = [Color(0xfffbb448), Color(0xfff7892b)];
  List<Color> get maincolor => _maincolor;
  Color get fcolor => _maincolor.first;
  Color get scolor => _maincolor[1];

  QuickSendResponse quickSendResponse = QuickSendResponse();
  PageControl _page = PageControl.Dashboard;

  String _pagetitle = TextData.pageTitles.last;
  String _errormsg;
  PageControl get page => _page;
  String get pagetitle => _pagetitle;

  String get responsemsg => _errormsg;
  int _credit = 0;
  int get credit => _credit;
  setcredit(value, {bool notify = true}) {
    _credit = value;
    if (notify) notifyListeners();
  }

  // --------------- start of functions

  swtichpage(PageControl page) {
    switch (page) {
      case PageControl.Dashboard:
        _page = PageControl.Dashboard;
        _pagetitle = TextData.pageTitles.last;
        break;
      case PageControl.QUICK_SEND:
        _page = PageControl.QUICK_SEND;
        _pagetitle = TextData.pageTitles.first;
        break;
      case PageControl.SCHEDULED_SMS:
        _page = PageControl.SCHEDULED_SMS;
        _pagetitle = TextData.pageTitles[1];
        break;
      case PageControl.CURRENT_DAY_MIS:
        _page = PageControl.CURRENT_DAY_MIS;
        _pagetitle = TextData.pageTitles[2];
        break;
      case PageControl.MIS_REPORT:
        _page = PageControl.MIS_REPORT;
        _pagetitle = TextData.pageTitles[3];
        break;
      case PageControl.DETAIL_REPORT:
        _page = PageControl.DETAIL_REPORT;
        _pagetitle = TextData.pageTitles[4];
        break;
      case PageControl.FILE_UPLOAD_STATUS:
        _page = PageControl.FILE_UPLOAD_STATUS;
        _pagetitle = TextData.pageTitles[5];
        break;
      case PageControl.DOWNLOAD_CENTRE:
        _page = PageControl.DOWNLOAD_CENTRE;
        _pagetitle = TextData.pageTitles[6];
        break;
      case PageControl.MANAGE_GROUP:
        _page = PageControl.MANAGE_GROUP;
        _pagetitle = TextData.pageTitles[7];
        break;
      case PageControl.MANAGE_CONTACT:
        _page = PageControl.MANAGE_CONTACT;
        _pagetitle = TextData.pageTitles[8];
        break;
      case PageControl.CREDIT_HISTORY:
        _page = PageControl.CREDIT_HISTORY;
        _pagetitle = TextData.pageTitles[9];
        break;
      case PageControl.TEMPLATE:
        _page = PageControl.TEMPLATE;
        _pagetitle = TextData.pageTitles[10];
        break;
      case PageControl.GENERAL:
        _page = PageControl.GENERAL;
        _pagetitle = TextData.pageTitles[11];
        break;
      case PageControl.PROFILE:
        _page = PageControl.PROFILE;
        _pagetitle = TextData.pageTitles[12];
        break;
      case PageControl.HELP:
        _page = PageControl.HELP;
        _pagetitle = TextData.pageTitles[13];
        break;
      case PageControl.Error:
        _page = PageControl.Error;
        _pagetitle = TextData.noInternetConnection;
        break;
      default:
        _pagetitle = TextData.pageTitles.first;
        _page = PageControl.QUICK_SEND;
        break;
    }
    notifyListeners();
  }
}
