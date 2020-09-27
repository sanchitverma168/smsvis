import 'package:Smsvis/providers/quicksendprovider_v2.dart';
import 'package:Smsvis/utils/stringtext.dart';
import 'package:Smsvis/widgets/quicksend/displayContentdata.dart';
import 'package:Smsvis/widgets/quicksendv2/error.dart';
import 'package:Smsvis/widgets/quicksendv2/importContacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MessageSend extends StatefulWidget {
  MessageSend({Key key}) : super(key: key);

  @override
  _MessageSend createState() => _MessageSend();
}

class _MessageSend extends State<MessageSend> {
  Future<bool> hideKeyboard() async {
    await SystemChannels.textInput.invokeMethod('TextInput.hide');
    return true;
  }

  // bool _keyboardIsVisible() {
  //   return (MediaQuery.of(context).viewInsets.bottom == 0.0);
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuickSendProviderV2>(builder: (context, user, child) {
      return Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            user.showimportbutton == true ? ImportContacts() : SizedBox(),
            Padding(
              padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
              child: new FloatingActionButton(
                backgroundColor: QuickSendProviderV2().scolor,
                heroTag: "abbb",
                child: Icon(
                  Icons.send,
                ),
                onPressed: () async {
                  await hideKeyboard();

                  user.validateContainer(context, user);
                },
                splashColor: Colors.white,
              ),
            ),
            new FloatingActionButton(
              heroTag: "aaaa",
              backgroundColor: QuickSendProviderV2().scolor,
              onPressed: () {
                hideKeyboard();
                user.showimportbutton = !user.showimportbutton;
              },
              child: user.showimportbutton == true
                  ? Icon(Icons.close)
                  : Icon(Icons.add),
              splashColor: Colors.white,
            )
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (user.error) ErrorText(),
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Center(child: Text(TextData.noteMessageSendPage)),
                          Form(
                            key: user.addnumberkey,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                QuickSendIcon(Icons.phone),
                                Expanded(
                                    flex: 1,
                                    child: TextFormField(
                                      onTap: () {
                                        if (user.showimportbutton)
                                          user.showimportbutton =
                                              !user.showimportbutton;
                                      },
                                      keyboardType: TextInputType.phone,
                                      onSaved: (newValue) {
                                        user.inputMobileData = newValue;
                                      },
                                      onChanged: (value) {
                                        user.error = false;
                                      },
                                      cursorColor: Colors.red,
                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText: TextData.enterNumberhere),
                                      maxLines: 1,
                                    )),
                                IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () {
                                    user.inputMobileData = null;
                                    user.addnumberkey.currentState.reset();
                                  },
                                )
                              ],
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              QuickSendIcon(Icons.message),
                              Expanded(
                                  flex: 1,
                                  child: Form(
                                    key: user.quicksend,
                                    child: TextFormField(
                                      onTap: () {
                                        if (user.showimportbutton)
                                          user.showimportbutton =
                                              !user.showimportbutton;
                                      },
                                      onSaved: (value) {
                                        user.usermessage = value;
                                      },
                                      onChanged: (value) {
                                        user.onChangeMessageValueTimer(value);
                                      },
                                      validator: (value) {
                                        if (value.isEmpty)
                                          return TextData.typeMessage;
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText: TextData.enterMessageHere),
                                      maxLines: 2,
                                      keyboardType: TextInputType.multiline,
                                    ),
                                  )),
                              IconButton(
                                  icon: Icon(Icons.clear),
                                  onPressed: () {
                                    user.quicksend.currentState.reset();
                                    user.charleftReset(notify: false);
                                    user.msgCountReset();
                                  }),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: <Widget>[
                                if (user.msgCount != 0)
                                  DisplayContentData(
                                      TextData.messages, user.msgCount),
                                if (user.charleft != 0)
                                  DisplayContentData(
                                      TextData.characters, user.charleft),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Wrap(children: [
                    if (user.phonenumbersLength != 0)
                      RawChip(
                          label: Text(TextData.phoneNumber +
                              user.phonenumbersLength.toString())),
                    if (user.filenumbersLength != 0)
                      RawChip(
                          label: Text(TextData.fileNumber +
                              user.filenumbersLength.toString())),
                    if (user.phonenumbersLength != 0 ||
                        user.filenumbersLength != 0)
                      RawChip(
                          label: Text(TextData.totalContacts +
                              (user.phonenumbersLength + user.filenumbersLength)
                                  .toString())),
                  ]),
                ],
              ),
            ),
          ),
        ),
      );
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
        color: QuickSendProviderV2().scolor,
      ),
    );
  }
}
