import 'package:flutter/material.dart';
import 'rowContent.dart';

class CommunicationDetails extends StatelessWidget {
  CommunicationDetails({Key key}) : super(key: key);
  final List<String> _data = [
    "Address",
    "City",
    "PinCode",
    "State",
    "Country",
    "E-mail",
    "Mobile Number"
  ];
  final String type = "Type";
  final String dot = "....";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Divider(),
          Text("Communication Details"),
          RowContent([
            Text(_data[0]),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(hintText: "$type ${_data[0]}$dot"),
            )
          ], [
            1,
            2
          ]),
          RowContent([
            Text(_data[1]),
            TextField(
              decoration: InputDecoration(hintText: "$type ${_data[1]}$dot"),
            )
          ], [
            1,
            2
          ]),
          RowContent([
            Text(_data[2]),
            TextField(
              decoration: InputDecoration(hintText: "$type ${_data[2]}$dot"),
            )
          ], [
            1,
            2
          ]),
          RowContent([
            Text(_data[3]),
            TextField(
              decoration: InputDecoration(hintText: "$type ${_data[3]}$dot"),
            )
          ], [
            1,
            2
          ]),
          RowContent([
            Text(_data[4]),
            TextField(
              decoration: InputDecoration(hintText: "$type ${_data[4]}$dot"),
            )
          ], [
            1,
            2
          ]),
          RowContent([
            Text(_data[5]),
            TextField(
              decoration: InputDecoration(hintText: "$type ${_data[5]}$dot"),
            )
          ], [
            1,
            2
          ]),
          RowContent([
            Text(_data[6]),
            TextField(
              decoration: InputDecoration(hintText: "$type ${_data[6]}$dot"),
            )
          ], [
            1,
            2
          ]),
        ],
      ),
    );
  }
}
