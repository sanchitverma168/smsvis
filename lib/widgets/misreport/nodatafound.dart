import 'package:flutter/material.dart';

class NoDataFoundMISReport extends StatelessWidget {
  const NoDataFoundMISReport({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text("No Record Found"),
      Text("Or"),
      Text("Select Another Date")
    ]));
  }
}
