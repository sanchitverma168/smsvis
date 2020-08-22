import 'package:Smsvis/providers/importContact.dart';
import 'package:Smsvis/providers/quicksendprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomTools extends StatefulWidget {
  const BottomTools({Key key}) : super(key: key);

  @override
  _BottomToolsState createState() => _BottomToolsState();
}

class _BottomToolsState extends State<BottomTools> {
  @override
  Widget build(BuildContext context) {
    final qsp = Provider.of<QuickSendProvider>(context, listen: false);
    final ic = Provider.of<ImportContact>(context, listen: false);

    return Container(
      height: MediaQuery.of(context).size.height * 0.125,
      child: Card(
        elevation: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            OutlineButton(
              onPressed: () {
                qsp.getbacktosendmessageScreen();
              },
              child: Text("Cancel"),
            ),
            if (ic.screenContent == ScreenContent.isDeviceContacts ||
                ic.screenContent == ScreenContent.isSearchContacts)
              OutlineButton(
                  onPressed: () {
                    // toggleSelectAll();
                    ic.toggleSelectAll();
                  },
                  child: ic.selectAllContacts == false
                      ? Text("Select All")
                      : Text("UnSelect All")),
            if (ic.screenContent == ScreenContent.isDeviceContacts ||
                ic.screenContent == ScreenContent.isSearchContacts)
              OutlineButton(
                onPressed: () {
                  var sContacts = ic.deviceContacts;
                  // print("1");
                  // convertnumbertostring();
                  for (int i = 0; i < sContacts.length; i++) {
                    // print("2");
                    if (ic.selectedContactsindex[i] == 1) {
                      // print("3");
                      if (sContacts[i].phones.toList().length != 0) {
                        String name = sContacts[i].displayName;
                        String number =
                            sContacts[i].phones.toList().first.value;
                        qsp.addcontacttolcontacts(
                            name: name,
                            number: number,
                            type: ContactType.isphone.toString());
                        qsp.phoneContacts = 1;
                      }
                      // print("4");
                      // print("5");
                    }
                    // print("6");
                  }
                  // print("7");

                  // for (int i = 0; i < selectedContacts.length; i++)
                  //   qsp.addContact(
                  //       selectedContacts[i].phones.toList().first.value,
                  //       name: selectedContacts[i].displayName,
                  //       notify: false);
                  // qsp.removeextracharfromnumbr();
                  qsp.getbacktosendmessageScreen();
                  // print("8");
                },
                child: Text("Import"),
              )
          ],
        ),
      ),
    );
  }
}
