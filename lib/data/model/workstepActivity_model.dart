import 'package:dibano/data/model/database_model.dart';

class WorkstepActivity extends DatabaseModel{
  @override
  final int? id;
  final int workstepId;
  final int? activityId;

  WorkstepActivity({
      this.id,
      required this.workstepId,
      this.activityId,
  });

  static Future<List<WorkstepActivity>> getAll() async{
    return await DatabaseModel.dbHandler.workstepActivities();
  }

  // keys correspond to the names of the columns in the database
  @override
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'workstepId': workstepId,
      'activityId': activityId,
    };
  }

  // for debugging and testing, i.e. with the print statement
  @override
  String toString() {
    return 'workstepActivity{id: $id, workstepId: $workstepId, activityId: $activityId';
  }

  @override
  String get tableName => 'WorkstepActivity';

}
