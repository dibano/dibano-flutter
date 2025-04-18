import 'package:dibano/ui/view_model/fields.dart';
import 'package:flutter/widgets.dart';
import 'package:dibano/data/model/fertilizer_model.dart';
import 'package:provider/provider.dart';

class FertilizerViewModel extends ChangeNotifier {
  List<Fertilizer> _fertilizerList = [];
  List<Fertilizer> get fertilizerList => _fertilizerList;

  Future<void> addFertilizer(String fertilizerName, String n, String p, String k) async{
    Fertilizer fertilizer = Fertilizer(fertilizerName: fertilizerName, n: double.parse(n), p: double.parse(p), k: double.parse(k));
    await fertilizer.insert();
    notifyListeners();
  }

  Future<void> getFertilizer() async{
    _fertilizerList = await Fertilizer.getAll();
    notifyListeners();
  }

  Future<void> remove(int id) async{
    Fertilizer removeFertilizer = _fertilizerList.firstWhere((fertilizer) => fertilizer.id == id);
    _fertilizerList.removeWhere((fertilizer)=>fertilizer.id==id);
    await removeFertilizer.delete();
    notifyListeners();
  }

  Future<void> update(int id, String fertilizerName, String n, String p, String k) async{
    Fertilizer fertilizer = Fertilizer(id: id, fertilizerName: fertilizerName, n: double.parse(n), p: double.parse(p), k: double.parse(k));
    await fertilizer.update();
    notifyListeners();
  }

  bool checkIfExisting(String fertilizerName){
    for(Fertilizer fertilizer in _fertilizerList){
      if(fertilizer.fertilizerName == fertilizerName){
        return true;
      }
    }
    return false;
  }

  double calcNPerField(String fertilizerId){
    Fertilizer fertilizerItem = _fertilizerList
      .firstWhere(
        (fertilizer) =>
          fertilizerId == fertilizer.id.toString(),
      );
    return fertilizerItem.n;
  }

  double calcNPerHa(String fertilizerId, double fieldSize){
    Fertilizer fertilizerItem = _fertilizerList
      .firstWhere(
        (fertilizer) =>
          fertilizerId == fertilizer.id.toString(),
      );
    return (fertilizerItem.n/fieldSize);
  }
  
  double calcPPerField(String fertilizerId){
    Fertilizer fertilizerItem = _fertilizerList
      .firstWhere(
        (fertilizer) =>
          fertilizerId == fertilizer.id.toString(),
      );
    return fertilizerItem.p;
  }

  double calcPPerHa(String fertilizerId, double fieldSize){
    Fertilizer fertilizerItem = _fertilizerList
      .firstWhere(
        (fertilizer) =>
          fertilizerId == fertilizer.id.toString(),
      );
    return (fertilizerItem.p/fieldSize);
  }

  double calcKPerField(String fertilizerId){
    Fertilizer fertilizerItem = _fertilizerList
      .firstWhere(
        (fertilizer) =>
          fertilizerId == fertilizer.id.toString(),
      );
    return fertilizerItem.k;
  }
  double calcKPerHa(String fertilizerId, double fieldSize){
    Fertilizer fertilizerItem = _fertilizerList
      .firstWhere(
        (fertilizer) =>
          fertilizerId == fertilizer.id.toString(),
      );
    return (fertilizerItem.k/fieldSize);
  }
}
