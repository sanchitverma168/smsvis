import 'package:Smsvis/models/api.dart';
import 'package:Smsvis/models/fetchallsendeerid.dart';
import 'package:Smsvis/providers/quicksendprovider_v2.dart';
import 'package:Smsvis/utils/sharedpreference.dart';
import 'package:Smsvis/utils/variables.dart';
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
    // print("1");
    if (!contentReady) {
      // print("1A");
      body = Container(
          child: Center(
              child: Column(children: [
        CircularProgressIndicator(),
        SizedBox(height: 20),
        Text("Fetching Id......")
      ])));
    } else if (contentReady == false && error == true) {
      // print("2");
      body = Container(
          child: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Can't Fetch SenerID"),
          FlatButton(
            child: Text("Ok"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      )));
    } else {
      // print("3");
      print(_selectedIndex);
      body = new Container(
        child: new SingleChildScrollView(
          child: new Column(
            children: [
              new Column(
                  children: new List<RadioListTile<int>>.generate(
                      senderid.length, (int index) {
                return new RadioListTile<int>(
                  value: index,
                  groupValue: _selectedIndex,
                  title: new Text(senderid[index].senderid),
                  onChanged: (int value) {
                    print("hello");
                    _selectedIndex = value;
                    print(_selectedIndex);
                    updateScreen();
                  },
                );
              })),
              OutlineButton(
                color: Colors.deepOrange,
                splashColor: Colors.deepOrange,
                child: Text("Send"),
                onPressed: () {
                  // var qspv2 =
                  //     Provider.of<QuickSendProviderV2>(context, listen: false);
                  widget.user.senderid = senderid[_selectedIndex].senderid;
                  widget.user.sendMessage();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      );
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
    // return Consumer<QuickSendProviderV2>(builder: (context, user, child) {
    //   return Container(height: h, width: w, child: body);
    // });
    return Container(height: h, width: w, child: body);
  }
}
