import 'package:flutter/material.dart';
import 'rowContent.dart';

enum Gender { Male, Female }

// ignore: must_be_immutable
class PersonalDetails extends StatelessWidget {
  PersonalDetails({Key key}) : super(key: key);
  DateTime selectedDate = DateTime.now();
  Future<Null> getdate(BuildContext context) async {
    final DateTime dt = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1960),
        lastDate: DateTime(2260));
    if (dt != null && dt != selectedDate) {
      selectedDate = dt;
      print("$dt");
      print("$selectedDate");
    }
  }

  @override
  Widget build(BuildContext context) {
    String g;
    Gender _gender = Gender.Male;
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Column(children: <Widget>[
        SizedBox(height: 10),
        Text("Personal Details"),
        Divider(),
        RowContent([Text("Title"), TextField()], [1, 2]),
        RowContent([Text("First Name"), TextField()], [1, 2]),
        RowContent([Text("Last Name"), TextField()], [1, 2]),
        RowContent([
          Text("Gender"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Radio(
                value: "Male",
                groupValue: _gender,
                onChanged: (value) {
                  g = value;
                },
                activeColor: Colors.lime,
              ),
              Text("Male"),
              Radio(
                value: "Female",
                groupValue: g,
                onChanged: (value) {
                  g = value;
                },
                activeColor: Colors.lime,
              ),
              Text("Female"),
            ],
          ),
        ], [
          1,
          2
        ]),
        RowContent([
          Text("Select DOB"),
          TextFormField(
              initialValue: "${selectedDate.toLocal()}".split(' ')[0],
              onTap: () {
                getdate(context);
              }),
          FlatButton(
            child: Text("Select\nDate"),
            onPressed: null,
          )
        ], [
          1,
          2,
          1
        ])
      ]),
    );
  }
}
