import 'package:dibano/data/model/database_model.dart';

class Field extends DatabaseModel{
  @override
  final int? id;
  final String fieldName;
  final double fieldSize;
  final double? longitude;
  final double? latitude;
  static String table = "Field";

  Field({
      this.id,
      required this.fieldName,
      required this.fieldSize,
      this.longitude,
      this.latitude,
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
      'fieldName': fieldName,
      'fieldSize': fieldSize,
      'longitude': longitude,
      'latitude': latitude

    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Field{id: $id, fieldName: $fieldName, fieldSize: $fieldSize, longitude: $longitude, latitude: $latitude}';
  }
  
  @override
  String get tableName => table;

}