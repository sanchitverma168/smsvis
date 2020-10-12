import 'package:Smsvis/utils/stringtext.dart';
import 'package:flutter/material.dart';
import 'rowContent.dart';

class CommunicationDetails extends StatelessWidget {
  CommunicationDetails({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Divider(),
          Text(TextData.communicationDetails),
          RowContent([
            Text(TextData.communicationDetailsArray[0]),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                  hintText: TextData.type +
                      TextData.communicationDetailsArray[0] +
                      TextData.dot),
            )
          ], [
            1,
            2
          ]),
          RowContent([
            Text(TextData.communicationDetailsArray[1]),
            TextField(
                decoration: InputDecoration(
                    hintText: TextData.type +
                        TextData.communicationDetailsArray[1] +
                        TextData.dot))
          ], [
            1,
            2
          ]),
          RowContent([
            Text(TextData.communicationDetailsArray[2]),
            TextField(
                decoration: InputDecoration(
                    hintText: TextData.type +
                        TextData.communicationDetailsArray[2] +
                        TextData.dot))
          ], [
            1,
            2
          ]),
          RowContent([
            Text(TextData.communicationDetailsArray[3]),
            TextField(
                decoration: InputDecoration(
                    hintText: TextData.type +
                        TextData.communicationDetailsArray[3] +
                        TextData.dot))
          ], [
            1,
            2
          ]),
          RowContent([
            Text(TextData.communicationDetailsArray[4]),
            TextField(
                decoration: InputDecoration(
                    hintText: TextData.type +
                        TextData.communicationDetailsArray[4] +
                        TextData.dot))
          ], [
            1,
            2
          ]),
          RowContent([
            Text(TextData.communicationDetailsArray[5]),
            TextField(
                decoration: InputDecoration(
                    hintText: TextData.type +
                        TextData.communicationDetailsArray[5] +
                        TextData.dot))
          ], [
            1,
            2
          ]),
          RowContent([
            Text(TextData.communicationDetailsArray[6]),
            TextField(
                decoration: InputDecoration(
                    hintText: TextData.type +
                        TextData.communicationDetailsArray[6] +
                        TextData.dot))
          ], [
            1,
            2
          ]),
        ],
      ),
    );
  }
}
