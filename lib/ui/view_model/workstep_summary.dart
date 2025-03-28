import 'package:dibano/data/model/completeWorkstep_model.dart';
import 'package:flutter/widgets.dart';

class WorkstepSummaryViewModel extends ChangeNotifier {
  List<CompleteWorkstep> _completeWorksteps = [];
  List<CompleteWorkstep> get completeWorksteps => _completeWorksteps;

  Future<void> getCompleteWorksteps() async{
    _completeWorksteps = await CompleteWorkstep.getCompleteWorksteps();
    notifyListeners();
  }

  void sortCompleteWorksteps(int sortType){
    switch(sortType){
      case 1:
        _completeWorksteps.sort((a,b) => a.fieldName.compareTo(b.fieldName));
        break;
      case 2:
        _completeWorksteps.sort((a,b) => a.activityName.compareTo(b.activityName));
        break;
      case 3:
        _completeWorksteps.sort((a,b) => a.date.compareTo(b.date));
        break;
    }
    notifyListeners();
  }
}