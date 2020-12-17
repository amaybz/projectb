import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDB {

  static final _databaseName = "local_database.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  final String tblEvents =
      "CREATE TABLE IF NOT EXISTS events(id INTEGER PRIMARY KEY, name TEXT, location TEXT)";
  final String tblDevice =
      "CREATE TABLE IF NOT EXISTS Device(id INTEGER PRIMARY KEY, name TEXT, location TEXT)";
  final String tblScoringData =
      "CREATE TABLE IF NOT EXISTS ScoringData(id INTEGER PRIMARY KEY, scoutName TEXT, matchNumber INTEGER, alliance TEXT, driveStation TEXT, team TEXT, facing TEXT, robotPosition TEXT, startingCells INTEGER)";

  createTables(Database db) async {
    db.execute(tblEvents);
    db.execute(tblScoringData);
    db.execute(tblDevice);
  }

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  // open the database
  _initDatabase() async {
    // The path_provider plugin gets the right directory for Android or iOS.
    String path = join(await getDatabasesPath(), _databaseName);
    // Open the database. Can also add an onUpdate callback parameter.
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: (db, version) {
          return createTables(db);
        },);
  }

  Future<void> insertEvent(Event event) async {
    // Get a reference to the database.
    final Database db = await database;
    //insert data to DB
    await db.insert(
      'events',
      event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertScoringData(ScoringData scoringData) async {
    // Get a reference to the database.
    final Database db = await database;

    // Insert the Dog into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same dog is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      'ScoringData',
      scoringData.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateDeviceDetails(DeviceName deviceName) async {
    // Get a reference to the database.
    final Database db = await database;
    //update device Record
    await db.insert(
      'Device',
      deviceName.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Event>> listEvents() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('events');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Event(
        id: maps[i]['id'],
        name: maps[i]['name'],
        location: maps[i]['location'],
      );
    });
  }

  Future<List<ScoringData>> listScoringData() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('ScoringData');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return ScoringData(
        id: maps[i]['id'],
        team: maps[i]['team'],
        scoutName: maps[i]['scoutName'],
      );
    });
  }
}

class Event {
  final int id;
  final String name;
  final String location;

  Event({this.id, this.name, this.location});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Event{id: $id, name: $name, location: $location}';
  }
}

class ScoringData {
  final int id;
  final String team;
  final String scoutName;

  ScoringData({this.id, this.team, this.scoutName});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'team': team,
      'scoutName': scoutName,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'ScoringData{id: $id, team: $team, scoutName: $scoutName}';
  }
}

class DeviceName {
  final int id;
  final String name;
  final String location;

  DeviceName({this.id, this.name, this.location});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
    };
  }

  @override
  String toString() {
    return 'DeviceName{id: $id, name: $name, location: $location}';
  }
}
