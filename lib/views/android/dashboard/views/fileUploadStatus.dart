import 'package:flutter/material.dart';

class FileUploadStatus extends StatefulWidget {
  FileUploadStatus({Key key}) : super(key: key);

  @override
  _FileUploadStatusState createState() => _FileUploadStatusState();
}

class _FileUploadStatusState extends State<FileUploadStatus> {
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
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Start Date:"),
                    Text("${from.toLocal()}".split(" ").first),
                    FlatButton(
                        onPressed: () => getstartDate(context),
                        child: Text("Select  Date")),
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
              ],
            ),
          )),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              splashColor: Colors.red,
              heroTag: null,
              onPressed: null,
              child: Text(
                "Search",
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              heroTag: null,
              onPressed: null,
              child: Text(
                "Download",
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
