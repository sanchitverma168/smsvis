import 'package:Smsvis/providers/importContact.dart';
import 'package:Smsvis/providers/quicksendprovider_v2.dart';
import 'package:Smsvis/utils/colors.dart';
import 'package:Smsvis/utils/stringtext.dart';
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
    final qsp = Provider.of<QuickSendProviderV2>(context, listen: false);
    final ic = Provider.of<ImportContact>(context, listen: false);

    return Container(
      height: MediaQuery.of(context).size.height * 0.125,
      child: Card(
        elevation: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RaisedButton(
              color: UIColors.alertColor,
              onPressed: () {
                qsp.getbacktosendmessageScreen();
              },
              child: Text(
                TextData.cancel,
                style: TextStyle(color: Colors.white),
              ),
            ),
            if (ic.screenContent == ScreenContent.isDeviceContacts ||
                ic.screenContent == ScreenContent.isSearchContacts)
              OutlineButton(
                  onPressed: () {
                    ic.toggleSelectAll();
                  },
                  child: ic.selectAllContacts == false
                      ? Text(TextData.selectAll)
                      : Text(TextData.unselectAll)),
            if (ic.screenContent == ScreenContent.isDeviceContacts ||
                ic.screenContent == ScreenContent.isSearchContacts)
              RaisedButton(
                color: UIColors.successColor,
                onPressed: () {
                  var sContacts = ic.deviceContacts;
                  for (int i = 0; i < sContacts.length; i++) {
                    if (ic.selectedContactsindex[i] == 1) {
                      if (sContacts[i].phones.toList().length != 0) {
                        String number =
                            sContacts[i].phones.toList().first.value;
                        qsp.phonenumbers.add(
                          qsp.removeextraCharFromNumber(number),
                        );
                      }
                    }
                  }

                  qsp.getbacktosendmessageScreen();
                },
                child: Text(
                  TextData.import,
                  style: TextStyle(color: Colors.white),
                ),
              )
          ],
        ),
      ),
    );
  }
}
