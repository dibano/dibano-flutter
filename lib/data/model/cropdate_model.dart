import 'package:dibano/data/model/database_model.dart';

class CropDate extends DatabaseModel{
  @override
  final int? id;
  final DateTime startDate;
  final DateTime endDate;
  final int cropId;
  final int fieldId;
  
  CropDate({
      this.id,
      required this.startDate,
      required this.endDate,
      required this.cropId,
      required this.fieldId,
  });
  
  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  @override
  Map<String, Object?> toMap() {
    return {
      'id': id, 
      'startDate': startDate, 
      'endDate': endDate, 
      'cropId': cropId, 
      'fieldId': fieldId, 
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'cropDate{id: $id, startDate: $startDate, endDate: $endDate, cropId: $cropId, fieldId: $fieldId}';
  }

}