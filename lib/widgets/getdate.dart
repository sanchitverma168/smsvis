import 'package:Smsvis/utils/stringtext.dart';
import 'package:flutter/material.dart';

class GetDate extends StatelessWidget {
  GetDate({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DateTime from = DateTime.now();
    DateTime to = DateTime.now();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(TextData.startDate),
                Text(from.toLocal().toString().split(" ").first),
                FlatButton(
                  onPressed: null,
                  child: Text(
                    TextData.selectDate,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(TextData.endDate),
                Text(to.toLocal().toString().split(" ").first),
                FlatButton(
                  onPressed: null,
                  child: Text(
                    TextData.selectDate,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
