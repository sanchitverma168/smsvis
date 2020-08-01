import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class MyAccountTemplate extends StatefulWidget {
  MyAccountTemplate({Key key}) : super(key: key);

  @override
  _MyAccountTemplateState createState() => _MyAccountTemplateState();
}

class _MyAccountTemplateState extends State<MyAccountTemplate> {
  var inputDecoration =
      new InputDecoration(filled: true, fillColor: Colors.white);

  Widget addtemplate() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Form(
        child: Column(children: [
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Template Name",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Message"),
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      OutlineButton(
                        splashColor: Color(0xfffbb448),
                        onPressed: () {
                          Toast.show("this Wil add template", context);
                        },
                        child: Text("Add"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ]),
      ),
    );
  }

  Widget datatable() {
    return Card(
      elevation: 2,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(2.0),
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'Temple Name',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Tempplate Message',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ],
          rows: <DataRow>[
            DataRow(
              cells: <DataCell>[
                DataCell(Text('Sarah')),
                DataCell(Text('Hi There')),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('Janine')),
                DataCell(Text('Recommend By the lorem ipsum')),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('William')),
                DataCell(Wrap(children: [
                  Text('um Lorem Ipsum Lore'),
                ])),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('William')),
                DataCell(Wrap(children: [
                  Text('um Lorem Ipsum Lore'),
                ])),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('William')),
                DataCell(Wrap(children: [
                  Text('um Lorem Ipsum Lore'),
                ])),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('William')),
                DataCell(Wrap(children: [
                  Text('um Lorem Ipsum Lore'),
                ])),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('William')),
                DataCell(Wrap(children: [
                  Text('um Lorem Ipsum Lore'),
                ])),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('William')),
                DataCell(Wrap(children: [
                  Text('um Lorem Ipsum Lore'),
                ])),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('William')),
                DataCell(Wrap(children: [
                  Text('um Lorem Ipsum Lore'),
                ])),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('William')),
                DataCell(Wrap(children: [
                  Text('um Lorem Ipsum Lore'),
                ])),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(Text('William')),
                DataCell(Wrap(children: [
                  Text('um Lorem Ipsum Lore'),
                ])),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          children: [
            addtemplate(),
            SizedBox(
              height: 10,
            ),
            Expanded(child: datatable()),
          ],
        ),
      ),
    );
  }
}
