import 'package:Smsvis/database/db.dart';
import 'package:Smsvis/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class FavouriteListView extends StatefulWidget {
  FavouriteListView({Key key}) : super(key: key);

  @override
  _FavouriteListViewState createState() => _FavouriteListViewState();
}

class _FavouriteListViewState extends State<FavouriteListView> {
  var data;
  var l;
  Widget expanded;
  var isDataParse;
  @override
  void initState() {
    isDataParse = false;
    _updateUI();
    setState(() {});
    getContactfromdb();
    super.initState();
  }

  getContactfromdb() async {
    final db = await $FloorAppDatabase.databaseBuilder(databaseName).build();
    final fl = db.fl;
    data = await fl.getlist();
    l = data.length;
    print(l);
    if (l != 0) isDataParse = true;
    print(data);
    _updateUI();
    setState(() {});
  }

  _updateUI() {
    if (isDataParse) {
      expanded = ListView.builder(
        itemCount: l,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Card(
                child: ListTile(
              title: Text("${data[index].name}"),
            )),
            onTap: () {
              Toast.show("hello", context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewContactList(data[index].id)));
            },
          );
        },
      );
    } else if (l == 0) {
      expanded = Center(child: Text("No Data found"));
    } else {
      expanded = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(backgroundColor: Colors.red),
            Text(
              "Loading...",
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Favourite List")),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: expanded,
        ),
      ),
    );
  }
}

class ViewContactList extends StatefulWidget {
  final String id;
  const ViewContactList(this.id, {Key key}) : super(key: key);

  @override
  _ViewContactListState createState() => _ViewContactListState();
}

class _ViewContactListState extends State<ViewContactList> {
  Widget expanded;
  bool isDataParse;
  var data;
  var l;
  @override
  void initState() {
    isDataParse = false;
    _updateUI();
    setState(() {});
    getContactfromdb();
    super.initState();
  }

  getContactfromdb() async {
    final db = await $FloorAppDatabase.databaseBuilder(databaseName).build();
    final contact = db.contact;
    data = await contact.getcontact(false, widget.id);
    l = data.length;
    isDataParse = true;
    print(data);
    _updateUI();
    setState(() {});
  }

  _updateUI() {
    if (isDataParse) {
      expanded = ListView.builder(
        itemCount: l,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Card(
                child: ListTile(
              title: Text("${data[index].givename}"),
              subtitle: Text("${data[index].phones}"),
            )),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewContactList(data[index].id)));
            },
          );
        },
      );
    } else if (l == 0) {
      expanded = Container(
        child: Text("No Data found"),
      );
    } else {
      expanded = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(backgroundColor: Colors.red),
            Text(
              "Loading...",
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          Navigator.pop(context);
          return null;
        },
        child: Scaffold(
          // appBar: AppBar(
          //   title: Text("Contacts List"),
          //   actions: [
          //     FlatButton(child: Text("Import"), onPressed: null),
          //   ],
          // ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: expanded,
          ),
        ),
      ),
    );
  }
}
