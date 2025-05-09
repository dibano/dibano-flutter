import 'package:flutter_test/flutter_test.dart';
import 'package:dibano/data/model/workstepActivity_model.dart';
import 'package:dibano/data/model/database_model.dart';
import 'package:dibano/data/database_handler.dart';
import 'package:mocktail/mocktail.dart';

class MockDBHandler extends Mock implements DatabaseHandler {}

void main() {
  group('WorkstepActivity', () {
    test('Constructor: with all fields', () {
      final workstepActivity = WorkstepActivity(
          id: 1,
          workstepId: 100,
          activityId: 200
      );

      expect(workstepActivity.id, 1);
      expect(workstepActivity.workstepId, 100);
      expect(workstepActivity.activityId, 200);
    });

    test('Constructor: with only required fields', () {
      final workstepActivity = WorkstepActivity(
          workstepId: 100
      );

      expect(workstepActivity.id, null);
      expect(workstepActivity.workstepId, 100);
      expect(workstepActivity.activityId, null);
    });

    test('toMap: returns a map that corresponds to the databases column names', () {
      final workstepActivity = WorkstepActivity(
          id: 2,
          workstepId: 101,
          activityId: 201
      );

      expect(workstepActivity.toMap(), {
        'id': 2,
        'workstepId': 101,
        'activityId': 201
      });
    });

    test('toString: returns a string usable for debugging and logging', () {
      final workstepActivity = WorkstepActivity(
          id: 3,
          workstepId: 102,
          activityId: 202
      );

      expect(workstepActivity.toString(), 'workstepActivity{id: 3, workstepId: 102, activityId: 202');
    });

    test('tableName: returns the name of the corresponding table', () {
      final workstepActivity = WorkstepActivity(
          workstepId: 103
      );

      expect(workstepActivity.tableName, 'WorkstepActivity');
    });

    test('getAll: returns all WorkstepActivities that are saved in the database', () async {
      final mockDBHandler = MockDBHandler();
      final testWorkstepActivities = [
        WorkstepActivity(id: 1, workstepId: 101, activityId: 201),
        WorkstepActivity(id: 2, workstepId: 102, activityId: 202),
        WorkstepActivity(id: 3, workstepId: 103, activityId: null)
      ];
      DatabaseModel.dbHandler = mockDBHandler;
      when(() => mockDBHandler.workstepActivities()).thenAnswer((_) async => testWorkstepActivities);

      final result = await WorkstepActivity.getAll();

      verify(() => mockDBHandler.workstepActivities()).called(1);
      expect(result, equals(testWorkstepActivities));
      expect(result.length, 3);
      expect(result[0].workstepId, 101);
      expect(result[1].activityId, 202);
      expect(result[2].activityId, null);
    });
  });
}
