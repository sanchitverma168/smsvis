import 'package:flutter/material.dart';

class ViewContactsType extends StatefulWidget {
  const ViewContactsType({Key key}) : super(key: key);

  @override
  _ViewContactsTypeState createState() => _ViewContactsTypeState();
}

class _ViewContactsTypeState extends State<ViewContactsType> {
  @override
  Widget build(BuildContext context) {
    // final qsp = Provider.of<QuickSendProvider>(context, listen: false);

    return Container(
      height: MediaQuery.of(context).size.height * 0.125,
      child: Card(
        elevation: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            OutlineButton(
              onPressed: () {},
              child: Text("User Typed"),
            ),
            OutlineButton(onPressed: () {}, child: Text("CSV File")),
            OutlineButton(
              onPressed: () {},
              child: Text("Phone"),
            )
          ],
        ),
      ),
    );
  }
}
