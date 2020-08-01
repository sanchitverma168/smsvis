import 'package:floor/floor.dart';

import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';

import 'dao/contactdao.dart';
import 'dao/favouritelistdao.dart';
import 'dao/tempdao.dart';
import 'entities/contact.dart';
import 'entities/favourtielist.dart';
import 'entities/temp.dart';

part 'db.g.dart';

@Database(
    version: 1,
    entities: [LocalContact, FavouriteList, PastContactsSendMessage])
abstract class AppDatabase extends FloorDatabase {
  ContactDao get contact;
  FavouriteListDao get fl;
  PastContactsSendMessageDao get pcsm;
}
