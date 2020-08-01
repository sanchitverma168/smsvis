import 'package:Smsvis/database/entities/contact.dart';
import 'package:floor/floor.dart';

@dao
abstract class ContactDao {
  @Query('Select * from LocalContact where temp= :temp and foreignlistid= :id')
  Future<List<LocalContact>> getcontact(bool temp, String id);

  @insert
  Future<void> insertcontacts(LocalContact contact);
}
