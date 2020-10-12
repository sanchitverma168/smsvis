import 'package:Smsvis/providers/importContact.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeviceContacts extends StatelessWidget {
  const DeviceContacts({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImportContact importContacts =
        Provider.of<ImportContact>(context, listen: false);
    var contacts = importContacts.showContacts;
    var selectedindex = importContacts.selectedContactsindex;

    return ListView.builder(
      itemCount: contacts?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        if (contacts[index].displayName != null) {
          return Card(
            elevation: 4,
            child: ListTile(
              onTap: () {
                importContacts.updateindex(index);
              },
              leading: CircleAvatar(
                child: Text(
                  contacts[index].displayName.substring(0, 1),
                ),
              ),
              title: Text(contacts[index].displayName),
              trailing: selectedindex[index] == 0
                  ? SizedBox(
                      child: Icon(Icons.check_circle_outline),
                    )
                  : SizedBox(
                      child: Icon(Icons.check_circle, color: Colors.green),
                    ),
            ),
          );
        }
        return Card();
      },
    );
  }
}
