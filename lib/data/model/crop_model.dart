import 'package:dibano/data/model/database_model.dart';

class Crop extends DatabaseModel{
  @override
  final int? id;
  final String cropName;

  Crop({
      this.id,
      required this.cropName
  });
  
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

}