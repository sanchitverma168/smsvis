import 'package:Smsvis/utils/stringtext.dart';
import 'package:flutter/material.dart';

class NoContactFound extends StatelessWidget {
  const NoContactFound({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(TextData.noContactFound),
      ),
    );
  }
}
