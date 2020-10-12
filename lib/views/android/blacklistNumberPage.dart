import 'package:Smsvis/database/entities/blacklistNumber.dart';
import 'package:Smsvis/utils/stringtext.dart';
import 'package:Smsvis/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:Smsvis/database/db.dart';

enum Data { Found, NotFound, Processing }

class BlacklistNumberPage extends StatefulWidget {
  BlacklistNumberPage({Key key}) : super(key: key);

  @override
  _BlacklistNumberPageState createState() => _BlacklistNumberPageState();
}

class _BlacklistNumberPageState extends State<BlacklistNumberPage> {
  List<BlackListedNumber> blnumbers;
  var data = Data.Processing;
  final GlobalKey<FormState> _addnumberKey = new GlobalKey<FormState>();
  String number;
  add() async {
    final database =
        await $FloorAppDatabase.databaseBuilder(databaseName).build();
    final form = _addnumberKey.currentState;
    form.save();
    String uuid = Uuid().v4();
    DateTime dt = DateTime.now();
    String date = dt.year.toString() + dt.month.toString() + dt.day.toString();
    String time = dt.hour.toString() + dt.minute.toString();
    var bNumber = BlackListedNumber(uuid, number, date, time);
    final blacklistdao = database.blacklistdao;
    blacklistdao.save(bNumber);
    form.reset();
    database.close();
    getnumbers();
  }

  @override
  void initState() {
    getnumbers();
    super.initState();
  }

  listTables() async {}

  getnumbers() async {
    final database =
        await $FloorAppDatabase.databaseBuilder(databaseName).build();
    final bnumbers = database.blacklistdao;
    blnumbers = await bnumbers.getallNumbers();
    if (blnumbers.length != 0)
      data = Data.Found;
    else
      data = Data.NotFound;
    database.close();
    setState(() {});
  }

  delete(String index) async {
    final database =
        await $FloorAppDatabase.databaseBuilder(databaseName).build();
    await database.blacklistdao.deleteNumber(index);
    getnumbers();
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (data == Data.Processing) {
      body = Center(
          child: CircularProgressIndicator(
        backgroundColor: Colors.deepOrange,
      ));
    } else if (data == Data.Found) {
      body = Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: ListView.builder(
          reverse: true,
          itemCount: blnumbers.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      delete(blnumbers[index].id);
                    }),
                title: Text(
                  blnumbers[index].number,
                ),
              ),
            );
          },
        ),
      );
    } else
      body = Center(child: Text(TextData.dataNotFound));
    return Scaffold(
      appBar: AppBar(title: Text(TextData.blacklistedNumbers)),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: body,
            ),
            Form(
              key: _addnumberKey,
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(child: TextFormField(
                        onSaved: (newValue) {
                          number = newValue;
                        },
                      )),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          add();
                        },
                        splashColor: Colors.deepOrange,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
