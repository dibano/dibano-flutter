import 'package:dibano/data/database_handler.dart';
import 'package:flutter/widgets.dart';
import 'package:dibano/data/model/field_model.dart';

class TrackActivetiesViewModel extends ChangeNotifier {
  final DatabaseHandler _databaseHandler = DatabaseHandler();
  List<String> _fields = [];
  List<String> get fieldsList => _fields;

  Future<void> getFields() async{
    List<Field> fields = await _databaseHandler.fields();
    _fields = fields.map((field) => field.fieldName).toList();
    notifyListeners();
  }
}
