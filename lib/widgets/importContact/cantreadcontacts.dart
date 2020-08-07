import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';

class CantReadContacts extends StatelessWidget {
  const CantReadContacts({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: GestureDetector(
          onHorizontalDragDown: (details) {
            print("updating Screen");
            // permission();
          },
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Can't Read Contacts Please Enable Permission from Settings",
                    style: TextStyle(color: Colors.red),
                  ),
                  Text('Pull Down to Refresh'),
                  OutlineButton(
                    child: Text("App Settings"),
                    onPressed: () {
                      AppSettings.openAppSettings();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
