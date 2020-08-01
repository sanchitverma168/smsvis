import 'package:flutter/material.dart';

class General extends StatefulWidget {
  General({Key key}) : super(key: key);

  @override
  _GeneralState createState() => _GeneralState();
}

Widget senderid() {
  return Row(
    children: [
      Expanded(
          flex: 3,
          child: TextFormField(
            decoration: InputDecoration(hintText: "Type Sender ID"),
          )),
      Expanded(
        flex: 1,
        child: OutlineButton(
          onPressed: () {},
          splashColor: Color(0xfffbb448),
          child: Icon(Icons.add),
        ),
      ),
    ],
  );
}

Widget signature() {
  return Column(
    children: [
      // Text("Add Signature to all outgoing messages"),
      SizedBox(
        height: 20,
      ),
      TextFormField(
        maxLines: 3,
        decoration:
            InputDecoration(hintText: "Add Signature to all outgoing messages"),
      ),
      FlatButton(
        splashColor: Color(0xfffbb448),
        onPressed: () {},
        child: Text("Add Signature"),
      )
    ],
  );
}

Widget password() {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Card(
        elevation: 10,
        child: Column(
          children: [
            Text("Don't use '<','>', \" \'  "),
            ListTile(
              title: Row(
                children: [
                  Expanded(flex: 1, child: Text("Old Password")),
                  Expanded(
                    flex: 1,
                    child: TextFormField(),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Expanded(flex: 1, child: Text("New Password")),
                  Expanded(
                    flex: 1,
                    child: TextFormField(),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                children: [
                  Expanded(flex: 1, child: Text("Confirm Password")),
                  Expanded(
                    flex: 1,
                    child: TextFormField(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton(onPressed: null, child: Text("Save"))
          ],
        )),
  );
}

class _GeneralState extends State<General> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  senderid(),
                  SizedBox(height: 10),
                  signature(),
                  // password(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
