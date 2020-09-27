import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ColumnContent extends StatelessWidget {
  final String title, data;
  final bool col;
  ColumnContent(this.title, this.data, {Key d, this.col = true})
      : super(key: d);
  String datato;
  @override
  Widget build(BuildContext context) {
    datato = data;
    if (data == null || data == "") datato = "No Data";
    if (col)
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("$title :"),
            Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text("$datato",
                        style: TextStyle(fontWeight: FontWeight.w300))))
          ]);
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text("$title : "),
          Container(
              child: Text("$datato",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.w300)))
        ]);
  }
}
