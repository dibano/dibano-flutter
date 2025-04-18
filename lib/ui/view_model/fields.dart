import 'package:flutter/widgets.dart';
import 'package:dibano/data/model/field_model.dart';

class FieldsViewModel extends ChangeNotifier {
  List<Field> _fields = [];
  List<Field> get fields => _fields;

  Future<void> addField(String fieldName, String fieldSize, String? latitude, String? longitude) async{
    Field field = Field(fieldName: fieldName, fieldSize: double.parse(fieldSize), latitude: latitude != null ? double.tryParse(latitude) : null, longitude: longitude != null ? double.tryParse(longitude) : null);
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

  Future<void> update(int id, String fieldName, String fieldSize, String? latitude, String? longitude) async{
    Field field = Field(id: id, fieldName: fieldName, fieldSize: double.parse(fieldSize), latitude: latitude != null ? double.tryParse(latitude) : null, longitude: longitude != null ? double.tryParse(longitude) : null);
    await field.update();
    notifyListeners();
  }

  bool checkIfExisting(String fieldName){
    for(Field field in _fields){
      if(field.fieldName == fieldName){
        return true;
      }
    }
    return false;
  }
}
