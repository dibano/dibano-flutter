import 'dart:ffi';

import 'package:dibano/data/database_handler.dart';

abstract class DatabaseModel {
  int? get id;
  Map<String, Object?> toMap();
  static late DatabaseHandler dbHandler;
  String get tableName;

  Future<void> insert() async{
    dbHandler.insert(this, tableName);
  }

  Future<void> delete() async{
    dbHandler.remove(id!, tableName);
  }

  Future<void> update() async{
    dbHandler.update(this, tableName);
  }

  Future<int> insertReturnId() async{
    int id = await dbHandler.insertReturnId(this, tableName);
    return id;
  }
}