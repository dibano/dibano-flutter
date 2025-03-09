import 'package:flutter/widgets.dart';

class FieldsViewModel extends ChangeNotifier {
  List<String> _fields = ["Feld A", "Feld B", "Feld C", "Feld D", "Feld E"];

  List<String> getFields() {
    return _fields;
  }

  void addField(String field) {
    _fields.add(field);
    notifyListeners();
  }

  void removeField(String field) {
    _fields.remove(field);
    notifyListeners();
  }

  void updateFields(int index, String newField) {
    if (index >= 0 && index < _fields.length) {
      _fields[index] = newField;
      notifyListeners();
    }
  }
}
