import 'package:Smsvis/providers/quicksendprovider.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:Smsvis/utils/sharedpreference.dart';
import 'package:Smsvis/utils/validateform.dart';
import 'package:Smsvis/widgets/quicksend/displayContentdata.dart';
import 'package:Smsvis/widgets/quicksend/error.dart';
import 'package:Smsvis/widgets/quicksend/importContacts.dart';
import 'package:Smsvis/widgets/quicksend/inputchip.dart';
import 'package:Smsvis/widgets/quicksend/selectsenderid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MessageSendPage extends StatefulWidget {
  MessageSendPage({Key key}) : super(key: key);

  @override
  _MessageSendPageState createState() => _MessageSendPageState();
}

class _MessageSendPageState extends State<MessageSendPage> {
  final GlobalKey<FormState> _quicksend = GlobalKey<FormState>();
  final GlobalKey<FormState> _addnumberkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final qsp = Provider.of<QuickSendProvider>(context, listen: false);
    var number;
    String usermessage;
    var inputDecoration =
        new InputDecoration(filled: true, fillColor: Colors.white);
    Timer searchOnStoppedTyping;
    addcontacttolist() async {
      var formdata = _addnumberkey.currentState;
      if (formdata.validate()) {
        await Provider.of<QuickSendProvider>(context, listen: false)
            .addContact(number);
        _addnumberkey.currentState.reset();
      }
    }

    sendsms() async {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      // return;
      final form = _quicksend.currentState;
      if (qsp.isContactlistempty()) {
        qsp.errortext = "Please Enter Atleast 1 Number";
        qsp.seterror(true);
        return;
      }
      if (qsp.sender == qsp.senderid.first) {
        qsp.errortext = "Select Sender ID";
        qsp.seterror(true);
        return;
      }
      if (!form.validate()) {
        qsp.errortext = "Please Type Message";
        qsp.seterror(true);
        return;
      }
      String u = await SharedData().username;
      String p = await SharedData().password;
      String number =
          await Provider.of<QuickSendProvider>(context, listen: false)
              .convertcontacttoplusformat();
      print(number);
      await Provider.of<QuickSendProvider>(context, listen: false)
          .sendmessage(qsp.sender, usermessage, p, number, u);

      return;
    }

    return Consumer<QuickSendProvider>(builder: (context, user, child) {
      // return SafeArea(child: QuickSendNew());
      return SafeArea(
          child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  if (qsp.error) ErrorText(),
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Form(
                            key: _addnumberkey,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                QuickSendIcon(Icons.phone),
                                Expanded(
                                    flex: 1,
                                    child: TextFormField(
                                      keyboardType: TextInputType.phone,
                                      validator: (value) {
                                        if (value.isEmpty)
                                          return "Please Enter Mobile Number ";
                                        number = int.parse(value.trim());
                                        return Validate.number(
                                            number, qsp.contacts);
                                      },
                                      cursorColor: Colors.red,
                                      decoration: inputDecoration,
                                      maxLines: 1,
                                    )),
                                IconButton(
                                    icon: Icon(Icons.clear),
                                    onPressed: () {
                                      _addnumberkey.currentState.reset();
                                    }),
                                RaisedButton(
                                  onPressed: () {
                                    addcontacttolist();
                                  },
                                  child: Text(
                                    "Add",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  color: Colors.white,
                                  splashColor: Colors.deepOrange,
                                )
                              ],
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              QuickSendIcon(Icons.assignment_ind),
                              Expanded(flex: 1, child: SelectSenderId()),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              QuickSendIcon(Icons.message),
                              Expanded(
                                  flex: 1,
                                  child: Form(
                                    key: _quicksend,
                                    child: TextFormField(
                                      onChanged: (value) {
                                        const duration = Duration(
                                            milliseconds:
                                                1000); // set the duration that you want call search() after that.
                                        if (searchOnStoppedTyping != null) {
                                          setState(() => searchOnStoppedTyping
                                              .cancel()); // clear timer
                                        }
                                        setState(() => searchOnStoppedTyping =
                                                new Timer(duration, () {
                                              qsp.onChangedMessageValue(value);
                                            }));
                                        // qsp.onChangedMessageValue(value);
                                      },
                                      validator: (value) {
                                        if (value.isEmpty)
                                          return "Please Type Message ";
                                        usermessage = value.trim();
                                        return null;
                                      },
                                      decoration: inputDecoration,
                                      maxLines: 3,
                                      keyboardType: TextInputType.multiline,
                                    ),
                                  )),
                              IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () {
                                    _quicksend.currentState.reset();
                                  }),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: <Widget>[
                                DisplayContentData("Messages", qsp.msgCount),
                                DisplayContentData("Characters", qsp.charleft),
                                Divider(),
                                DisplayContentData(
                                    "Contacts Added", qsp.contacts.length),
                                DisplayContentData(
                                    "File Contacts", qsp.filecontacts.length),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: SingleChildScrollView(
                          child: InputChipWidget(qsp.contacts))),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            qsp.showimportbutton == true ? ImportContacts() : SizedBox(),
            Padding(
              padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: new FloatingActionButton(
                backgroundColor: QuickSendProvider().scolor,
                heroTag: "abbb",
                child: Icon(
                  Icons.send,
                  // color: Colors.deepOrange,
                ),
                onPressed: () {
                  sendsms();
                  // _senddata(user.contacts);
                },
                splashColor: Colors.white,
              ),
            ),
            new FloatingActionButton(
              heroTag: "aaaa",
              backgroundColor: QuickSendProvider().scolor,
              onPressed: () {
                qsp.showimportbutton = !qsp.showimportbutton;
              },
              child: qsp.showimportbutton == true
                  ? Icon(Icons.close)
                  : Icon(Icons.add),
              splashColor: Colors.white,
            )
          ],
        ),
      ));
    });
  }
}

class QuickSendIcon extends StatelessWidget {
  final IconData ic;
  QuickSendIcon(this.ic, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.0, right: 4.0),
      child: Icon(
        ic,
        color: QuickSendProvider().scolor,
      ),
    );
  }
}
