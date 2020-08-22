import 'package:Smsvis/utils/permissions.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

enum ScreenContent {
  isDeviceContacts,
  isSearchContacts,
  isError,
  isloading,
  isNoContactFound
}

class ImportContact with ChangeNotifier {
  List<Contact> _searchedContacts = new List();
  // List<Contact> get searchedContacts => _searchedContacts;
  List<Contact> _deviceContacts = new List();
  List<Contact> get deviceContacts => _deviceContacts;
  List<Contact> _showContacts = new List();
  List<Contact> get showContacts => _showContacts;
  List<int> _selectedContactsindex;
  List<int> get selectedContactsindex => _selectedContactsindex;
  List<int> _searchContactsIndex;
  List<int> get searchContactsIndex => _searchContactsIndex;
  ScreenContent _screenContent = ScreenContent.isloading;
  ScreenContent get screenContent => _screenContent;
  bool _selectAllContacts = false;
  bool get selectAllContacts => _selectAllContacts;
  int _countContacts = 0;
  int get countContacts => _countContacts;
  int _maxIndex = 0;
  bool _selectedAllContacts = false;
  bool get selectedAllContacts => _selectedAllContacts;

  init() async {
    _screenContent = ScreenContent.isDeviceContacts;
    var getPermission = new GetPermission();
    var result = await getPermission.isContactPermitted();
    if (result) {
      await readContacts();
      await initContactselectedlist();
      return screenUpdate(_deviceContacts);
    } else
      _screenContent = ScreenContent.isError;
    notifyListeners();
  }

  Future readContacts() async {
    _deviceContacts = (await ContactsService.getContacts(
            withThumbnails: false, iOSLocalizedLabels: false))
        .toList();
  }

  screenUpdate(
    List<Contact> contacts,
  ) {
    _showContacts = new List();

    if (contacts.length == 0) _screenContent = ScreenContent.isNoContactFound;

    _showContacts.addAll(contacts);

    notifyListeners();
  }

  initContactselectedlist({List<int> indexlist}) {
    _selectedContactsindex = new List(_deviceContacts.length);
    if (indexlist != null) {
      for (int i = 0; i < _deviceContacts.length; i++) {
        for (int j = 0; j < indexlist.length; j++) {
          i == indexlist[j]
              ? _selectedContactsindex[i] = 1
              : _selectedContactsindex[i] = 0;
        }
      }
    } else {
      for (int j = 0; j < _deviceContacts.length; j++)
        _selectedContactsindex[j] = 0;
    }
  }

  updateindex(int index) {
    // print("inside $index");
    if (_selectedContactsindex[index] == 1) {
      _selectedContactsindex[index] = 0;
      _countContacts--;
    } else {
      _selectedContactsindex[index] = 1;
      if (_maxIndex < index) _maxIndex = index;
      _countContacts++;
    }
    for (int i = 0; i < _selectedContactsindex.length; i++) {
      if (_selectedContactsindex[i] == 1) {
        _selectedAllContacts = true;
        continue;
      }
      _selectedAllContacts = false;
      break;
    }
    notifyListeners();
  }

  toggleSelectAll() {
    for (int i = 0; i < _selectedContactsindex.length; i++) {
      _selectedAllContacts == true
          ? _selectedContactsindex[i] = 0
          : _selectedContactsindex[i] = 1;
    }
    _selectedAllContacts == false
        ? _maxIndex = _selectedContactsindex.length
        : _maxIndex = 0;
    _selectedAllContacts = !_selectedAllContacts;

    notifyListeners();
  }

  search(String value) {
    // print("abc");
    // print("1");
    _showContacts.clear();
    // print("2");
    // print(_searchContactsIndex);
    _showContacts = new List();
    _searchContactsIndex != null ?? _searchContactsIndex.clear();
    // print("3");
    // print(_searchContactsIndex);
    _searchContactsIndex = new List();
    _searchedContacts != null ?? _searchedContacts.clear();
    // print("4");

    _searchedContacts = new List();
    for (int i = 0; i < _deviceContacts.length; i++) {
      // print("5");
      Contact c = _deviceContacts[i];
      // print("5a");
      String displayName = c.displayName.toLowerCase();
      // print("5b");
      if (c.phones.toList().length != 0) {
        String number = c.phones.toList().first.value;
        // print("5c");
        if (displayName.contains(value) || number.contains(value)) {
          // print("5e");
          // print("i ${_searchedContacts.length}");
          _searchedContacts.add(c);
          // print("i ${_searchedContacts.length}");

          // print("5f");
          _searchContactsIndex.add(i);
          // print("5g");
        }
      }
      // print("5h");
    }
    // print("6");
    if (_searchedContacts.length > 0) {
      // print("7");
      _screenContent = ScreenContent.isSearchContacts;
      // print("8");
      _showContacts.addAll(_searchedContacts);
      // print("9");
    } else
      _screenContent = ScreenContent.isNoContactFound;
    // print("10");
    if (value.length == 0) {
      // print("11");
      _screenContent = ScreenContent.isDeviceContacts;
      screenUpdate(_deviceContacts);
    }
    // print("12");
    // print(_screenContent);
    // print(_searchContactsIndex.length);
    notifyListeners();
  }

  showdeviceContactsonResetButton() {
    _screenContent = ScreenContent.isDeviceContacts;
    screenUpdate(_deviceContacts);
  }
}
