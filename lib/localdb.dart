// @dart = 2.7

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:projectb/class_pitdata.dart';

class LocalDB {
  static final _databaseName = "local_database.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 23;

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
      'numMatch INTEGER,'
      'idAlliance TEXT,'
      'idDriveStation TEXT,'
      'idTeam TEXT,'
      'txScoutName TEXT,'
      'idStartFacing TEXT,'
      'idStartPosition TEXT,'
      'idStartCells TEXT,'
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
      'autoNumCellAttempt INTEGER,'
      'autoNumCellSuccess INTEGER,'
      'autoFlOuter TEXT,'
      'autoFlInner TEXT,'
      'autoFlLower TEXT,'
      'teleFlPanelRotation TEXT,'
      'teleIdPanelRotationTime TEXT,'
      'teleFlPanelPosition TEXT,'
      'teleIdPanelPositionTime TEXT,'
      'teleNumPanelAttempt INTEGER,'
      'teleNumPanelSuccess INTEGER,'
      'teleFlPark TEXT,'
      'teleIdClimb TEXT,'
      'teleIdClimbGrabTime TEXT,'
      'teleIdClimbTime TEXT,'
      'teleIdClimbOutcome TEXT,'
      'teleIdClimbPos TEXT,'
      'teleNumClimbOthers INTEGER,'
      'teleFlClimbBalance TEXT,'
      'teleFlClimbCorrection TEXT,'
      'teleFlClimbFall TEXT,'
      'teleNumCellAttempt INTEGER,'
      'teleNumCellSuccess INTEGER,'
      'teleFlOuter TEXT,'
      'teleFlInner TEXT,'
      'teleFlLower TEXT,'
      'commFlAssist TEXT,'
      'commIdDriveRating TEXT,'
      'commIdDefenceRating TEXT,'
      'commFlAlliance TEXT,'
      'commFlStrategy TEXT,'
      'commFlOwnThing TEXT,'
      'commFlRecovery TEXT,'
      'commFlWarning TEXT,'
      'commFlHighlight TEXT,'
      'commFlShotFar TEXT,'
      'commFlShotMid TEXT,'
      'commFlShotNear TEXT,'
      'commFlShotWall TEXT,'
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
      'flCells TEXT,'
      'flIntakeGround TEXT,'
      'flIntakeHigh TEXT,'
      'numStorage INTEGER,'
      'txShooting TEXT,'
      'flTargetLow TEXT,'
      'flTargetOuter TEXT,'
      'flTargetInner TEXT,'
      'flClimb TEXT,'
      'idClimbType TEXT,'
      'numClimbHeight INTEGER,'
      'flClimbSecure TEXT,'
      'idClimbGrab TEXT,'
      'idClimbSpeed TEXT,'
      'flClimbTilt TEXT,'
      'txClimb TEXT,'
      'idClimbPos TEXT,'
      'flClimbLevel TEXT,'
      'flClimbLevelSelf TEXT,'
      'flClimbLevelOther TEXT,'
      'flClimbMove TEXT,'
      'flClimbOther TEXT,'
      'numClimbOther INTEGER,'
      'flPanel TEXT,'
      'flPanelBrake TEXT,'
      'flPanelRotation TEXT,'
      'flPanelPos TEXT,'
      'flPanelSensor TEXT,'
      'txPanelSensor TEXT,'
      'flAuto TEXT,'
      'flAutoLine TEXT,'
      'flAutoShoot TEXT,'
      'numAutoShoot INTEGER,'
      'numAutoLoad INTEGER,'
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

class MatchScoutingData {
  int id;
  String txEvent;
  String idTeam;
  String txScoutName;
  int numMatch;
  String idAlliance;
  String idDriveStation;
  String idStartFacing;
  String idStartPosition;
  String idStartCells;
  bool flCrash;
  bool flYellow;
  bool flRed;
  bool flRanking1;
  bool flRanking2;
  //Auto Tab
  bool autoFlStart;
  bool autoFlBaseLine;
  int autoNumCellLoad;
  //Auto - Errors
  bool autoFlFoul;
  bool autoFlRobotContact;
  bool autoFlLoseStartObject;
  bool autoFlCrossOver;
  //Auto - Performance
  int autoNumCellAttempt;
  int autoNumCellSuccess;
  bool autoFlOuter;
  bool autoFlInner;
  bool autoFlLower;

  //Tele Op Tab
  int teleNumCellAttempt;
  int teleNumCellSuccess;
  bool teleFlOuter;
  bool teleFlInner;
  bool teleFlLower;
  bool teleFlPanelRotation;
  String teleIdPanelRotationTime;
  bool teleFlPanelPosition;
  String teleIdPanelPositionTime;
  int teleNumPanelAttempt;
  int teleNumPanelSuccess;
  bool teleFlPark;
  String teleIdClimb;
  String teleIdClimbGrabTime;
  String teleIdClimbTime;
  String teleIdClimbOutcome;
  String teleIdClimbPos;
  int teleNumClimbOthers;
  bool teleFlClimbBalance;
  bool teleFlClimbCorrection;
  bool teleFlClimbFall;
  //Ratings Tab
  String commIdDriveRating;
  String commIdDefenceRating;
  bool commFlAssist;
  bool commFlAlliance;
  bool commFlStrategy;
  bool commFlRecovery;
  bool commFlOwnThing;
  bool commFlIntakeGround;
  bool commFlIntakeHigh;
  bool commFlIntakeRobot;
  bool commFlShotWall;
  bool commFlShotNear;
  bool commFlShotMid;
  bool commFlShotFar;
  String commTxNotes;
  bool commFlHighlight;
  bool commFlWarning;

  MatchScoutingData({
    this.id,
    this.txEvent,
    this.idTeam,
    this.txScoutName,
    this.idAlliance,
    this.idDriveStation,
    this.idStartFacing,
    this.numMatch = 0,
    this.idStartPosition,
    this.idStartCells,
    this.flCrash = false,
    this.flYellow = false,
    this.flRed = false,
    this.flRanking1 = false,
    this.flRanking2 = false,
    //Auto Tab
    this.autoFlStart = false,
    this.autoFlBaseLine = false,
    this.autoNumCellLoad = 0,
    //Auto - Errors
    this.autoFlLoseStartObject = false,
    this.autoFlRobotContact = false,
    this.autoFlCrossOver = false,
    this.autoFlFoul = false,
    //Auto - Performance
    this.autoNumCellAttempt = 0,
    this.autoNumCellSuccess = 0,
    this.autoFlOuter = false,
    this.autoFlInner = false,
    this.autoFlLower = false,
    //Tele OP Tab
    //Tele - Control Panel
    this.teleFlPanelRotation = false,
    this.teleIdPanelRotationTime,
    this.teleFlPanelPosition = false,
    this.teleIdPanelPositionTime,
    this.teleNumPanelAttempt = 0,
    this.teleNumPanelSuccess = 0,
    //Tele - Endgame
    this.teleFlPark = false,
    this.teleIdClimb,
    this.teleIdClimbGrabTime,
    this.teleIdClimbTime,
    this.teleIdClimbOutcome,
    this.teleIdClimbPos,
    this.teleNumClimbOthers = 0,
    this.teleFlClimbBalance = false,
    this.teleFlClimbCorrection = false,
    this.teleFlClimbFall = false,
    //Tele - Performance
    this.teleNumCellAttempt = 0,
    this.teleNumCellSuccess = 0,
    this.teleFlOuter = false,
    this.teleFlInner = false,
    this.teleFlLower = false,
    //Ratings Tab
    this.commIdDriveRating,
    this.commIdDefenceRating,
    this.commFlAssist = false,
    this.commFlAlliance = false,
    this.commFlStrategy = false,
    this.commFlRecovery = false,
    this.commFlOwnThing = false,
    this.commFlIntakeGround = false,
    this.commFlIntakeHigh = false,
    this.commFlIntakeRobot = false,
    this.commFlShotWall = false,
    this.commFlShotNear = false,
    this.commFlShotMid = false,
    this.commFlShotFar = false,
    this.commTxNotes,
    this.commFlHighlight = false,
    this.commFlWarning = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'txEvent' : txEvent,
      'numMatch' : numMatch,
      'idAlliance' : idAlliance,
      'idDriveStation' : idDriveStation,
      'idTeam' : idTeam,
      'txScoutName' : txScoutName,
      'idStartFacing' : idStartFacing,
      'idStartPosition' : idStartPosition,
      'idStartCells' : idStartCells,
      'flRed' : flRed,
      'flYellow' : flYellow,
      'flCrash' : flCrash,
      'flRanking1' : flRanking1,
      'flRanking2' : flRanking2,
      //AutoTab
      'autoFlStart' : autoFlStart,
      'autoFlBaseLine' : autoFlBaseLine,
      'autoNumCellLoad' : autoNumCellLoad,
      'autoFlFoul' : autoFlFoul,
      'autoFlRobotContact' : autoFlRobotContact,
      'autoFlLoseStartObject' : autoFlLoseStartObject,
      'autoFlCrossOver' : autoFlCrossOver,
      'autoNumCellAttempt' : autoNumCellAttempt,
      'autoNumCellSuccess' : autoNumCellSuccess,
      'autoFlOuter' : autoFlOuter,
      'autoFlInner' : autoFlInner,
      'autoFlLower' : autoFlLower,
      //Tele OP Tab
      'teleFlPanelRotation' : teleFlPanelRotation,
      'teleIdPanelRotationTime' : teleIdPanelRotationTime,
      'teleFlPanelPosition' : teleFlPanelPosition,
      'teleIdPanelPositionTime' : teleIdPanelPositionTime,
      'teleNumPanelAttempt' : teleNumPanelAttempt,
      'teleNumPanelSuccess' : teleNumPanelSuccess,
      'teleFlPark' : teleFlPark,
      'teleIdClimb' : teleIdClimb,
      'teleIdClimbGrabTime' : teleIdClimbGrabTime,
      'teleIdClimbTime' : teleIdClimbTime,
      'teleIdClimbOutcome' : teleIdClimbOutcome,
      'teleIdClimbPos' : teleIdClimbPos,
      'teleNumClimbOthers' : teleNumClimbOthers,
      'teleFlClimbBalance' : teleFlClimbBalance,
      'teleFlClimbCorrection' : teleFlClimbCorrection,
      'teleFlClimbFall' : teleFlClimbFall,
      'teleNumCellAttempt' : teleNumCellAttempt,
      'teleNumCellSuccess' : teleNumCellSuccess,
      'teleFlOuter' : teleFlOuter,
      'teleFlInner' : teleFlInner,
      'teleFlLower' : teleFlLower,
      //RatingsTab
      'commFlAssist' : commFlAssist,
      'commIdDriveRating' : commIdDriveRating,
      'commIdDefenceRating' : commIdDefenceRating,
      'commFlAlliance' : commFlAlliance,
      'commFlStrategy' : commFlStrategy,
      'commFlOwnThing' : commFlOwnThing,
      'commFlRecovery' : commFlRecovery,
      'commFlWarning' : commFlWarning,
      'commFlHighlight' : commFlHighlight,
      'commFlShotFar' : commFlShotFar,
      'commFlShotMid' : commFlShotMid,
      'commFlShotNear' : commFlShotNear,
      'commFlShotWall' : commFlShotWall,
      'commFlIntakeGround' : commFlIntakeGround,
      'commFlIntakeHigh' : commFlIntakeHigh,
      'commFlIntakeRobot' : commFlIntakeRobot,
      'commTxNotes' : commTxNotes,
    };
  }

  Map<String, dynamic> toLocalDB() {
    return {
      'id': id,
      'txEvent': txEvent,
      'numMatch': numMatch,
      'idAlliance': idAlliance,
      'idDriveStation': idDriveStation,
      'idTeam': idTeam,
      'txScoutName': txScoutName,
      'idStartFacing': idStartFacing,
      'idStartPosition': idStartPosition,
      'idStartCells': idStartCells,
      'flRed': flRed.toString(),
      'flYellow': flYellow.toString(),
      'flCrash': flCrash.toString(),
      'flRanking1': flRanking1.toString(),
      'flRanking2': flRanking2.toString(),
      //Auto Tab
      'autoFlStart': autoFlStart.toString(),
      'autoFlBaseLine': autoFlBaseLine.toString(),
      'autoNumCellLoad': autoNumCellLoad,
      'autoFlFoul': autoFlFoul.toString(),
      'autoFlRobotContact': autoFlRobotContact.toString(),
      'autoFlLoseStartObject': autoFlLoseStartObject.toString(),
      'autoFlCrossOver': autoFlCrossOver.toString(),
      'autoNumCellAttempt': autoNumCellAttempt,
      'autoNumCellSuccess': autoNumCellSuccess,
      'autoFlOuter': autoFlOuter.toString(),
      'autoFlInner': autoFlInner.toString(),
      'autoFlLower': autoFlLower.toString(),
      //Tele OP Tab
      'teleFlPanelRotation': teleFlPanelRotation.toString(),
      'teleIdPanelRotationTime': teleIdPanelRotationTime,
      'teleFlPanelPosition': teleFlPanelPosition.toString(),
      'teleIdPanelPositionTime': teleIdPanelPositionTime,
      'teleNumPanelAttempt': teleNumPanelAttempt,
      'teleNumPanelSuccess': teleNumPanelSuccess,
      'teleFlPark': teleFlPark.toString(),
      'teleIdClimb': teleIdClimb,
      'teleIdClimbGrabTime': teleIdClimbGrabTime,
      'teleIdClimbTime': teleIdClimbTime,
      'teleIdClimbOutcome': teleIdClimbOutcome,
      'teleIdClimbPos': teleIdClimbPos,
      'teleNumClimbOthers': teleNumClimbOthers,
      'teleFlClimbBalance': teleFlClimbBalance.toString(),
      'teleFlClimbCorrection': teleFlClimbCorrection.toString(),
      'teleFlClimbFall': teleFlClimbFall.toString(),
      'teleNumCellAttempt': teleNumCellAttempt,
      'teleNumCellSuccess': teleNumCellSuccess,
      'teleFlOuter': teleFlOuter.toString(),
      'teleFlInner': teleFlInner.toString(),
      'teleFlLower': teleFlLower.toString(),
      //Ratings Tab
      'commFlAssist': commFlAssist.toString(),
      'commIdDriveRating': commIdDriveRating,
      'commIdDefenceRating': commIdDefenceRating,
      'commFlAlliance': commFlAlliance.toString(),
      'commFlStrategy': commFlStrategy.toString(),
      'commFlOwnThing': commFlOwnThing.toString(),
      'commFlRecovery': commFlRecovery.toString(),
      'commFlWarning': commFlWarning.toString(),
      'commFlHighlight': commFlHighlight.toString(),
      'commFlShotFar': commFlShotFar.toString(),
      'commFlShotMid': commFlShotMid.toString(),
      'commFlShotNear': commFlShotNear.toString(),
      'commFlShotWall': commFlShotWall.toString(),
      'commFlIntakeGround': commFlIntakeGround.toString(),
      'commFlIntakeHigh': commFlIntakeHigh.toString(),
      'commFlIntakeRobot': commFlIntakeRobot.toString(),
      'commTxNotes': commTxNotes,
    };
  }

  MatchScoutingData.fromLocalDB(Map<dynamic, dynamic> map) {
    this.id = map['id'];
    this.txEvent = map['txEvent'];
    this.numMatch = map['numMatch'];
    this.idAlliance = map['idAlliance'];
    this.idDriveStation = map['idDriveStation'];
    this.idTeam = map['idTeam'];
    this.txScoutName = map['txScoutName'];
    this.idStartFacing = map['idStartFacing'];
    this.idStartPosition = map['idStartPosition'];
    this.idStartCells = map['idStartCells'];
    this.flRed = map['flRed'].toString().toLowerCase() == 'true';
    this.flYellow = map['flYellow'].toString().toLowerCase() == 'true';
    this.flCrash = map['flCrash'].toString().toLowerCase() == 'true';
    this.flRanking1 = map['flRanking1'].toString().toLowerCase() == 'true';
    this.flRanking2 = map['flRanking2'].toString().toLowerCase() == 'true';
    //Auto Tab
    this.autoFlStart = map['autoFlStart'].toString().toLowerCase() == 'true';
     this.autoFlBaseLine = map['autoFlBaseLine'].toString().toLowerCase() == 'true';
    this.autoNumCellLoad = map['autoNumCellLoad'];
    this.autoFlFoul = map['autoFlFoul'].toString().toLowerCase() == 'true';
    this.autoFlRobotContact = map['autoFlRobotContact'].toString().toLowerCase() == 'true';
    this.autoFlLoseStartObject = map['autoFlLoseStartObject'].toString().toLowerCase() == 'true';
    this.autoFlCrossOver = map['autoFlCrossOver'].toString().toLowerCase() == 'true';
    this.autoNumCellAttempt = map['autoNumCellAttempt'];
    this.autoNumCellSuccess = map['autoNumCellSuccess'];
    this.autoFlOuter = map['autoFlOuter'].toString().toLowerCase() == 'true';
    this.autoFlInner = map['autoFlInner'].toString().toLowerCase() == 'true';
    this.autoFlLower = map['autoFlLower'].toString().toLowerCase() == 'true';
    //Tele OP Tab
    this.teleFlPanelRotation = map['teleFlPanelRotation'].toString().toLowerCase() == 'true';
    this.teleIdPanelRotationTime = map['teleIdPanelRotationTime'];
    this.teleFlPanelPosition = map['teleFlPanelPosition'].toString().toLowerCase() == 'true';
    this.teleIdPanelPositionTime = map['teleIdPanelPositionTime'];
    this.teleNumPanelAttempt = map['teleNumPanelAttempt'];
    this.teleNumPanelSuccess = map['teleNumPanelSuccess'];
    this.teleFlPark = map['teleFlPark'].toString().toLowerCase() == 'true';
    this.teleIdClimb = map['teleIdClimb'];
    this.teleIdClimbGrabTime = map['teleIdClimbGrabTime'];
    this.teleIdClimbTime = map['teleIdClimbTime'];
    this.teleIdClimbOutcome = map['teleIdClimbOutcome'];
    this.teleIdClimbPos = map['teleIdClimbPos'];
    this.teleNumClimbOthers = map['teleNumClimbOthers'];
    this.teleFlClimbBalance = map['teleFlClimbBalance'].toString().toLowerCase() == 'true';
    this.teleFlClimbCorrection = map['teleFlClimbCorrection'].toString().toLowerCase() == 'true';
    this.teleFlClimbFall = map['teleFlClimbFall'].toString().toLowerCase() == 'true';
    this.teleNumCellAttempt = map['teleNumCellAttempt'];
    this.teleNumCellSuccess = map['teleNumCellSuccess'];
    this.teleFlOuter = map['teleFlOuter'].toString().toLowerCase() == 'true';
    this.teleFlInner = map['teleFlInner'].toString().toLowerCase() == 'true';
    this.teleFlLower = map['teleFlLower'].toString().toLowerCase() == 'true';
    //Ratings Tab
    this.commFlAssist = map['commFlAssist'].toString().toLowerCase() == 'true';
    this.commIdDriveRating = map['commIdDriveRating'];
    this.commIdDefenceRating = map['commIdDefenceRating'];
    this.commFlAlliance = map['commFlAlliance'].toString().toLowerCase() == 'true';
    this.commFlStrategy = map['commFlStrategy'].toString().toLowerCase() == 'true';
    this.commFlOwnThing = map['commFlOwnThing'].toString().toLowerCase() == 'true';
    this.commFlRecovery = map['commFlRecovery'].toString().toLowerCase() == 'true';
    this.commFlWarning = map['commFlWarning'].toString().toLowerCase() == 'true';
    this.commFlHighlight = map['commFlHighlight'].toString().toLowerCase() == 'true';
    this.commFlShotFar = map['commFlShotFar'].toString().toLowerCase() == 'true';
    this.commFlShotMid = map['commFlShotMid'].toString().toLowerCase() == 'true';
    this.commFlShotNear = map['commFlShotNear'].toString().toLowerCase() == 'true';
    this.commFlShotWall = map['commFlShotWall'].toString().toLowerCase() == 'true';
    this.commFlIntakeGround = map['commFlIntakeGround'].toString().toLowerCase() == 'true';
    this.commFlIntakeHigh = map['commFlIntakeHigh'].toString().toLowerCase() == 'true';
    this.commFlIntakeRobot = map['commFlIntakeRobot'].toString().toLowerCase() == 'true';
    this.commTxNotes = map['commTxNotes'];
  }

  MatchScoutingData.fromMap(Map<String, dynamic> map) {

    this.id = map['id'];
    this.txEvent = map['txEvent'];
    this.numMatch = map['numMatch'];
    this.idAlliance = map['idAlliance'];
    this.idDriveStation = map['idDriveStation'];
    this.idTeam = map['idTeam'];
    this.txScoutName = map['txScoutName'];
    this.idStartFacing = map['idStartFacing'];
    this.idStartPosition = map['idStartPosition'];
    this.idStartCells = map['idStartCells'];
    this.flRed = map['flRed'];
    this.flYellow = map['flYellow'];
    this.flCrash = map['flCrash'];
    this.flRanking1 = map['flRanking1'];
    this.flRanking2 = map['flRanking2'];
    //Auto Tab
    this.autoFlStart = map['autoFlStart'];
    this.autoFlBaseLine = map['autoFlBaseLine'];
    this.autoNumCellLoad = map['autoNumCellLoad'];
    this.autoFlFoul = map['autoFlFoul'];
    this.autoFlRobotContact = map['autoFlRobotContact'];
    this.autoFlLoseStartObject = map['autoFlLoseStartObject'];
    this.autoFlCrossOver = map['autoFlCrossOver'];
    this.autoNumCellAttempt = map['autoNumCellAttempt'];
    this.autoNumCellSuccess = map['autoNumCellSuccess'];
    this.autoFlOuter = map['autoFlOuter'];
    this.autoFlInner = map['autoFlInner'];
    this.autoFlLower = map['autoFlLower'];
    //Tele OP Tab
    this.teleFlPanelRotation = map['teleFlPanelRotation'];
    this.teleIdPanelRotationTime = map['teleIdPanelRotationTime'];
    this.teleFlPanelPosition = map['teleFlPanelPosition'];
    this.teleIdPanelPositionTime = map['teleIdPanelPositionTime'];
    this.teleNumPanelAttempt = map['teleNumPanelAttempt'];
    this.teleNumPanelSuccess = map['teleNumPanelSuccess'];
    this.teleFlPark = map['teleFlPark'];
    this.teleIdClimb = map['teleIdClimb'];
    this.teleIdClimbGrabTime = map['teleIdClimbGrabTime'];
    this.teleIdClimbTime = map['teleIdClimbTime'];
    this.teleIdClimbOutcome = map['teleIdClimbOutcome'];
    this.teleIdClimbPos = map['teleIdClimbPos'];
    this.teleNumClimbOthers = map['teleNumClimbOthers'];
    this.teleFlClimbBalance = map['teleFlClimbBalance'];
    this.teleFlClimbCorrection = map['teleFlClimbCorrection'];
    this.teleFlClimbFall = map['teleFlClimbFall'];
    this.teleNumCellAttempt = map['teleNumCellAttempt'];
    this.teleNumCellSuccess = map['teleNumCellSuccess'];
    this.teleFlOuter = map['teleFlOuter'];
    this.teleFlInner = map['teleFlInner'];
    this.teleFlLower = map['teleFlLower'];
    //Ratings Tab
    this.commFlAssist = map['commFlAssist'];
    this.commIdDriveRating = map['commIdDriveRating'];
    this.commIdDefenceRating = map['commIdDefenceRating'];
    this.commFlAlliance = map['commFlAlliance'];
    this.commFlStrategy = map['commFlStrategy'];
    this.commFlOwnThing = map['commFlOwnThing'];
    this.commFlRecovery = map['commFlRecovery'];
    this.commFlWarning = map['commFlWarning'];
    this.commFlHighlight = map['commFlHighlight'];
    this.commFlShotFar = map['commFlShotFar'];
    this.commFlShotMid = map['commFlShotMid'];
    this.commFlShotNear = map['commFlShotNear'];
    this.commFlShotWall = map['commFlShotWall'];
    this.commFlIntakeGround = map['commFlIntakeGround'];
    this.commFlIntakeHigh = map['commFlIntakeHigh'];
    this.commFlIntakeRobot = map['commFlIntakeRobot'];
    this.commTxNotes = map['commTxNotes'];
  }

  // Implement toString to make it easier to see information about
  @override
  String toString() {
    return 'MatchScoutingData{'
        'id: $id, '
        'team: $idTeam, '
        'scoutName: $txScoutName, '
        'alliance: $idAlliance, '
        'driveStation: $idDriveStation, '
        'facing: $idStartFacing, '
        'numMatch: $numMatch, '
        'robotPosition: $idStartPosition, '
        'idStartCells: $idStartCells, '
        '}';
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
