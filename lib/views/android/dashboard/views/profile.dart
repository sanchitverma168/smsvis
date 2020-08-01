import 'package:Smsvis/widgets/profile/communicationdetails.dart';
import 'package:Smsvis/widgets/profile/personaldetails.dart';
import 'package:Smsvis/widgets/profile/rowContent.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  Profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
            child: Center(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        elevation: 2,
                        child: Column(children: <Widget>[
                          PersonalDetails(),
                          CommunicationDetails(),
                          SizedBox(height: 20),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RowContent([
                                OutlineButton(
                                  onPressed: null,
                                  child: Text("Update"),
                                ),
                                OutlineButton(
                                  onPressed: null,
                                  child: Text("Cancel"),
                                )
                              ], [
                                1,
                                1
                              ]))
                        ]))))));
  }
}
