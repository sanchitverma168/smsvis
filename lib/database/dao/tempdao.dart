import 'package:Smsvis/database/entities/temp.dart';
import 'package:floor/floor.dart';

@dao
abstract class PastContactsSendMessageDao {
  @Query("Select * from PastContactsSendMessage")
  Future<List<PastContactsSendMessage>> getpastSendMessage();

  @insert
  Future<void> inserttemplist(PastContactsSendMessage pastContactsSendMessage);
}
