import 'package:Smsvis/models/api.dart';
import 'package:Smsvis/models/fetchallsendeerid.dart';
import 'package:Smsvis/providers/handle_main_drawer_activity.dart';
import 'package:Smsvis/providers/routehandler.dart';
import 'package:Smsvis/utils/sharedpreference.dart';
import 'package:Smsvis/utils/stringtext.dart';
import 'package:Smsvis/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SideDrawer extends StatefulWidget {
  final String username;
  final String credits;
  SideDrawer(this.username, this.credits, {Key key}) : super(key: key);
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  Credits creditsUpdate;
  String c;
  @override
  void initState() {
    c = widget.credits;
    super.initState();
  }

  getpage(PageControl page, BuildContext context) async {
    Navigator.pop(context);
    await Provider.of<HandleDrawerActivity>(context, listen: false)
        .swtichpage(page);
  }

  fetchuserdata() async {
    c = creditsFromMap(
      await API().fetchdata(await SharedData().username, TypeData.Credits),
    ).creditLeft;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
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
                          widget.username,
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
                gradient: LinearGradient(
                  colors: RouteHandler().maincolor,
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    TextData.creditLeft + ": $c",
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
                      fetchuserdata();
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
      ),
    );
  }
}
