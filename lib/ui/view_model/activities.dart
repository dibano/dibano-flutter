import 'package:flutter/widgets.dart';
import 'package:dibano/data/model/activity_model.dart';

class ActivitiesViewModel extends ChangeNotifier {
  List<Activity> _activities = [];
  List<Activity> get activities => _activities;

  Future<void> add(String activityName) async{
    Activity activity = Activity(activityName: activityName);
    await activity.insert();
    notifyListeners();
  }

  Future<void> getActivities() async{
    _activities = await Activity.getAll();
    notifyListeners();
  }

  Future<void> remove(int id) async{
    Activity removeActivity = _activities.firstWhere((activity) => activity.id == id);
    _activities.removeWhere((activity)=>activity.id==id);
    await removeActivity.delete();
    notifyListeners();
  }

  Future<void> update(int id, String activityName) async{
    Activity activity = Activity(id:id, activityName: activityName);
    await activity.update();
    notifyListeners();
  }

  bool checkIfExisting(String activityName){
    for(Activity activity in _activities){
      if(activity.activityName == activityName){
        return true;
      }
    }
    return false;
  }
}
