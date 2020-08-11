import 'package:flutter/material.dart';
import '../blacklistNumberPage.dart';

class Settings extends StatelessWidget {
  const Settings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
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
            title: Text("Blacklist Numbers"),
            subtitle: Text("Numbers 0"),
          ),
        ],
      ),
    );
  }
}
