import 'package:dibano/data/model/database_model.dart';

class CropDate extends DatabaseModel{
  @override
  final int? id;
  final String startDate;
  final String endDate;
  final int cropId;
  final int fieldId;

  CropDate({
      this.id,
      required this.startDate,
      required this.endDate,
      required this.cropId,
      required this.fieldId,
  });

  static Future<List<CropDate>> getAll() async{
    return await DatabaseModel.dbHandler.cropDates();
  }

  // keys correspond to the names of the columns in the database
  @override
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'startDate': startDate,
      'endDate': endDate,
      'cropId': cropId,
      'fieldId': fieldId,
    };
  }

  // for debugging and testing, i.e. with the print statement
  @override
  String toString() {
    return 'cropDate{id: $id, startDate: $startDate, endDate: $endDate, cropId: $cropId, fieldId: $fieldId}';
  }

  @override
  String get tableName => 'CropDate';

}
