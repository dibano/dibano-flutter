import 'package:dibano/data/database_handler.dart';
import 'package:dibano/data/model/database_model.dart';

class Workstep extends DatabaseModel{
  @override
  final int? id;
  final String description;
  final int personId;
  final int cropdateId;
  final String date;
  final dbHandler = DatabaseHandler();
  
  Workstep({
      this.id,
      required this.description,
      required this.personId,
      required this.cropdateId,
      required this.date,
  });

  static Future<List<Workstep>> getAll() async{
    return await DatabaseModel.dbHandler.worksteps();
  }

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  @override
  Map<String, Object?> toMap() {
    return {
      'id': id, 
      'description': description, 
      'personId': personId, 
      'cropDateId': cropdateId, 
      'date': date, 
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'workstep{id: $id, description: $description, personId: $personId, cropDateId: $cropdateId, date: $date}';
  }

  @override
  String get tableName => 'Workstep';

}