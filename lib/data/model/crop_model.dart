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

  Future<int> insertReturnId(Crop crop) async{
    int workstepId = await DatabaseModel.dbHandler.insertReturnId(this, tableName);
    return workstepId;
  }
  
  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  @override
  Map<String, Object?> toMap() {
    return {
      'id': id, 
      'cropName': cropName
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'crop{id: $id, cropName: $cropName}';
  }

  @override
  String get tableName => table;

}