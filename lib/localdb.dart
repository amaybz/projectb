import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:projectb/class_pitdata.dart';

class LocalDB {
  static final _databaseName = "local_database.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 20;

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
      'numStartCells INTEGER,'
      'flRed TEXT,'
      'flYellow TEXT,'
      'flCrash TEXT,'
      'flRanking1 TEXT,'
      'flRanking2 TEXT,'
      "loseStartObject TEXT,"
      "crossSector TEXT,"
      "contactWithRobot TEXT,"
      "foul TEXT,"
      "doesAuto TEXT,"
      "leaveLine TEXT,"
      "cellAttempts INTEGER,"
      "cellSuccess INTEGER,"
      "powerPortOuter TEXT,"
      "powerPortInner TEXT,"
      "powerPortLower TEXT,"
      "cpRotationControl TEXT,"
      "cpRotationTimeTaken TEXT,"
      "cpPositionControl TEXT,"
      "cpPositionTimeTaken TEXT,"
      "cpPanelAttempts INTEGER,"
      "cpPanelSuccess INTEGER,"
      "endgamePark TEXT,"
      "endgameClimb TEXT,"
      "endgameTimeToGrip TEXT,"
      "endgameTimeFromGripToClimb TEXT,"
      "endgameOutcome TEXT,"
      "endgamePreferredPosition TEXT,"
      "endgameBuddies INTEGER,"
      "endgameBalance TEXT,"
      "endgameBalanceCorrection TEXT,"
      "endgameFall TEXT,"
      "quickRatingsDriveRating TEXT,"
      "quickRatingsDefenceRating TEXT,"
      "quickRatingsAssistRobot TEXT,"
      "quickRatingsWorkedWithAlliance TEXT,"
      "quickRatingsWorkedToAStrategy TEXT,"
      "quickRatingsRecovered TEXT,"
      "quickRatingsNoTeamWork TEXT,"
      "intakeGround TEXT,"
      "intakeHigh TEXT,"
      "intakeOtherRobot TEXT,"
      "shootingWall TEXT,"
      "shootingNearZone TEXT,"
      "shootingMidZone TEXT,"
      "shootingFarZone TEXT,"
      "comments TEXT,"
      "highlightTeam ,"
      "warning TEXT"
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
    return null;
  }

  Future<MatchScoutingData> getScoringDataRecord(int id) async {
    Database db = await database;
    List<Map> maps =
        await db.query(tblScoringData, where: 'id = ?', whereArgs: [id]);
    if (maps.length > 0) {
      return MatchScoutingData.fromLocalDB(maps.first);
    }
    return null;
  }
  Future<PitData> getPitDataRecord(int id) async {
    Database db = await database;
    List<Map> maps =
    await db.query(tblPitData, where: 'id = ?', whereArgs: [id]);
    if (maps.length > 0) {
      return PitData.fromLocalDB(maps.first);
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
  int numStartCells;
  bool flCrash;
  bool flYellow;
  bool flRed;
  bool flRanking1;
  bool flRanking2;
  //Auto Tab
  bool loseStartObject;
  bool contactWithRobot;
  bool crossSector;
  bool foul;
  bool doesAuto;
  bool leaveLine;
  //Tele Op Tab
  int cellAttempts;
  int cellSuccess;
  bool powerPortOuter;
  bool powerPortInner;
  bool powerPortLower;
  bool cpRotationControl;
  String cpRotationTimeTaken;
  bool cpPositionControl;
  String cpPositionTimeTaken;
  int cpPanelAttempts;
  int cpPanelSuccess;
  bool endgamePark;
  String endgameClimb;
  String endgameTimeToGrip;
  String endgameTimeFromGripToClimb;
  String endgameOutcome;
  String endgamePreferredPosition;
  int endgameBuddies;
  bool endgameBalance;
  bool endgameBalanceCorrection;
  bool endgameFall;
  //Ratings Tab
  String quickRatingsDriveRating;
  String quickRatingsDefenceRating;
  bool quickRatingsAssistRobot;
  bool quickRatingsWorkedWithAlliance;
  bool quickRatingsWorkedToAStrategy;
  bool quickRatingsRecovered;
  bool quickRatingsNoTeamWork;
  bool intakeGround;
  bool intakeHigh;
  bool intakeOtherRobot;
  bool shootingWall;
  bool shootingNearZone;
  bool shootingMidZone;
  bool shootingFarZone;
  String comments;
  bool highlightTeam;
  bool warning;

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
    this.numStartCells = 0,
    this.flCrash = false,
    this.flYellow = false,
    this.flRed = false,
    this.flRanking1 = false,
    this.flRanking2 = false,
    //Auto Tab
    this.loseStartObject = false,
    this.contactWithRobot = false,
    this.crossSector = false,
    this.foul = false,
    this.doesAuto = false,
    this.leaveLine = false,
    //Tele OP Tab
    this.cellAttempts = 0,
    this.cellSuccess = 0,
    this.powerPortInner = false,
    this.powerPortLower = false,
    this.powerPortOuter = false,
    this.cpRotationControl = false,
    this.cpRotationTimeTaken,
    this.cpPositionControl = false,
    this.cpPositionTimeTaken,
    this.cpPanelAttempts = 0,
    this.cpPanelSuccess = 0,
    this.endgameClimb,
    this.endgamePark = false,
    this.endgameTimeToGrip,
    this.endgameTimeFromGripToClimb,
    this.endgameOutcome,
    this.endgamePreferredPosition,
    this.endgameBuddies = 0,
    this.endgameBalance = false,
    this.endgameBalanceCorrection = false,
    this.endgameFall = false,
    //Ratings Tab
    this.quickRatingsDriveRating,
    this.quickRatingsDefenceRating,
    this.quickRatingsAssistRobot = false,
    this.quickRatingsWorkedWithAlliance = false,
    this.quickRatingsWorkedToAStrategy = false,
    this.quickRatingsRecovered = false,
    this.quickRatingsNoTeamWork = false,
    this.intakeGround = false,
    this.intakeHigh = false,
    this.intakeOtherRobot = false,
    this.shootingWall = false,
    this.shootingNearZone = false,
    this.shootingMidZone = false,
    this.shootingFarZone = false,
    this.comments,
    this.highlightTeam = false,
    this.warning = false,
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
      'numStartCells' : numStartCells,
      'flRed' : flRed,
      'flYellow' : flYellow,
      'flCrash' : flCrash,
      'flRanking1' : flRanking1,
      'flRanking2' : flRanking2,
      //AutoTab
      'loseStartObject': loseStartObject,
      'contactWithRobot': contactWithRobot,
      'crossSector': crossSector,
      'foul': foul,
      'doesAuto': doesAuto,
      'leaveLine': leaveLine,
      //Tele OP Tab
      'cellAttempts': cellAttempts,
      'cellSuccess': cellSuccess,
      'powerPortLower': powerPortLower,
      'powerPortInner': powerPortInner,
      'powerPortOuter': powerPortOuter,
      'cpRotationControl': cpRotationControl,
      'cpRotationTimeTaken': cpRotationTimeTaken,
      'cpPositionControl': cpPositionControl,
      'cpPositionTimeTaken': cpPositionTimeTaken,
      'cpPanelAttempts': cpPanelAttempts,
      'cpPanelSuccess': cpPanelSuccess,
      'endgamePark': endgamePark,
      'endgameClimb': endgameClimb,
      'endgameTimeToGrip': endgameTimeToGrip,
      'endgameTimeFromGripToClimb': endgameTimeFromGripToClimb,
      'endgameOutcome': endgameOutcome,
      'endgamePreferredPosition': endgamePreferredPosition,
      'endgameBuddies': endgameBuddies,
      'endgameBalance': endgameBalance,
      'endgameBalanceCorrection': endgameBalanceCorrection,
      'endgameFall': endgameFall,
      //RatingsTab
      'quickRatingsDriveRating': quickRatingsDriveRating,
      'quickRatingsDefenceRating': quickRatingsDefenceRating,
      'quickRatingsAssistRobot': quickRatingsAssistRobot,
      'quickRatingsWorkedWithAlliance': quickRatingsWorkedWithAlliance,
      'quickRatingsWorkedToAStrategy': quickRatingsWorkedToAStrategy,
      'quickRatingsRecovered': quickRatingsRecovered,
      'quickRatingsNoTeamWork': quickRatingsNoTeamWork,
      'intakeGround': intakeGround,
      'intakeHigh': intakeHigh,
      'intakeOtherRobot': intakeOtherRobot,
      'shootingWall': shootingWall,
      'shootingNearZone': shootingNearZone,
      'shootingMidZone': shootingMidZone,
      'shootingFarZone': shootingFarZone,
      'comments': comments,
      'highlightTeam': highlightTeam,
      'warning': warning,
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
      'numStartCells': numStartCells,
      'flRed': flRed.toString(),
      'flYellow': flYellow.toString(),
      'flCrash': flCrash.toString(),
      'flRanking1': flRanking1.toString(),
      'flRanking2': flRanking2.toString(),
      //Auto Tab
      'loseStartObject': loseStartObject.toString(),
      'contactWithRobot': contactWithRobot.toString(),
      'crossSector': crossSector.toString(),
      'foul': foul.toString(),
      'doesAuto': doesAuto.toString(),
      'leaveLine': leaveLine.toString(),
      //Tele OP Tab
      'cellAttempts': cellAttempts,
      'cellSuccess': cellSuccess,
      'powerPortLower': powerPortLower.toString(),
      'powerPortInner': powerPortInner.toString(),
      'powerPortOuter': powerPortOuter.toString(),
      'cpRotationControl': cpRotationControl.toString(),
      'cpRotationTimeTaken': cpRotationTimeTaken.toString(),
      'cpPositionControl': cpPositionControl.toString(),
      'cpPositionTimeTaken': cpPositionTimeTaken.toString(),
      'cpPanelAttempts': cpPanelAttempts,
      'cpPanelSuccess': cpPanelSuccess,
      'endgamePark': endgamePark.toString(),
      'endgameClimb': endgameClimb.toString(),
      'endgameTimeToGrip': endgameTimeToGrip.toString(),
      'endgameTimeFromGripToClimb': endgameTimeFromGripToClimb.toString(),
      'endgameOutcome': endgameOutcome.toString(),
      'endgamePreferredPosition': endgamePreferredPosition.toString(),
      'endgameBuddies': endgameBuddies,
      'endgameBalance': endgameBalance.toString(),
      'endgameBalanceCorrection': endgameBalanceCorrection.toString(),
      'endgameFall': endgameFall.toString(),
      //Ratings Tab
      'quickRatingsDriveRating': quickRatingsDriveRating,
      'quickRatingsDefenceRating': quickRatingsDefenceRating,
      'quickRatingsAssistRobot': quickRatingsAssistRobot.toString(),
      'quickRatingsWorkedWithAlliance': quickRatingsWorkedWithAlliance.toString(),
      'quickRatingsWorkedToAStrategy': quickRatingsWorkedToAStrategy.toString(),
      'quickRatingsRecovered': quickRatingsRecovered.toString(),
      'quickRatingsNoTeamWork': quickRatingsNoTeamWork.toString(),
      'intakeGround': intakeGround.toString(),
      'intakeHigh': intakeHigh.toString(),
      'intakeOtherRobot': intakeOtherRobot.toString(),
      'shootingWall': shootingWall.toString(),
      'shootingNearZone': shootingNearZone.toString(),
      'shootingMidZone': shootingMidZone.toString(),
      'shootingFarZone': shootingFarZone.toString(),
      'comments': comments.toString(),
      'highlightTeam': highlightTeam.toString(),
      'warning': warning.toString(),
    };
  }

  MatchScoutingData.fromLocalDB(Map<String, dynamic> map) {
    this.id = map['id'];
    this.txEvent = map['txEvent'];
    this.numMatch = map['numMatch'];
    this.idAlliance = map['idAlliance'];
    this.idDriveStation = map['idDriveStation'];
    this.idTeam = map['idTeam'];
    this.txScoutName = map['txScoutName'];
    this.idStartFacing = map['idStartFacing'];
    this.idStartPosition = map['idStartPosition'];
    this.numStartCells = map['numStartCells'];
    this.flRed = map['flRed'];
    this.flYellow = map['flYellow'].toString().toLowerCase() == 'true';
    this.flCrash = map['flCrash'].toString().toLowerCase() == 'true';
    this.flRanking1 = map['flRanking1'].toString().toLowerCase() == 'true';
    this.flRanking2 = map['flRanking2'].toString().toLowerCase() == 'true';//Auto Tab
    this.loseStartObject =
        map['loseStartObject'].toString().toLowerCase() == 'true';
    this.contactWithRobot =
        map['contactWithRobot'].toString().toLowerCase() == 'true';
    this.crossSector = map['crossSector'].toString().toLowerCase() == 'true';
    this.foul = map['foul'].toString().toLowerCase() == 'true';
    this.doesAuto = map['doesAuto'].toString().toLowerCase() == 'true';
    this.leaveLine = map['leaveLine'].toString().toLowerCase() == 'true';
    //Tele OP Tab
    this.cellAttempts = map['cellAttempts'];
    this.cellSuccess = map['cellSuccess'];
    this.powerPortLower =
        map['powerPortLower'].toString().toLowerCase() == 'true';
    this.powerPortInner =
        map['powerPortInner'].toString().toLowerCase() == 'true';
    this.powerPortOuter =
        map['powerPortOuter'].toString().toLowerCase() == 'true';
    this.cpRotationControl =
        map['cpRotationControl'].toString().toLowerCase() == 'true';
    this.cpRotationTimeTaken = map['cpRotationTimeTaken'];
    this.cpPositionControl =
        map['cpPositionControl'].toString().toLowerCase() == 'true';
    this.cpPanelAttempts = map['cpPanelAttempts'];
    this.cpPanelSuccess = map['cpPanelSuccess'];
    this.cpPositionTimeTaken = map['cpPositionTimeTaken'];
    this.endgamePark = map['endgamePark'].toString().toLowerCase() == 'true';
    this.endgameClimb = map['endgameClimb'];
    this.endgameTimeToGrip = map['endgameTimeToGrip'];
    this.endgameTimeFromGripToClimb = map['endgameTimeFromGripToClimb'];
    this.endgameOutcome = map['endgameOutcome'];
    this.endgamePreferredPosition = map['endgamePreferredPosition'];
    this.endgameBuddies = map['endgameBuddies'];
    this.endgameBalance = map['endgameBalance'].toString().toLowerCase() == 'true';
    this.endgameBalanceCorrection = map['endgameBalanceCorrection'].toString().toLowerCase() == 'true';
    this.endgameFall = map['endgameFall'].toString().toLowerCase() == 'true';
    //Ratings Tab
    this.quickRatingsDriveRating = map['quickRatingsDriveRating'];
    this.quickRatingsDefenceRating = map['quickRatingsDefenceRating'];
    this.quickRatingsAssistRobot = map['quickRatingsAssistRobot'].toString().toLowerCase() == 'true';
    this.quickRatingsWorkedWithAlliance = map['quickRatingsWorkedWithAlliance'].toString().toLowerCase() == 'true';
    this.quickRatingsWorkedToAStrategy = map['quickRatingsWorkedToAStrategy'].toString().toLowerCase() == 'true';
    this.quickRatingsRecovered = map['quickRatingsRecovered'].toString().toLowerCase() == 'true';
    this.quickRatingsNoTeamWork = map['quickRatingsNoTeamWork'].toString().toLowerCase() == 'true';
    this.intakeGround = map['intakeGround'].toString().toLowerCase() == 'true';
    this.intakeHigh = map['intakeHigh'].toString().toLowerCase() == 'true';
    this.intakeOtherRobot = map['intakeOtherRobot'].toString().toLowerCase() == 'true';
    this.shootingWall = map['shootingWall'].toString().toLowerCase() == 'true';
    this.shootingNearZone = map['shootingNearZone'].toString().toLowerCase() == 'true';
    this.shootingMidZone = map['shootingMidZone'].toString().toLowerCase() == 'true';
    this.shootingFarZone = map['shootingFarZone'].toString().toLowerCase() == 'true';
    this.comments = map['comments'];
    this.highlightTeam = map['highlightTeam'].toString().toLowerCase() == 'true';
    this.warning = map['warning'].toString().toLowerCase() == 'true';
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
    this.numStartCells = map['numStartCells'];
    this.flRed = map['flRed'];
    this.flYellow = map['flYellow'];
    this.flCrash = map['flCrash'];
    this.flRanking1 = map['flRanking1'];
    this.flRanking2 = map['flRanking2'];
    //Auto Tab
    this.loseStartObject = map['loseStartObject'];
    this.contactWithRobot = map['contactWithRobot'];
    this.crossSector = map['crossSector'];
    this.foul = map['foul'];
    this.doesAuto = map['doesAuto'];
    this.leaveLine = map['leaveLine'];
    //Tele OP Tab
    this.cellAttempts = map['cellAttempts'];
    this.cellSuccess = map['cellSuccess'];
    this.powerPortLower = map['powerPortLower'];
    this.powerPortInner = map['powerPortInner'];
    this.powerPortOuter = map['powerPortOuter'];
    this.cpRotationControl = map['cpRotationControl'];
    this.cpRotationTimeTaken = map['cpRotationTimeTaken'];
    this.cpPositionControl = map['cpPositionControl'];
    this.cpPositionTimeTaken = map['cpPositionTimeTaken'];
    this.cpPanelAttempts = map['cpPanelAttempts'];
    this.cpPanelSuccess = map['cpPanelSuccess'];
    this.endgamePark = map['endgamePark'];
    this.endgameClimb = map['endgameClimb'];
    this.endgameTimeToGrip = map['endgameTimeToGrip'];
    this.endgameTimeFromGripToClimb = map['endgameTimeFromGripToClimb'];
    this.endgameOutcome = map['endgameOutcome'];
    this.endgamePreferredPosition = map['endgamePreferredPosition'];
    this.endgameBuddies = map['endgameBuddies'];
    this.endgameBalance = map['endgameBalance'];
    this.endgameBalanceCorrection = map['endgameBalanceCorrection'];
    this.endgameFall = map['endgameFall'];
    //Ratings Tab
    this.quickRatingsDriveRating = map['quickRatingsDriveRating'];
    this.quickRatingsDefenceRating = map['quickRatingsDefenceRating'];
    this.quickRatingsAssistRobot = map['quickRatingsAssistRobot'];
    this.quickRatingsWorkedWithAlliance = map['quickRatingsWorkedWithAlliance'];
    this.quickRatingsWorkedToAStrategy = map['quickRatingsWorkedToAStrategy'];
    this.quickRatingsRecovered = map['quickRatingsRecovered'];
    this.quickRatingsNoTeamWork = map['quickRatingsNoTeamWork'];
    this.intakeGround = map['intakeGround'];
    this.intakeHigh = map['intakeHigh'];
    this.intakeOtherRobot = map['intakeOtherRobot'];
    this.shootingWall = map['shootingWall'];
    this.shootingNearZone = map['shootingNearZone'];
    this.shootingMidZone = map['shootingMidZone'];
    this.shootingFarZone = map['shootingFarZone'];
    this.comments = map['comments'];
    this.highlightTeam = map['highlightTeam'];
    this.warning = map['warning'];
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
        'startingCells: $numStartCells, '
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
