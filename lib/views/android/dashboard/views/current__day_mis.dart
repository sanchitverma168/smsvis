import 'package:Smsvis/providers/currentdaymis.dart';
import 'package:Smsvis/widgets/currentdaymis/datarow.dart';
import 'package:flutter/material.dart';

class CurrentDayMIS extends StatefulWidget {
  CurrentDayMIS({Key key}) : super(key: key);

  @override
  _CurrentDayMISState createState() => _CurrentDayMISState();
}

class _CurrentDayMISState extends State<CurrentDayMIS> {
  List<String> field = [
    "Send:",
    "Failed:",
    "Reject:",
    "Delivered:",
    "Total Submit:",
    "Submitted to SMSC:"
  ];
  DateTime from = DateTime.now();
  DateTime to = DateTime.now();
  Future<void> getstartDate(BuildContext context) async {
    final DateTime dt = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1960),
        lastDate: DateTime(2260));
    if (dt != null && dt != from) {
      from = dt;
      setState(() {});
    }
  }

  Future<void> getendDate(BuildContext context) async {
    final DateTime dt = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1960),
        lastDate: DateTime(2260));
    if (dt != null && dt != to) {
      to = dt;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // PageHeading("MIS Report"),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Start Date:"),
                    Text("${from.toLocal()}".split(" ").first),
                    FlatButton(
                        onPressed: () => getstartDate(context),
                        child: Text("Select Date")),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("End Date:"),
                    Text("${to.toLocal()}".split(" ").first),
                    FlatButton(
                        onPressed: () => getendDate(context),
                        child: Text("Select  Date")),
                  ],
                ),

                for (int i = 0; i < 6; i++) MISDataRow("${field[i]}", "1")
              ],
            ),
          )),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: FloatingActionButton(
                backgroundColor: CurrentDayMISProvider().scolor,
                splashColor: Colors.red,
                heroTag: null,
                onPressed: null,
                child: Icon(Icons.search)),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: FloatingActionButton(
                backgroundColor: CurrentDayMISProvider().scolor,
                heroTag: null,
                onPressed: null,
                child: Icon(Icons.file_download)),
          ),
        ],
      ),
    );
  }
}
