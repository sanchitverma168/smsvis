import 'package:Smsvis/providers/detailreport.dart';
import 'package:Smsvis/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailReport extends StatefulWidget {
  DetailReport({Key key}) : super(key: key);

  @override
  _DetailReportState createState() => _DetailReportState();
}

class _DetailReportState extends State<DetailReport> {
  DateTime from = DateTime.now();
  DateTime to = DateTime.now();

  @override
  void initState() {
    final qsp = Provider.of<DetailReportProvider>(context, listen: false);
    qsp.init();
    super.initState();
  }

  getDatafromuserinalertboxtosearch() {
    final qsp = Provider.of<DetailReportProvider>(context, listen: false);
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
              elevation: 5,
              scrollable: true,
              title: Text('Choose Date'),
              content: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return SingleChildScrollView(
                    child: Column(children: [
                  Wrap(children: [
                    Text("Start Date:"),
                    Text("${from.toLocal()}".split(" ").first),
                    Card(
                      child: FlatButton(
                          onPressed: () => getstartDate(context),
                          child: Text("Select Date")),
                    )
                  ]),
                  Wrap(children: [
                    Text("End Date:"),
                    Text("${to.toLocal()}".split(" ").first),
                    Card(
                      child: FlatButton(
                          onPressed: () => getendDate(context),
                          child: Text("Select Date")),
                    )
                  ])
                ]));
              }),
              actions: <Widget>[
                FlatButton(
                  child: Text('Send'),
                  onPressed: () async {
                    String first = from.year.toString() +
                        "-" +
                        from.month.toString() +
                        "-" +
                        from.day.toString();
                    String end = to.year.toString() +
                        "-" +
                        to.month.toString() +
                        "-" +
                        to.day.toString();
                    // print(first);
                    // print(end);
                    qsp.getDataFromServer(first, end);
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text("Cancel"),
                  onPressed: () => Navigator.pop(context),
                )
              ]);
        });
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

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailReportProvider>(builder: (context, value, child) {
      return Scaffold(
          body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: value.body,
              )),
          floatingActionButton:
              Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            // if (value.dataReady)
            //   Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: FloatingActionButton(
            //         backgroundColor: UIColors.scolor,
            //         onPressed: () {
            //           value.dataInCard = !value.dataInCard;
            //           value.setScreenContent();
            //         },
            //         child: Icon(Icons.swap_horiz),
            //       )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                  backgroundColor: UIColors.scolor,
                  splashColor: Colors.red,
                  heroTag: null,
                  onPressed: () => getDatafromuserinalertboxtosearch(),
                  child: Icon(Icons.search)),
            )
          ]));
    });
  }
}
