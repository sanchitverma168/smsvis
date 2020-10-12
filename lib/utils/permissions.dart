import 'package:permission_handler/permission_handler.dart';

class GetPermission {
  isContactPermitted() async {
    var status = await Permission.contacts.status;
    return validatepermission(status);
  }

  bool validatepermission(var status) {
    if (status == PermissionStatus.undetermined ||
        status == PermissionStatus.denied ||
        status == PermissionStatus.permanentlyDenied ||
        status == PermissionStatus.restricted) {
      return false;
    }
    return true;
  }
}
