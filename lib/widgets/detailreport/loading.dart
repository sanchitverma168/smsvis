import 'package:flutter/material.dart';

class LoadingDetailReport extends StatelessWidget {
  const LoadingDetailReport({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [CircularProgressIndicator(), Text("Fetching Data")],
      ),
    );
  }
}
