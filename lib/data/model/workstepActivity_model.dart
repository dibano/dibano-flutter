import 'package:dibano/data/model/database_model.dart';

class WorkstepActivity extends DatabaseModel{
  @override
  final int? id;
  final int workstepId;
  final int activityId;

  
  WorkstepActivity({
      this.id,
      required this.workstepId,
      required this.activityId,
  });
  
  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  @override
  Map<String, Object?> toMap() {
    return {
      'id': id, 
      'workstepId': workstepId, 
      'activityId': activityId, 
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'workstepActivity{id: $id, workstepId: $workstepId, activityId: $activityId';
  }

}