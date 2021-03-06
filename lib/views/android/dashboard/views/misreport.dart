import 'package:Smsvis/providers/misreport.dart';
import 'package:Smsvis/utils/colors.dart';
import 'package:Smsvis/utils/stringtext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MISReport extends StatefulWidget {
  MISReport({Key key}) : super(key: key);

  @override
  _MISReportState createState() => _MISReportState();
}

class _MISReportState extends State<MISReport> {
  DateTime from = DateTime.now();
  DateTime to = DateTime.now();
  String first, end;
  @override
  void initState() {
    final qsp = Provider.of<MISReportProvider>(context, listen: false);
    convertdatetoFormattedString();
    qsp.init(first, end);
    super.initState();
  }

  convertdatetoFormattedString() {
    first = from.year.toString() +
        "-" +
        from.month.toString() +
        "-" +
        from.day.toString();
    end = to.year.toString() +
        "-" +
        to.month.toString() +
        "-" +
        to.day.toString();
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

  getDatafromuserinalertboxtosearch() {
    final qsp = Provider.of<MISReportProvider>(context, listen: false);
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
              elevation: 5,
              scrollable: true,
              title: Text(TextData.chooseDate),
              content: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return SingleChildScrollView(
                    child: Column(children: [
                  Wrap(children: [
                    Text(TextData.startDate),
                    Text(from.toLocal().toString().split(" ").first),
                    Card(
                      child: FlatButton(
                          onPressed: () => getstartDate(context),
                          child: Text(TextData.selectDate)),
                    )
                  ]),
                  Wrap(children: [
                    Text(TextData.endDate),
                    Text(to.toLocal().toString().split(" ").first),
                    Card(
                      child: FlatButton(
                          onPressed: () => getendDate(context),
                          child: Text(TextData.selectDate)),
                    )
                  ])
                ]));
              }),
              actions: <Widget>[
                FlatButton(
                  child: Text(TextData.send),
                  onPressed: () async {
                    convertdatetoFormattedString();
                    qsp.getDataFromServer(first, end);
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text(TextData.cancel),
                  onPressed: () => Navigator.pop(context),
                )
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MISReportProvider>(
      builder: (context, value, child) {
        return Scaffold(
          body: Padding(padding: const EdgeInsets.all(8.0), child: value.body),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(45.0),
                      side: BorderSide(color: UIColors.fcolor)),
                  color: UIColors.fcolor,
                  child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    splashColor: Colors.red,
                    heroTag: null,
                    onPressed: () => getDatafromuserinalertboxtosearch(),
                    child: Icon(
                      Icons.search,
                      color: UIColors.fcolor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
