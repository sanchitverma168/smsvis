import 'package:floor/floor.dart';

@entity
class FavouriteList {
  @primaryKey
  final String id;

  final String name;

  FavouriteList(this.id, this.name);
}
