import 'package:Smsvis/models/api.dart';
import 'package:Smsvis/models/fetchallsendeerid.dart';
import 'package:Smsvis/providers/quicksendprovider_v2.dart';
import 'package:Smsvis/utils/colors.dart';
import 'package:Smsvis/utils/sharedpreference.dart';
import 'package:Smsvis/utils/stringtext.dart';
import 'package:Smsvis/utils/enum.dart';
import 'package:flutter/material.dart';

class FetchingIDAandShowAlertBox extends StatefulWidget {
  final QuickSendProviderV2 user;
  FetchingIDAandShowAlertBox(this.user, {Key key}) : super(key: key);

  @override
  _FetchingIDAandShowAlertBoxState createState() =>
      _FetchingIDAandShowAlertBoxState();
}

class _FetchingIDAandShowAlertBoxState
    extends State<FetchingIDAandShowAlertBox> {
  Widget body;
  bool contentReady, error = true;
  var senderid;

  int _selectedIndex = 0;
  @override
  void initState() {
    contentReady = false;
    updateScreen();
    getsenderid();
    super.initState();
  }

  updateScreen() {
    if (!contentReady) {
      body = Container(
        child: Center(
          child: Column(
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text(TextData.fetchingid),
            ],
          ),
        ),
      );
    } else if (contentReady == false && error == true) {
      body = Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(TextData.cantfetchid),
              FlatButton(
                child: Text(TextData.ok),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      );
    } else {
      body = new Container(
          child: new SingleChildScrollView(
              child: new Column(children: [
        Center(
          child: Card(
            color: UIColors.scolor,
            child: Container(
              margin: EdgeInsets.all(8.0),
              child: Text(
                TextData.selectSenderID,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        new Column(
          children: new List<RadioListTile<int>>.generate(
            senderid.length,
            (int index) {
              return new RadioListTile<int>(
                value: index,
                groupValue: _selectedIndex,
                title: new Text(senderid[index].senderid),
                onChanged: (int value) {
                  _selectedIndex = value;
                  print(_selectedIndex);
                  updateScreen();
                },
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlineButton(
                color: Colors.deepOrange,
                splashColor: Colors.deepOrange,
                child: Text(
                  TextData.send,
                  style: TextStyle(color: UIColors.alertColor),
                ),
                onPressed: () {
                  widget.user.senderid = senderid[_selectedIndex].senderid;
                  widget.user.sendMessage();
                  Navigator.pop(context);
                }),
            RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                TextData.cancel,
                style: TextStyle(color: Colors.white),
              ),
              color: UIColors.alertColor,
            )
          ],
        )
      ])));
    }
    setState(() {});
  }

  getsenderid() async {
    String username = await SharedData().username;
    var data;
    try {
      data = await API().fetchdata(username, TypeData.SenderID);
      senderid = senderIdFromMap(data);
      error = false;
      contentReady = true;
    } catch (e) {
      print(e.toString());
    } finally {
      if (data == null) {
        error = true;
        contentReady = false;
      }
      updateScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var h = size.height * 0.2, w = size.width * 0.5;
    if (contentReady && !error) {
      h = size.height * 0.7;
      w = size.width * 0.5;
    }
    return Container(height: h, width: w, child: body);
  }
}
