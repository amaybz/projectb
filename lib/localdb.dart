import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'webapi.dart';

class LocalDB {

  static final _databaseName = "local_database.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 6;

  final String tblEvents = "events";
  final String tblDevice = "Device";
  final String tblScoringData = "ScoringData";
  final String tblEventTeams= "EventTeams";

  final String createTblEventTeams=
      "CREATE TABLE IF NOT EXISTS EventTeams("
      "key TEXT PRIMARY KEY, "
      "name TEXT, "
      "nickName TEXT, "
      "teamNumber TEXT)";

  final String createTblEvents =
      "CREATE TABLE IF NOT EXISTS events("
      "key TEXT PRIMARY KEY, "
      "name TEXT, "
      "shortName TEXT, "
      "location TEXT)";
  final String createTblDevice =
      "CREATE TABLE IF NOT EXISTS Device(id INTEGER PRIMARY KEY, name TEXT, location TEXT)";
  final String createTblScoringData =
      "CREATE TABLE IF NOT EXISTS ScoringData("
      "id INTEGER PRIMARY KEY, "
      "scoutName TEXT, "
      "matchNumber INTEGER, "
      "alliance TEXT, "
      "driveStation TEXT, "
      "team TEXT, "
      "facing TEXT, "
      "robotPosition TEXT, "
      "startingCells INTEGER)";

  // Make this a singleton class.
  LocalDB._privateConstructor();
  static final LocalDB instance = LocalDB._privateConstructor();

  createTables(Database db) async {
    db.execute(createTblEvents);
    db.execute(createTblScoringData);
    db.execute(createTblDevice);
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

  Future<void> insertEvent(LocalEvent event) async {
    // Get a reference to the database.
    final Database db = await database;
    //insert data to DB
    await db.insert(
      tblEvents,
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
      tblScoringData,
      scoringData.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateDeviceDetails(DeviceName deviceName) async {
    // Get a reference to the database.
    final Database db = await database;
    //update device Record
    await db.insert(
      tblDevice,
      deviceName.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<DeviceName> getDeviceName() async {
    Database db = await database;
    List<Map> maps = await db.query(tblDevice,
        columns: ['id', 'name', 'location'],
        where: 'id = ?',
        whereArgs: [1]);
    if (maps.length > 0) {
      return DeviceName.fromMap(maps.first);
    }
    return null;
  }

  Future<List<LocalEvent>> listEvents() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all records.
    final List<Map<String, dynamic>> maps = await db.query(tblEvents);

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return LocalEvent(
        key: maps[i]['key'],
        name: maps[i]['name'],
        location: maps[i]['location'],
      );
    });
  }

  Future<List<LocalEvent>> getEvent(String key) async {
    // Get a reference to the database.
    final Database db = await database;
    // Query the table for all records.
    final List<Map<String, dynamic>> maps = await db.query(tblEvents, where: 'key=?', whereArgs: [key]);

    // Convert the List<Map<String, dynamic> into a List
    return List.generate(maps.length, (i) {
      return LocalEvent(
        key: maps[i]['key'],
        name: maps[i]['name'],
        shortName: maps[i]['shortName'],
        location: maps[i]['location'],
      );
    });
  }

  Future<List<ScoringData>> listScoringData() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query(tblScoringData);

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

class LocalTeam {
  final String key;
  final String name;
  final String teamNumber;
  final String nickName;

  LocalTeam({
    @required this.key,
    this.name,
    this.nickName,
    this.teamNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'name': name,
      'shortName': nickName,
      'location': teamNumber,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Event{id: $key, name: $name, teamNumber: $teamNumber}';
  }
}

class LocalEvent {
  final String key;
  final String name;
  final String location;
  final String shortName;

  LocalEvent({
    this.name,
    this.shortName,
    this.location,
    @required this.key
  });

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'name': name,
      'shortName': shortName,
      'location': location,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Event{id: $key, name: $name, location: $location}';
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
   int id;
   String name;
   String location;

  DeviceName({this.id, this.name, this.location});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
    };

  }

   DeviceName.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    location = map['location'];
  }

  @override
  String toString() {
    return 'DeviceName{id: $id, name: $name, location: $location}';
  }
}
