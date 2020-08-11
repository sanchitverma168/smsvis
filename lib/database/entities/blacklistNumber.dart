import 'package:floor/floor.dart';

@entity
class BlackListedNumber {
  @primaryKey
  String id;
  String number;
  String date;
  String time;

  BlackListedNumber(this.id, this.number, this.date, this.time);
}
