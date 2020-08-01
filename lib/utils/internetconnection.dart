import 'package:connectivity/connectivity.dart';

class InternetConnection {
  var connectivityResult;
  Future<ConnectivityResult> updateConnection() async {
    return connectivityResult = await (Connectivity().checkConnectivity());
  }

  Future<bool> isMobile() async {
    if (ConnectivityResult.mobile == await updateConnection()) return true;
    return false;
  }

  Future<bool> isWifi() async {
    connectivityResult = await (Connectivity().checkConnectivity());

    if (ConnectivityResult.wifi == await updateConnection()) return true;

    return false;
  }

  Future<bool> isConnected() async {
    if (await isMobile() || await isWifi()) return true;
    return false;
  }
}
