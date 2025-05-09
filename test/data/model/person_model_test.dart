import 'package:flutter_test/flutter_test.dart';
import 'package:dibano/data/model/person_model.dart';
import 'package:dibano/data/model/database_model.dart';
import 'package:dibano/data/database_handler.dart';
import 'package:mocktail/mocktail.dart';

class MockDBHandler extends Mock implements DatabaseHandler {}

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

    test('getAll: returns all Persons that are saved in the database', () async {
      final mockDBHandler = MockDBHandler();
      final testPersons = [
        Person(id: 1, personName: 'John Doe'),
        Person(id: 2, personName: 'Jane Smith'),
        Person(id: 3, personName: 'Alice Johnson')
      ];
      DatabaseModel.dbHandler = mockDBHandler;
      when(() => mockDBHandler.person()).thenAnswer((_) async => testPersons);

      final result = await Person.getAll();

      verify(() => mockDBHandler.person()).called(1);
      expect(result, equals(testPersons));
      expect(result.length, 3);
      expect(result[0].personName, 'John Doe');
      expect(result[1].personName, 'Jane Smith');
      expect(result[2].personName, 'Alice Johnson');
    });
  });
}
