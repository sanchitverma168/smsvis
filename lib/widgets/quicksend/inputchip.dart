import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class InputChipWidget extends StatelessWidget {
  final List<Contact> selectedContact;
  InputChipWidget(this.selectedContact, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Wrap(
          children: <Widget>[
            for (int i = 0; i < selectedContact.length; i++)
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: InputChip(
                  label: Text("${selectedContact[i].phones.toList()[0].value}"),
                  onDeleted: () async {
                    // await Provider.of<QuickSendProvider>(context, listen: false)
                    //     .deleteContact(i);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
