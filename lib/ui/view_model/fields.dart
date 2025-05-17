import 'package:flutter/widgets.dart';
import 'package:dibano/data/model/field_model.dart';

class FieldsViewModel extends ChangeNotifier {
  List<Field> _fields = [];
  List<Field> get fields => _fields;
  List<Map<String, double>> _fieldCoordinates = [];
  List<Map<String, double>> get fieldCoordinates => _fieldCoordinates;

  Future<void> addField(String fieldName, String fieldSize, String? latitude, String? longitude) async{
    Field field = Field(fieldName: fieldName, fieldSize: double.parse(fieldSize), latitude: latitude != null ? double.tryParse(latitude) : null, longitude: longitude != null ? double.tryParse(longitude) : null);
    await field.insert();
    await getLastCoordinates();
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
    await getLastCoordinates();
    notifyListeners();
  }

  Future<void> update(int id, String fieldName, String fieldSize, String? latitude, String? longitude) async{
    Field field = Field(id: id, fieldName: fieldName, fieldSize: double.parse(fieldSize), latitude: latitude != null ? double.tryParse(latitude) : null, longitude: longitude != null ? double.tryParse(longitude) : null);
    await field.update();
    await getLastCoordinates();
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

  Future<void> getLastCoordinates() async{
    _fields = await Field.getAll();
    if(_fields.isNotEmpty){
      Field lastField = _fields.last;
      double? longitude = lastField.longitude;
      double? latitude = lastField.latitude;
      _fieldCoordinates = [{"latitude":latitude ?? 0, "longitude": longitude ?? 0}];
    }
    else{
      _fieldCoordinates=[];
    }
    notifyListeners();
  }

}
