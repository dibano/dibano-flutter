import 'package:dibano/data/model/database_model.dart';

class CompleteCrop{
  final int id;
  final int fieldId;
  final String fieldName;
  final double? fieldSize;
  final String cropName;
  final String startDate;
  final String endDate;
  final int cropDateId;
  
  CompleteCrop({
    required this.id,
    required this.fieldId,
    required this.cropName,
    required this.fieldName,
    this.fieldSize,
    required this.startDate,
    required this.endDate,
    required this.cropDateId
  });

  factory CompleteCrop.fromMap(Map<String, Object?> completeCropMap) {
    return CompleteCrop(id: completeCropMap['id'] as int,
                        fieldId: completeCropMap['fieldId'] as int,
                        cropName: completeCropMap['cropName'] as String,
                        fieldName: completeCropMap['fieldName'] as String,
                        fieldSize: completeCropMap['fieldSize'] as double?, 
                        startDate: completeCropMap['startDate'] as String,
                        endDate: completeCropMap['endDate'] as String,
                        cropDateId: completeCropMap['cropDateId'] as int,
                      );
  }

  static Future<List<CompleteCrop>> getCompleteCrops() async{
    return await DatabaseModel.dbHandler.completeCrops();
  }
}
