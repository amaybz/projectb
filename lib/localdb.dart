// @dart = 2.7

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:projectb/class_pitdata.dart';
import 'package:projectb/class_macthscoutingdata.dart';

class LocalDB {
  static final _databaseName = "local_database.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 30;

  final String tblEvents = "events";
  final String tblDevice = "Device";
  final String tblScoringData = "ScoringData";
  final String tblEventTeams = "EventTeams";
  final String tblPitData = "PitData";

  final String createTblEventTeams = "CREATE TABLE IF NOT EXISTS EventTeams("
      "key TEXT PRIMARY KEY, "
      "name TEXT, "
      "nickName TEXT, "
      "teamNumber TEXT)";

  final String createTblEvents = "CREATE TABLE IF NOT EXISTS events("
      "key TEXT PRIMARY KEY, "
      "name TEXT, "
      "shortName TEXT, "
      "location TEXT)";
  final String createTblDevice =
      "CREATE TABLE IF NOT EXISTS Device(id INTEGER PRIMARY KEY, name TEXT, location TEXT)";
  final String createTblScoringData = "CREATE TABLE IF NOT EXISTS ScoringData("
      "id INTEGER PRIMARY KEY, "
      'txEvent TEXT,'
      'txDeviceName TEXT,'
      'numMatch INTEGER,'
      'idAlliance TEXT,'
      'idDriveStation TEXT,'
      'idTeam TEXT,'
      'txScoutName TEXT,'
      'idStartFacing TEXT,'
      'idStartPosition TEXT,'
      'numStartCargo TEXT,'
      'flRed TEXT,'
      'flYellow TEXT,'
      'flCrash TEXT,'
      'flRanking1 TEXT,'
      'flRanking2 TEXT,'
      'autoFlStart TEXT,'
      'autoFlBaseLine TEXT,'
      'autoNumCellLoad INTEGER,'
      'autoFlFoul TEXT,'
      'autoFlRobotContact TEXT,'
      'autoFlLoseStartObject TEXT,'
      'autoFlCrossOver TEXT,'
      'autoNumCargoHighAttempt INTEGER,'
      'autoNumCargoHighSuccess INTEGER,'
      'autoNumCargoLowAttempt INTEGER,'
      'autoNumCargoLowSuccess INTEGER,'
      'autoNumCargoTerminalAttempt INTEGER,'
      'autoNumCargoTerminalSuccess INTEGER,'
      'autoNumCargoHumanAttempt INTEGER,'
      'autoNumCargoHumanHighSuccess INTEGER,'
      'autoNumCargoHumanLowSuccess INTEGER,'
      'autoNumCargoHumanField INTEGER,'
      'autoNumCargoHumanRobot INTEGER,'
      'teleFlHanger TEXT,'
      'teleNumClimbTime TEXT,'
      'teleIdClimb TEXT,'
      'teleIdClimbGrabTime TEXT,'
      'teleIdClimbTime TEXT,'
      'teleIdClimbOutcome TEXT,'
      'teleIdClimbPos TEXT,'
      'teleFlClimbFall TEXT,'
      'flClimbTransition TEXT,'
      'idTransitionSpeed TEXT,'
      'teleNumCargoHighAttempt INTEGER,'
      'teleNumCargoHighSuccess INTEGER,'
      'teleNumCargoLowAttempt INTEGER,'
      'teleNumCargoLowSuccess INTEGER,'
      'teleNumCargoTerminalAttempt INTEGER,'
      'teleNumCargoTerminalSuccess INTEGER,'
      'commFlAssist TEXT,'
      'commIdDriveRating TEXT,'
      'commIdDefenceRating TEXT,'
      'commFlStrategy TEXT,'
      'commFlOwnThing TEXT,'
      'commFlRecovery TEXT,'
      'commFlWarning TEXT,'
      'commFlHighlight TEXT,'
      'commFlShotFar TEXT,'
      'commFlShotMid TEXT,'
      'commFlShotNear TEXT,'
      'commFlShotWall TEXT,'
      'commFlShotHub TEXT,'
      'commFlIntakeGround TEXT,'
      'commFlIntakeHigh TEXT,'
      'commFlIntakeRobot TEXT,'
      'commTxNotes TEXT'
      ")";
  final String createTblPitData = 'CREATE TABLE IF NOT EXISTS PitData('
      'id INTEGER PRIMARY KEY, '
      'txEvent TEXT,'
      'idTeam TEXT,'
      'txScoutName TEXT,'
      'numWeight INTEGER,'
      'numHeight INTEGER,'
      'numWidth INTEGER,'
      'imgTeamUniform TEXT,'
      'imgRobotFront TEXT,'
      'imgRobotSide TEXT,'
      'flCargo TEXT,'
      'flIntakeGround TEXT,'
      'flIntakeHigh TEXT,'
      'flIntakeBounce TEXT,'
      'flIntakeSort TEXT,'
      'numStorage INTEGER,'
      'txShooting TEXT,'
      'flTargetLow TEXT,'
      'flTargetUpper TEXT,'
      'flTargetTerminal TEXT,'
      'flClimb TEXT,'
      'idClimbType TEXT,'
      'numClimbHeight INTEGER,'
      'numClimbWidth INTEGER,'
      'flClimbSecure TEXT,'
      'idClimbGrab TEXT,'
      'idClimbSpeed TEXT,'
      'idClimbPos TEXT,'
      'flClimbMove TEXT,'
      'txClimb TEXT,'
      'flClimbTransition TEXT,'
      'idTransition TEXT,'
      'idTransitionSpeed TEXT,'
      'flHuman TEXT,'
      'intHumanAccuracy INTEGER,'
      'flAuto TEXT,'
      'flAutoLine TEXT,'
      'flAutoShoot TEXT,'
      'numAutoShoot INTEGER,'
      'numAutoLoad INTEGER,'
      'flAutoSort TEXT,'
      'txPitNotes TEXT,'
      'dtCreation TEXT,'
      'dtModified TEXT,'
      'txComputerName TEXT'
      ')';

  // Make this a singleton class.
  LocalDB._privateConstructor();
  static final LocalDB instance = LocalDB._privateConstructor();

  void _createTables(Database db, int version) async {
    await db.execute(createTblEvents);
    await db.execute(createTblScoringData);
    await db.execute(createTblDevice);
    await db.execute(createTblEventTeams);
    await db.execute(createTblPitData);
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute("DROP TABLE IF EXISTS $tblScoringData");
    await db.execute("DROP TABLE IF EXISTS $tblEventTeams");
    await db.execute("DROP TABLE IF EXISTS $tblEvents");
    await db.execute("DROP TABLE IF EXISTS $tblDevice");
    await db.execute("DROP TABLE IF EXISTS $tblPitData");
    _createTables(db, newVersion);
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
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _createTables,
      onUpgrade: _onUpgrade,
    );
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

  Future<int> insertScoringData(MatchScoutingData scoringData) async {
    // Get a reference to the database.
    final Database db = await database;

    int insertedID = await db.insert(
      tblScoringData,
      scoringData.toLocalDB(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return insertedID;
  }

  Future<int> insertPitData(PitData pitData) async {
    // Get a reference to the database.
    final Database db = await database;

    int insertedID = await db.insert(
      tblPitData,
      pitData.toLocalDB(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return insertedID;
  }

  Future<int> insertLocalTeam(LocalTeam localTeam) async {
    // Get a reference to the database.
    final Database db = await database;

    int insertedID = await db.insert(
      tblEventTeams,
      localTeam.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return insertedID;
  }

  Future<void> clearLocalTeams() async {
    // Get a reference to the database.
    final Database db = await database;
    //delete all teams in DB
    await db.execute("delete from " + tblEventTeams);
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
        columns: ['id', 'name', 'location'], where: 'id = ?', whereArgs: [1]);
    if (maps.length > 0) {
      return DeviceName.fromMap(maps.first);
    }
    DeviceName deviceName;
    deviceName.name = "";
    return deviceName;
  }

  Future<MatchScoutingData> getScoringDataRecord(int id) async {
    Database db = await database;
    List<Map> maps =
        await db.query(tblScoringData, where: 'id = ?', whereArgs: [id]);
    if (maps.length > 0) {
      return MatchScoutingData.fromLocalDB(maps.first);
    }
    MatchScoutingData matchScoutingData;
    matchScoutingData.idTeam = "0";
    return matchScoutingData;
  }

  Future<PitData> getPitDataRecord(int id) async {
    Database db = await database;
    List<Map> maps =
        await db.query(tblPitData, where: 'id = ?', whereArgs: [id]);
    if (maps.length > 0) {
      return PitData.fromLocalDB(maps.first);
    }
    PitData pitData;
    pitData.idTeam = "0";
    return pitData;
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

  Future<List<LocalTeam>> listLocalTeams() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all records.
    final List<Map<String, dynamic>> maps = await db.query(tblEventTeams);

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return LocalTeam(
        key: maps[i]['key'],
        name: maps[i]['name'],
        nickName: maps[i]['nickName'],
        teamNumber: maps[i]['teamNumber'],
      );
    });
  }

  Future<List<LocalEvent>> getEvent(String key) async {
    // Get a reference to the database.
    final Database db = await database;
    // Query the table for all records.
    final List<Map<String, dynamic>> maps =
        await db.query(tblEvents, where: 'key=?', whereArgs: [key]);

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

  Future<List<MatchScoutingData>> listScoringData() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query(tblScoringData);

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return MatchScoutingData.fromLocalDB(maps[i]);
    });
  }

  Future<List<PitData>> listPitData() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query(tblPitData);

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return PitData.fromLocalDB(maps[i]);
    });
  }
}

class LocalTeam {
  String key;
  String name;
  String teamNumber;
  String nickName;

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
      'nickName': nickName,
      'teamNumber': teamNumber,
    };
  }

  // Implement toString to make it easier to see information about
  // each team when using the print statement.
  @override
  String toString() {
    return 'LocalTeam{id: $key, name: $name, teamNumber: $teamNumber}';
  }
}

class LocalEvent {
  final String key;
  final String name;
  final String location;
  final String shortName;

  LocalEvent({this.name, this.shortName, this.location, @required this.key});

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'name': name,
      'shortName': shortName,
      'location': location,
    };
  }

  // Implement toString to make it easier to see information about
  // each item when using the print statement.
  @override
  String toString() {
    return 'Event{id: $key, name: $name, location: $location}';
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

  DeviceName.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    name = map['name'];
    location = map['location'];
  }

  @override
  String toString() {
    return 'DeviceName{id: $id, name: $name, location: $location}';
  }
}
