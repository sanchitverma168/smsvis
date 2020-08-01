import 'package:flutter/material.dart';
import 'package:Smsvis/widgets/getdate.dart';

class DownloadCentre extends StatelessWidget {
  const DownloadCentre({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          GetDate(),
          SingleChildScrollView(
            child: Text("No data available"),
          ),
        ],
      ),
    );
  }
}
