import 'package:dibano/data/model/completeCrop_model.dart';
import 'package:dibano/data/model/cropdate_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dibano/data/model/crop_model.dart';

class CropsViewModel extends ChangeNotifier {
  List<CropDate> _cropDateList = [];
  List<CropDate> get cropDateList => _cropDateList;

  List<CompleteCrop> _completeCrop = [];
  List<CompleteCrop> get completeCrop => _completeCrop;

  List<Crop> _cropList = [];
  List<Crop> get cropList => _cropList;

  Future<void> add(
    String cropName,
    DateTime startDate,
    DateTime endDate,
    int fieldId,
  ) async {
    Crop crop = Crop(cropName: cropName);
    int cropId = await crop.insertReturnId();

    CropDate cropDate = CropDate(
      startDate: startDate.toIso8601String(),
      endDate: endDate.toIso8601String(),
      cropId: cropId,
      fieldId: fieldId,
    );
    await cropDate.insert();
    notifyListeners();
  }

  Future<void> getCrops() async {
    _cropList = await Crop.getAll();
    _cropDateList = await CropDate.getAll();
    notifyListeners();
  }

  Future<void> remove(int id) async {
    CropDate removeCropDate = _cropDateList.firstWhere((crop) => crop.id == id);
    _cropDateList.removeWhere((crop) => crop.id == id);
    await removeCropDate.delete();
    notifyListeners();
  }

  Future<void> update(
    String cropName,
    DateTime startDate,
    DateTime endDate,
    int fieldId,
    int cropId,
    int cropDateId,
  ) async {
    Crop crop = Crop(id: cropId, cropName: cropName);
    await crop.update();

    CropDate cropDate = CropDate(
      id: cropDateId,
      startDate: startDate.toIso8601String(),
      endDate: endDate.toIso8601String(),
      cropId: cropId,
      fieldId: fieldId,
    );
    cropDate.update();
    notifyListeners();
  }

  Future<void> getCompleteCrops() async {
    _completeCrop = await CompleteCrop.getCompleteCrops();
    notifyListeners();
  }

  String getCropName(int fieldId, DateTime date) {
    final dateWithoutTime = DateTime(date.year, date.month, date.day);
    for (CompleteCrop crop in _completeCrop) {
      if (fieldId == crop.fieldId) {
        final startDate = DateTime.parse(crop.startDate);
        final endDate = DateTime.parse(crop.endDate);

        final start = DateTime(startDate.year, startDate.month, startDate.day);
        final end = DateTime(endDate.year, endDate.month, endDate.day);

        if (dateWithoutTime.isAtSameMomentAs(start) ||
            dateWithoutTime.isAtSameMomentAs(end) ||
            (dateWithoutTime.isAfter(start) && dateWithoutTime.isBefore(end))) {
          return crop.cropName;
        }
      }
    }
    return "unbekannt";
  }

  bool existingCropAtDateAndField(
    int fieldId,
    DateTime startDate,
    DateTime endDate,
    int? excludeCrop,
  ) {
    final startDateWithoutTime = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
    );
    final endDateWithoutTime = DateTime(
      endDate.year,
      endDate.month,
      endDate.day,
    );

    for (CompleteCrop crop in _completeCrop.where(
      (existingCrop) => existingCrop.fieldId == fieldId,
    )) {
      if (excludeCrop != null && crop.id == excludeCrop) {
        continue;
      }
      if (fieldId == crop.fieldId) {
        final startDate = DateTime.parse(crop.startDate);
        final endDate = DateTime.parse(crop.endDate);

        final start = DateTime(startDate.year, startDate.month, startDate.day);
        final end = DateTime(endDate.year, endDate.month, endDate.day);

        if ((startDateWithoutTime.isAtSameMomentAs(start) ||
                startDateWithoutTime.isAtSameMomentAs(end) ||
                endDateWithoutTime.isAtSameMomentAs(start) ||
                endDateWithoutTime.isAtSameMomentAs(end)) ||
            ((startDateWithoutTime.isBefore(start) &&
                    endDateWithoutTime.isAfter(start)) ||
                (startDateWithoutTime.isBefore(end) &&
                    endDateWithoutTime.isAfter(end)) ||
                (startDateWithoutTime.isAfter(start) &&
                    endDateWithoutTime.isBefore(end)))) {
          return true;
        }
      }
    }
    return false;
  }

  bool endIsBeforeStart(DateTime startDate, DateTime endDate) {
    final startDateWithoutTime = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
    );
    final endDateWithoutTime = DateTime(
      endDate.year,
      endDate.month,
      endDate.day,
    );
    if (startDateWithoutTime.isAfter(endDateWithoutTime)) {
      return true;
    }
    return false;
  }
}
