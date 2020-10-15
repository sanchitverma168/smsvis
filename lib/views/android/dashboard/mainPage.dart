import 'package:Smsvis/providers/handle_main_drawer_activity.dart';
import 'package:Smsvis/providers/routehandler.dart';
import 'package:Smsvis/utils/colors.dart';
import 'package:Smsvis/utils/stringtext.dart';
import 'package:Smsvis/widgets/dashboard/gridviewwidget.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class Dashboard extends StatelessWidget {
  Dashboard({Key key}) : super(key: key);
  gotoPage(context, page) {
    Provider.of<HandleDrawerActivity>(context, listen: false).swtichpage(page);
  }

  @override
  Widget build(BuildContext context) {
    var rh = Provider.of<RouteHandler>(context).connecitivityResult;
    return Consumer<HandleDrawerActivity>(builder: (context, user, child) {
      Color creditBox;
      var size = MediaQuery.of(context).size;
      if (int.parse(user.credit) > 60)
        creditBox = UIColors.successColor;
      else if (int.parse(user.credit) > 20 && (int.parse(user.credit) < 60))
        creditBox = Colors.yellow;
      else
        creditBox = Colors.red;
      return Container(
          height: size.height,
          width: size.width,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Expanded(
                    flex: 1,
                    child: GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 10,
                        children: [
                          GridViewBoxShow(
                              function: () {
                                if (rh != ConnectivityResult.none)
                                  gotoPage(context, PageControl.QUICK_SEND);
                                else
                                  Toast.show(
                                      TextData.noInternetConnection, context);
                              },
                              boxColor: rh == ConnectivityResult.none
                                  ? Colors.grey
                                  : UIColors.fcolor,
                              icondata: Icons.send,
                              text: TextData.quickSendSMS,
                              heightBox: size.height * .15,
                              widthBox: size.width * 0.25),
                          GridViewBoxShow(
                              function: () {
                                if (rh != ConnectivityResult.none)
                                  user.swtichpage(PageControl.CURRENT_DAY_MIS);
                                else
                                  Toast.show(
                                      TextData.noInternetConnection, context);
                              },
                              boxColor: rh == ConnectivityResult.none
                                  ? Colors.grey
                                  : UIColors.fcolor,
                              icondata: Icons.report,
                              text: TextData.currentDayMis,
                              heightBox: size.height * .15,
                              widthBox: size.width * 0.25),
                          GridViewBoxShow(
                              function: () {
                                if (rh != ConnectivityResult.none)
                                  gotoPage(context, PageControl.MIS_REPORT);
                                else
                                  Toast.show(
                                      TextData.noInternetConnection, context);
                              },
                              boxColor: rh == ConnectivityResult.none
                                  ? Colors.grey
                                  : UIColors.fcolor,
                              icondata: Icons.report,
                              text: TextData.misReport,
                              heightBox: size.height * .15,
                              widthBox: size.width * 0.25),
                          GridViewBoxShow(
                              function: () {},
                              textColor: Colors.blue[50],
                              heightBox: size.height * .15,
                              widthBox: size.width * 0.25,
                              text: TextData.creditLeft,
                              data: user.credit,
                              boxColor: creditBox)
                        ]))
              ])));
    });
  }
}
