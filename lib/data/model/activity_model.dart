import 'package:dibano/data/model/database_model.dart';

class Activity extends DatabaseModel{
  @override
  final int? id;
  final String activityName;

  Activity({
      this.id,
      required this.activityName
  });
  
  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  @override
  Map<String, Object?> toMap() {
    return {
      'id': id, 
      'activityName': activityName
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'activity{id: $id, activityName: $activityName}';
  }

}