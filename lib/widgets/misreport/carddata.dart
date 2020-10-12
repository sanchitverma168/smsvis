import 'package:Smsvis/providers/misreport.dart';
import 'package:Smsvis/utils/stringtext.dart';
import 'package:Smsvis/widgets/detailreport/carddata/columncontent.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MISReportCardData extends StatelessWidget {
  const MISReportCardData({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final drp = Provider.of<MISReportProvider>(context, listen: false);
    return ListView.builder(
        reverse: true,
        itemCount: drp.jsondataistoRepresent.message.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: Card(
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ColumnContent(TextData.mobile,
                            drp.jsondataistoRepresent.message[index].mobile),
                        ColumnContent(TextData.text,
                            drp.jsondataistoRepresent.message[index].text),
                        ColumnContent(TextData.msg_tag,
                            drp.jsondataistoRepresent.message[index].msgTag)
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        ColumnContent(
                            TextData.sent_date,
                            drp.jsondataistoRepresent.message[index].sentDate
                                .toString()),
                        ColumnContent(
                            TextData.status_description,
                            drp.jsondataistoRepresent.message[index]
                                .finalStatus)
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
