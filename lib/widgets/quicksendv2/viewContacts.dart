import 'package:Smsvis/providers/quicksendprovider_v2.dart';
import 'package:Smsvis/utils/stringtext.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewContacts extends StatelessWidget {
  final String value;
  ViewContacts(this.value, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var qsp = Provider.of<QuickSendProviderV2>(context);
    List<String> numbers;
    int numbersLength;
    if (value == TextData.phoneNumber) {
      numbers = qsp.phonenumbers;
      numbersLength = qsp.phonenumbersLength;
    } else {
      numbers = qsp.filenumbers;
      numbersLength = qsp.filenumbersLength;
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
              margin: EdgeInsets.symmetric(vertical: 5.0), child: Text(value)),
          if (numbersLength != 0)
            Expanded(
                flex: 1,
                child: ListView.builder(
                  itemCount: numbersLength,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(numbers[index]),
                      trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            if (value == TextData.phoneNumber) {
                              qsp.phonenumbers.removeAt(index);
                            } else {
                              qsp.filenumbers.removeAt(index);
                            }
                            qsp.updateScreen();
                          }),
                    );
                  },
                ))
          else
            Text(TextData.noNumberAdded),
        ],
      ),
    );
  }
}
