import 'package:floor/floor.dart';

@entity
class LocalContact {
  @primaryKey
  final String id;
  final String foreignlistid;
  final String givename;
  final String phones;
  final bool temp;

  LocalContact(
    this.id,
    this.foreignlistid,
    this.givename,
    this.phones,
    this.temp,
  );
}
