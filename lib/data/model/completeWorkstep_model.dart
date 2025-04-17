import 'package:dibano/data/model/database_model.dart';

class CompleteWorkstep{
  final int id;
  final int workstepActivityId;
  final int workstepId;
  final int activityId;
  final int personId;
  final String personName;
  final String fieldName;
  final String cropName;
  final String activityName;
  final String description;
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
  
  CompleteWorkstep({
    required this.id,
    required this.workstepActivityId,
    required this.workstepId,
    required this.activityId,
    required this.personId,
    required this.personName,
    required this.fieldName,
    required this.cropName,
    required this.activityName,
    required this.description,
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

  factory CompleteWorkstep.fromMap(Map<String, Object?> completeWorkstepMap) {
    return CompleteWorkstep(id: completeWorkstepMap['id'] as int,
                        workstepActivityId: completeWorkstepMap['workstepActivityId'] as int,
                        workstepId: completeWorkstepMap['workstepId'] as int,
                        activityId: completeWorkstepMap['activityId'] as int,
                        personId: completeWorkstepMap['personId'] as int,
                        personName: completeWorkstepMap['personName'] as String,
                        cropName: completeWorkstepMap['cropName'] as String,
                        fieldName: completeWorkstepMap['fieldName'] as String, 
                        activityName: completeWorkstepMap['activityName'] as String,
                        description: completeWorkstepMap['description'] as String,
                        date: completeWorkstepMap['date'] as String,
                        quantityPerField: completeWorkstepMap['quantityPerField']as double?,
                        quantityPerHa: completeWorkstepMap['quantityPerHa'] as double?,
                        nPerField: completeWorkstepMap['nPerField'] as double?,
                        nPerHa: completeWorkstepMap['nPerHa'] as double?,
                        pPerField: completeWorkstepMap['pPerField'] as double?,
                        pPerHa: completeWorkstepMap['pPerHa'] as double?,
                        kPerField: completeWorkstepMap['kPerField'] as double?,
                        kPerHa: completeWorkstepMap['kPerHa'] as double?,
                        tractor: completeWorkstepMap['tractor'] as String?,
                        fertilizerSpreader: completeWorkstepMap['fertilizerSpreader'] as String?,
                        seedingDepth: completeWorkstepMap['seedingDepth'] as double?,
                        seedingQuantity: completeWorkstepMap['seedingQuantity'] as double?,
                        plantProtectionName: completeWorkstepMap['plantProtectionName'] as String?,
                        rowDistance: completeWorkstepMap['rowDistance'] as double?,
                        seedingDistance: completeWorkstepMap['seedingDistance'] as double?,
                        germinationAbility: completeWorkstepMap['germinationAbility'] as String?,
                        goalQuantity: completeWorkstepMap['goalQuantity'] as double?,
                        spray: completeWorkstepMap['spray'] as String?,
                        machiningDepth: completeWorkstepMap['machiningDepth'] as double?,
                        usedMachine: completeWorkstepMap['usedMachine'] as String?,
                        productName: completeWorkstepMap['productName'] as String?,
                        plantProtectionType: completeWorkstepMap['plantProtectionType'] as String?,
                        actualQuantity: completeWorkstepMap['actualQuantity'] as double?,
                        waterQuantityProcentage: completeWorkstepMap['waterQuantityProcentage'] as double?,
                        groundDamage: completeWorkstepMap['groundDamage'] as String?,
                        pest: completeWorkstepMap['pest'] as String?,
                        fungal: completeWorkstepMap['fungal'] as String?,
                        problemWeeds: completeWorkstepMap['problemWeeds'] as String?,
                        nutrient: completeWorkstepMap['nutrient'] as String?,
                        countPerPlant: completeWorkstepMap['countPerPlant'] as double?,
                        plantPerQm: completeWorkstepMap['plantPerQm'] as double?,
                        fertilizerId: completeWorkstepMap['fertilizerId'] as int?,
    );
  }

  static Future<List<CompleteWorkstep>> getCompleteWorksteps() async{
    return await DatabaseModel.dbHandler.completeWorksteps();
  }
}