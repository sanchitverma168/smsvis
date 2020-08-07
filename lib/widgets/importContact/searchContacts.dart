import 'package:Smsvis/providers/importContact.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchContacts extends StatelessWidget {
  const SearchContacts({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImportContact importContacts =
        Provider.of<ImportContact>(context, listen: false);
    var contacts = importContacts.showContacts;
    var indexS = importContacts.searchContactsIndex;
    var selectecContact = importContacts.selectedContactsindex;
    // print("SearchContacts");
    // var s = " ";
    // for (int i = 0; i < indexS.length; i++) s += indexS[i].toString() + " ";
    // print(s);
    // print("${indexS.length} index");
    // print("${selectecContact.length} selected");
    // print("${contacts.length} contacts");

    return ListView.builder(
      itemCount: contacts?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: 4,
          child: ListTile(
            onTap: () {
              importContacts.updateindex(indexS[index]);
            },
            leading: CircleAvatar(
                child: Text(contacts[index].displayName.substring(0, 1))),
            title: Text(contacts[index].displayName),
            trailing: selectecContact[indexS[index]] == 0
                ? SizedBox(child: Icon(Icons.check_circle_outline))
                : SizedBox(
                    child: Icon(Icons.check_circle, color: Colors.green)),
          ),
        );
      },
    );
  }
}
