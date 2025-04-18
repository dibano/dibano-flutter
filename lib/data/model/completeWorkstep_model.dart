import 'package:dibano/data/model/database_model.dart';

class CompleteWorkstep{
  final int id;
  final int workstepActivityId;
  final int workstepId;
  final int? activityId;
  final int? personId;
  final String? personName;
  final String fieldName;
  final String cropName;
  final String? activityName;
  final String? description;
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
  final double? machiningDepth;
  final String? usedMachine;
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
  final String? fertilizerName;
  final double? n;
  final double? p;
  final double? k;
  final int? fertilizerId;
  final int? turning;
  final int? ptoDriven;
  
  CompleteWorkstep({
    required this.id,
    required this.workstepActivityId,
    required this.workstepId,
    this.activityId,
    this.personId,
    this.personName,
    required this.fieldName,
    required this.cropName,
    this.activityName,
    this.description,
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
    this.machiningDepth,
    this.usedMachine,
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
    this.fertilizerName,
    this.n,
    this.p,
    this.k,
    this.fertilizerId,
    this.turning,
    this.ptoDriven,
  });

  factory CompleteWorkstep.fromMap(Map<String, Object?> completeWorkstepMap) {
    return CompleteWorkstep(id: completeWorkstepMap['id'] as int,
                        workstepActivityId: completeWorkstepMap['workstepActivityId'] as int,
                        workstepId: completeWorkstepMap['workstepId'] as int,
                        activityId: completeWorkstepMap['activityId'] as int?,
                        personId: completeWorkstepMap['personId'] as int?,
                        personName: completeWorkstepMap['personName'] as String?,
                        cropName: completeWorkstepMap['cropName'] as String,
                        fieldName: completeWorkstepMap['fieldName'] as String, 
                        activityName: completeWorkstepMap['activityName'] as String?,
                        description: completeWorkstepMap['description'] as String?,
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
                        fertilizerName: completeWorkstepMap['fertilizerName'] as String?,
                        n: completeWorkstepMap['n'] as double?,
                        p: completeWorkstepMap['p'] as double?,
                        k: completeWorkstepMap['k'] as double?,
                        fertilizerId: completeWorkstepMap['fertilizerId'] as int?,
                        turning: completeWorkstepMap['turning'] as int?,
                        ptoDriven: completeWorkstepMap['ptoDriven'] as int?,
    );
  }

  static Future<List<CompleteWorkstep>> getCompleteWorksteps() async{
    return await DatabaseModel.dbHandler.completeWorksteps();
  }
}