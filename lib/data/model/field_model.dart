import 'package:dibano/data/model/database_model.dart';

class Field extends DatabaseModel{
  @override
  final int? id;
  final String fieldName;
  static String table = "Field";

  Field({
      this.id,
      required this.fieldName
  });

  static Future<List<Field>> getAll() async{
    return await DatabaseModel.dbHandler.fields();
  }

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  @override
  Map<String, Object?> toMap() {
    return {
      'id': id, 
      'fieldName': fieldName
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Field{id: $id, fieldName: $fieldName}';
  }
  
  @override
  String get tableName => table;

}