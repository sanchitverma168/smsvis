import 'package:flutter/material.dart';

class DisplayContentData extends StatelessWidget {
  final String label;
  final int count;
  DisplayContentData(this.label, this.count, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(label),
          // Chip(
          //   label: Text(count.toString()),
          //   backgroundColor: Colors.orange[100],
          // ),
          Text(count.toString()),
        ]);
  }
}
