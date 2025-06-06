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
          (a, b) => (a.activityName ?? '').compareTo(b.activityName ?? ''),
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

  bool _matchesFilter<T>(List<T>? selectedValues, T value) {
    return selectedValues == null ||
        selectedValues.isEmpty ||
        selectedValues.contains(value);
  }

  void filterCompleteWorkstepsByIds({
    List<String?>? selectedFields,
    List<String?>? selectedActivities,
    List<String?>? selectedCrops,
    List<String?>? selectedPersonIds,
    List<String?>? selectedFertilizers,
    DateTime? selectedStartDate,
    DateTime? selectedEndDate,
  }) {
    _filteredWorksteps =
        _completeWorksteps.where((workstep) {
          final matchesField = _matchesFilter(
            selectedFields,
            workstep.fieldName.toString(),
          );
          final matchesCrop = _matchesFilter(
            selectedCrops,
            workstep.cropName.toString(),
          );
          final matchesActivity = _matchesFilter(
            selectedActivities,
            workstep.activityName.toString(),
          );
          final matchesPerson = _matchesFilter(
            selectedPersonIds,
            workstep.personId.toString(),
          );
          final matchesFertilizers = _matchesFilter(
            selectedFertilizers,
            workstep.fertilizerName.toString(),
          );

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
              matchesCrop &&
              matchesActivity &&
              matchesPerson &&
              matchesStartDate &&
              matchesFertilizers &&
              matchesEndDate;
        }).toList();

    notifyListeners();
  }

  void searchWorksteps(String query) {
    if (query.isEmpty) {
      _filteredWorksteps = _completeWorksteps;
    } else {
      _filteredWorksteps =
          _completeWorksteps.where((workstep) {
            final lowerCaseQuery = query.toLowerCase();

            return (workstep.activityName?.toLowerCase().contains(
                      lowerCaseQuery,
                    ) ??
                    false) ||
                (workstep.personName?.toLowerCase().contains(lowerCaseQuery) ??
                    false) ||
                workstep.cropName.toLowerCase().contains(lowerCaseQuery) ||
                workstep.fieldName.toLowerCase().contains(lowerCaseQuery) ||
                workstep.date.toLowerCase().contains(lowerCaseQuery) ||
                (workstep.fertilizerName?.toLowerCase().contains(
                      lowerCaseQuery,
                    ) ??
                    false) ||
                (workstep.description?.toLowerCase().contains(lowerCaseQuery) ??
                    false);
          }).toList();
    }
    notifyListeners();
  }

  List<String?> getPersonNameById(List<String?> selectedPersonIds) {
    return _completeWorksteps
        .where(
          (workstep) =>
              selectedPersonIds.contains(workstep.personId.toString()),
        )
        .map((workstep) => workstep.personName)
        .toList();
  }
}
