import 'package:Smsvis/providers/detailreport.dart';
import 'package:Smsvis/widgets/detailreport/carddata.dart';
import 'package:Smsvis/widgets/detailreport/datatable.dart';
import 'package:flutter/material.dart';

class DetailReport extends StatefulWidget {
  DetailReport({Key key}) : super(key: key);

  @override
  _DetailReportState createState() => _DetailReportState();
}

class _DetailReportState extends State<DetailReport> {
  DateTime from = DateTime.now();
  DateTime to = DateTime.now();
  String mstatus;
  List<String> status = [
    'All',
    'Delivered',
    'SMC',
    'Failed',
    'NDNC',
    'Sent',
    'Reject',
  ];
  @override
  void initState() {
    swap = DetailReportDataTable();
    super.initState();
  }

  getDatafromuserinalertboxtosearch() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 5,
          scrollable: true,

          // title: Text('Sendsssss Message'),
          title: Text('Confirm Id'),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Wrap(
                    children: [
                      Text("Start Date:"),
                      Text("${from.toLocal()}".split(" ").first),
                      Card(
                        child: FlatButton(
                            onPressed: () => getstartDate(context),
                            child: Text("Select Date")),
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      Text("End Date:"),
                      Text("${to.toLocal()}".split(" ").first),
                      Card(
                        child: FlatButton(
                            onPressed: () => getendDate(context),
                            child: Text("Select Date")),
                      ),
                    ],
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(flex: 1, child: Text("Mobile")),
                        Expanded(
                            flex: 1,
                            child: TextFormField(
                              onChanged: (value) {},
                            ))
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(flex: 1, child: Text("Status")),
                      Expanded(
                        flex: 1,
                        child: DropdownButton<String>(
                          isExpanded: true,
                          hint: Text("Select Status ID"),
                          value: mstatus,
                          onChanged: (String value) {
                            setState(() {
                              mstatus = value;
                            });
                          },
                          items: status
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                                value: value, child: Text(value));
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
          actions: <Widget>[
            FlatButton(
              child: Text('Send'),
              onPressed: () {
                Navigator.of(context).pop();
                // sendmsg();
              },
            ),
            FlatButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
    );
  }

  Future<void> getstartDate(BuildContext context) async {
    Navigator.pop(context);
    final DateTime dt = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1960),
        lastDate: DateTime(2260));
    if (dt != null && dt != from) {
      from = dt;
      setState(() {});
      getDatafromuserinalertboxtosearch();
    }
  }

  Future<void> getendDate(BuildContext context) async {
    Navigator.pop(context);
    final DateTime dt = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1960),
        lastDate: DateTime(2260));
    if (dt != null && dt != to) {
      to = dt;
      setState(() {});
      getDatafromuserinalertboxtosearch();
    }
  }

  bool datatable = true;
  Widget swap;
  swapwidget() {
    if (datatable) {
      swap = DetailReportDataTable();
    } else
      swap = DetailReportCardData();
    datatable = !datatable;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: swap,
          )),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              backgroundColor: DetailReportProvider().scolor,
              onPressed: () {
                swapwidget();
              },
              child: Icon(Icons.swap_horiz),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
                backgroundColor: DetailReportProvider().scolor,
                splashColor: Colors.red,
                heroTag: null,
                onPressed: () => getDatafromuserinalertboxtosearch(),
                child: Icon(Icons.search)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
                backgroundColor: DetailReportProvider().scolor,
                heroTag: null,
                onPressed: () => getDatafromuserinalertboxtosearch(),
                child: Icon(Icons.file_download)),
          ),
        ],
      ),
    );
  }
}
