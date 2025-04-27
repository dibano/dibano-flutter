import 'package:dibano/data/model/database_model.dart';

class Crop extends DatabaseModel{
  @override
  final int? id;
  final String cropName;
  static String table = "Crop";

  Crop({
      this.id,
      required this.cropName
  });

  static Future<List<Crop>> getAll() async{
    return await DatabaseModel.dbHandler.crops();
  }

  // keys correspond to the names of the columns in the database.
  @override
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'cropName': cropName
    };
  }

  // for debugging and testing, i.e. with the print statement
  @override
  String toString() {
    return 'crop{id: $id, cropName: $cropName}';
  }

  @override
  String get tableName => table;

}
