import 'package:shared_preferences/shared_preferences.dart';

class SharedData {
  var sp;

  Future<SharedPreferences> initshareprefer() async {
    sp = await SharedPreferences.getInstance();
    return sp;
  }

  get username async {
    SharedPreferences storage = await initshareprefer();
    return storage.getStringList("loginCredentials") == null
        ? false
        : storage.getStringList("loginCredentials")[0];
  }

  get password async {
    SharedPreferences storage = await initshareprefer();
    return storage.getStringList("loginCredentials") == null
        ? false
        : storage.getStringList("loginCredentials")[1];
  }

  get isNotfirsttime async {
    SharedPreferences storage = await initshareprefer();
    if (storage.getBool("firsttime") == null) {
      this.setfirstime(true);
      return true;
    }
    return true;
  }

  islogin() async {
    if (await this.username == false) return false;
    return true;
  }

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

  Future<bool> setfirstime(
    bool isfirstime,
  ) async {
    SharedPreferences storage = await initshareprefer();
    await storage.setBool("firsttime", isfirstime);
    return true;
  }

  Future<void> logout() async {
    SharedPreferences storage = await initshareprefer();
    storage.remove("loginCredentials");
    return true;
  }
}
