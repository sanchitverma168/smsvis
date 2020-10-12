import 'package:Smsvis/providers/quicksendprovider_v2.dart';
import 'package:Smsvis/utils/colors.dart';
import 'package:Smsvis/utils/stringtext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImportContacts extends StatelessWidget {
  ImportContacts({Key key}) : super(key: key);
  final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
      side: BorderSide(color: Colors.white));
  final color = Colors.white;
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
          child: Text(TextData.reset, style: TextStyle(color: color)),
          shape: shape,
          color: UIColors.alertColor,
        ),
        new RaisedButton(
          clipBehavior: Clip.antiAlias,
          shape: shape,
          color: color,
          onPressed: () async {
            qsp.showimportbutton = !qsp.showimportbutton;
            await qsp.importCSVFILE(context);
          },
          child: Text(
            TextData.importCSVFile,
            style: TextStyle(
              color: UIColors.scolor,
            ),
          ),
        ),
        new RaisedButton(
          clipBehavior: Clip.antiAlias,
          shape: shape,
          color: color,
          onPressed: () async {
            qsp.showimportbutton = !qsp.showimportbutton;
            await qsp.getcontactsfromphone(context);
          },
          child: Text(
            TextData.importFromPhone,
            style: TextStyle(
              color: UIColors.scolor,
            ),
          ),
        ),
      ],
    );
  }
}
