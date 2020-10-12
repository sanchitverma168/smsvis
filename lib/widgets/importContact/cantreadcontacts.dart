import 'package:Smsvis/utils/stringtext.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';

class CantReadContacts extends StatelessWidget {
  const CantReadContacts({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: GestureDetector(
          onHorizontalDragDown: (details) {},
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    TextData.cantReadContactsPleaseEnablePermission,
                    style: TextStyle(color: Colors.red),
                  ),
                  Text(TextData.pulldownToRefresh),
                  OutlineButton(
                    child: Text(TextData.appSettings),
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
