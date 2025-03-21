import 'package:dibano/data/database_handler.dart';
import 'package:dibano/data/model/workstepActivity_model.dart';
import 'package:dibano/data/model/workstep_model.dart';
import 'package:dibano/ui/view_model/people.dart';
import 'package:flutter/widgets.dart';
import 'package:dibano/data/model/field_model.dart';
import 'package:dibano/data/model/person_model.dart';
import 'package:dibano/data/model/crop_model.dart';


class TrackActivetiesViewModel extends ChangeNotifier {
  List<Workstep> _worksteps = [];
  List<Workstep> get worksteps => _worksteps;
  String tableName = "Workstep";

  Future<void> add(String description, String person, int activityId) async{
    Workstep workstep = Workstep(cropDateId: 0, description: description, person: person);
    //int workstepId = await workstep.insertWorkstep(0, description, person);

    //WorkstepActivity workstepActivity = WorkstepActivity(workstepId: workstepId, activityId: activityId);
    //await workstepActivity.insert();

    notifyListeners();
  }

  Future<void> getAll() async{
    //_worksteps = await Workstep.getAll();
  }

  /*Future<void> remove(int id) async{
    Crop removeCrop = _crops.firstWhere((crop) => crop.id == id);
    _crops.removeWhere((crop)=>crop.id==id);
    await removeCrop.delete();
  }

  Future<void> update(int id, String cropName) async{
    Crop crop = Crop(id:id, cropName: cropName);
    await crop.update();
    await getCrops();
    notifyListeners();
  }*/
}
