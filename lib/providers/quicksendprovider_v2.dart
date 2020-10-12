import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:Smsvis/models/api.dart';
import 'package:Smsvis/models/quicksendresponse.dart';
import 'package:Smsvis/utils/colors.dart';
import 'package:Smsvis/utils/sharedpreference.dart';
import 'package:Smsvis/utils/stringtext.dart';
import 'package:Smsvis/utils/validation.dart';
import 'package:Smsvis/widgets/quicksendv2/fetchingsenderid_AlertBox.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

enum Display { PHONECONTACTS, SENDMESSAGE }

class QuickSendProviderV2 with ChangeNotifier {
  Display _display = Display.SENDMESSAGE;
  Display get display => _display;

  bool _showimportbutton = false;
  bool get showimportbutton => _showimportbutton;
  set showimportbutton(bool value) {
    _showimportbutton = value;
    notifyListeners();
  }

  List<Color> _maincolor = [Color(0xfffbb448), Color(0xfff7892b)];
  List<Color> get maincolor => _maincolor;
  Color get fcolor => _maincolor.first;
  Color get scolor => _maincolor[1];

  GlobalKey<FormState> _addnumberkey = GlobalKey<FormState>();
  GlobalKey<FormState> get addnumberkey => _addnumberkey;
  set addnumberkey(value) => _addnumberkey = value;

  GlobalKey<FormState> _quicksend = GlobalKey<FormState>();
  GlobalKey<FormState> get quicksend => _quicksend;
  set quicksend(value) => _quicksend = value;

  Widget _widgetbodyContentMessagePage;
  Widget get widgetbodyContentMessagePage => _widgetbodyContentMessagePage;

  var _inputDecoration =
      new InputDecoration(filled: true, fillColor: Colors.white);
  get inputDecoration => _inputDecoration;

  /// This signifies the Names of the File Imported through.
  List<String> _filename = new List();
  //---

  /**
   * This  all variables stores the Phone Number 
   * imported via CSV FILES.
   */
  /// This signifies the number added from the csv file.
  List<String> _fileNumbers = new List();

  /// Return the total numbers added from the file.
  int get filenumbersLength => _fileNumbers.length;

  /// Return the list of numbers added through the csv file.
  List<String> get filenumbers => _fileNumbers;

  /**
   * These all variables stores the Phone Number 
   * imported via CSV FILES.
   */
  /// This signifies the number added from the Phone Contacts.
  List<String> _phoneNumbers = new List();

  /// Return the total numbers added from the Device.
  int get phonenumbersLength => _phoneNumbers.length;

  /// Return the list of numbers added via Device Contacts.
  List<String> get phonenumbers => _phoneNumbers;

  ///  These all variable  will define the type of Error Occured

  /// Define Whether to Show the Error Box or not.
  bool _error = false;

  /// Returns the Error value.
  bool get error => _error;

  /// Updates the Error value.
  set error(bool value) {
    _error = value;
    notifyListeners();
  }

  ///  Error color Variable.
  Color _errorcolor;

  /// Return the Error color.
  Color get errorColor => _errorcolor;

  /// Error Text Variable
  String _errortext;

  /// Returns the Error Text.
  String get errortext => _errortext;

  /// Updates the Error Text.
  set errortext(value) => _errortext = value;

  /// Displays The Error on The Screen with arugments given.
  seterror(
    bool value, {
    Color color = UIColors.alertColor,
    @required String errorText,
    bool notify = true,
  }) {
    _errorcolor = color;
    _error = value;
    _errortext = errorText;
    if (notify) notifyListeners();
  }

  /// This stores the User Typed Message.
  String _usermessage;

  /// Return the User Typed Message.
  String get usermessage => _usermessage;

  /// Updates the Usere Typed Message.
  set usermessage(value) => _usermessage = value;

  /// Stores SenderID
  String _senderid;

  /// Return SenderID by which the messaage is send.
  String get senderid => _senderid;

  /// Updates The senderID
  set senderid(value) => _senderid = value;

  /// Store the timer Value.
  Timer _searchOnStoppedTyping;

  /// Stores the Message Count Value.
  int _msgCount = 0;

  /// Returns Message Count.
  int get msgCount => _msgCount;

  /// Updates the Message Count Value.
  set msgCount(value) => _msgCount = value;

  /// Store The Charater Count Value.
  int _charleft = 0;

  /// Returns Charater Count.
  int get charleft => _charleft;

  /// Updates the Charater Count Value.
  set charleft(value) => _charleft = value;

  /// Max English Character Count.
  int _maxEnglishChars = 160;

  /// Returns the Max English Character Count.
  int get maxEnglishChars => _maxEnglishChars;

  /// Max Non English Character Count.
  int _maxNonEnglishChars = 70;

  /// Returns the Max Non-English Character Count.
  int get maxNonEnglishChars => _maxNonEnglishChars;

  /// This Refers to Store the numbers which is typed
  /// by user.
  String _inputMobileData;

  /// Returns the _inputMobilString.
  String get inputMobileData => _inputMobileData;

  /// Updates the _inputMobilString.
  set inputMobileData(value) => _inputMobileData = value;

  /// This Refers to Store the numbers in final format to
  /// send the data to API by the next method.
  String _wrongMobileNumber;

  /// Returns the _inputMobilString.
  String get wrongMobileNumber => _wrongMobileNumber;

  /// Updates the _inputMobilString.
  set wrongMobileNumber(value) => _wrongMobileNumber = value;

  AnimationController helpanimationController;

  /// Decided whether to show [View Contact];
  bool viewContactonQuickSendPage = false;
  bool get getViewContactonQuickSendPage => viewContactonQuickSendPage;

  set setViewContactonQuickSendPage(bool viewContactonQuickSendPage) =>
      this.viewContactonQuickSendPage = viewContactonQuickSendPage;

  ////////////////////////////////// Methods Start////////////////////////////////-------------///////////////////////////////////////////////////////////////////////////////////////////////////
  charleftReset({bool notify = true}) {
    charleft = 0;
    if (notify) notifyListeners();
  }

  msgCountReset({bool notify = true}) {
    msgCount = 0;
    if (notify) notifyListeners();
  }

  validateContainer(var context, QuickSendProviderV2 user) async {
    error = false;
    addnumberkey.currentState.save();

    if (isLenghtNotZero(filenumbersLength) &&
        isLenghtNotZero(phonenumbersLength) &&
        (inputMobileData == null || inputMobileData.isEmpty))
      return seterror(true, errorText: TextData.noNumberAdded);
    if (validateMessageBox()) return getid(context, user);
  }

  _showDialog(context, QuickSendProviderV2 user) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: new FetchingIDAandShowAlertBox(user),
        );
      },
    );
  }

  getid(context, QuickSendProviderV2 user) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        _showDialog(context, user);
      },
    );
  }

  /// Recieve Number in String Format,UserName and password as
  /// argument.
  sendMessage() async {
    String numberString, username, password;
    username = await SharedData().username;
    password = await SharedData().password;
    print(filenumbers.length);
    print(filenumbersLength);

    if (inputMobileData != null || inputMobileData != "") {
      List<String> numbers = inputMobileData.split(",");
      for (int i = 0; i < numbers.length; i++) {
        if (numberString == null || numberString == "")
          numberString = numbers[i];
        else
          numberString += numbers[i];
        if (i != numbers.length - 1) numberString += "+";
      }
    }

    if (filenumbersLength != 0) {
      if (numberString != null) numberString += "+";
      numberString = convertListtoString(filenumbers);
    }

    if (phonenumbersLength != 0) {
      if (numberString != null) numberString += "+";
      if (numberString == null)
        numberString = convertListtoString(phonenumbers);
      else {
        var d = convertListtoString(phonenumbers);
        numberString += d;
      }
    }
    if (senderid == null ||
        usermessage == null ||
        password == null ||
        numberString == null ||
        username == null)
      return seterror(true, errorText: TextData.somethingWentWrong);
    var rsp = await API()
        .postmesage(senderid, usermessage, password, numberString, username);
    var jsondata = json.decode(rsp);
    var msgrsp = QuickSendResponse.fromJson(jsondata);
    switch (msgrsp.status) {
      case 401:
        seterror(true, errorText: msgrsp.statusMessage);
        break;
      case 202:
        seterror(true,
            color: Colors.green,
            errorText: msgrsp.statusMessage,
            notify: false);

        resetform(errorT: true);
        break;
      case 406:
        seterror(true, errorText: msgrsp.statusMessage);
        break;
    }
    notifyListeners();
    return;
  }

  importCSVFILE(BuildContext context) async {
    File file = await FilePicker.getFile(allowCompression: false);
    if (file != null) {
      String name = file.path.split('/').last;
      String ext = file.path.split('.').last;
      for (int i = 0; i < _filename.length; i++) {
        if (_filename[i] == name) {
          Toast.show(TextData.fileAlreadyImported, context);
          return;
        }
      }
      if (ext != TextData.csv) {
        Toast.show(TextData.fileNotSupported, context);
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
        _fileNumbers.add(
          removeextraCharFromNumber(number),
        );
      }, onDone: () {
        _filename.add(name);
      }, onError: (e) {});
      error = false;
      notifyListeners();
    }
  }

  getcontactsfromphone(BuildContext context) async {
    _display = Display.PHONECONTACTS;
    notifyListeners();
  }

  getbacktosendmessageScreen() {
    _display = Display.SENDMESSAGE;
    error = false;
    notifyListeners();
  }

  convertListtoString(List<String> numbers) {
    String numberdata = "";
    for (int i = 0; i <= numbers.length; i++) {
      numberdata += numbers[i];
      if (numbers.length - 1 == i) {
        break;
      }
      numberdata += "+";
    }
    return numberdata;
  }

  /// This Method validates the MessageBox and if MessageBox isNotEmpty
  /// then it will save the form and save the content to [usermessage].
  validateMessageBox() {
    final form = _quicksend.currentState;
    if (!form.validate()) {
      seterror(true, errorText: TextData.pleaseTypeMessage);
      return false;
    }
    print(true);
    form.save();
    return true;
  }

  /// Remove Extra Char Like '91', 'Empty Space' ,
  /// '-' , '(' , ')', '+' from Number String.
  removeextraCharFromNumber(String number) {
    return number
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
  }

  bool isLenghtNotZero(int data) {
    if (data == 0) return true;
    return false;
  }

  resetform({bool errorT = false}) {
    filenumbers.clear();
    phonenumbers.clear();
    usermessage = null;
    error = errorT;
    addnumberkey.currentState.reset();
    quicksend.currentState.reset();
    msgCountReset(notify: false);
    charleftReset(notify: false);
    notifyListeners();
  }

  /// Redirect to onChangedMessageValue Of Textbox in Message is Typed.
  onChangeMessageValueTimer(value) {
    const duration = Duration(milliseconds: 1000);
    if (_searchOnStoppedTyping != null) _searchOnStoppedTyping.cancel();
    _searchOnStoppedTyping = new Timer(duration, () {
      onChangedMessageValue(value);
    });
  }

  /// Updates the Character And Message Count value.
  onChangedMessageValue(value) {
    _error = false;
    int l = value.length;
    if (value.isEmpty) {
      charleft = msgCount = 0;
      notifyListeners();
      return;
    }
    if (!RegExp(TextData.regExpOnMessageSendPage,
            multiLine: true, caseSensitive: false)
        .hasMatch(value.split(" ").join(""))) {
      msgCount = (l ~/ maxEnglishChars).toInt();
      charleft = maxEnglishChars - (l - (msgCount * maxEnglishChars));
      msgCount++;
      notifyListeners();
      return;
    } else {
      msgCount = (l ~/ maxNonEnglishChars).toInt();
      charleft = maxNonEnglishChars - (l - (msgCount * maxNonEnglishChars));
      msgCount++;
      notifyListeners();
    }
  }

  validateusernumberentered(String value) {
    if (!Validation.isNumberorComma(value)) {
      seterror(true, errorText: TextData.notsupported);
      return false;
    }
    if (!isNumberLengthCorrect(value)) {
      if (wrongMobileNumber == "")
        seterror(true, errorText: TextData.removecommafromLast);
      else
        seterror(true, errorText: TextData.wrongnumberis + wrongMobileNumber);
      return false;
    }
    return true;
  }

  bool isNumberLengthCorrect(value) {
    wrongMobileNumber = null;
    bool r = true;
    List<String> numbers = value.split(",");
    numbers.forEach(
      (element) {
        if (Validation.isSpace(element) ||
            Validation.isNull(element) ||
            Validation.isEqualtoValue(element, 0) ||
            !Validation.isEqualtoValue(element, 10)) {
          wrongMobileNumber = element;
          r = false;
        } else
          r = true;
      },
    );
    return r;
  }

  updateScreen() {
    notifyListeners();
  }
}
