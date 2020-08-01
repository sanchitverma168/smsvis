import 'package:flutter/material.dart';
import '../widgets/profile/personaldetails.dart';
import '../widgets/profile/communicationdetails.dart';
import '../widgets/profile/rowContent.dart';

class NewProfile extends StatelessWidget {
  NewProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 10,
          child: Column(
            children: <Widget>[
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
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
