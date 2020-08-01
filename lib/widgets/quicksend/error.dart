import 'package:Smsvis/providers/quicksendprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ErrorText extends StatelessWidget {
  ErrorText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final qsp = Provider.of<QuickSendProvider>(context, listen: false);
    return Card(
      elevation: 8,
      child: Container(
        color: qsp.errorColor,
        // height: MediaQuery.of(context).size.height * 0.05,
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
              }),
        ),
      ),
    );
  }
}
