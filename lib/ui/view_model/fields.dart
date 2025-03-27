import 'package:flutter/widgets.dart';
import 'package:dibano/data/model/field_model.dart';

class FieldsViewModel extends ChangeNotifier {
  List<Field> _fields = [];
  List<Field> get fields => _fields;
  String tableName = "Field";

  Future<void> addField(String fieldName) async{
    Field field = Field(fieldName: fieldName);
    await field.insert();
    notifyListeners();
  }

  Future<void> getFields() async{
    _fields = await Field.getAll();
    notifyListeners();
  }

  Future<void> remove(int id) async{
    Field removeField = _fields.firstWhere((field) => field.id == id);
    _fields.removeWhere((field)=>field.id==id);
    await removeField.delete();
    notifyListeners();
  }

  Future<void> update(int id, String fieldName) async{
    Field field = Field(id:id, fieldName: fieldName);
    await field.update();
    await getFields();
    notifyListeners();
  }
}
