import 'dart:async';

import 'package:dibano/data/model/database_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:dibano/data/model/field_model.dart';

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
}