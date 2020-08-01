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
                  Text("Start Date:"),
                  Text("${from.toLocal()}".split(" ").first),
                  FlatButton(onPressed: null, child: Text("Select  Date")),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("End Date:"),
                  Text("${to.toLocal()}".split(" ").first),
                  FlatButton(onPressed: null, child: Text("Select  Date")),
                ],
              ),
            ],
          ),
        ));
  }
}
