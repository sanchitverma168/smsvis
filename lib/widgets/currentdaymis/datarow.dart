import 'package:Smsvis/widgets/textlabel.dart';
import 'package:flutter/material.dart';

class MISDataRow extends StatelessWidget {
  final String value, field;
  MISDataRow(this.field, this.value, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[TextLabel("$field"), Text("$value")],
      ),
    );
  }
}
