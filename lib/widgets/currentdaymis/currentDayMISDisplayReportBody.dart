import 'package:Smsvis/providers/currentDayMISDisplayReportProvider.dart';
import 'package:Smsvis/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrentDayMISDisplayReportBody extends StatelessWidget {
  const CurrentDayMISDisplayReportBody({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var cdp =
        Provider.of<CurrentDayMISDisplayReportProvider>(context, listen: false);
    var data = cdp.currentDayMISDisplayReport.message;
    return Column(children: [
      Expanded(
          child: ListView.builder(
              itemBuilder: (context, index) {
                // if (index == data.length && data.length > 10) {
                if (index == data.length) {
                  print(true);
                  return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 58.0),
                      child: Column(children: [
                        LinearProgressIndicator(
                            backgroundColor: UIColors.scolor),
                        Text("Fetching Data")
                      ]));
                }
                // else
                //   SizedBox();
                print(false);
                return Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Card(
                        child: Column(children: [
                      SizedBox(height: 10),
                      Text(data[index].mobile),
                      SizedBox(height: 10),
                      Text(data[index].text),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(children: [
                              Text(data[index].sentDate),
                              Text(data[index].lastUpdate),
                            ]),
                            Column(children: [
                              Text(data[index].finalStatus),
                              Text(data[index].msgTag)
                            ]),
                          ])
                    ])));
              },
              itemCount: data.length + 1)),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        IconButton(onPressed: null, icon: Icon(Icons.navigate_before)),
        IconButton(onPressed: null, icon: Icon(Icons.navigate_next))
      ])
    ]);
  }
}
