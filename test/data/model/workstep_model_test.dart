import 'package:flutter_test/flutter_test.dart';
import 'package:dibano/data/model/workstep_model.dart';

void main() {
  group('Workstep', () {
    test('Constructor: with required fields only', () {
      final workstep = Workstep(
          cropdateId: 1,
          date: '2023-07-15'
      );

      expect(workstep.id, null);
      expect(workstep.cropdateId, 1);
      expect(workstep.date, '2023-07-15');
      expect(workstep.description, null);
      // Other fields should be null
    });

    test('Constructor: with all fields', () {
      final workstep = Workstep(
          id: 1,
          description: 'Fertilization',
          personId: 5,
          cropdateId: 2,
          date: '2023-07-20',
          quantityPerField: 500.0,
          quantityPerHa: 125.0,
          nPerField: 75.0,
          nPerHa: 18.75,
          pPerField: 40.0,
          pPerHa: 10.0,
          kPerField: 65.0,
          kPerHa: 16.25,
          tractor: 'John Deere 6M',
          fertilizerSpreader: 'Amazone ZA-M',
          seedingDepth: 5.0,
          seedingQuantity: 220.0,
          plantProtectionName: 'Fungicide',
          rowDistance: 75.0,
          seedingDistance: 20.0,
          germinationAbility: '90%',
          goalQuantity: 8500.0,
          spray: 'Manual',
          machiningDepth: 25.0,
          usedMachine: 'Plow',
          productName: 'NPK 15-8-13',
          plantProtectionType: 'Preventive',
          actualQuantity: 480.0,
          waterQuantityProcentage: 15.0,
          groundDamage: 'None',
          pest: 'None',
          fungal: 'None',
          problemWeeds: 'Bindweed',
          nutrient: 'Nitrogen',
          countPerPlant: 2.5,
          plantPerQm: 12.0,
          fertilizerId: 3,
          turning: 1,
          ptoDriven: 0
      );

      expect(workstep.id, 1);
      expect(workstep.description, 'Fertilization');
      expect(workstep.personId, 5);
      expect(workstep.cropdateId, 2);
      expect(workstep.date, '2023-07-20');
      expect(workstep.quantityPerField, 500.0);
      expect(workstep.quantityPerHa, 125.0);
      expect(workstep.nPerField, 75.0);
      expect(workstep.plantPerQm, 12.0);
      expect(workstep.fertilizerId, 3);
      expect(workstep.turning, 1);
      expect(workstep.ptoDriven, 0);
      // Testing a subset of fields for brevity
    });

    test('toMap: returns a map that corresponds to the databases column names', () {
      final workstep = Workstep(
          id: 2,
          description: 'Sowing',
          personId: 3,
          cropdateId: 4,
          date: '2023-08-10',
          seedingDepth: 3.5,
          seedingQuantity: 180.0,
          rowDistance: 25.0
      );

      final map = workstep.toMap();
      expect(map['id'], 2);
      expect(map['description'], 'Sowing');
      expect(map['personId'], 3);
      expect(map['cropDateId'], 4);
      expect(map['date'], '2023-08-10');
      expect(map['seedingDepth'], 3.5);
      expect(map['seedingQuantity'], 180.0);
      expect(map['rowDistance'], 25.0);
      expect(map['quantityPerField'], null);
      // Other fields should be null in the map
    });

    test('toString: returns a string usable for debugging and logging', () {
      final workstep = Workstep(
          id: 3,
          description: 'Harvesting',
          cropdateId: 5,
          date: '2023-10-15',
          actualQuantity: 8200.0
      );

      expect(workstep.toString(), contains('Workstep{id: 3'));
      expect(workstep.toString(), contains('description: Harvesting'));
      expect(workstep.toString(), contains('cropDateId: 5'));
      expect(workstep.toString(), contains('date: 2023-10-15'));
      expect(workstep.toString(), contains('actualQuantity: 8200.0'));
    });

    test('tableName: returns the name of the corresponding table', () {
      final workstep = Workstep(
          cropdateId: 6,
          date: '2023-09-01'
      );

      expect(workstep.tableName, 'Workstep');
    });

    test('getAll: returns all Worksteps that are saved in the database', () {
      // TODO: implement this test
    }, skip: 'Not yet implemented, as it requires mocking DBHandler');
  });
}
