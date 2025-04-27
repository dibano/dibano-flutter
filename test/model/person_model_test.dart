import 'package:flutter_test/flutter_test.dart';
import 'package:dibano/data/model/person_model.dart';

void main() {
  group('Person', () {
    test('Constructor: with all fields', () {
      final person = Person(id: 1, personName: 'John Doe');

      expect(person.id, 1);
      expect(person.personName, 'John Doe');
    });

    test('Constructor: id is optional', () {
      final person = Person(personName: 'Jane Smith');

      expect(person.id, null);
      expect(person.personName, 'Jane Smith');
    });

    test('toMap: returns a map that corresponds to the databases column names', () {
      final person = Person(id: 2, personName: 'Alice Johnson');

      expect(person.toMap(), {
        'id': 2,
        'personName': 'Alice Johnson',
      });
    });

    test('toString: returns a string usable for debugging and logging', () {
      final person = Person(id: 3, personName: 'Bob Brown');

      expect(person.toString(), 'person{id: 3, personName: Bob Brown}');
    });

    test('tableName: returns the name of the corresponding table', () {
      final person = Person(personName: 'Test Person');

      expect(person.tableName, 'Person');
    });

    test('getAll: returns all Persons that are saved in the database', () {
      // TODO: implement this test
    }, skip: 'Not yet implemented, as it requires mocking DBHandler');
  });
}
