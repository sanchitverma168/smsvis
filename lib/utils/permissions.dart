import 'package:permission_handler/permission_handler.dart';

class GetPermission {
  isContactPermitted() async {
    var status = await Permission.contacts.status;
    // print("inside GetPermission $status");
    return validatepermission(status);
  }

  bool validatepermission(var status) {
    // print("inside validatePermission $status");
    if (status == PermissionStatus.undetermined ||
        status == PermissionStatus.denied ||
        status == PermissionStatus.permanentlyDenied ||
        status == PermissionStatus.restricted) {
      // print("false");
      return false;
    }
    // print("true");
    return true;
  }
}
