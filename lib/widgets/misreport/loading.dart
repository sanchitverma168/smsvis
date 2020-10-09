import 'package:flutter/material.dart';

class LoadingMISReport extends StatelessWidget {
  const LoadingMISReport({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [CircularProgressIndicator(), Text("Fetching Data")],
      ),
    );
  }
}
