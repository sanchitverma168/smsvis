import 'package:Smsvis/providers/credithistory.dart';
import 'package:Smsvis/widgets/getdate.dart';
import 'package:flutter/material.dart';

class CreditHistory extends StatelessWidget {
  const CreditHistory({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            GetDate(),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: CreditHistoryProvider().scolor,
        onPressed: () {},
        child: Icon(Icons.search),
      ),
    );
  }
}
