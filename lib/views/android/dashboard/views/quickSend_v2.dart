import 'package:Smsvis/providers/importContact.dart';
import 'package:Smsvis/providers/quicksendprovider_v2.dart';
import 'package:Smsvis/widgets/quicksendv2/returnContact.dart';
import 'package:Smsvis/widgets/quicksendv2/messagesend.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuickSendV2 extends StatelessWidget {
  const QuickSendV2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<QuickSendProviderV2>(builder: (context, value, child) {
      switch (value.display) {
        case Display.PHONECONTACTS:
          return ChangeNotifierProvider(
            create: (context) => ImportContact(),
            child: ReturnContactQuickSendWidget(),
          );
        case Display.SENDMESSAGE:
          return MessageSend();
        default:
          return MessageSend();
      }
    });
  }
}
