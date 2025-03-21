import 'package:dibano/data/model/workstepActivity_model.dart';
import 'package:dibano/data/model/workstep_model.dart';
import 'package:flutter/widgets.dart';


class TrackActivetiesViewModel extends ChangeNotifier {
  List<Workstep> _worksteps = [];
  List<Workstep> get worksteps => _worksteps;
  String tableName = "Workstep";

  Future<void> addWorkstepActivity(int cropDateId, String description, int personId, int activityId) async{
    Workstep workstep = Workstep(description: description, personId: personId, cropDateId: cropDateId);
    int workstepId = await workstep.insertReturnId(workstep);

    print("Workstep wurde gespeichert: $workstep mit der ID $workstepId");


    WorkstepActivity workstepActivity = WorkstepActivity(workstepId: workstepId, activityId: activityId);
    workstepActivity.insert();

    print("Workstepactivity wurde gespeichert: $workstepActivity");

    notifyListeners();
  }

  Future<void> updateWorkStepActivity(int cropDateId, String description, int personId, int activityId, int workstepActivityId, int workstepId) async{
    Workstep workstep = Workstep(id: workstepId, description: description, personId: personId, cropDateId: cropDateId);
    await workstep.update();

    WorkstepActivity workstepActivity = WorkstepActivity(id: workstepActivityId, workstepId: workstepId, activityId: activityId);
    workstepActivity.update();
    notifyListeners();
  }
}
