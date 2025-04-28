import 'package:flutter_test/flutter_test.dart';
import 'package:dibano/data/model/completeCrop_model.dart';
import 'package:dibano/data/model/database_model.dart';
import 'package:dibano/data/database_handler.dart';
import 'package:mocktail/mocktail.dart';

class MockDBHandler extends Mock implements DatabaseHandler {}

void main() {
  group('CompleteCrop', () {

    test('Constructor: with all fields', () {
      final crop = CompleteCrop(
        id: 1,
        fieldId: 2,
        cropName: 'Wheat',
        fieldName: 'North Field',
        fieldSize: 10.5,
        startDate: '2024-01-01',
        endDate: '2024-06-01',
        cropDateId: 7,
      );

      expect(crop.id, 1);
      expect(crop.fieldId, 2);
      expect(crop.cropName, 'Wheat');
      expect(crop.fieldName, 'North Field');
      expect(crop.fieldSize, 10.5);
      expect(crop.startDate, '2024-01-01');
      expect(crop.endDate, '2024-06-01');
      expect(crop.cropDateId, 7);
    });

        test('Constructor: fieldSize is optional', () {
          final crop = CompleteCrop(
            id: 1,
            fieldId: 2,
            cropName: 'Wheat',
            fieldName: 'North Field',
            startDate: '2024-01-01',
            endDate: '2024-06-01',
            cropDateId: 7,
          );

          expect(crop.id, 1);
          expect(crop.fieldId, 2);
          expect(crop.cropName, 'Wheat');
          expect(crop.fieldName, 'North Field');
          expect(crop.fieldSize, null);
          expect(crop.startDate, '2024-01-01');
          expect(crop.endDate, '2024-06-01');
          expect(crop.cropDateId, 7);
        });

    test('fromMap: returns an object from the given map', () {
      final map = {
        'id': 10,
        'fieldId': 20,
        'cropName': 'Barley',
        'fieldName': 'South Field',
        'fieldSize': 12.0,
        'startDate': '2023-03-10',
        'endDate': '2023-09-15',
        'cropDateId': 99,
      };

      final crop = CompleteCrop.fromMap(map);

      expect(crop.id, 10);
      expect(crop.fieldId, 20);
      expect(crop.cropName, 'Barley');
      expect(crop.fieldName, 'South Field');
      expect(crop.fieldSize, 12.0);
      expect(crop.startDate, '2023-03-10');
      expect(crop.endDate, '2023-09-15');
      expect(crop.cropDateId, 99);
    });

    test('fromMap: field size is optional', () {
      final map = {
        'id': 11,
        'fieldId': 21,
        'cropName': 'Corn',
        'fieldName': 'East Field',
        'fieldSize': null,
        'startDate': '2022-04-01',
        'endDate': '2022-10-01',
        'cropDateId': 101,
      };

      final crop = CompleteCrop.fromMap(map);

      expect(crop.fieldSize, isNull);
    });

    test('fromMap: field size is optional', () {
      final map = {
        'id': 11,
        'fieldId': 21,
        'cropName': 'Corn',
        'fieldName': 'East Field',
        'startDate': '2022-04-01',
        'endDate': '2022-10-01',
        'cropDateId': 101,
      };

      final crop = CompleteCrop.fromMap(map);

      expect(crop.fieldSize, isNull);
    });

    test('fromMap: TypeError is thrown if incorrect map is provided', () {
      final map = {
        'id': 11,
        'fieldId': 21,
        'fieldName': 'East Field',
        'startDate': '2022-04-01',
        'endDate': '2022-10-01',
        'cropDateId': 101,
      };

      expect(() => CompleteCrop.fromMap(map), throwsA(isA<TypeError>()));
    });

    test('getCompleteCrops returns list from dbHandler', () async {
      final mockDBHandler = MockDBHandler();
      final testCompleteCrops = [
        CompleteCrop(
          id: 1,
          fieldId: 101,
          cropName: 'Wheat',
          fieldName: 'North Field',
          fieldSize: 10.5,
          startDate: '2023-01-01',
          endDate: '2023-12-31',
          cropDateId: 201
        ),
        CompleteCrop(
          id: 2,
          fieldId: 102,
          cropName: 'Corn',
          fieldName: 'South Field',
          startDate: '2023-03-15',
          endDate: '2023-10-31',
          cropDateId: 202
        )
      ];
      DatabaseModel.dbHandler = mockDBHandler;
      when(() => mockDBHandler.completeCrops()).thenAnswer((_) async => testCompleteCrops);

      final result = await CompleteCrop.getCompleteCrops();

      verify(() => mockDBHandler.completeCrops()).called(1);
      expect(result, equals(testCompleteCrops));
      expect(result.length, 2);
      expect(result[0].cropName, 'Wheat');
      expect(result[1].fieldName, 'South Field');
    });
  });
}
