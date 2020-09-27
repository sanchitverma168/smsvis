import 'package:flutter/material.dart';

class LoadingDisplayReport extends StatelessWidget {
  const LoadingDisplayReport({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [CircularProgressIndicator(), Text("Fetching Data")],
      ),
    );
  }
}
