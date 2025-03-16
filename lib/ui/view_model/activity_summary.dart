import 'package:dibano/ui/view_model/components/activity_card.dart';
import 'package:flutter/widgets.dart';

class ActivitySummaryViewModel extends ChangeNotifier {
  final List<Activity> _activities = [
    Activity(
      activity: "Dügung mit 250kg Harnstoff",
      date: "23.05.2025",
      field: "Feld A Ost",
    ),
  ];

  List<Activity> getActivities() {
    return _activities;
  }

  void addActivity(Activity activity) {
    _activities.add(activity);
    notifyListeners();
  }

  void removeActivity(Activity activity) {
    _activities.remove(activity);
    notifyListeners();
  }

  void updateActivities(int index, Activity newActivity) {
    if (index >= 0 && index < _activities.length) {
      _activities[index] = newActivity;
      notifyListeners();
    }
  }
}
