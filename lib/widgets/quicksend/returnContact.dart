import 'package:Smsvis/providers/quicksendprovider.dart';
import 'package:Smsvis/utils/permissions.dart';
import 'package:app_settings/app_settings.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReturnContactQuickSendWidget extends StatefulWidget {
  ReturnContactQuickSendWidget({Key key}) : super(key: key);

  @override
  _ReturnContactQuickSendWidgetState createState() =>
      _ReturnContactQuickSendWidgetState();
}

enum ShowScreen { Progress, ListView, Error }

class _ReturnContactQuickSendWidgetState
    extends State<ReturnContactQuickSendWidget> {
  List<List> l = new List();
  List<Contact> _contacts;
  List<Contact> selectedContacts;
  List<Contact> searchContactList;
  List<int> activedisabled;
  var contacts;
  String numbers;
  int count = 0;
  int maxindex = 0;
  Map returndata;
  bool selectedAll = false;
  ShowScreen showScreen = ShowScreen.Progress;
  @override
  void initState() {
    screenContent();
    permission();

    super.initState();
  }

  searchContacts(var substring) {
    for (int i = 0; i < _contacts.length; i++) {
      Contact c = _contacts[i];
      String displayName = c.displayName;
      String number = c.phones.toList().first.value;

      if (displayName.contains(substring) || number.contains(substring)) {
        searchContactList.add(c);
      }
    }
  }

  permission() async {
    GetPermission getPermission = new GetPermission();
    showScreen = ShowScreen.Error;
    print("before permission");
    var result = await getPermission.isContactPermitted();
    if (result) {
      showScreen = ShowScreen.ListView;
      return getcontacts();
    }
    print("after  permission");
    screenContent();
    setState(() {});
  }

  Widget body;
  screenContent() {
    print("screenContent building");
    print(showScreen);
    if (showScreen == ShowScreen.Progress) {
      print("inside progress");
      body = Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else if (showScreen == ShowScreen.ListView) {
      print("inside listview");
      body = Stack(
        children: <Widget>[
          Container(
            // color: Colors.red,

            // flex: 1,
            // height: MediaQuery.of(context).size.height * 0.7,
            child: ListView.builder(
              itemCount: _contacts?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                Contact c = _contacts?.elementAt(index);
                return Card(
                  elevation: 4,
                  child: ListTile(
                    onTap: () {
                      print("working");
                      updateleadingicon(index);
                      print(activedisabled[index]);
                    },
                    leading: CircleAvatar(child: Text(c.initials())),
                    title: Text(c.displayName ?? ""),
                    trailing: activedisabled[index] == 0
                        ? SizedBox(child: Icon(Icons.check_circle_outline))
                        : SizedBox(
                            child:
                                Icon(Icons.check_circle, color: Colors.green)),
                  ),
                );
              },
            ),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  // color: Colors.lime,
                  child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    onPressed: () {},
                    child: Icon(Icons.search, color: Colors.deepOrange),
                    splashColor: Colors.deepOrange,
                  ),
                ),
              )),
          Positioned(bottom: -5, left: -5, right: -5, child: bottomTools())
        ],
      );
    } else if (showScreen == ShowScreen.Error) {
      print("inside errorr");
      body = GestureDetector(
        onHorizontalDragDown: (details) {
          print("updating Screen");
          permission();
        },
        child: Container(
          // color: Colors.blue,
          // height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Can't Read Contacts Please Enable Permission from Settings",
                  style: TextStyle(color: Colors.red),
                ),
                Text('Pull Down to Refresh'),
                OutlineButton(
                  child: Text("App Settings"),
                  onPressed: () {
                    AppSettings.openAppSettings();
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Future<void> getcontacts() async {
    // Load without thumbnails initially.
    contacts = (await ContactsService.getContacts(
            withThumbnails: false, iOSLocalizedLabels: false))
        .toList();
    if (contacts != null) {
      initalizeactivearray(contacts.length);
      refreshContacts(contacts);
    }
  }

  initalizeactivearray(int l) {
    activedisabled = new List(l);
    for (int i = 0; i < l; i++) {
      activedisabled[i] = 0;
    }
    return true;
  }

  refreshContacts(var contacts) {
    _contacts = contacts;
    screenContent();
    setState(() {});
  }

  convertnumbertostring() {
    selectedContacts = new List();
    for (int i = 0; i < _contacts.length; i++) {
      if (activedisabled[i] == 1) {
        if (_contacts[i].phones.toList().length > 0)
          selectedContacts.add(_contacts[i]);
      }
      if (i == maxindex) break;
    }
    print("output done");
  }

  updateleadingicon(index) {
    if (activedisabled[index] == 1) {
      activedisabled[index] = 0;
      count--;
    } else {
      activedisabled[index] = 1;
      if (maxindex < index) maxindex = index;
      count++;
    }
    for (int i = 0; i < activedisabled.length; i++) {
      if (activedisabled[i] == 1) {
        selectedAll = true;
        continue;
      }
      selectedAll = false;
      break;
    }
    // setState(() {});
    refreshContacts(contacts);
  }

  toggleSelectAll() {
    for (int i = 0; i < activedisabled.length; i++) print(activedisabled[i]);
    print("before");

    for (int i = 0; i < activedisabled.length; i++) {
      selectedAll == true ? activedisabled[i] = 0 : activedisabled[i] = 1;
    }
    selectedAll == false ? maxindex = activedisabled.length : maxindex = 0;
    selectedAll = !selectedAll;
    for (int i = 0; i < activedisabled.length; i++) print(activedisabled[i]);
    print("after");

    refreshContacts(contacts);
  }

  @override
  Widget build(BuildContext context) {
    final qsp = Provider.of<QuickSendProvider>(context, listen: false);

    return Scaffold(
      // floatingActionButton: Container(
      //   height: MediaQuery.of(context).size.height * 0.2,
      //   child: Card(
      //     elevation: 10,
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
      //       children: [
      //         OutlineButton(
      //           onPressed: () {
      //             qsp.getbacktosendmessageScreen();
      //           },
      //           child: Text("Cancel"),
      //         ),
      //         showScreen == ShowScreen.ListView
      //             ? OutlineButton(
      //                 onPressed: () {
      //                   toggleSelectAll();
      //                 },
      //                 child: selectedAll == true
      //                     ? Text("UnSelect All")
      //                     : Text("Select All"),
      //               )
      //             : SizedBox(),
      //         showScreen == ShowScreen.ListView
      //             ? OutlineButton(
      //                 onPressed: () {
      //                   convertnumbertostring();
      //                   for (int i = 0; i < selectedContacts.length; i++)
      //                     qsp.addContact(
      //                         selectedContacts[i].phones.toList().first.value,
      //                         name: selectedContacts[i].displayName,
      //                         notify: false);
      //                   qsp.removeextracharfromnumbr();
      //                   qsp.getbacktosendmessageScreen();
      //                 },
      //                 child: Text("Import"),
      //               )
      //             : SizedBox(),
      //       ],
      //     ),
      //   ),
      // ),
      body: body,
      // body: Center(child: Text("adfaf")),
    );
  }

  Widget bottomTools() {
    final qsp = Provider.of<QuickSendProvider>(context, listen: false);
    return Container(
      // color: Colors.red,
      height: MediaQuery.of(context).size.height * 0.125,
      // width: MediaQuery.of(context).size.width * 1.2,
      child: Card(
        elevation: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            OutlineButton(
              onPressed: () {
                qsp.getbacktosendmessageScreen();
              },
              child: Text("Cancel"),
            ),
            showScreen == ShowScreen.ListView
                ? OutlineButton(
                    onPressed: () {
                      toggleSelectAll();
                    },
                    child: selectedAll == true
                        ? Text("UnSelect All")
                        : Text("Select All"),
                  )
                : SizedBox(),
            showScreen == ShowScreen.ListView
                ? OutlineButton(
                    onPressed: () {
                      convertnumbertostring();
                      for (int i = 0; i < selectedContacts.length; i++)
                        qsp.addContact(
                            selectedContacts[i].phones.toList().first.value,
                            name: selectedContacts[i].displayName,
                            notify: false);
                      qsp.removeextracharfromnumbr();
                      qsp.getbacktosendmessageScreen();
                    },
                    child: Text("Import"),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
