import 'package:Smsvis/database/db.dart';
import 'package:Smsvis/database/entities/contact.dart';
import 'package:Smsvis/database/entities/favourtielist.dart';
import 'package:Smsvis/utils/variables.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:uuid/uuid.dart';

class SaveContacts extends StatefulWidget {
  final List<Contact> selectedContact;
  SaveContacts(this.selectedContact, {Key key}) : super(key: key);

  @override
  _SaveContactsState createState() => _SaveContactsState();
}

class _SaveContactsState extends State<SaveContacts> {
  final GlobalKey<FormState> _savelist = GlobalKey<FormState>();
  String name;
  savecontacttodb() async {
    Uuid uuid = Uuid();
    var id = uuid.v4();
    final database =
        await $FloorAppDatabase.databaseBuilder(databaseName).build();
    final favouritelistdao = database.fl;
    final contactdao = database.contact;
    final list = FavouriteList(id, name);
    await favouritelistdao.insertlist(list);
    var temp = false;
    for (int i = 0; i < widget.selectedContact.length; i++) {
      var lid = Uuid().v4();
      var givename = widget.selectedContact[i].givenName;
      var phone = widget.selectedContact[i].phones.toList()[0].value;
      final contact = LocalContact(lid, id, givename, phone, temp);
      await contactdao.insertcontacts(contact);
    }
    Navigator.pop(context);
    Toast.show("Save Successfully", context);
  }

  showalerttonamefile() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Name this List'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Form(
                  key: _savelist,
                  child: TextFormField(
                    initialValue: "7c9519bd83",
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Please Enter name";
                      }
                      name = value;
                      return null;
                    },
                    autofocus: true,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Save'),
              onPressed: () {
                final _passwordform = _savelist.currentState;
                if (_passwordform.validate()) {
                  Navigator.of(context).pop();
                  savecontacttodb();
                }
              },
            ),
            RaisedButton(
              color: Colors.red,
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print("working");
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          Navigator.pop(context);
          return null;
        },
        child: Container(
            color: Colors.black12,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: widget.selectedContact.length != 0
                ? ListView.builder(
                    itemCount: widget.selectedContact.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: GestureDetector(
                          onTap: () {
                            print(index);
                          },
                          child: ListTile(
                            title: Text(
                                "${widget.selectedContact[index].givenName}"),
                            subtitle: Text(
                                "${widget.selectedContact[index].phones.toList()[0].value}"),
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text("No Contact Added "),
                  )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showalerttonamefile();
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
