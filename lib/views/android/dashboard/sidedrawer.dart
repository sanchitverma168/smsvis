import 'package:Smsvis/providers/handle_main_drawer_activity.dart';
import 'package:Smsvis/providers/routehandler.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class SideDrawer extends StatelessWidget {
  final String username;
  SideDrawer(this.username, {Key key}) : super(key: key);

  getpage(PageControl page, BuildContext context) async {
    Navigator.pop(context);
    await Provider.of<HandleDrawerActivity>(context, listen: false)
        .swtichpage(page);
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
                  CircleAvatar(
                    backgroundColor: RouteHandler().scolor,
                    child: Icon(Icons.verified_user, color: Colors.white),
                    radius: 50,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Welcome")),
                      Padding(
                        padding: EdgeInsets.only(left: 18.0),
                        child: Text("$username",
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 18)),
                      ),
                    ],
                  ),
                ],
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: RouteHandler().maincolor),
                // color: Color.fromRGBO(0, 176, 255, 1.0),
              ),
            ),
            ExpansionTile(
              leading: Icon(Icons.message),
              title: Text("Sms"),
              children: <Widget>[
                ListTile(
                  title: Text("Quick Send"),
                  onTap: () {
                    getpage(PageControl.QUICK_SEND, context);
                  },
                ),
                ListTile(
                  title: Text("Scheduled SMS"),
                  onTap: () async {
                    getpage(PageControl.SCHEDULED_SMS, context);
                  },
                ),
              ],
            ),
            ExpansionTile(
              leading: Icon(Icons.report),
              title: Text("Reports"),
              children: <Widget>[
                ListTile(
                  title: Text("Current Day MIS"),
                  onTap: () {
                    getpage(PageControl.CURRENT_DAY_MIS, context);
                  },
                ),
                ListTile(
                  title: Text("MIS Report"),
                  onTap: () {
                    getpage(PageControl.MIS_REPORT, context);
                  },
                ),
                ListTile(
                  title: Text("Detail Report"),
                  onTap: () {
                    getpage(PageControl.DETAIL_REPORT, context);
                  },
                ),
                ListTile(
                  title: Text("File Upload Status"),
                  onTap: () {
                    getpage(PageControl.FILE_UPLOAD_STATUS, context);
                  },
                ),
                ListTile(
                  title: Text("Download Centre"),
                  onTap: () {
                    getpage(PageControl.DOWNLOAD_CENTRE, context);
                  },
                ),
              ],
            ),
            ExpansionTile(
              leading: Icon(Icons.account_box),
              title: Text("Address Book"),
              children: <Widget>[
                ListTile(
                  title: Text("Manage Group"),
                  onTap: () {
                    getpage(PageControl.MANAGE_GROUP, context);
                  },
                ),
                ListTile(
                  title: Text("Mangage Contact"),
                  onTap: () {
                    Toast.show("Not Made", context);
                    // getpage(PageControl.MANAGE_CONTACT, context);
                  },
                ),
              ],
            ),
            ExpansionTile(
              leading: Icon(Icons.verified_user),
              title: Text("My Account"),
              children: <Widget>[
                ListTile(
                  title: Text("Credit History"),
                  onTap: () {
                    getpage(PageControl.CREDIT_HISTORY, context);
                  },
                ),
                ListTile(
                  title: Text("Template"),
                  onTap: () {
                    getpage(PageControl.TEMPLATE, context);
                  },
                ),
                ListTile(
                  title: Text("General"),
                  onTap: () {
                    getpage(PageControl.GENERAL, context);
                  },
                ),
                ListTile(
                  title: Text("Profile"),
                  onTap: () {
                    getpage(PageControl.PROFILE, context);
                  },
                ),
              ],
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("Help"),
              onTap: () {
                getpage(PageControl.HELP, context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("About US"),
              onTap: () {
                Toast.show("not made yet", context);
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text("History"),
              onTap: () {
                Toast.show("history not made yet", context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
              ),
              title: Text("Log Out"),
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
