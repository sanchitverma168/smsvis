import 'dart:convert';
import 'dart:io';
import 'package:Smsvis/models/api.dart';
import 'package:Smsvis/models/quicksendresponse.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

List<String> errormessage = [
  "Incorrect Message",
  "Message Accepted",
  "Sender Id doesn't match"
];
enum ErrorType { INCORRECT_LOGIN, MESSGE_ACCEPTED, SENDER_ID_DONT_MATCH }
enum Display { PHONECONTACTS, SENDMESSAGE }
enum ShowScreen { Progress, ListView, Error, SearchedContacts }
enum ContactType { istyped, isphone, isfile }
Map errorMessage = {
  ErrorType.INCORRECT_LOGIN: "Incorrect Login",
  ErrorType.MESSGE_ACCEPTED: "Message Accepted",
  ErrorType.SENDER_ID_DONT_MATCH: "Sender Id doesn't match"
};
Map errorCode = {
  ErrorType.INCORRECT_LOGIN: 401,
  ErrorType.MESSGE_ACCEPTED: 202,
  ErrorType.SENDER_ID_DONT_MATCH: 406
};
List<String> senderid = [
  'Select Sender ID',
  'DEMAPI',
  'DEMOID',
  'smsvis',
  'id 4',
  'id 5',
];

class QuickSendProvider with ChangeNotifier {
  Display _display = Display.SENDMESSAGE;
  Display get display => _display;
  List<Color> _maincolor = [Color(0xfffbb448), Color(0xfff7892b)];
  List<Color> get maincolor => _maincolor;
  Color get fcolor => _maincolor.first;
  Color get scolor => _maincolor[1];

  List<Map> lcontacts = new List();

  /// [
  ///   {
  ///     name:"Sanchit Verma",
  ///     number:"8193025998",
  ///     type :"istyped"
  ///   },
  ///   {
  ///     name:"Demo Verma",
  ///     number:"9149253879",
  ///     type :"isphone"
  ///   }
  /// ]

  int _maxContacttoshow = 20;
  int get maxContact => _maxContacttoshow;

  bool _showimportbutton = false;
  bool get showimportbutton => _showimportbutton;
  set showimportbutton(bool value) {
    _showimportbutton = value;
    notifyListeners();
  }

  List<int> selectedContactsindex = new List();

  List<Contact> _viewselectedContact = new List();
  List<Contact> get viewselectedContact => _viewselectedContact;

  List<Contact> _selectedContact = new List();
  List<Contact> get contacts => _selectedContact;

  // List<Contact> _fileContacts = new List();
  // List<Contact> get filecontacts => _fileContacts;
  set viewselectedContact(value) {
    _viewselectedContact.add(value);
    notifyListeners();
  }

  List<String> filename = new List();

  int msgCount = 0, charleft = 0;
  int maxEnglishChars = 160;
  int maxNonEnglishChars = 70;
  int _fileContacts = 0;
  int get fileContacts => _fileContacts;

  int _phoneContacts = 0;
  int get phoneContacts => _phoneContacts;
  set phoneContacts(value) => _phoneContacts += value;
  int _typeContacts = 0;
  int get typeContacts => _typeContacts;
  set typeContacts(value) => _typeContacts = value;

  String _senderidselected = senderid.first;
  String get sender => _senderidselected;
  bool _error = false;
  bool get error => _error;
  set error(bool value) {
    _error = value;
    notifyListeners();
  }

  Color _errorcolor;
  Color get errorColor => _errorcolor;

  String _errortext;
  String get errortext => _errortext;
  set errortext(value) => _errortext = value;

  seterror(bool value,
      {Color color = Colors.redAccent, @required String errorText}) {
    _errorcolor = color;
    _error = value;
    _errortext = errorText;
    notifyListeners();
  }

  importCSVFILE(BuildContext context) async {
    print("${_selectedContact.length} + csv");
    File file = await FilePicker.getFile();
    if (file != null) {
      String name = file.path.split('/').last;
      String ext = file.path.split('.').last;
      print(name + ext);
      for (int i = 0; i < filename.length; i++) {
        if (filename[i] == name) {
          Toast.show("File Already Imported", context);
          return;
        }
      }
      if (ext != "csv") {
        Toast.show(
          "File Not Supported",
          context,
        );
        return;
      }
      Stream<List> inputStream = file.openRead();
      inputStream
          .transform(utf8.decoder) // Decode bytes to UTF-8.
          .transform(new LineSplitter()) // Convert stream to individual lines.
          .listen((String line) {
        // Process results.
        List row = line.split(' '); // split by comma

        String number = row[0];
        addcontacttolcontacts(
            name: "File Contact",
            number: number,
            type: ContactType.isfile.toString());

        print('$number');
        _fileContacts += 1;
      }, onDone: () {
        filename.add(name);
        print('File is now closed.');
      }, onError: (e) {
        print(e.toString());
      });
    }

    notifyListeners();
    this.removeextracharfromnumbr();
  }

  void addcontacttolcontacts(
      {@required String name, @required String number, @required String type}) {
    Map mcontacts = new Map();

    /// [Map] [mcontacts data to be stored]
    ///  {name:"Sanchit Verma",
    ///   number:"8193025998",
    ///   type :"istyped" }
    ///
    mcontacts["name"] = name;
    mcontacts["number"] = number;
    mcontacts["type"] = type;
    lcontacts.add(mcontacts);
  }

  removeextracharfromnumbr() {
    //not working don't know why bug here
    String number;

    List<Contact> temp = new List();
    // print("${_selectedContact.length}" + "before giving to temp variable");
    // print("${temp.length}" + "before giving to temp variable");
    for (int i = 0; i < _selectedContact.length; i++) {
      // print(i);
      temp.add(_selectedContact[i]);
      // print(temp.length);
    }
    for (int i = 0; i < _selectedContact.length; i++)
      _selectedContact.removeAt(i);

    _selectedContact.clear();
    // print("${_selectedContact.length}" + "after giving to temp variable");
    // print("${temp.length}" + "after giving to temp variable");
    // _selectedContact.clear();
    // _selectedContact.cl
    _selectedContact = new List();
    for (int i = 0; i < temp.length; i++) {
      // print("${temp.length} $i");
      Contact c = temp[i];
      if (c.phones.toList().length > 0) {
        number = c.phones.toList()[0].value.toString();
        int length = number.length;
        // print("$length  $i");
        if (length > 10) {
          // print("inside");
          // print(number);
          number = number
              .split("91")
              .join()
              .split(" ")
              .join()
              .split("-")
              .join()
              .split("(")
              .join()
              .split(")")
              .join()
              .split("+")
              .join();
          // print(withoutspace);
        }
        c.phones = [Item(label: "mobile", value: number)];
      }
      // print(c.phones.toList()[0].value);

      _selectedContact.add(c);
    }
    // print("beforenotifylisteners");
    notifyListeners();
  }

  getcontactsfromphone(BuildContext context) async {
    _display = Display.PHONECONTACTS;
    notifyListeners();
  }

  // convertcontacttoplusformat() {
  //   String number;
  //   if (_selectedContact.length != 0) {
  //     for (int i = 0; i < _selectedContact.length; i++) {
  //       if (number == null) {
  //         number = _selectedContact[i].phones.toList()[0].value;
  //         continue;
  //       }
  //       number = number + "+" + _selectedContact[i].phones.toList()[0].value;
  //     }
  //   }
  //   if (_fileContacts.length != 0) {
  //     for (int i = 0; i < _fileContacts.length; i++) {
  //       if (number == null) {
  //         number = _fileContacts[i].phones.toList()[0].value;
  //         continue;
  //       }
  //       number = number + "+" + _fileContacts[i].phones.toList()[0].value;
  //     }
  //   }
  //   return number;
  // }

  changesenderid(String value) {
    _senderidselected = value;
    if (value != senderid[0]) _error = false;

    notifyListeners();
  }

  onChangedMessageValue(value) {
    _error = false;
    int l = value.length;
    if (value.isEmpty) {
      charleft = msgCount = 0;
      notifyListeners();
      return;
    }
    if (!RegExp("[^\s\S\w():,.<>?\/\'a-zA-Z0-9{}:;\"')(-_=+*&^%\$#@!~]",
            multiLine: true, caseSensitive: false)
        .hasMatch(value.split(" ").join(""))) {
      print(" English");
      msgCount = (l ~/ maxEnglishChars).toInt();
      charleft = maxEnglishChars - (l - (msgCount * maxEnglishChars));
      msgCount++;
      notifyListeners();
      return;
    } else {
      print("Non English");
      msgCount = (l ~/ maxNonEnglishChars).toInt();
      charleft = maxNonEnglishChars - (l - (msgCount * maxNonEnglishChars));
      msgCount++;
      notifyListeners();
    }
  }

  resetform({bool notify = true}) {
    _selectedContact.clear();
    phoneContacts = 0;
    _fileContacts = 0;
    typeContacts = 0;

    // _fileContacts.clear();
    msgCount = 0;
    charleft = 0;
    _senderidselected = senderid[0];
    filename.clear();
    _error = false;
    if (notify) notifyListeners();
  }

  resetMsgBox() {
    msgCount = 0;
    charleft = 0;
    notifyListeners();
  }

  Future sendmessage(String id, String usermessage, String password,
      String number, String userid) async {
    var response =
        await API().postmesage(id, usermessage, password, number, userid);
    var jsondata = json.decode(response);
    var msgresponse = QuickSendResponse.fromJson(jsondata);

    if (msgresponse.status == errorCode[ErrorType.INCORRECT_LOGIN]) {
      // _errortext = msgresponse.statusMessage;
      seterror(true, errorText: msgresponse.statusMessage);
      print("incorrect login");
    } else if (msgresponse.status == errorCode[ErrorType.MESSGE_ACCEPTED]) {
      // _errortext = msgresponse.statusMessage;
      seterror(true, color: Colors.green, errorText: msgresponse.statusMessage);
      resetform(notify: false);
    } else if (msgresponse.status ==
        errorCode[ErrorType.SENDER_ID_DONT_MATCH]) {
      // _errortext = msgresponse.statusMessage;
      seterror(true, errorText: msgresponse.statusMessage);
      print("don't match");
    }

    notifyListeners();
    return;
  }

  // isContactlistempty() {
  //   if (_selectedContact.length == 0 && _fileContacts.length == 0) return true;
  //   return false;
  // }

  getbacktosendmessageScreen() {
    _display = Display.SENDMESSAGE;
    notifyListeners();
  }

  validateusernumberentered(String value) {
    print("hee");
    if (!isNumberorComma(value)) {
      return seterror(true, errorText: "Not Supported");
    }
    print(isNumberLengthCorrect(value));
    if (!isNumberLengthCorrect(value)) {
      return seterror(true, errorText: "Enter Valid Numbers");
    }
    seterror(false, errorText: null);
  }

  bool isNumberorComma(value) {
    if (RegExp("[^0-9,]", multiLine: true, caseSensitive: false)
        .hasMatch(value)) return false;
    return true;
  }

  bool isNumberLengthCorrect(value) {
    var r = true;
    int count = 0;
    List<String> numbers = value.split(",");
    print("1");
    numbers.forEach((element) {
      print("2");
      if (element.length != 10 &&
          element != " " &&
          element != null &&
          element.length != 0) {
        print("3");
        return r = false;
      } else
        count += 1;
      print("4");

      r = true;
    });
    print("5");
    typeContacts = count;
    print("6");
    if (r) print(numbers.length);
    print("7");
    return r;
    // return true;
  }
}
