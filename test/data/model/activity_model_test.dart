import 'package:flutter_test/flutter_test.dart';
import 'package:dibano/data/model/activity_model.dart';
import 'package:dibano/data/model/database_model.dart';
import 'package:dibano/data/database_handler.dart';
import 'package:mocktail/mocktail.dart';

// Create a mock class for DBHandler
class MockDBHandler extends Mock implements DatabaseHandler {}

void main() {
  group('Activity', () {
    test('Constructor: with all fields', () {
      final activity = Activity(id: 1, activityName: 'Plowing');
      expect(activity.id, 1);
      expect(activity.activityName, 'Plowing');
    });

    test('Constructor: id is optional', () {
      final activity = Activity(activityName: 'Plowing');
      expect(activity.id, null);
      expect(activity.activityName, 'Plowing');
    });

    test('toMap: returns a map that corresponds to the databases column names', () {
      final activity = Activity(id: 2, activityName: 'Sowing');
      expect(activity.toMap(), {
        'id': 2,
        'activityName': 'Sowing',
      });
    });

    test('toString: returns a string usable for debugging and logging', () {
      final activity = Activity(id: 3, activityName: 'Fertilizing');
      expect(activity.toString(), 'activity{id: 3, activityName: Fertilizing}');
    });

    test('tableName: returns the name of the corresponding table', () {
      final activity = Activity(id: 4, activityName: 'Harvesting');
      expect(activity.tableName, 'Activity');
    });

    test('getAll: returns all Activities that are saved in the database', () async {
      final mockDBHandler = MockDBHandler();
      final testActivities = [
        Activity(id: 1, activityName: 'Plowing'),
        Activity(id: 2, activityName: 'Seeding'),
        Activity(id: 3, activityName: 'Harvesting')
      ];
      DatabaseModel.dbHandler = mockDBHandler;
      when(() => mockDBHandler.activity()).thenAnswer((_) async => testActivities);

      final result = await Activity.getAll();

      verify(() => mockDBHandler.activity()).called(1);
      expect(result, equals(testActivities));
      expect(result.length, 3);
      expect(result[0].activityName, 'Plowing');
      expect(result[1].activityName, 'Seeding');
      expect(result[2].activityName, 'Harvesting');
    });
  });
}
