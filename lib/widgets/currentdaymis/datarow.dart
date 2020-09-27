import 'package:flutter/material.dart';

class DataRowCurrentMISReport extends StatelessWidget {
  final String title, value;
  DataRowCurrentMISReport(this.title, this.value, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: ListTile(title: Text(title), trailing: Text(value)));
  }
}
