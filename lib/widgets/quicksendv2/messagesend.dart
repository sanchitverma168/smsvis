import 'package:Smsvis/providers/handle_main_drawer_activity.dart';
import 'package:Smsvis/providers/quicksendprovider_v2.dart';
import 'package:Smsvis/providers/routehandler.dart';
import 'package:Smsvis/utils/colors.dart';
import 'package:Smsvis/utils/stringtext.dart';
import 'package:Smsvis/widgets/quicksendv2/displayContentdata.dart';
import 'package:Smsvis/widgets/quicksendv2/error.dart';
import 'package:Smsvis/widgets/quicksendv2/importContacts.dart';
import 'package:Smsvis/widgets/quicksendv2/viewContacts.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class MessageSend extends StatefulWidget {
  MessageSend({Key key}) : super(key: key);

  @override
  _MessageSend createState() => _MessageSend();
}

class _MessageSend extends State<MessageSend> with TickerProviderStateMixin {
  AnimationController helpanimationController;

  Future<bool> hideKeyboard() async {
    await SystemChannels.textInput.invokeMethod(TextData.textinputHide);
    return true;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuickSendProviderV2>(
      builder: (context, user, child) {
        if (user.messageSentSuccessfully) {
          user.messageSentSuccessfully = false;
          Provider.of<HandleDrawerActivity>(context, listen: false)
              .fetchCredit();
        }
        return Scaffold(
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              user.showimportbutton == true ? ImportContacts() : SizedBox(),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                child: new FloatingActionButton(
                    backgroundColor:
                        Provider.of<RouteHandler>(context, listen: false)
                                    .connecitivityResult ==
                                ConnectivityResult.none
                            ? Colors.grey
                            : UIColors.orangeJelly,
                    heroTag: TextData.heroTag[0],
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      await hideKeyboard();
                      if (Provider.of<RouteHandler>(context, listen: false)
                              .connecitivityResult ==
                          ConnectivityResult.none) {
                        Toast.show(TextData.noInternetConnection, context);
                        print(TextData.blacklistedNumbers);
                      } else
                        user.validateContainer(context, user);
                    },
                    splashColor: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                    child: new FloatingActionButton(
                      heroTag: TextData.heroTag[4],
                      backgroundColor: Colors.white,
                      onPressed: () {},
                      child: InputChip(
                        backgroundColor: Colors.white,
                        label: Icon(
                          Icons.remove_red_eye,
                          color: user.viewContactonQuickSendPage == true
                              ? UIColors.scolor
                              : Colors.black,
                        ),
                        onPressed: () {
                          if (user.showimportbutton)
                            user.showimportbutton = !user.showimportbutton;
                          user.viewContactonQuickSendPage =
                              !user.viewContactonQuickSendPage;
                          user.updateScreen();
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                    child: new FloatingActionButton(
                      heroTag: TextData.heroTag[1],
                      backgroundColor: Colors.white,
                      onPressed: () {
                        hideKeyboard();
                        user.showimportbutton = !user.showimportbutton;
                      },
                      child: user.showimportbutton == true
                          ? Icon(
                              Icons.close,
                              color: UIColors.scolor,
                            )
                          : Icon(Icons.add, color: UIColors.scolor),
                      splashColor: Colors.white,
                    ),
                  ),
                ],
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
                            Center(
                              child: Container(
                                margin: EdgeInsets.all(8.0),
                                child: Text(
                                  TextData.noteMessageSendPage,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Divider(),
                            Form(
                              key: user.addnumberkey,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  QuickSendIcon(Icons.phone),
                                  Expanded(
                                    flex: 1,
                                    child: Stack(
                                      children: [
                                        TextFormField(
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
                                              border: InputBorder.none,
                                              filled: true,
                                              fillColor: Color(0xfff3f3f4),
                                              hintText:
                                                  TextData.enterNumberhere),
                                          maxLines: 1,
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.clear,
                                            ),
                                            onPressed: () {
                                              user.inputMobileData = null;
                                              user.addnumberkey.currentState
                                                  .reset();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                QuickSendIcon(Icons.message),
                                Expanded(
                                  flex: 1,
                                  child: Form(
                                    key: user.quicksend,
                                    child: Stack(
                                      children: [
                                        TextFormField(
                                          onTap: () {
                                            if (user.showimportbutton)
                                              user.showimportbutton =
                                                  !user.showimportbutton;
                                          },
                                          onSaved: (value) {
                                            user.usermessage = value;
                                          },
                                          onChanged: (value) {
                                            user.onChangeMessageValueTimer(
                                                value);
                                          },
                                          validator: (value) {
                                            if (value.isEmpty)
                                              return TextData.typeMessage;
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              filled: true,
                                              fillColor: Color(0xfff3f3f4),
                                              hintText:
                                                  TextData.enterMessageHere),
                                          maxLines: 2,
                                          keyboardType: TextInputType.multiline,
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: IconButton(
                                            icon: Icon(Icons.clear),
                                            onPressed: () {
                                              user.quicksend.currentState
                                                  .reset();
                                              user.charleftReset(notify: false);
                                              user.msgCountReset();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
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
                    if (user.phonenumbersLength != 0 ||
                        user.filenumbersLength != 0)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            RawChip(
                                label: Text(TextData.phoneNumber +
                                    user.phonenumbersLength.toString())),
                            RawChip(
                                label: Text(TextData.fileNumber +
                                    user.filenumbersLength.toString())),
                            RawChip(
                                label: Text(TextData.totalContacts +
                                    (user.phonenumbersLength +
                                            user.filenumbersLength)
                                        .toString())),
                          ],
                        ),
                      ),
                    if (user.viewContactonQuickSendPage)
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: ViewContacts(TextData.phoneNumber)),
                          Expanded(
                              flex: 1,
                              child: ViewContacts(TextData.fileNumber)),
                        ],
                      )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class QuickSendIcon extends StatelessWidget {
  final IconData ic;
  final Color iconColor;
  QuickSendIcon(this.ic, {this.iconColor = UIColors.scolor, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 4.0, right: 4.0),
      child: Icon(ic, color: iconColor),
    );
  }
}
