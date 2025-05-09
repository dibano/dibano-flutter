import 'package:flutter_test/flutter_test.dart';
import 'package:dibano/data/model/cropdate_model.dart';
import 'package:dibano/data/model/database_model.dart';
import 'package:dibano/data/database_handler.dart';
import 'package:mocktail/mocktail.dart';

class MockDBHandler extends Mock implements DatabaseHandler {}

void main() {
  group('CropDate', () {
    test('Constructor: with all fields', () {
      final cropDate = CropDate(
        id: 1,
        startDate: '2023-01-01',
        endDate: '2023-12-31',
        cropId: 101,
        fieldId: 202,
      );

      expect(cropDate.id, 1);
      expect(cropDate.startDate, '2023-01-01');
      expect(cropDate.endDate, '2023-12-31');
      expect(cropDate.cropId, 101);
      expect(cropDate.fieldId, 202);
    });

    test('Constructor: id is optional', () {
      final cropDate = CropDate(
        startDate: '2023-01-01',
        endDate: '2023-12-31',
        cropId: 101,
        fieldId: 202,
      );

      expect(cropDate.id, isNull);
      expect(cropDate.startDate, '2023-01-01');
      expect(cropDate.endDate, '2023-12-31');
      expect(cropDate.cropId, 101);
      expect(cropDate.fieldId, 202);
    });

    test('toMap: returns a map that corresponds to the databases column names', () {
      final cropDate = CropDate(
        id: 1,
        startDate: '2023-01-01',
        endDate: '2023-12-31',
        cropId: 101,
        fieldId: 202,
      );

      final map = cropDate.toMap();

      expect(map, {
        'id': 1,
        'startDate': '2023-01-01',
        'endDate': '2023-12-31',
        'cropId': 101,
        'fieldId': 202,
      });
    });

    test('toString: returns a string usable for debugging and logging', () {
      final cropDate = CropDate(
        id: 1,
        startDate: '2023-01-01',
        endDate: '2023-12-31',
        cropId: 101,
        fieldId: 202,
      );

      final string = cropDate.toString();

      expect(string, 'cropDate{id: 1, startDate: 2023-01-01, endDate: 2023-12-31, cropId: 101, fieldId: 202}');
    });

    test('tableName: returns the name of the corresponding table', () {
      final cropDate = CropDate(
        startDate: '2023-01-01',
        endDate: '2023-12-31',
        cropId: 101,
        fieldId: 202,
      );

      expect(cropDate.tableName, 'CropDate');
    });

    test('getAll should return a list of CropDate objects', () async {
      final mockDBHandler = MockDBHandler();
      final testCropDates = [
        CropDate(
          id: 1,
          startDate: '2023-01-01',
          endDate: '2023-12-31',
          cropId: 101,
          fieldId: 201
        ),
        CropDate(
          id: 2,
          startDate: '2023-03-15',
          endDate: '2023-11-15',
          cropId: 102,
          fieldId: 202
        ),
        CropDate(
          id: 3,
          startDate: '2023-05-01',
          endDate: '2023-10-31',
          cropId: 103,
          fieldId: 203
        )
      ];
      DatabaseModel.dbHandler = mockDBHandler;
      when(() => mockDBHandler.cropDates()).thenAnswer((_) async => testCropDates);

      final result = await CropDate.getAll();

      verify(() => mockDBHandler.cropDates()).called(1);
      expect(result, equals(testCropDates));
      expect(result.length, 3);
      expect(result[0].startDate, '2023-01-01');
      expect(result[1].cropId, 102);
      expect(result[2].fieldId, 203);
    });
  });
}
