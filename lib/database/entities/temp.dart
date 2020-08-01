import 'package:floor/floor.dart';

@entity
class PastContactsSendMessage {
  @primaryKey
  final String id;
  final int contactcount;
  final String msg;

  PastContactsSendMessage(this.id, this.contactcount, this.msg);
}
