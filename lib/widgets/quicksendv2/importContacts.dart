import 'package:Smsvis/providers/quicksendprovider_v2.dart';
import 'package:Smsvis/utils/colors.dart';
import 'package:Smsvis/views/android/contacts/viewfavouritelist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImportContacts extends StatelessWidget {
  ImportContacts({Key key}) : super(key: key);
  final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
      side: BorderSide(color: Colors.white));
  final color = UIColors.fcolor;
  @override
  Widget build(BuildContext context) {
    final qsp = Provider.of<QuickSendProviderV2>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        new RaisedButton(
          onPressed: () {
            qsp.resetform();
          },
          child: Text(
            "Reset",
          ),
          shape: shape,
          color: color,
        ),
        new RaisedButton(
            clipBehavior: Clip.antiAlias,
            shape: shape,
            color: color,
            onPressed: () {
              qsp.showimportbutton = !qsp.showimportbutton;
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => SaveContacts(qsp.contacts)));
            },
            child: Text(
              "Save Contacts",
            )),
        new RaisedButton(
            clipBehavior: Clip.antiAlias,
            shape: shape,
            color: color,
            onPressed: () async {
              qsp.showimportbutton = !qsp.showimportbutton;
              await qsp.importCSVFILE(context);
            },
            child: Text(
              "Import CSV File",
            )),
        new RaisedButton(
            clipBehavior: Clip.antiAlias,
            shape: shape,
            color: color,
            onPressed: () async {
              qsp.showimportbutton = !qsp.showimportbutton;
              await qsp.getcontactsfromphone(context);
            },
            child: Text(
              "Import from Phone",
            )),
        new RaisedButton(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.white)),
            color: UIColors.fcolor,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FavouriteListView()));
            },
            child: Text(
              "Favourite Contacts",
            )),
      ],
    );
  }
}
