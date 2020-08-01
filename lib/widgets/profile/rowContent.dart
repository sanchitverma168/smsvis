import 'package:flutter/material.dart';

class RowContent extends StatelessWidget {
  final List<Widget> first;
  final List<int> flexint;
  RowContent(this.first, this.flexint, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      for (int i = 0; i < first.length; i++)
        Expanded(flex: flexint[i], child: first[i]),
    ]);
  }
}
