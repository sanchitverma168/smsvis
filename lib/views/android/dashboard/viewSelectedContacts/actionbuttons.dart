import 'package:flutter/material.dart';

class UpperTools extends StatelessWidget {
  const UpperTools({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          OutlineButton(
            onPressed: null,
            child: Text("File"),
          ),
          OutlineButton(
            onPressed: null,
            child: Text("Phone"),
          ),
          OutlineButton(
            onPressed: null,
            child: Text("Typed"),
          ),
        ],
      ),
    );
  }
}
