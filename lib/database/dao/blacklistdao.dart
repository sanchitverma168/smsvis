import 'package:Smsvis/database/entities/blacklistNumber.dart';
import 'package:floor/floor.dart';

@dao
abstract class BlackListDao {
  @insert
  Future<void> save(BlackListedNumber blackListedNumber);

  @Query("Select * from BlackListedNumber")
  Future<List<BlackListedNumber>> getallNumbers();

  @Query("Delete from BlackListedNumber where id= :id")
  Future<void> deleteNumber(String id);
}
