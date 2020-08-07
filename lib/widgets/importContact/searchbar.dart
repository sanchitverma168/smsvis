import 'package:Smsvis/providers/importContact.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {
  SearchBar({Key key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final GlobalKey<FormState> searchcontact = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ImportContact importContacts =
        Provider.of<ImportContact>(context, listen: false);
    return Padding(
        padding: const EdgeInsets.all(6.0),
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 3,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: <Widget>[
                  Expanded(
                      child: Form(
                          key: searchcontact,
                          child: TextFormField(
                              onChanged: (value) {
                                print("hello");
                                importContacts.search(value);
                              },
                              decoration: InputDecoration(
                                  hintText: "Enter Name or Number")))),
                  IconButton(
                    icon: Icon(Icons.search, color: Colors.deepOrange),
                    onPressed: () {},
                  ),
                  IconButton(
                      icon: Icon(Icons.clear, color: Colors.deepOrange),
                      onPressed: () {
                        searchcontact.currentState.reset();
                        importContacts.showdeviceContactsonResetButton();
                      })
                ]))));
  }
}
