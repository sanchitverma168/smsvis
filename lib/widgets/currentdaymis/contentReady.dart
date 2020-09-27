import 'package:Smsvis/providers/currentDayMISDisplayReportProvider.dart';
import 'package:Smsvis/providers/currentdaymis.dart';
import 'package:Smsvis/utils/stringtext.dart';
import 'package:Smsvis/views/android/displayReport.dart';
import 'package:Smsvis/widgets/detailreport/carddata/columncontent.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContetReady extends StatelessWidget {
  ContetReady({Key key}) : super(key: key);
  // Future<bool> _onBackPressed(var context) async {
  //   // Your back press code here...
  //   print("hello back button");
  //   await Provider.of<HandleDrawerActivity>(context, listen: false)
  //       .swtichpage(PageControl.QUICK_SEND);
  //   return true;
  // }

  @override
  Widget build(BuildContext context) {
    final cdmp = Provider.of<CurrentDayMISProvider>(context, listen: false);
    var data = cdmp.currentDayMisReport.message;
    return Scaffold(
      body: Container(
          child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (
                context,
                index,
              ) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangeNotifierProvider(
                                  create: (context) =>
                                      CurrentDayMISDisplayReportProvider(),
                                  child: CurrentDayMISReporttoDisplayReport(
                                      data[index].msgGroup),
                                )));
                    print("Travelling to msgroup ID: " + data[index].msgGroup);
                  },
                  child: Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ColumnContent(
                                  TextData.split_count, data[index].delivered,
                                  col: false),
                              ColumnContent(
                                  TextData.senderid, data[index].senderid,
                                  col: false),
                              ColumnContent(TextData.sent, data[index].sent,
                                  col: false),
                              ColumnContent(
                                  TextData.delivered, data[index].delivered,
                                  col: false),
                              ColumnContent(TextData.smsc, data[index].smsc,
                                  col: false),
                              ColumnContent(TextData.failed, data[index].failed,
                                  col: false)
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ColumnContent(TextData.ndnc, data[index].ndnc,
                                  col: false),
                              ColumnContent(TextData.reject, data[index].reject,
                                  col: false),
                              ColumnContent(
                                  TextData.msg_tag, data[index].msgTag),
                              ColumnContent(TextData.userid, data[index].userId,
                                  col: false),
                              ColumnContent(
                                TextData.totalCount,
                                data[index].totalCount.toString(),
                                col: false,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              })),
    );
  }
}
