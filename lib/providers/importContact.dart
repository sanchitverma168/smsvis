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
    _showContacts.clear();
    _showContacts = new List();
    _searchContactsIndex != null ?? _searchContactsIndex.clear();
    _searchContactsIndex = new List();
    _searchedContacts != null ?? _searchedContacts.clear();
    _searchedContacts = new List();
    for (int i = 0; i < _deviceContacts.length; i++) {
      Contact c = _deviceContacts[i];
      String displayName = c.displayName.toLowerCase();
      if (c.phones.toList().length != 0) {
        String number = c.phones.toList().first.value;
        if (displayName.contains(value) || number.contains(value)) {
          _searchedContacts.add(c);
          _searchContactsIndex.add(i);
        }
      }
    }
    if (_searchedContacts.length > 0) {
      _screenContent = ScreenContent.isSearchContacts;
      _showContacts.addAll(_searchedContacts);
    } else
      _screenContent = ScreenContent.isNoContactFound;
    if (value.length == 0) {
      _screenContent = ScreenContent.isDeviceContacts;
      screenUpdate(_deviceContacts);
    }
    notifyListeners();
  }

  showdeviceContactsonResetButton() {
    _screenContent = ScreenContent.isDeviceContacts;
    screenUpdate(_deviceContacts);
  }
}
