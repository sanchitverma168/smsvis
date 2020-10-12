import 'package:flutter/material.dart';

class DisplayContentData extends StatelessWidget {
  final String label;
  final int count;
  DisplayContentData(this.label, this.count, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(label),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            count.toString(),
          ),
        ),
      ],
    );
  }
}
