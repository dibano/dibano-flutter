import 'package:dibano/data/model/completeWorkstep_model.dart';
import 'package:dibano/data/model/workstep_model.dart';
import 'package:flutter/widgets.dart';

class ActivitySummaryViewModel extends ChangeNotifier {
  List<CompleteWorkstep> _completeWorksteps = [];
  List<CompleteWorkstep> get completeWorksteps => _completeWorksteps;
  String tableName = "CompleteWorkstep";

  Future<void> getCompleteWorksteps() async{
    _completeWorksteps = await CompleteWorkstep.getCompleteWorksteps();
    print(_completeWorksteps);
    notifyListeners();
  }
}