import 'package:Smsvis/providers/handle_main_drawer_activity.dart';
import 'package:Smsvis/providers/routehandler.dart';
import 'package:Smsvis/utils/animation.dart';
import 'package:Smsvis/utils/colors.dart';
import 'package:Smsvis/utils/stringtext.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class SideDrawer extends StatefulWidget {
  SideDrawer({Key key}) : super(key: key);
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> with TickerProviderStateMixin {
  String c;
  AnimationController helpanimationController;
  ConnectivityResult rh;

  @override
  void initState() {
    rh = Provider.of<RouteHandler>(context, listen: false).connecitivityResult;
    super.initState();
    helpanimationController =
        AnimationController(duration: const Duration(seconds: 5), vsync: this)
          ..repeat();
  }

  @override
  void dispose() {
    helpanimationController.dispose();
    super.dispose();
  }

  getpage(PageControl page, BuildContext context) async {
    if (rh == ConnectivityResult.none) {
      Toast.show(TextData.noInternetConnection, context);
      print("toast");
    } else {
      Navigator.pop(context);
      print("function");
      await Provider.of<HandleDrawerActivity>(context, listen: false)
          .swtichpage(page);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(rh);
    return Consumer<HandleDrawerActivity>(builder: (context, user, child) {
      return Container(
        child: Drawer(
          child: Stack(children: [
            ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Row(
                    children: [
                      Image.asset(TextData.app_logo),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              TextData.welcome,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 18.0),
                            child: Text(
                              user.username,
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    gradient: rh == ConnectivityResult.none
                        ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.blueGrey, Colors.grey],
                          )
                        : LinearGradient(
                            colors: RouteHandler().maincolor,
                          ),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        TextData.creditLeft + ": " + user.credit,
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        tooltip: TextData.checkForCreditLeft,
                        icon: Icon(Icons.refresh),
                        onPressed: () {
                          if (rh == ConnectivityResult.none) {
                            Toast.show(TextData.noInternetConnection, context);
                            print("toast");
                          } else {
                            user.fetchCredit();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                ExpansionTile(
                  leading: Icon(Icons.message),
                  title: Text(TextData.sms),
                  children: <Widget>[
                    ListTile(
                      title: Text(TextData.quickSendSMS),
                      onTap: () {
                        getpage(PageControl.QUICK_SEND, context);
                      },
                    )
                  ],
                ),
                ExpansionTile(
                  leading: Icon(Icons.report),
                  title: Text(TextData.reports),
                  children: <Widget>[
                    ListTile(
                      title: Text(TextData.currentDayMis),
                      onTap: () {
                        getpage(PageControl.CURRENT_DAY_MIS, context);
                      },
                    ),
                    ListTile(
                      title: Text(TextData.misReport),
                      onTap: () {
                        getpage(PageControl.MIS_REPORT, context);
                      },
                    ),
                  ],
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text(TextData.logOut),
                  onTap: () async {
                    await Provider.of<RouteHandler>(context, listen: false)
                        .logout();
                  },
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedBuilder(
                animation: helpanimationController,
                builder: (context, child) {
                  return Container(
                    color: backgroundOnQuickSendSmsPageHelp.evaluate(
                      AlwaysStoppedAnimation(
                        helpanimationController.value,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(TextData.help24x7),
                        FlatButton(
                          onPressed: () async {
                            String url = "tel:" + TextData.helpNumber;
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {}
                          },
                          child: Row(
                            children: [
                              QuickSendIcon(
                                Icons.call,
                                iconColor: Colors.white,
                              ),
                              Text(
                                TextData.helpNumber,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ]),
        ),
      );
    });
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
