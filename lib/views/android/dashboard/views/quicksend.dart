import 'package:Smsvis/providers/quicksendprovider.dart';
import 'package:Smsvis/widgets/quicksend/msgSendpage.dart';
import 'package:Smsvis/widgets/quicksend/returnContact.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class QuickSend extends StatelessWidget {
  QuickSend({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<QuickSendProvider>(builder: (context, user, child) {
      switch (user.display) {
        case Display.PHONECONTACTS:
          return ReturnContactQuickSendWidget();
        case Display.SENDMESSAGE:
          return MessageSendPage();
        default:
          return MessageSendPage();
      }
    });
  }
}
