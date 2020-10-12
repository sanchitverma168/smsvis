import 'package:Smsvis/providers/quicksendprovider_v2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ErrorText extends StatelessWidget {
  ErrorText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final qsp = Provider.of<QuickSendProviderV2>(context, listen: false);
    return Card(
      elevation: 8,
      child: Container(
        color: qsp.errorColor,
        width: MediaQuery.of(context).size.width,
        child: ListTile(
          title: Center(
            child: Text(
              qsp.errortext,
              style: TextStyle(color: Colors.white),
            ),
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              qsp.error = false;
            },
          ),
        ),
      ),
    );
  }
}
