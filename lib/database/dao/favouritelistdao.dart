import 'package:Smsvis/database/entities/favourtielist.dart';
import 'package:floor/floor.dart';
// import 'package:'

@dao
abstract class FavouriteListDao {
  @Query('Select * from favouritelist')
  Future<List<FavouriteList>> getlist();

  @insert
  Future<void> insertlist(FavouriteList list);
}
