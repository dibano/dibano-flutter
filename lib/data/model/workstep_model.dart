import 'package:dibano/data/database_handler.dart';
import 'package:dibano/data/model/database_model.dart';

class Workstep extends DatabaseModel{
  @override
  final int? id;
  final String description;
  final int personId;
  final int cropdateId;
  final String date;
  final double? quantityPerField;
  final double? quantityPerHa;
  final double? nPerField;
  final double? nPerHa;
  final double? pPerField;
  final double? pPerHa;
  final double? kPerField;
  final double? kPerHa;
  final String? tractor;
  final String? fertilizerSpreader;
  final double? seedingDepth;
  final double? seedingQuantity;
  final String? plantProtectionName;
  final double? rowDistance;
  final double? seedingDistance;
  final String? germinationAbility;
  final double? goalQuantity;
  final String? spray;
  //final bool? turning;
  final double? machiningDepth;
  final String? usedMachine;
  //final bool? ptoDriven;
  final String? productName;
  final String? plantProtectionType;
  final double? actualQuantity;
  final double? waterQuantityProcentage;
  final String? groundDamage;
  final String? pest;
  final String? fungal;
  final String? problemWeeds;
  final String? nutrient;
  final double? countPerPlant;
  final double? plantPerQm;
  final int? fertilizerId;
  final dbHandler = DatabaseHandler();
  
  Workstep({
    this.id,
    required this.description,
    required this.personId,
    required this.cropdateId,
    required this.date,
    this.quantityPerField,
    this.quantityPerHa,
    this.nPerField,
    this.nPerHa,
    this.pPerField,
    this.pPerHa,
    this.kPerField,
    this.kPerHa,
    this.tractor,
    this.fertilizerSpreader,
    this.seedingDepth,
    this.seedingQuantity,
    this.plantProtectionName,
    this.rowDistance,
    this.seedingDistance,
    this.germinationAbility,
    this.goalQuantity,
    this.spray,
    //this.turning,
    this.machiningDepth,
    this.usedMachine,
    //this.ptoDriven,
    this.productName,
    this.plantProtectionType,
    this.actualQuantity,
    this.waterQuantityProcentage,
    this.groundDamage,
    this.pest,
    this.fungal,
    this.problemWeeds,
    this.nutrient,
    this.countPerPlant,
    this.plantPerQm,
    this.fertilizerId,
  });

  static Future<List<Workstep>> getAll() async{
    return await DatabaseModel.dbHandler.worksteps();
  }

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  @override
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'description': description,
      'quantityPerField': quantityPerField,
      'quantityPerHa': quantityPerHa,
      'nPerField': nPerField,
      'nPerHa': nPerHa,
      'pPerField': pPerField,
      'pPerHa': pPerHa,
      'kPerField': kPerField,
      'kPerHa': kPerHa,
      'tractor': tractor,
      'fertilizerSpreader': fertilizerSpreader,
      'seedingDepth': seedingDepth,
      'seedingQuantity': seedingQuantity,
      'plantProtectionName': plantProtectionName,
      'rowDistance': rowDistance,
      'seedingDistance':seedingDistance,
      'germinationAbility': germinationAbility,
      'goalQuantity': goalQuantity,
      'spray': spray,
      //'turning': turning,
      'machiningDepth': machiningDepth,
      'usedMachine':  usedMachine,
      //'ptoDriven': ptoDriven,
      'productName': productName,
      'plantProtectionType': plantProtectionType,
      'actualQuantity': actualQuantity,
      'waterQuantityProcentage': waterQuantityProcentage,
      'groundDamage': groundDamage,
      'pest': pest,
      'fungal': fungal,
      'problemWeeds': problemWeeds,
      'nutrient': nutrient,
      'countPerPlant': countPerPlant,
      'plantPerQm': plantPerQm,
      'fertilizerId': fertilizerId,
      'personId': personId,
      'cropDateId': cropdateId,
      'date': date,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Workstep{id: $id, description: $description, personId: $personId, cropDateId: $cropdateId, date: $date, '
           'quantityPerField: $quantityPerField, quantityPerHa: $quantityPerHa, '
           'nPerField: $nPerField, nPerHa: $nPerHa, pPerField: $pPerField, pPerHa: $pPerHa, '
           'kPerField: $kPerField, kPerHa: $kPerHa, fertilizerSpreader: $fertilizerSpreader, '
           'seedingDepth: $seedingDepth, seedingQuantity: $seedingQuantity, plantProtectionName: $plantProtectionName, '
           'rowDistance: $rowDistance, seedingDistance: $seedingDistance, germinationAbility: $germinationAbility, goalQuantity: $goalQuantity, spray: $spray, '
           'machiningDepth: $machiningDepth, productName: $productName, '
           'plantProtectionType: $plantProtectionType, actualQuantity: $actualQuantity, waterQuantityProcentage: $waterQuantityProcentage, '
           'groundDamage: $groundDamage, pest: $pest, fungal: $fungal, problemWeeds: $problemWeeds, nutrient: $nutrient, '
           'countPerPlant: $countPerPlant, plantPerQm: $plantPerQm, fertilizerId: $fertilizerId}';
  }

  @override
  String get tableName => 'Workstep';

}