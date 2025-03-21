import 'dart:async';

import 'package:dibano/data/model/completeCrop_model.dart';
import 'package:dibano/data/model/cropdate_model.dart';
import 'package:dibano/data/model/database_model.dart';
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
            person VARCHAR(50) NOT NULL,
            FOREIGN KEY(cropdateId) REFERENCES CropDate(id)
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
            SELECT cr.cropName
                  ,cd.startDate
                  ,cd.endDate
                  ,cd.fieldId
                  ,fl.fieldName
            FROM Crop cr
            INNER JOIN CropDate cd
            on cd.cropId = cr.id
            INNER JOIN Field fl
            on fl.id = cd.fieldId
        ''');
      }
    );
  }

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

  Future<int> insertReturnId(DatabaseModel databaseModel, String tableName) async {
    final db = await database;
    int id = await db.insert(
      tableName,
      databaseModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,  
    );
    return id;
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
}