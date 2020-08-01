import 'package:flutter/material.dart';

class DetailReportDataTable extends StatelessWidget {
  const DetailReportDataTable({Key key}) : super(key: key);

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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: Column(
          children: [
            DataTable(columns: <DataColumn>[
              DataColumn(label: Text("Sr. No")),
              for (int i = 0; i < 6; i++)
                DataColumn(label: Text("${columnname[i]}"))
            ], rows: <DataRow>[
              for (int i = 0; i < maxdata; i++)
                DataRow(cells: <DataCell>[
                  DataCell(Text("$i")),
                  for (int i = 0; i < 6; i++) DataCell(Text("${celldata[i]}"))
                ])
            ])
          ],
        ),
      ),
    );
  }
}
