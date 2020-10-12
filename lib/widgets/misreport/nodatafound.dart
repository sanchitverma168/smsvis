import 'package:Smsvis/utils/stringtext.dart';
import 'package:flutter/material.dart';

class NoDataFoundMISReport extends StatelessWidget {
  const NoDataFoundMISReport({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(TextData.norecordFound),
          Text(TextData.or),
          Text(TextData.selectAnotherDate)
        ],
      ),
    );
  }
}
