import 'package:Smsvis/models/fetchallsendeerid.dart';
import 'package:Smsvis/models/quicksendresponse.dart';
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
  Error
}

List<String> pagecontrol = [
  "Quick Send",
  "Scheduled Sms",
  "Current Day MIS",
  "MIS Report",
  "Detail Report",
  "File Upload Status",
  "Download Centre",
  "Manage Group",
  "Manage Contact",
  "Credit History",
  "Template",
  "General",
  "Profile",
];
String senderidfirst = "Select Sender ID";

class HandleDrawerActivity with ChangeNotifier {
  List<Color> _maincolor = [Color(0xfffbb448), Color(0xfff7892b)];
  List<Color> get maincolor => _maincolor;
  Color get fcolor => _maincolor.first;
  Color get scolor => _maincolor[1];

  QuickSendResponse quickSendResponse = QuickSendResponse();
  PageControl _page = PageControl.QUICK_SEND;

  String _pagetitle = pagecontrol.first;
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

  List<String> _senderid = new List();
  List<String> get senderid => _senderid;
  Future setsenderid(List<SenderId> id) {
    print("hello");
    senderid.add(senderidfirst);
    for (int i = 0; i < id.length; i++) {
      senderid.add(id[i].senderid);
    }
    return null;
  }

  List<String> localsenderid = ["Select Sender ID", "No ID Found"];
  // --------------- start of functions

  swtichpage(PageControl page) {
    switch (page) {
      case PageControl.QUICK_SEND:
        _page = PageControl.QUICK_SEND;
        _pagetitle = pagecontrol.first;
        break;
      case PageControl.SCHEDULED_SMS:
        _page = PageControl.SCHEDULED_SMS;
        _pagetitle = pagecontrol[1];
        break;
      case PageControl.CURRENT_DAY_MIS:
        _page = PageControl.CURRENT_DAY_MIS;
        _pagetitle = pagecontrol[2];
        break;
      case PageControl.MIS_REPORT:
        _page = PageControl.MIS_REPORT;
        _pagetitle = pagecontrol[3];
        break;
      case PageControl.DETAIL_REPORT:
        _page = PageControl.DETAIL_REPORT;
        _pagetitle = pagecontrol[4];
        break;
      case PageControl.FILE_UPLOAD_STATUS:
        _page = PageControl.FILE_UPLOAD_STATUS;
        _pagetitle = pagecontrol[5];
        break;
      case PageControl.DOWNLOAD_CENTRE:
        _page = PageControl.DOWNLOAD_CENTRE;
        _pagetitle = pagecontrol[6];
        break;
      case PageControl.MANAGE_GROUP:
        _page = PageControl.MANAGE_GROUP;
        _pagetitle = pagecontrol[7];
        break;
      case PageControl.MANAGE_CONTACT:
        _page = PageControl.MANAGE_CONTACT;
        _pagetitle = pagecontrol[8];
        break;
      case PageControl.CREDIT_HISTORY:
        _page = PageControl.CREDIT_HISTORY;
        _pagetitle = pagecontrol[9];
        break;
      case PageControl.TEMPLATE:
        _page = PageControl.TEMPLATE;
        _pagetitle = pagecontrol[10];
        break;
      case PageControl.GENERAL:
        _page = PageControl.GENERAL;
        _pagetitle = pagecontrol[11];
        break;
      case PageControl.PROFILE:
        _page = PageControl.PROFILE;
        _pagetitle = pagecontrol[12];
        break;
      case PageControl.HELP:
        _page = PageControl.HELP;
        _pagetitle = pagecontrol[13];
        break;
      case PageControl.Error:
        _page = PageControl.Error;
        _pagetitle = "No Internet";
        break;
      default:
        _pagetitle = pagecontrol.first;
        _page = PageControl.QUICK_SEND;
        break;
    }
    notifyListeners();
  }
}
