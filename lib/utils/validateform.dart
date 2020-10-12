import 'package:Smsvis/utils/stringtext.dart';
import 'package:contacts_service/contacts_service.dart';

class Validate {
  static number(int value, List<Contact> contacts) {
    if (value.toString().length > 10 || value.toString().length < 10) {
      return TextData.pleaseEnterCorrectMobileNumber;
    }
    for (int i = 0; i < contacts.length; i++) {
      if (value.toString() == contacts[i].phones.toList()[0].value.toString())
        return TextData.numberAlreadyAdded;
    }

    return null;
  }

  static msg(String value) {
    if (value.length > 50 || value.length < 2) {
      return TextData.shouldlessthen50;
    }
    return null;
  }
}
