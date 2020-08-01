import 'package:flutter/material.dart';

class TextLabel extends StatelessWidget {
  final String value;
  TextLabel(this.value, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        value,
        style: TextStyle(color: Colors.grey, fontSize: 15),
      ),
    );
  }
}
