import 'package:flutter_test/flutter_test.dart';
import 'package:dibano/data/model/fertilizer_model.dart';

void main() {
  group('Fertilizer', () {
    test('Constructor: with all fields', () {
      final fertilizer = Fertilizer(
          id: 1,
          fertilizerName: 'NPK 15-15-15',
          n: 15.0,
          p: 15.0,
          k: 15.0
      );

      expect(fertilizer.id, 1);
      expect(fertilizer.fertilizerName, 'NPK 15-15-15');
      expect(fertilizer.n, 15.0);
      expect(fertilizer.p, 15.0);
      expect(fertilizer.k, 15.0);
    });

    test('Constructor: id is optional', () {
      final fertilizer = Fertilizer(
          fertilizerName: 'Urea',
          n: 46.0,
          p: 0.0,
          k: 0.0
      );

      expect(fertilizer.id, null);
      expect(fertilizer.fertilizerName, 'Urea');
      expect(fertilizer.n, 46.0);
      expect(fertilizer.p, 0.0);
      expect(fertilizer.k, 0.0);
    });

    test('toMap: returns a map that corresponds to the databases column names', () {
      final fertilizer = Fertilizer(
          id: 2,
          fertilizerName: 'DAP',
          n: 18.0,
          p: 46.0,
          k: 0.0
      );

      expect(fertilizer.toMap(), {
        'id': 2,
        'fertilizerName': 'DAP',
        'n': 18.0,
        'p': 46.0,
        'k': 0.0,
      });
    });

    test('toString: returns a string usable for debugging and logging', () {
      final fertilizer = Fertilizer(
          id: 3,
          fertilizerName: 'MOP',
          n: 0.0,
          p: 0.0,
          k: 60.0
      );

      expect(fertilizer.toString(), 'Fertilizer{id: 3, fertilizerName: MOP, n: 0.0, p: 0.0, k: 60.0}');
    });

    test('tableName: returns the name of the corresponding table', () {
      final fertilizer = Fertilizer(
          id: 4,
          fertilizerName: 'SSP',
          n: 0.0,
          p: 16.0,
          k: 0.0
      );

      expect(fertilizer.tableName, 'Fertilizer');
    });

    test('static table field contains correct table name', () {
      expect(Fertilizer.table, 'Fertilizer');
    });

    test('getAll: returns all Fertilizers that are saved in the database', () {
      // TODO: implement this test
    }, skip: 'Not yet implemented, as it requires mocking DBHandler');
  });
}
