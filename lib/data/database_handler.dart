import 'dart:async';

import 'package:dibano/data/model/completeCrop_model.dart';
import 'package:dibano/data/model/completeWorkstep_model.dart';
import 'package:dibano/data/model/cropdate_model.dart';
import 'package:dibano/data/model/database_model.dart';
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
            personName VARCHAR(50) NOT NULL UNIQUE
          )
        ''');

        await database.execute('''
          CREATE TABLE Field(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            fieldName VARCHAR(50) NOT NULL UNIQUE
          )
        ''');

        await database.execute('''
          CREATE TABLE Crop(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            cropName VARCHAR(50) NOT NULL UNIQUE
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
            description VARCHAR(200) NOT NULL,
            date DATE NOT NULL,
            personId INTEGER NOT NULL,
            FOREIGN KEY(cropdateId) REFERENCES CropDate(id)
            FOREIGN KEY(personId) REFERENCES Person(id)
          )
        ''');

        await database.execute('''
          CREATE TABLE Activity(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            activityName VARCHAR(50) NOT NULL UNIQUE
          )
        ''');

        await database.execute('''
          CREATE TABLE WorkstepActivity(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            activityId INTEGER NOT NULL,
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
              ,ac.activityName
              ,fd.fieldName
              ,cp.cropName
              ,ws.description
              ,ws.date
            FROM WorkstepActivity wa
            INNER JOIN Workstep ws
            on ws.id = wa.workstepId
            INNER JOIN Activity ac
            on ac.id = wa.activityId
            INNER JOIN CropDate cd
            on cd.id = ws.cropdateId
            INNER JOIN Crop cp
            on cp.id = cd.cropId
            INNER JOIN Field fd
            on fd.id = cd.fieldId
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
      for (final {'id': id as int, 'fieldName': fieldName as String}
          in fieldMaps)
        Field(id: id, fieldName: fieldName),
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
      for (final {'id': id as int, 'description': description as String, 'personId': personId as int, 'cropdateId': cropDateId as int, 'date': date as String}
        in worksteps)
        Workstep(id: id, description: description, personId: personId, cropdateId: cropDateId, date: date),
    ];  
  }
}