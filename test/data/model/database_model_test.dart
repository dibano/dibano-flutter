import 'package:dibano/data/database_handler.dart';
import 'package:dibano/data/model/database_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDatabaseHandler extends Mock implements DatabaseHandler {}

class TestModel extends DatabaseModel {
  @override
  final int? id;
  final String testName;

  TestModel({this.id, required this.testName});

  @override
  Map<String, Object?> toMap() {
    return {'id': id, 'testName': testName};
  }

  @override
  String get tableName => 'TestTable';
}

void main() {
  late MockDatabaseHandler mockHandler;
  late TestModel testModel;

  setUp(() {
    mockHandler = MockDatabaseHandler();
    DatabaseModel.dbHandler = mockHandler;
    testModel = TestModel(id: 1, testName: 'Test');

    registerFallbackValue(testModel);
    registerFallbackValue('TestTable');
  });

  group('DatabaseModel', () {
    test('insert: calls dbHandler.insert with correct parameters', () async {
      when(() => mockHandler.insert(any(), any()))
          .thenAnswer((_) async {});

      await testModel.insert();

      verify(() => mockHandler.insert(testModel, 'TestTable')).called(1);
    });

    test('delete: calls dbHandler.remove with correct parameters', () async {
      when(() => mockHandler.remove(any(), any()))
          .thenAnswer((_) async {});

      await testModel.delete();

      verify(() => mockHandler.remove(1, 'TestTable')).called(1);
    });

    test('update: calls dbHandler.update with correct parameters', () async {
      when(() => mockHandler.update(any(), any()))
          .thenAnswer((_) async {});

      await testModel.update();

      verify(() => mockHandler.update(testModel, 'TestTable')).called(1);
    });

    test('insertReturnId: calls dbHandler.insertReturnId and returns the correct id', () async {
      when(() => mockHandler.insertReturnId(any(), any()))
          .thenAnswer((_) async => 42);

      final result = await testModel.insertReturnId();

      verify(() => mockHandler.insertReturnId(testModel, 'TestTable')).called(1);
      expect(result, 42);
    });
  });
}
