import 'package:dibano/data/database_handler.dart';
import 'package:flutter/widgets.dart';
import 'package:dibano/data/model/field_model.dart';

class FieldsViewModel extends ChangeNotifier {
  final DatabaseHandler _databaseHandler = DatabaseHandler();
  List<Field> _fields = [];
  List<Field> get fields => _fields;
  String tableName = "Field";

  Future<void> addField(String fieldName) async{
    var field = Field(fieldName: fieldName);
    await _databaseHandler.insert(field, tableName);
    notifyListeners();
  }

  Future<void> getFields() async{
    _fields = await _databaseHandler.fields();
    notifyListeners();
  }

  Future<void> remove(int id) async{
    await _databaseHandler.remove(id, tableName);
    notifyListeners();
  }

  Future<void> update(int id, String fieldName) async{
    var field = Field(id: id, fieldName: fieldName);
    await _databaseHandler.update(field, tableName);
    notifyListeners();
  }
}
