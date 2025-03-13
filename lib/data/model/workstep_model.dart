import 'package:dibano/data/model/database_model.dart';

class Workstep extends DatabaseModel{
  @override
  final int? id;
  final String description;
  final String person;
  final int cropDateId;
  
  Workstep({
      this.id,
      required this.description,
      required this.person,
      required this.cropDateId,
  });
  
  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  @override
  Map<String, Object?> toMap() {
    return {
      'id': id, 
      'description': description, 
      'person': person, 
      'cropDateId': cropDateId, 
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'workstep{id: $id, description: $description, person: $person, cropDateId: $cropDateId}';
  }

}