import 'package:flutter_test/flutter_test.dart';
import 'package:dibano/data/model/field_model.dart';
import 'package:dibano/data/model/database_model.dart';
import 'package:dibano/data/database_handler.dart';
import 'package:mocktail/mocktail.dart';

class MockDBHandler extends Mock implements DatabaseHandler {}

void main() {
  group('Field', () {
    test('Constructor: with all fields', () {
      final field = Field(
          id: 1,
          fieldName: 'North Plot',
          fieldSize: 5.5,
          longitude: 13.404954,
          latitude: 52.520008
      );

      expect(field.id, 1);
      expect(field.fieldName, 'North Plot');
      expect(field.fieldSize, 5.5);
      expect(field.longitude, 13.404954);
      expect(field.latitude, 52.520008);
    });

    test('Constructor: optional fields can be null', () {
      final field = Field(
          fieldName: 'South Plot',
          fieldSize: 3.2
      );

      expect(field.id, null);
      expect(field.fieldName, 'South Plot');
      expect(field.fieldSize, 3.2);
      expect(field.longitude, null);
      expect(field.latitude, null);
    });

    test('toMap: returns a map that corresponds to the databases column names', () {
      final field = Field(
          id: 2,
          fieldName: 'West Plot',
          fieldSize: 4.7,
          longitude: 10.123456,
          latitude: 51.987654
      );

      expect(field.toMap(), {
        'id': 2,
        'fieldName': 'West Plot',
        'fieldSize': 4.7,
        'longitude': 10.123456,
        'latitude': 51.987654
      });
    });

    test('toString: returns a string usable for debugging and logging', () {
      final field = Field(
          id: 3,
          fieldName: 'East Plot',
          fieldSize: 6.3,
          longitude: 11.543210,
          latitude: 53.123456
      );

      expect(field.toString(), 'Field{id: 3, fieldName: East Plot, fieldSize: 6.3, longitude: 11.54321, latitude: 53.123456}');
    });

    test('tableName: returns the name of the corresponding table', () {
      final field = Field(
          fieldName: 'Test Plot',
          fieldSize: 2.5
      );

      expect(field.tableName, 'Field');
    });

    test('static table field contains correct table name', () {
      expect(Field.table, 'Field');
    });

    test('getAll: returns all Fields that are saved in the database', () async {
      final mockDBHandler = MockDBHandler();
      final testFields = [
        Field(id: 1, fieldName: 'North Plot', fieldSize: 5.5, longitude: 13.404954, latitude: 52.520008),
        Field(id: 2, fieldName: 'South Plot', fieldSize: 3.2),
        Field(id: 3, fieldName: 'West Plot', fieldSize: 4.7, longitude: 10.123456, latitude: 51.987654)
      ];
      DatabaseModel.dbHandler = mockDBHandler;
      when(() => mockDBHandler.fields()).thenAnswer((_) async => testFields);

      final result = await Field.getAll();

      verify(() => mockDBHandler.fields()).called(1);
      expect(result, equals(testFields));
      expect(result.length, 3);
      expect(result[0].fieldName, 'North Plot');
      expect(result[1].fieldSize, 3.2);
      expect(result[2].longitude, 10.123456);
    });
  });
}
