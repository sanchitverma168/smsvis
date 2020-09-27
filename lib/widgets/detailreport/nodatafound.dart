import 'package:flutter/material.dart';

class NoDataFoundDetailReport extends StatelessWidget {
  const NoDataFoundDetailReport({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("No Record Found"),
      ),
    );
  }
}
