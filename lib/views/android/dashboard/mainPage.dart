import 'package:Smsvis/providers/handle_main_drawer_activity.dart';
import 'package:Smsvis/utils/colors.dart';
import 'package:Smsvis/utils/stringtext.dart';
import 'package:Smsvis/widgets/dashboard/gridviewwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  final String creditLeft;
  Dashboard(this.creditLeft, {Key key}) : super(key: key);
  gotoPage(context, page) {
    Provider.of<HandleDrawerActivity>(context, listen: false).swtichpage(page);
  }

  @override
  Widget build(BuildContext context) {
    Color creditBox;
    var size = MediaQuery.of(context).size;
    if (int.parse(creditLeft) > 60)
      creditBox = UIColors.successColor;
    else if (int.parse(creditLeft) > 20 && (int.parse(creditLeft) < 60))
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
                              gotoPage(context, PageControl.QUICK_SEND);
                            },
                            icondata: Icons.send,
                            text: TextData.quickSendSMS,
                            heightBox: size.height * .15,
                            widthBox: size.width * 0.25),
                        GridViewBoxShow(
                            function: () {
                              gotoPage(context, PageControl.CURRENT_DAY_MIS);
                            },
                            icondata: Icons.report,
                            text: TextData.currentDayMis,
                            heightBox: size.height * .15,
                            widthBox: size.width * 0.25),
                        GridViewBoxShow(
                            function: () {
                              gotoPage(context, PageControl.MIS_REPORT);
                            },
                            icondata: Icons.report,
                            text: TextData.misReport,
                            heightBox: size.height * .15,
                            widthBox: size.width * 0.25),
                        // GridViewBoxShow(
                        //     function: () {
                        //       gotoPage(context, PageControl.DETAIL_REPORT);
                        //     },
                        //     icondata: Icons.receipt,
                        //     text: TextData.detailReportPage,
                        //     heightBox: size.height * .15,
                        //     widthBox: size.width * 0.25),
                        GridViewBoxShow(
                            function: () {},
                            textColor: Colors.blue[50],
                            heightBox: size.height * .15,
                            widthBox: size.width * 0.25,
                            text: TextData.creditLeft,
                            data: creditLeft,
                            boxColor: creditBox)
                      ]))
            ])));
  }
}
