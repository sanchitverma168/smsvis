import 'package:Smsvis/utils/stringtext.dart';

class Validation {
  Validation._();

  /// [String value]
  static bool isEqualtoValue(String value, int length) {
    if (value.length == length) return true;
    return false;
  }

  static bool isSpace(value) {
    if (value == TextData.emptyStringSpace) return true;
    return false;
  }

  static bool isNumberorComma(value) {
    if (RegExp("[^0-9,]", multiLine: true, caseSensitive: false)
        .hasMatch(value)) return false;
    return true;
  }

  static bool isNull(value) {
    if (value == null) return true;
    return false;
  }

  static bool isContainSpace(String value) {
    if (value.contains(" ")) return true;
    return false;
  }
}
