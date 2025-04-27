import 'package:flutter_test/flutter_test.dart';
import 'package:dibano/data/model/crop_model.dart';

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
      // TODO: implement this test
    }, skip: 'Not yet implemented, as it requires mocking DBHandler');
  });
}
