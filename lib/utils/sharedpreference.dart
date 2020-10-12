import 'package:shared_preferences/shared_preferences.dart';

class SharedData {
  var sp;

  /// Initaite the Storage;
  Future<SharedPreferences> initshareprefer() async {
    sp = await SharedPreferences.getInstance();
    return sp;
  }

  /// Returs [username];
  get username async {
    SharedPreferences storage = await initshareprefer();
    return storage.getStringList("loginCredentials") == null
        ? false
        : storage.getStringList("loginCredentials")[0];
  }

  /// Return password [password];
  get password async {
    SharedPreferences storage = await initshareprefer();
    return storage.getStringList("loginCredentials") == null
        ? false
        : storage.getStringList("loginCredentials")[1];
  }

  /// Check Whether the App is Loaded First Time Or Not;
  get isNotfirsttime async {
    SharedPreferences storage = await initshareprefer();
    if (storage.getBool("firsttime") == null) {
      this.setfirstime(true);
      return true;
    }
    return true;
  }

  /// Returns [Boolean Value]  whether the user is Logged In or not;
  islogin() async {
    if (await this.username == false) return false;
    return true;
  }

  ///  Stores [username] and [password] in Shared Preferences Storage;
  Future<bool> setlogincredentials(
    String id,
    String password,
  ) async {
    SharedPreferences storage = await initshareprefer();

    List<String> data = new List();
    data.add(id);
    data.add(password);
    await storage.setStringList("loginCredentials", data);
    return true;
  }

  /// Sets Users Logged In For the First Time;
  Future<bool> setfirstime(
    bool isfirstime,
  ) async {
    SharedPreferences storage = await initshareprefer();
    await storage.setBool("firsttime", isfirstime);
    return true;
  }

  /// Clears the [Storage];
  Future<void> logout() async {
    SharedPreferences storage = await initshareprefer();
    storage.remove("loginCredentials");
    return true;
  }
}
