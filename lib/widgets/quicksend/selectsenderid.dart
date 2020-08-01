import 'package:Smsvis/providers/quicksendprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SelectSenderId extends StatelessWidget {
  SelectSenderId({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final qsp = Provider.of<QuickSendProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          DropdownButton<String>(
            isExpanded: true,
            hint: Text("Select Sender ID"),
            value: qsp.sender,
            onChanged: (String value) {
              qsp.changesenderid(value);
            },
            items: qsp.senderid.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
          ),
        ],
      ),
    );
  }
}
