import 'package:dibano/data/model/completeWorkstep_model.dart';
import 'package:dibano/data/model/workstepActivity_model.dart';
import 'package:dibano/data/model/workstep_model.dart';
import 'package:flutter/widgets.dart';

class WorkstepSummaryViewModel extends ChangeNotifier {
  List<CompleteWorkstep> _completeWorksteps = [];
  List<CompleteWorkstep> get completeWorksteps => _completeWorksteps;

  List<CompleteWorkstep> _filteredWorksteps = [];
  List<CompleteWorkstep> get filteredWorksteps => _filteredWorksteps;

  List<WorkstepActivity> _workstepActivList = [];
  List<WorkstepActivity> get workstepActivList => _workstepActivList;

  List<Workstep> _worksteps = [];
  List<Workstep> get worksteps => _worksteps;

  Future<void> getCompleteWorksteps() async {
    _worksteps = await Workstep.getAll();
    _workstepActivList = await WorkstepActivity.getAll();

    _completeWorksteps = await CompleteWorkstep.getCompleteWorksteps();
    _filteredWorksteps = _completeWorksteps;
    notifyListeners();
  }

  void sortCompleteWorksteps(int sortType) {
    switch (sortType) {
      case 1:
        _completeWorksteps.sort((a, b) => a.fieldName.compareTo(b.fieldName));
        break;
      case 2:
        _completeWorksteps.sort(
          (a, b) => a.activityName.compareTo(b.activityName),
        );
        break;
      case 3:
        _completeWorksteps.sort((a, b) => a.date.compareTo(b.date));
        break;
    }
    notifyListeners();
  }

  Future<void> remove(int id) async {
    Workstep workstep = _worksteps.firstWhere((workstep) => workstep.id == id);
    _worksteps.removeWhere((workstep) => workstep.id == id);
    workstep.delete();

    WorkstepActivity workstepActivity = _workstepActivList.firstWhere(
      (workstepActivity) => workstepActivity.workstepId == id,
    );
    _workstepActivList.removeWhere(
      (workstepActivity) => workstepActivity.workstepId == id,
    );
    workstepActivity.delete();

    await getCompleteWorksteps();
    notifyListeners();
  }

  void filterCompleteWorkstepsByIds({
    String? selectedFieldName,
    String? selectedActivityName,
    String? selectedPersonId,
    DateTime? selectedStartDate,
    DateTime? selectedEndDate,
  }) {
    _filteredWorksteps =
        _completeWorksteps.where((workstep) {
          final matchesField =
              selectedFieldName == null ||
              selectedFieldName == "-1" ||
              workstep.fieldName.toString() == selectedFieldName;

          final matchesActivity =
              selectedActivityName == null ||
              selectedActivityName == "-1" ||
              workstep.activityName.toString() == selectedActivityName;

          final matchesPerson =
              selectedPersonId == null ||
              selectedPersonId == "-1" ||
              workstep.personId.toString() == selectedPersonId;

          final workstepDate = DateTime.parse(workstep.date);

          final matchesStartDate =
              selectedStartDate == null ||
              workstepDate.isAfter(selectedStartDate) ||
              workstepDate.isAtSameMomentAs(selectedStartDate);

          final matchesEndDate =
              selectedEndDate == null ||
              workstepDate.isBefore(selectedEndDate) ||
              workstepDate.isAtSameMomentAs(selectedEndDate);

          return matchesField &&
              matchesActivity &&
              matchesPerson &&
              matchesStartDate &&
              matchesEndDate;
        }).toList();

    notifyListeners();
  }
}
