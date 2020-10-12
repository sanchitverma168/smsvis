import 'package:Smsvis/utils/stringtext.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class ReturnContact extends StatefulWidget {
  final List<Contact> _oldlist;
  ReturnContact(this._oldlist, {Key key}) : super(key: key);

  @override
  _ReturnContactState createState() => _ReturnContactState();
}

class _ReturnContactState extends State<ReturnContact> {
  List<List> l = new List();
  List<Contact> _contacts;
  List<Contact> selectedContacts;
  List<int> activedisabled;
  var contacts;
  String numbers;
  int count = 0;
  int maxindex = 0;
  Map returndata;
  @override
  void initState() {
    getcontacts();
    super.initState();
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
    setState(() {
      _contacts = contacts;
    });
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
    setState(() {});
    refreshContacts(contacts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TextData.selectContacts),
        actions: <Widget>[],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          new FloatingActionButton(
            heroTag: TextData.heroTag.first,
            child: Text(TextData.cancel),
            onPressed: () {
              Navigator.pop(context, returndata);
            },
          ),
          new FloatingActionButton(
            heroTag: TextData.heroTag.last,
            child: Text(TextData.add),
            onPressed: () {
              convertnumbertostring();
              returndata = {
                "list": selectedContacts,
                "oldlist": widget._oldlist
              };
              Navigator.pop(context, returndata);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: _contacts != null
            ? ListView.builder(
                itemCount: _contacts?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  Contact c = _contacts?.elementAt(index);
                  return ListTile(
                    onTap: () {
                      updateleadingicon(index);
                    },
                    leading: CircleAvatar(child: Text(c.initials())),
                    title: Text(c.displayName ?? ""),
                    trailing: activedisabled[index] == 0
                        ? Icon(Icons.check_circle_outline)
                        : Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
