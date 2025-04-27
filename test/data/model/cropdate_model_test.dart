import 'package:flutter_test/flutter_test.dart';
import 'package:dibano/data/model/cropdate_model.dart';

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

    test('getAll should return a list of CropDate objects', () {
      // TODO: implement this test
    }, skip: 'Not yet implemented, as it requires mocking DBHandler');
  });
}
