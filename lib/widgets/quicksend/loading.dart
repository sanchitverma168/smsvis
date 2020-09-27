import 'package:flutter/material.dart';

class LoadingMessageSendPage extends StatelessWidget {
  const LoadingMessageSendPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            backgroundColor: Colors.deepOrange,
          ),
          Text("Fetching Sender ID From Our Servers...")
        ],
      ),
    );
  }
}
