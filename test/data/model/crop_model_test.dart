import 'package:flutter_test/flutter_test.dart';
import 'package:dibano/data/model/crop_model.dart';
import 'package:dibano/data/model/database_model.dart';
import 'package:dibano/data/database_handler.dart';
import 'package:mocktail/mocktail.dart';

class MockDBHandler extends Mock implements DatabaseHandler {}

void main() {
  group('Crop', () {
    test('Constructor: with all fields', () {
      final crop = Crop(id: 1, cropName: 'Barley');
      expect(crop.id, 1);
      expect(crop.cropName, 'Barley');
    });

    test('toMap: returns a map that corresponds to the databases column names', () {
      final crop = Crop(id: 2, cropName: 'Wheat');
      expect(crop.toMap(), {
        'id': 2,
        'cropName': 'Wheat',
      });
    });

    test('toMap handles null id', () {
      final crop = Crop(id: null, cropName: 'Corn');
      expect(crop.toMap(), {
        'id': null,
        'cropName': 'Corn',
      });
    });

    test('toString: returns a string usable for debugging and logging', () {
      final crop = Crop(id: 3, cropName: 'Oats');
      expect(crop.toString(), 'crop{id: 3, cropName: Oats}');
    });

    test('tableName: returns the name of the corresponding table', () {
      final crop = Crop(id: 4, cropName: 'Rye');
      expect(crop.tableName, Crop.table);
    });

    test('getAll returns list from dbHandler', () async {
      final mockDBHandler = MockDBHandler();
      final testCrops = [
        Crop(id: 1, cropName: 'Wheat'),
        Crop(id: 2, cropName: 'Corn'),
        Crop(id: 3, cropName: 'Barley')
      ];
      DatabaseModel.dbHandler = mockDBHandler;
      when(() => mockDBHandler.crops()).thenAnswer((_) async => testCrops);

      final result = await Crop.getAll();

      verify(() => mockDBHandler.crops()).called(1);
      expect(result, equals(testCrops));
      expect(result.length, 3);
      expect(result[0].cropName, 'Wheat');
      expect(result[1].cropName, 'Corn');
      expect(result[2].cropName, 'Barley');
    });
  });
}
