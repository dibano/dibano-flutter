import 'package:flutter_test/flutter_test.dart';
import 'package:dibano/data/model/completeWorkstep_model.dart';

void main() {
  group('CompleteWorkstep', () {

    test('Constructor: with all values', () {
      final workstep = CompleteWorkstep(
        id: 1,
        workstepActivityId: 2,
        workstepId: 3,
        activityId: 4,
        personId: 5,
        personName: 'Alice',
        fieldName: 'Field A',
        cropName: 'Wheat',
        activityName: 'Plowing',
        description: 'Spring plowing',
        date: '2024-04-01',
        quantityPerField: 10.0,
        quantityPerHa: 2.5,
        nPerField: 1.0,
        nPerHa: 0.5,
        pPerField: 0.8,
        pPerHa: 0.4,
        kPerField: 0.7,
        kPerHa: 0.35,
        tractor: 'John Deere',
        fertilizerSpreader: 'SpreadMaster 3000',
        seedingDepth: 5.0,
        seedingQuantity: 150.0,
        plantProtectionName: 'HerbicideX',
        rowDistance: 12.0,
        seedingDistance: 2.0,
        germinationAbility: '90%',
        goalQuantity: 1000.0,
        spray: 'SprayY',
        machiningDepth: 20.0,
        usedMachine: 'Seeder',
        productName: 'SeedA',
        plantProtectionType: 'Fungicide',
        actualQuantity: 950.0,
        waterQuantityProcentage: 80.0,
        groundDamage: 'None',
        pest: 'Aphids',
        fungal: 'None',
        problemWeeds: 'Dandelion',
        nutrient: 'Nitrogen',
        countPerPlant: 5.0,
        plantPerQm: 30.0,
        fertilizerName: 'NPK',
        n: 10.0,
        p: 5.0,
        k: 8.0,
        fertilizerId: 101,
        turning: 1,
        ptoDriven: 0,
      );

      expect(workstep.id, 1);
      expect(workstep.workstepActivityId, 2);
      expect(workstep.workstepId, 3);
      expect(workstep.activityId, 4);
      expect(workstep.personId, 5);
      expect(workstep.personName, 'Alice');
      expect(workstep.fieldName, 'Field A');
      expect(workstep.cropName, 'Wheat');
      expect(workstep.activityName, 'Plowing');
      expect(workstep.description, 'Spring plowing');
      expect(workstep.date, '2024-04-01');
      expect(workstep.quantityPerField, 10.0);
      expect(workstep.quantityPerHa, 2.5);
      expect(workstep.nPerField, 1.0);
      expect(workstep.nPerHa, 0.5);
      expect(workstep.pPerField, 0.8);
      expect(workstep.pPerHa, 0.4);
      expect(workstep.kPerField, 0.7);
      expect(workstep.kPerHa, 0.35);
      expect(workstep.tractor, 'John Deere');
      expect(workstep.fertilizerSpreader, 'SpreadMaster 3000');
      expect(workstep.seedingDepth, 5.0);
      expect(workstep.seedingQuantity, 150.0);
      expect(workstep.plantProtectionName, 'HerbicideX');
      expect(workstep.rowDistance, 12.0);
      expect(workstep.seedingDistance, 2.0);
      expect(workstep.germinationAbility, '90%');
      expect(workstep.goalQuantity, 1000.0);
      expect(workstep.spray, 'SprayY');
      expect(workstep.machiningDepth, 20.0);
      expect(workstep.usedMachine, 'Seeder');
      expect(workstep.productName, 'SeedA');
      expect(workstep.plantProtectionType, 'Fungicide');
      expect(workstep.actualQuantity, 950.0);
      expect(workstep.waterQuantityProcentage, 80.0);
      expect(workstep.groundDamage, 'None');
      expect(workstep.pest, 'Aphids');
      expect(workstep.fungal, 'None');
      expect(workstep.problemWeeds, 'Dandelion');
      expect(workstep.nutrient, 'Nitrogen');
      expect(workstep.countPerPlant, 5.0);
      expect(workstep.plantPerQm, 30.0);
      expect(workstep.fertilizerName, 'NPK');
      expect(workstep.n, 10.0);
      expect(workstep.p, 5.0);
      expect(workstep.k, 8.0);
      expect(workstep.fertilizerId, 101);
      expect(workstep.turning, 1);
      expect(workstep.ptoDriven, 0);
    });

    test('fromMap: returns CompleteWorkstep object with given values', () {
      final map = {
        'id': 2,
        'workstepActivityId': 3,
        'workstepId': 4,
        'activityId': 5,
        'personId': 6,
        'personName': 'Bob',
        'fieldName': 'Field B',
        'cropName': 'Barley',
        'activityName': 'Seeding',
        'description': 'Seeding in spring',
        'date': '2024-04-02',
        'quantityPerField': 20.0,
        'quantityPerHa': 4.0,
        'nPerField': 2.0,
        'nPerHa': 1.0,
        'pPerField': 1.6,
        'pPerHa': 0.8,
        'kPerField': 1.4,
        'kPerHa': 0.7,
        'tractor': 'Case IH',
        'fertilizerSpreader': 'SpreadMaster 4000',
        'seedingDepth': 6.0,
        'seedingQuantity': 160.0,
        'plantProtectionName': 'HerbicideY',
        'rowDistance': 13.0,
        'seedingDistance': 3.0,
        'germinationAbility': '85%',
        'goalQuantity': 1100.0,
        'spray': 'SprayZ',
        'machiningDepth': 22.0,
        'usedMachine': 'SeederX',
        'productName': 'SeedB',
        'plantProtectionType': 'Herbicide',
        'actualQuantity': 1050.0,
        'waterQuantityProcentage': 85.0,
        'groundDamage': 'Minor',
        'pest': 'Beetle',
        'fungal': 'Rust',
        'problemWeeds': 'Thistle',
        'nutrient': 'Phosphorus',
        'countPerPlant': 6.0,
        'plantPerQm': 32.0,
        'fertilizerName': 'PK',
        'n': 12.0,
        'p': 6.0,
        'k': 9.0,
        'fertilizerId': 102,
        'turning': 0,
        'ptoDriven': 1,
      };

      final workstep = CompleteWorkstep.fromMap(map);

      expect(workstep.id, 2);
      expect(workstep.workstepActivityId, 3);
      expect(workstep.workstepId, 4);
      expect(workstep.activityId, 5);
      expect(workstep.personId, 6);
      expect(workstep.personName, 'Bob');
      expect(workstep.fieldName, 'Field B');
      expect(workstep.cropName, 'Barley');
      expect(workstep.activityName, 'Seeding');
      expect(workstep.description, 'Seeding in spring');
      expect(workstep.date, '2024-04-02');
      expect(workstep.quantityPerField, 20.0);
      expect(workstep.quantityPerHa, 4.0);
      expect(workstep.nPerField, 2.0);
      expect(workstep.nPerHa, 1.0);
      expect(workstep.pPerField, 1.6);
      expect(workstep.pPerHa, 0.8);
      expect(workstep.kPerField, 1.4);
      expect(workstep.kPerHa, 0.7);
      expect(workstep.tractor, 'Case IH');
      expect(workstep.fertilizerSpreader, 'SpreadMaster 4000');
      expect(workstep.seedingDepth, 6.0);
      expect(workstep.seedingQuantity, 160.0);
      expect(workstep.plantProtectionName, 'HerbicideY');
      expect(workstep.rowDistance, 13.0);
      expect(workstep.seedingDistance, 3.0);
      expect(workstep.germinationAbility, '85%');
      expect(workstep.goalQuantity, 1100.0);
      expect(workstep.spray, 'SprayZ');
      expect(workstep.machiningDepth, 22.0);
      expect(workstep.usedMachine, 'SeederX');
      expect(workstep.productName, 'SeedB');
      expect(workstep.plantProtectionType, 'Herbicide');
      expect(workstep.actualQuantity, 1050.0);
      expect(workstep.waterQuantityProcentage, 85.0);
      expect(workstep.groundDamage, 'Minor');
      expect(workstep.pest, 'Beetle');
      expect(workstep.fungal, 'Rust');
      expect(workstep.problemWeeds, 'Thistle');
      expect(workstep.nutrient, 'Phosphorus');
      expect(workstep.countPerPlant, 6.0);
      expect(workstep.plantPerQm, 32.0);
      expect(workstep.fertilizerName, 'PK');
      expect(workstep.n, 12.0);
      expect(workstep.p, 6.0);
      expect(workstep.k, 9.0);
      expect(workstep.fertilizerId, 102);
      expect(workstep.turning, 0);
      expect(workstep.ptoDriven, 1);
    });

    test('fromMap: handles optional values correctly, given as null values', () {
      final map = {
        'id': 3,
        'workstepActivityId': 4,
        'workstepId': 5,
        'activityId': null,
        'personId': null,
        'personName': null,
        'fieldName': 'Field C',
        'cropName': 'Corn',
        'activityName': null,
        'description': null,
        'date': '2024-04-03',
        'quantityPerField': null,
        'quantityPerHa': null,
        'nPerField': null,
        'nPerHa': null,
        'pPerField': null,
        'pPerHa': null,
        'kPerField': null,
        'kPerHa': null,
        'tractor': null,
        'fertilizerSpreader': null,
        'seedingDepth': null,
        'seedingQuantity': null,
        'plantProtectionName': null,
        'rowDistance': null,
        'seedingDistance': null,
        'germinationAbility': null,
        'goalQuantity': null,
        'spray': null,
        'machiningDepth': null,
        'usedMachine': null,
        'productName': null,
        'plantProtectionType': null,
        'actualQuantity': null,
        'waterQuantityProcentage': null,
        'groundDamage': null,
        'pest': null,
        'fungal': null,
        'problemWeeds': null,
        'nutrient': null,
        'countPerPlant': null,
        'plantPerQm': null,
        'fertilizerName': null,
        'n': null,
        'p': null,
        'k': null,
        'fertilizerId': null,
        'turning': null,
        'ptoDriven': null,
      };

      final workstep = CompleteWorkstep.fromMap(map);

      expect(workstep.activityId, isNull);
      expect(workstep.personId, isNull);
      expect(workstep.personName, isNull);
      expect(workstep.activityName, isNull);
      expect(workstep.description, isNull);
      expect(workstep.quantityPerField, isNull);
      expect(workstep.quantityPerHa, isNull);
      expect(workstep.nPerField, isNull);
      expect(workstep.nPerHa, isNull);
      expect(workstep.pPerField, isNull);
      expect(workstep.pPerHa, isNull);
      expect(workstep.kPerField, isNull);
      expect(workstep.kPerHa, isNull);
      expect(workstep.tractor, isNull);
      expect(workstep.fertilizerSpreader, isNull);
      expect(workstep.seedingDepth, isNull);
      expect(workstep.seedingQuantity, isNull);
      expect(workstep.plantProtectionName, isNull);
      expect(workstep.rowDistance, isNull);
      expect(workstep.seedingDistance, isNull);
      expect(workstep.germinationAbility, isNull);
      expect(workstep.goalQuantity, isNull);
      expect(workstep.spray, isNull);
      expect(workstep.machiningDepth, isNull);
      expect(workstep.usedMachine, isNull);
      expect(workstep.productName, isNull);
      expect(workstep.plantProtectionType, isNull);
      expect(workstep.actualQuantity, isNull);
      expect(workstep.waterQuantityProcentage, isNull);
      expect(workstep.groundDamage, isNull);
      expect(workstep.pest, isNull);
      expect(workstep.fungal, isNull);
      expect(workstep.problemWeeds, isNull);
      expect(workstep.nutrient, isNull);
      expect(workstep.countPerPlant, isNull);
      expect(workstep.plantPerQm, isNull);
      expect(workstep.fertilizerName, isNull);
      expect(workstep.n, isNull);
      expect(workstep.p, isNull);
      expect(workstep.k, isNull);
      expect(workstep.fertilizerId, isNull);
      expect(workstep.turning, isNull);
      expect(workstep.ptoDriven, isNull);
    });

    test('fromMap: handles optional values correctly, not given at all', () {
      final map = {
        'id': 3,
        'workstepActivityId': 4,
        'workstepId': 5,
        'fieldName': 'Field C',
        'cropName': 'Corn',
        'date': '2024-04-03',
      };

      final workstep = CompleteWorkstep.fromMap(map);

      expect(workstep.activityId, isNull);
      expect(workstep.personId, isNull);
      expect(workstep.personName, isNull);
      expect(workstep.activityName, isNull);
      expect(workstep.description, isNull);
      expect(workstep.quantityPerField, isNull);
      expect(workstep.quantityPerHa, isNull);
      expect(workstep.nPerField, isNull);
      expect(workstep.nPerHa, isNull);
      expect(workstep.pPerField, isNull);
      expect(workstep.pPerHa, isNull);
      expect(workstep.kPerField, isNull);
      expect(workstep.kPerHa, isNull);
      expect(workstep.tractor, isNull);
      expect(workstep.fertilizerSpreader, isNull);
      expect(workstep.seedingDepth, isNull);
      expect(workstep.seedingQuantity, isNull);
      expect(workstep.plantProtectionName, isNull);
      expect(workstep.rowDistance, isNull);
      expect(workstep.seedingDistance, isNull);
      expect(workstep.germinationAbility, isNull);
      expect(workstep.goalQuantity, isNull);
      expect(workstep.spray, isNull);
      expect(workstep.machiningDepth, isNull);
      expect(workstep.usedMachine, isNull);
      expect(workstep.productName, isNull);
      expect(workstep.plantProtectionType, isNull);
      expect(workstep.actualQuantity, isNull);
      expect(workstep.waterQuantityProcentage, isNull);
      expect(workstep.groundDamage, isNull);
      expect(workstep.pest, isNull);
      expect(workstep.fungal, isNull);
      expect(workstep.problemWeeds, isNull);
      expect(workstep.nutrient, isNull);
      expect(workstep.countPerPlant, isNull);
      expect(workstep.plantPerQm, isNull);
      expect(workstep.fertilizerName, isNull);
      expect(workstep.n, isNull);
      expect(workstep.p, isNull);
      expect(workstep.k, isNull);
      expect(workstep.fertilizerId, isNull);
      expect(workstep.turning, isNull);
      expect(workstep.ptoDriven, isNull);
    });

        test('fromMap: TypeError is thrown if incorrect map is provided', () {
      final map = {
        'id': 3,
        'workstepId': 5,
        'fieldName': 'Field C',
        'cropName': 'Corn',
        'date': '2024-04-03',
      };

      expect(() => CompleteWorkstep.fromMap(map), throwsA(isA<TypeError>()));
    });


    test('getCompleteWorksteps returns list from dbHandler', () async {
    // TODO: implement this test
    }, skip: 'Not yet implemented, as it requires mocking DBHandler');
  });
}
