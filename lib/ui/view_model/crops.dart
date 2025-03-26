import 'dart:ffi';

import 'package:dibano/data/database_handler.dart';
import 'package:dibano/data/model/completeCrop_model.dart';
import 'package:dibano/data/model/cropdate_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dibano/data/model/crop_model.dart';

class CropsViewModel extends ChangeNotifier {
  final DatabaseHandler _databaseHandler = DatabaseHandler();

  List<CropDate> _cropDateList = [];
  List<CropDate> get cropDateList => _cropDateList;

  List<CompleteCrop> _completeCrop = [];
  List<CompleteCrop> get completeCrop => _completeCrop;

  List<Crop> _cropList = [];
  List<Crop> get cropList => _cropList;

  String tableName = "Crop";

  Future<void> add(String cropName, DateTime startDate, DateTime endDate, int fieldId) async{
    Crop crop = Crop(cropName: cropName);
    int cropId = await crop.insertReturnId(crop);


    CropDate cropDate = CropDate(startDate: startDate.toIso8601String(), endDate: endDate.toIso8601String(), cropId: cropId, fieldId: fieldId);
    await cropDate.insert();
    notifyListeners();
  }

  Future<void> getCrops() async{
    _cropList = await Crop.getAll();
    _cropDateList = await CropDate.getAll();
    notifyListeners();
  }

  Future<void> remove(int id) async{
    CropDate removeCropDate = _cropDateList.firstWhere((crop) => crop.id == id);
    _cropDateList.removeWhere((crop)=>crop.id==id);
    await removeCropDate.delete();
  }

  Future<void> update(String cropName, DateTime startDate, DateTime endDate, int fieldId, int cropId, int cropDateId) async{
    Crop crop = Crop(id: cropId, cropName: cropName);
    await crop.update();

    CropDate cropDate = CropDate(id:cropDateId, startDate: startDate.toIso8601String(), endDate: endDate.toIso8601String(), cropId: cropId, fieldId: fieldId);
    cropDate.update();

    await getCrops();
    notifyListeners();
  }

  Future<void> getCompleteCrops() async{
    _completeCrop = await CompleteCrop.getCompleteCrops();
    notifyListeners();
  }

  String getCropName(int fieldId, DateTime date){
    for (CompleteCrop crop in _completeCrop){
      if(fieldId == crop.fieldId){
        DateTime startDate = DateTime.parse(crop.startDate);
        DateTime endDate = DateTime.parse(crop.endDate);
        if(date.isAtSameMomentAs(startDate) ||
           date.isAtSameMomentAs(endDate)||
           (date.isAfter(startDate) && date.isBefore(endDate))){
            return crop.cropName;
           }
      }
    }
    return "unbekannt";
  }
}
