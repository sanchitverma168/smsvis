import 'package:Smsvis/utils/stringtext.dart';
import 'package:flutter/material.dart';
import '../blacklistNumberPage.dart';

class Settings extends StatelessWidget {
  const Settings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TextData.settings),
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlacklistNumberPage(),
                  ));
            },
            leading: Icon(Icons.block),
            title: Text(TextData.blacklistedNumbers),
            subtitle: Text(TextData.numbers + " 0"),
          ),
        ],
      ),
    );
  }
}
