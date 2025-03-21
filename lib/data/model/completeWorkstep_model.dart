import 'package:dibano/data/model/database_model.dart';

class CompleteWorkstep{
  final int id;
  final int workstepActivityId;
  final int workstepId;
  final int activityId;
  final int personId;
  final String fieldName;
  final String cropName;
  final String activityName;
  final String description;
  
  CompleteWorkstep({
    required this.id,
    required this.workstepActivityId,
    required this.workstepId,
    required this.activityId,
    required this.personId,
    required this.fieldName,
    required this.cropName,
    required this.activityName,
    required this.description,
  });

  factory CompleteWorkstep.fromMap(Map<String, Object?> completeWorkstepMap) {
    return CompleteWorkstep(id: completeWorkstepMap['id'] as int,
                        workstepActivityId: completeWorkstepMap['workstepActivityId'] as int,
                        workstepId: completeWorkstepMap['workstepId'] as int,
                        activityId: completeWorkstepMap['activityId'] as int,
                        personId: completeWorkstepMap['personId'] as int,
                        cropName: completeWorkstepMap['cropName'] as String,
                        fieldName: completeWorkstepMap['fieldName'] as String, 
                        activityName: completeWorkstepMap['activityName'] as String,
                        description: completeWorkstepMap['description'] as String,
                      );
  }

  static Future<List<CompleteWorkstep>> getCompleteWorksteps() async{
    return await DatabaseModel.dbHandler.completeWorksteps();
  }
}