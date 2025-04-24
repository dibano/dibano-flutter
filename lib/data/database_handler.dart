import 'dart:async';

import 'package:dibano/data/model/completeCrop_model.dart';
import 'package:dibano/data/model/completeWorkstep_model.dart';
import 'package:dibano/data/model/cropdate_model.dart';
import 'package:dibano/data/model/database_model.dart';
import 'package:dibano/data/model/fertilizer_model.dart';
import 'package:dibano/data/model/workstepActivity_model.dart';
import 'package:dibano/data/model/workstep_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:dibano/data/model/field_model.dart';
import 'package:dibano/data/model/crop_model.dart';
import 'package:dibano/data/model/person_model.dart';
import 'package:dibano/data/model/activity_model.dart';

class DatabaseHandler{
  static Future<Database> get database async{
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'dibano_db');

  /// *************************************************************************
  /// Setup for the Database Tables and Views
  ///**************************************************************************
    return openDatabase(
      path,
      version: 1,
      onCreate: (database, version) async{
        await database.execute('''
          CREATE TABLE Person(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            personName VARCHAR(500) NOT NULL UNIQUE
          )
        ''');

        await database.execute('''
          CREATE TABLE Field(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            fieldName VARCHAR(500) NOT NULL UNIQUE,
            fieldSize DOUBLE NOT NULL,
            longitude DOUBLE,
            latitude DOUBLE
          )
        ''');

        await database.execute('''
          CREATE TABLE Fertilizer(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            fertilizerName VARCHAR(500) NOT NULL UNIQUE,
            n DOUBLE NOT NULL,
            p DOUBLE NOT NULL,
            k DOUBLE NOT NULL
          )
        ''');

        await database.execute('''
          CREATE TABLE Crop(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            cropName VARCHAR(500) NOT NULL
          )
        ''');

        await database.execute('''
          CREATE TABLE CropDate(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            startDate DATE NOT NULL,
            endDate DATE NOT NULL,
            cropId INTEGER NOT NULL,
            fieldId INTEGER NOT NULL,
            FOREIGN KEY(fieldId) REFERENCES Field(id),
            FOREIGN KEY(cropId) REFERENCES Crop(id)
          )
        ''');

        await database.execute('''
          CREATE TABLE Workstep(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            cropdateId INTEGER NOT NULL,
            description VARCHAR(500),
            date DATE NOT NULL,
            quantityPerField DOUBLE,
            quantityPerHa DOUBLE,
            nPerField DOUBLE,
            nPerHa DOUBLE,
            pPerField DOUBLE,
            pPerHa DOUBLE,
            kPerField DOUBLE,
            kPerHa DOUBLE,
            tractor VARCHAR(500),
            fertilizerSpreader VARCHAR(500),
            seedingDepth DOUBLE,
            seedingQuantity DOUBLE,
            plantProtectionName VARCHAR(500),
            rowDistance DOUBLE,
            seedingDistance DOUBLE,
            germinationAbility VARCHAR(500),
            goalQuantity DOUBLE,
            spray VARCHAR(500),
            machiningDepth DOUBLE,
            usedMachine VARCHAR(500),
            productName VARCHAR(500),
            plantProtectionType VARCHAR(500),
            actualQuantity DOUBLE,
            waterQuantityProcentage DOUBLE,
            groundDamage VARCHAR(500),
            pest VARCHAR(500),
            fungal VARCHAR(500),
            problemWeeds VARCHAR(500),
            nutrient VARCHAR(500),
            countPerPlant DOUBLE,
            plantPerQm DOUBLE,
            turning INTEGER,
            ptoDriven INTEGER,
            personId INTEGER,
            fertilizerId INTEGER,
            FOREIGN KEY(cropdateId) REFERENCES CropDate(id)
            FOREIGN KEY(personId) REFERENCES Person(id)
            FOREIGN KEY(fertilizerId) REFERENCES Fertilizer(id)
          )
        ''');

        await database.execute('''
          CREATE TABLE Activity(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            activityName VARCHAR(500) NOT NULL UNIQUE
          )
        ''');

        await database.execute('''
          INSERT INTO Activity(activityName)
          VALUES ('Düngen (Körner)');
        ''');

        await database.execute('''
          INSERT INTO Activity(activityName)
          VALUES ('Düngen (flüssig)');
        ''');

        await database.execute('''
          INSERT INTO Activity(activityName)
          VALUES ('Saat');
        ''');

        await database.execute('''
          INSERT INTO Activity(activityName)
          VALUES ('Bodenbearbeitung');
        ''');

        await database.execute('''
          INSERT INTO Activity(activityName)
          VALUES ('Saatbeetbearbeitung');
        ''');

        await database.execute('''
          INSERT INTO Activity(activityName)
          VALUES ('Anwedung Pflanzenschutzmittel');
        ''');

        await database.execute('''
          INSERT INTO Activity(activityName)
          VALUES ('Ernte');
        ''');

        await database.execute('''
          INSERT INTO Activity(activityName)
          VALUES ('Kontrolle');
        ''');

        await database.execute('''
          CREATE TABLE WorkstepActivity(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            activityId INTEGER,
            workstepId INTEGER NOT NULL,
            FOREIGN KEY(activityId) REFERENCES Activity(id),
            FOREIGN KEY(workstepId) REFERENCES Workstep(id)
          )
        ''');

        await database.execute('''
          CREATE VIEW CompleteCrops AS
            SELECT cd.id
                  ,cr.cropName
                  ,cd.startDate
                  ,cd.endDate
                  ,cd.fieldId
                  ,fl.fieldName
                  ,fl.fieldSize
                  ,cd.id AS cropDateId
            FROM Crop cr
            INNER JOIN CropDate cd
            on cd.cropId = cr.id
            INNER JOIN Field fl
            on fl.id = cd.fieldId
        ''');

        await database.execute('''
          CREATE VIEW CompleteWorkstep AS
            SELECT cd.id
              ,wa.id as workstepActivityId
              ,ws.id as workstepId
              ,wa.activityId
              ,ws.personId
              ,pe.personName
              ,ac.activityName
              ,fd.fieldName
              ,cp.cropName
              ,ws.description
              ,ws.date
              ,ws.quantityPerField
              ,ws.quantityPerHa
              ,ws.nPerField
              ,ws.nPerHa
              ,ws.pPerField
              ,ws.pPerHa
              ,ws.kPerField
              ,ws.kPerHa
              ,ws.tractor
              ,ws.fertilizerSpreader
              ,ws.seedingDepth
              ,ws.seedingQuantity
              ,ws.plantProtectionName
              ,ws.rowDistance
              ,ws.seedingDistance
              ,ws.germinationAbility
              ,ws.goalQuantity
              ,ws.spray
              ,ws.machiningDepth
              ,ws.usedMachine
              ,ws.productName
              ,ws.plantProtectionType
              ,ws.actualQuantity
              ,ws.waterQuantityProcentage
              ,ws.groundDamage
              ,ws.pest
              ,ws.fungal
              ,ws.problemWeeds
              ,ws.nutrient
              ,ws.countPerPlant
              ,ws.plantPerQm
              ,ws.fertilizerId
              ,fe.fertilizerName
              ,fe.n
              ,fe.p
              ,fe.k
              ,ws.turning
              ,ws.ptoDriven
            FROM WorkstepActivity wa
            left JOIN Workstep ws
            on ws.id = wa.workstepId
            left JOIN Activity ac
            on ac.id = wa.activityId
            left JOIN CropDate cd
            on cd.id = ws.cropdateId
            left JOIN Crop cp
            on cp.id = cd.cropId
            left JOIN Field fd
            on fd.id = cd.fieldId
            left JOIN Person pe
            on pe.id = ws.personId
            left JOIN Fertilizer fe
            on fe.id = ws.fertilizerId
        ''');
      }
    );
  }

  /// *************************************************************************
  /// insert, update and remove functions to insert, update and remove records
  ///**************************************************************************

  // Define a function that inserts fields into the database
  Future<void> insert(DatabaseModel databaseModel, String tableName) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Field into the correct table. You might also specify the
    // In this case, replace any previous data.
    await db.insert(
      tableName,
      databaseModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,  
    );
  }

  Future<void> remove(int id, String tableName) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Field into the correct table. You might also specify the
    // In this case, replace any previous data.
    await db.delete(
      tableName,
      where: "id=?",
      whereArgs: [id]
    );
  }

  Future<void> update(DatabaseModel databaseModel, String tableName) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Field into the correct table. You might also specify the
    // In this case, replace any previous data.
    await db.update(
      tableName,
      databaseModel.toMap(),
      where: "id=?",
      whereArgs: [databaseModel.id]
    );
  }

  Future<int> insertReturnId(DatabaseModel databaseModel, String tableName) async {
    final db = await database;
    int id = await db.insert(
      tableName,
      databaseModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,  
    );
    return id;
  }

  /// *************************************************************************
  /// getters for every modelclass to return records from database
  ///**************************************************************************
   
  // A method that retrieves all the Fields from the fields table.
  Future<List<Field>> fields() async {
    final db = await database;
    final List<Map<String, Object?>> fieldMaps = await db.query('Field');
    return [
      for (final {'id': id as int, 'fieldName': fieldName as String, 'fieldSize': fieldSize as double, 'latitude': latitude as double?, 'longitude': longitude as double?}
          in fieldMaps)
        Field(id: id, fieldName: fieldName, fieldSize: fieldSize, latitude: latitude, longitude: longitude),
    ];
  }

  // A method that retrieves all the Fertilizer from the fertilizer table.
  Future<List<Fertilizer>> fertilizer() async {
    final db = await database;
    final List<Map<String, Object?>> fertilizerMap = await db.query('Fertilizer');
    return [
      for (final {'id': id as int, 'fertilizerName': fertilizerName as String, 'n': n as double, 'p': p as double, 'k': k as double}
          in fertilizerMap)
        Fertilizer(id: id, fertilizerName: fertilizerName, n: n, p: p, k: k),
    ];
  }

  // A method that retrieves all the Fields from the fields table.
  Future<List<CropDate>> cropDates() async {
    final db = await database;
    final List<Map<String, Object?>> cropDatesMap = await db.query('CropDate');
    return [
      for (final {'id': id as int, 'startDate': startDate as String, 'endDate': endDate as String, 'cropId':cropId as int, 'fieldId':fieldId as int}
          in cropDatesMap)
        CropDate(id: id, startDate: startDate, endDate: endDate, cropId: cropId, fieldId: fieldId),
    ];
  }

  Future<List<Crop>> crops() async {
    final db = await database;
    final List<Map<String, Object?>> cropMaps = await db.query('Crop');
    return [
      for (final {'id': id as int, 'cropName': cropName as String}
          in cropMaps)
        Crop(id: id, cropName: cropName),
    ];
  }

  Future<List<CompleteCrop>> completeCrops() async {
    final db = await database;
    final List<Map<String, Object?>> completeCropMap = await db.query('CompleteCrops');
    return completeCropMap.map((map) => CompleteCrop.fromMap(map)).toList();
  }

  Future<List<CompleteWorkstep>> completeWorksteps() async {
    final db = await database;
    final List<Map<String, Object?>> completeWorkstepMap = await db.query('CompleteWorkstep');
    return completeWorkstepMap.map((map) => CompleteWorkstep.fromMap(map)).toList();
  }

  Future<List<Person>> person() async {
    final db = await database;
    final List<Map<String, Object?>> personMaps = await db.query('Person');
    return [
      for (final {'id': id as int, 'personName': personName as String}
          in personMaps)
        Person(id: id, personName: personName),
    ];
  }

  Future<List<Activity>> activity() async {
    final db = await database;
    final List<Map<String, Object?>> activityMaps = await db.query('Activity');
    return [
      for (final {'id': id as int, 'activityName': activityName as String}
          in activityMaps)
        Activity(id: id, activityName: activityName),
    ];
  }

  Future<List<WorkstepActivity>> workstepActivities() async {
    final db = await database;
    final List<Map<String, Object?>> workstepActivities = await db.query('WorkstepActivity');
    return [
      for (final {'id': id as int, 'activityId': activityId as int, 'workstepId': workstepId as int}
        in workstepActivities)
        WorkstepActivity(id: id, activityId: activityId, workstepId: workstepId),
    ];  
  }

  Future<List<Workstep>> worksteps() async {
    final db = await database;
    final List<Map<String, Object?>> worksteps = await db.query('Workstep');
    return [
      for (final {'id': id as int, 
                  'description': description as String?, 
                  'quantityPerField':quantityPerField as double?,
                  'quantityPerHa':quantityPerHa as double?,
                  'nPerField':nPerField as double?,
                  'nPerHa':nPerHa as double?,
                  'pPerField':pPerField as double?,
                  'pPerHa':pPerHa as double?,
                  'kPerField':kPerField as double?,
                  'kPerHa':kPerHa as double?,
                  'fertilizerSpreader':fertilizerSpreader as String?, 
                  'seedingDepth':seedingDepth as double?,
                  'seedingQuantity':seedingQuantity as double?,
                  'plantProtectionName':plantProtectionName as String?, 
                  'rowDistance':rowDistance as double?,
                  'seedingDistance':seedingDistance as double?,
                  'germinationAbility':germinationAbility as String?, 
                  'goalQuantity':goalQuantity as double?,
                  'spray':spray as String?, 
                  'machiningDepth':machiningDepth as double?,
                  'productName':productName as String?, 
                  'plantProtectionType':plantProtectionType as String?,
                  'actualQuantity':actualQuantity as double?,
                  'waterQuantityProcentage':waterQuantityProcentage as double?,
                  'groundDamage':groundDamage as String?, 
                  'pest':pest as String?, 
                  'fungal':fungal as String?, 
                  'problemWeeds':problemWeeds as String?, 
                  'nutrient':nutrient as String?, 
                  'countPerPlant':countPerPlant as double?,
                  'plantPerQm':plantPerQm as double?,
                  'fertilizerId':fertilizerId as int?,
                  'personId': personId as int?, 
                  'cropdateId': cropDateId as int, 
                  'date': date as String,
                  'turning':turning as int?,
                  'ptoDriven':ptoDriven as int?,}
        in worksteps)
        Workstep(
          id: id,
          description: description,
          quantityPerField: quantityPerField,
          quantityPerHa: quantityPerHa,
          nPerField: nPerField,
          nPerHa: nPerHa,
          pPerField: pPerField,
          pPerHa: pPerHa,
          kPerField: kPerField,
          kPerHa: kPerHa,
          fertilizerSpreader: fertilizerSpreader,
          seedingDepth: seedingDepth,
          seedingQuantity: seedingQuantity,
          plantProtectionName: plantProtectionName,
          rowDistance: rowDistance,
          seedingDistance: seedingDistance,
          germinationAbility: germinationAbility,
          goalQuantity: goalQuantity,
          spray: spray,
          machiningDepth: machiningDepth,
          productName: productName,
          plantProtectionType: plantProtectionType,
          actualQuantity: actualQuantity,
          waterQuantityProcentage: waterQuantityProcentage,
          groundDamage: groundDamage,
          pest: pest,
          fungal: fungal,
          problemWeeds: problemWeeds,
          nutrient: nutrient,
          countPerPlant: countPerPlant,
          plantPerQm: plantPerQm,
          fertilizerId: fertilizerId,
          personId: personId,
          cropdateId: cropDateId,
          date: date,
          turning: turning,
          ptoDriven: ptoDriven,
        )
    ];  
  }
}