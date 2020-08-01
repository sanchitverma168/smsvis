import 'package:contacts_service/contacts_service.dart';

class Validate {
  static number(int value, List<Contact> contacts) {
    if (value.toString().length > 10 || value.toString().length < 10) {
      return "Please Enter Correct Mobile Number";
    }
    for (int i = 0; i < contacts.length; i++) {
      if (value.toString() == contacts[i].phones.toList()[0].value.toString())
        return "Number is Already Added";
    }

    return null;
  }

  static msg(String value) {
    if (value.length > 50 || value.length < 2) {
      return "Should be less than 50  and greater than 2 characters respectively";
    }
    return null;
  }
}
