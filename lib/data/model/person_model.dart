import 'package:dibano/data/model/database_model.dart';

class Person extends DatabaseModel{
  @override
  final int? id;
  final String personName;

  Person({
      this.id,
      required this.personName
  });
  
  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  @override
  Map<String, Object?> toMap() {
    return {
      'id': id, 
      'personName': personName
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'person{id: $id, personName: $personName}';
  }

}