import 'package:flutter/material.dart';

import 'actionbuttons.dart';
import 'containerdata.dart';

class SelectedContacts extends StatelessWidget {
  const SelectedContacts({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Selected Contacts"),
        ),
        body: Container(
            color: Colors.red,
            child: Column(children: <Widget>[UpperTools(), ContainerData()])));
  }
}
