import 'package:dibano/data/database_handler.dart';
import 'package:dibano/data/model/database_model.dart';

class Workstep extends DatabaseModel{
  @override
  final int? id;
  final String description;
  final int personId;
  final int cropDateId;
  final dbHandler = DatabaseHandler();
  
  Workstep({
      this.id,
      required this.description,
      required this.personId,
      required this.cropDateId,
  });

  /*static Future<List<Workstep>> getAll() async{
    return await DatabaseModel.dbHandler.worksteps();
  }*/

  Future<int> insertReturnId(Workstep workstep) async{
    int workstepId = await DatabaseModel.dbHandler.insertReturnId(this, tableName);
    return workstepId;
  }

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  @override
  Map<String, Object?> toMap() {
    return {
      'id': id, 
      'description': description, 
      'personId': personId, 
      'cropDateId': cropDateId, 
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'workstep{id: $id, description: $description, personId: $personId, cropDateId: $cropDateId}';
  }

  @override
  String get tableName => 'Workstep';

}