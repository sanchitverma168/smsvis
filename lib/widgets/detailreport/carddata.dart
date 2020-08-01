import 'package:flutter/material.dart';

class DetailReportCardData extends StatelessWidget {
  const DetailReportCardData({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int maxdata = 100;
    List<String> columnname = [
      "Mobile",
      "Text",
      "Submit Date",
      "Carrier Update",
      "Status",
      "Status Description"
    ];
    List<String> celldata = [
      "xxx3025xxx",
      "Hi there this is a long text message from system generated automatically.therefore it is wrap",
      "2020-07-16 16:16:56",
      "2020-07-16 16:17:11",
      "Delivered",
      "	Delivered to Handset"
    ];
    return ListView.builder(
        itemCount: maxdata,
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
                        for (int i = 0; i < 3; i++)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "${columnname[i]}:",
                                style: TextStyle(fontWeight: FontWeight.w300),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                    "${celldata[i]}",
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        for (int i = 3; i < 6; i++)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "${columnname[i]}:",
                                style: TextStyle(fontWeight: FontWeight.w300),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: Text("${celldata[i]}"),
                              ),
                            ],
                          ),
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
