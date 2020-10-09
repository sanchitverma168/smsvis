import 'package:Smsvis/models/api.dart';
import 'package:Smsvis/providers/currentdaymis.dart';
import 'package:Smsvis/providers/detailreport.dart';
import 'package:Smsvis/providers/misreport.dart';
import 'package:Smsvis/providers/quicksendprovider_v2.dart';
import 'package:Smsvis/utils/variables.dart';
import 'package:Smsvis/models/fetchallsendeerid.dart';
import 'package:Smsvis/providers/handle_main_drawer_activity.dart';
import 'package:Smsvis/utils/sharedpreference.dart';
import 'package:Smsvis/views/android/contacts/viewfavouritelist.dart';
import 'package:Smsvis/views/android/dashboard/help.dart';
import 'package:Smsvis/views/android/dashboard/mainPage.dart';
import 'package:Smsvis/views/android/dashboard/sidedrawer.dart';
import 'package:Smsvis/views/android/dashboard/views/credithistory.dart';
import 'package:Smsvis/views/android/dashboard/views/current__day_mis.dart';
import 'package:Smsvis/views/android/dashboard/views/detailreport.dart';
import 'package:Smsvis/views/android/dashboard/views/downloadcentre.dart';
import 'package:Smsvis/views/android/dashboard/views/fileUploadStatus.dart';
import 'package:Smsvis/views/android/dashboard/views/general.dart';
import 'package:Smsvis/views/android/dashboard/views/misreport.dart';
import 'package:Smsvis/views/android/dashboard/views/myaccounttemplate.dart';
import 'package:Smsvis/views/android/dashboard/views/profile.dart';
import 'package:Smsvis/views/android/dashboard/views/quickSend_v2.dart';
import 'package:Smsvis/views/android/dashboard/views/scheduled_sms.dart';
import 'package:Smsvis/views/android/error.dart';
import 'package:Smsvis/views/android/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AndroidDashboard extends StatefulWidget {
  AndroidDashboard({Key key}) : super(key: key);

  @override
  _AndroidDashboardState createState() => _AndroidDashboardState();
}

class _AndroidDashboardState extends State<AndroidDashboard> {
  String u;
  Credits credits;
  List<SenderId> senderid;

  @override
  void initState() {
    getusername();
    super.initState();
  }

  fetchuserdata(u) async {
    var creditsjson;
    // senderidjson = await API().fetchdata(u, Type.SenderID);
    // print(senderidjson);
    creditsjson = await API().fetchdata(u, TypeData.Credits);
    print(creditsjson);
    credits = creditsFromMap(creditsjson);
    setState(() {});
    // senderid = senderIdFromMap(senderidjson);
  }

  getusername() async {
    u = await SharedData().username;
    fetchuserdata(u);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HandleDrawerActivity()),
        ],
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Consumer<HandleDrawerActivity>(
                builder: (context, user, child) {
                  return Text(user.pagetitle);
                },
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: HandleDrawerActivity().maincolor)),
              ),
            ),
            drawer:
                Consumer<HandleDrawerActivity>(builder: (context, user, child) {
              return SideDrawer(u, credits.creditLeft);
            }),
            body: Consumer<HandleDrawerActivity>(
              builder: (context, user, child) {
                Widget data;
                switch (user.page) {
                  case PageControl.Dashboard:
                    if (credits == null) return AndroidLoading();
                    return Dashboard(credits.creditLeft);
                  case PageControl.QUICK_SEND:
                    data = ChangeNotifierProvider(
                        create: (context) => QuickSendProviderV2(),
                        child: QuickSendV2());
                    break;
                  case PageControl.SCHEDULED_SMS:
                    data = Scheduledsms();
                    break;
                  case PageControl.CURRENT_DAY_MIS:
                    data = ChangeNotifierProvider(
                        create: (context) => CurrentDayMISProvider(),
                        child: CurrentDayMIS());
                    break;
                  case PageControl.MIS_REPORT:
                    data = ChangeNotifierProvider(
                        create: (context) => MISReportProvider(),
                        child: MISReport());
                    break;
                  case PageControl.DETAIL_REPORT:
                    data = ChangeNotifierProvider(
                        create: (context) => DetailReportProvider(),
                        child: DetailReport());
                    break;
                  case PageControl.FILE_UPLOAD_STATUS:
                    data = FileUploadStatus();
                    break;
                  case PageControl.DOWNLOAD_CENTRE:
                    data = DownloadCentre();
                    break;
                  case PageControl.MANAGE_GROUP:
                    data = FavouriteListView();
                    break;
                  // case PageControl.MANAGE_CONTACT:
                  //   return ManageContact();
                  case PageControl.CREDIT_HISTORY:
                    data = CreditHistory();
                    break;
                  case PageControl.TEMPLATE:
                    data = MyAccountTemplate();
                    break;
                  case PageControl.GENERAL:
                    data = General();
                    break;
                  case PageControl.PROFILE:
                    data = Profile();
                    break;
                  case PageControl.HELP:
                    data = HelpMe();
                    break;
                  case PageControl.Error:
                    data = ErrorPage();
                    break;
                  default:
                    data = QuickSendV2();
                }
                return WillPopScope(
                    onWillPop: () {
                      var hdp = Provider.of<HandleDrawerActivity>(context,
                          listen: false);
                      if (hdp.pagetitle == PageControl.Dashboard.toString())
                        Navigator.pop(context);
                      else
                        hdp.swtichpage(PageControl.Dashboard);
                      return;
                    },
                    child: data);
              },
            ),
          ),
        ));
  }
}
