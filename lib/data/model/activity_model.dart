import 'package:dibano/data/model/database_model.dart';

class Activity extends DatabaseModel{
  @override
  final int? id;
  final String activityName;

  Activity({
      this.id,
      required this.activityName
  });

  static Future<List<Activity>> getAll() async{
    return await DatabaseModel.dbHandler.activity();
  }

  // keys correspond to the names of the columns in the database
  @override
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'activityName': activityName
    };
  }

  // for debugging and testing, i.e. with the print statement
  @override
  String toString() {
    return 'activity{id: $id, activityName: $activityName}';
  }

  @override
  String get tableName => 'Activity';

}
