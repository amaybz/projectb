import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'webapi.dart';

class LocalDB {
  static final _databaseName = "local_database.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 18;

  final String tblEvents = "events";
  final String tblDevice = "Device";
  final String tblScoringData = "ScoringData";
  final String tblEventTeams = "EventTeams";

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
      "scoutName TEXT, "
      "matchNumber INTEGER, "
      "alliance TEXT, "
      "driveStation TEXT, "
      "team TEXT, "
      "facing TEXT, "
      "robotPosition TEXT, "
      "startingCells INTEGER,"
      "robotFail TEXT,"
      "yellowCard TEXT,"
      "redCard TEXT,"
      "operational TEXT,"
      "energised TEXT,"
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
      "driveRating TEXT,"
      "defenceRating TEXT"
      ")";

  // Make this a singleton class.
  LocalDB._privateConstructor();
  static final LocalDB instance = LocalDB._privateConstructor();

  void _createTables(Database db, int version) async {
    await db.execute(createTblEvents);
    await db.execute(createTblScoringData);
    await db.execute(createTblDevice);
    await db.execute(createTblEventTeams);
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute("DROP TABLE IF EXISTS $tblScoringData");
    await db.execute("DROP TABLE IF EXISTS $tblEventTeams");
    await db.execute("DROP TABLE IF EXISTS $tblEvents");
    await db.execute("DROP TABLE IF EXISTS $tblDevice");
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
  String team;
  String scoutName;
  int matchNumber;
  String alliance;
  String driveStation;
  String facing;
  String robotPosition;
  int startingCells;
  bool robotFail;
  bool yellowCard;
  bool redCard;
  bool operational;
  bool energised;
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
  String driveRating;
  String defenceRating;

  MatchScoutingData({
    this.id,
    this.team,
    this.scoutName,
    this.alliance,
    this.driveStation,
    this.facing,
    this.matchNumber = 0,
    this.robotPosition,
    this.startingCells = 0,
    this.robotFail = false,
    this.yellowCard = false,
    this.redCard = false,
    this.operational = false,
    this.energised = false,
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
    this.driveRating,
    this.defenceRating,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'team': team,
      'scoutName': scoutName,
      'alliance': alliance,
      'driveStation': driveStation,
      'facing': facing,
      'matchNumber': matchNumber,
      'robotPosition': robotPosition,
      'startingCells': startingCells,
      'robotFail': robotFail,
      'operational': operational,
      'redCard': redCard,
      'yellowCard': yellowCard,
      'energised': energised,
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
      'driveRating': driveRating,
      'defenceRating': defenceRating,
    };
  }

  Map<String, dynamic> toLocalDB() {
    return {
      'id': id,
      'team': team,
      'scoutName': scoutName,
      'alliance': alliance,
      'driveStation': driveStation,
      'facing': facing,
      'matchNumber': matchNumber,
      'robotPosition': robotPosition,
      'startingCells': startingCells,
      'robotFail': robotFail.toString(),
      'operational': operational.toString(),
      'redCard': redCard.toString(),
      'yellowCard': yellowCard.toString(),
      'energised': energised.toString(),
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
      'driveRating': driveRating,
      'defenceRating': defenceRating,
    };
  }

  MatchScoutingData.fromLocalDB(Map<String, dynamic> map) {
    this.id = map['id'];
    this.team = map['team'];
    this.scoutName = map['scoutName'];
    this.alliance = map['alliance'];
    this.driveStation = map['driveStation'];
    this.facing = map['facing'];
    this.matchNumber = map['matchNumber'];
    this.robotPosition = map['robotPosition'];
    this.startingCells = map['startingCells'];
    this.robotPosition = map['robotPosition'];
    this.robotFail = map['robotFail'].toString().toLowerCase() == 'true';
    this.operational = map['operational'].toString().toLowerCase() == 'true';
    this.redCard = map['redCard'].toString().toLowerCase() == 'true';
    this.yellowCard = map['yellowCard'].toString().toLowerCase() == 'true';
    this.energised = map['energised'].toString().toLowerCase() == 'true';
    //Auto Tab
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
    this.driveRating = map['driveRating'];
    this.defenceRating = map['defenceRating'];
  }

  MatchScoutingData.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.team = map['team'];
    this.scoutName = map['scoutName'];
    this.alliance = map['alliance'];
    this.driveStation = map['driveStation'];
    this.facing = map['facing'];
    this.matchNumber = map['matchNumber'];
    this.robotPosition = map['robotPosition'];
    this.startingCells = map['startingCells'];
    this.robotPosition = map['robotPosition'];
    this.robotFail = map['robotFail'];
    this.operational = map['operational'];
    this.redCard = map['redCard'];
    this.yellowCard = map['yellowCard'];
    this.energised = map['energised'];
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
    this.driveRating = map['driveRating'];
    this.defenceRating = map['defenceRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['"id"'] = this.id;
    data['"team"'] = '"' + this.team.toString() + '"';
    data['"scoutName"'] = '"' + this.scoutName.toString() + '"';
    data['"alliance"'] = '"' + this.alliance.toString() + '"';
    data['"driveStation"'] = '"' + this.driveStation.toString() + '"';
    data['"facing"'] = '"' + this.facing.toString() + '"';
    data['"matchNumber"'] = this.matchNumber;
    data['"robotPosition"'] = '"' + this.robotPosition.toString() + '"';
    data['"startingCells"'] = this.startingCells;
    data['"robotFail"'] = '"' + this.robotFail.toString() + '"';
    data['"operational"'] = '"' + this.operational.toString() + '"';
    data['"redCard"'] = '"' + this.redCard.toString() + '"';
    data['"yellowCard"'] = '"' + this.yellowCard.toString() + '"';
    data['"energised"'] = '"' + this.energised.toString() + '"';
    //Auto Tab
    data['"loseStartObject"'] = '"' + this.loseStartObject.toString() + '"';
    data['"contactWithRobot"'] = '"' + this.contactWithRobot.toString() + '"';
    data['"crossSector"'] = '"' + this.crossSector.toString() + '"';
    data['"foul"'] = '"' + this.foul.toString() + '"';
    data['"doesAuto"'] = '"' + this.doesAuto.toString() + '"';
    data['"leaveLine"'] = '"' + this.leaveLine.toString() + '"';
    //Tele OP Tab
    data['"cellAttempts"'] = this.cellAttempts;
    data['"cellSuccess"'] = this.cellSuccess;
    data['"powerPortLower"'] = '"' + this.powerPortLower.toString() + '"';
    data['"powerPortInner"'] = '"' + this.powerPortInner.toString() + '"';
    data['"powerPortOuter"'] = '"' + this.powerPortOuter.toString() + '"';
    data['"cpRotationControl"'] = '"' + this.cpRotationControl.toString() + '"';
    data['"cpRotationTimeTaken"'] =
        '"' + this.cpRotationTimeTaken.toString() + '"';
    data['"cpPositionControl"'] = '"' + this.cpPositionControl.toString() + '"';
    data['"cpPositionTimeTaken"'] =
        '"' + this.cpPositionTimeTaken.toString() + '"';
    data['"cpPanelAttempts"'] = this.cpPanelAttempts;
    data['"cpPanelSuccess"'] = this.cpPanelSuccess;
    data['"endgamePark"'] = '"' + this.endgamePark.toString() + '"';
    data['"endgameClimb"'] = '"' + this.endgameClimb.toString() + '"';
    data['"endgameTimeToGrip"'] = '"' + this.endgameTimeToGrip.toString() + '"';
    data['"endgameTimeFromGripToClimb"'] = '"' + this.endgameTimeFromGripToClimb.toString() + '"';
    data['"endgameOutcome"'] = '"' + this.endgameOutcome.toString() + '"';
    data['"endgamePreferredPosition"'] = '"' + this.endgamePreferredPosition.toString() + '"';
    data['"endgameBuddies"'] = this.endgameBuddies;
    data['"endgameBalance"'] = '"' + this.endgameBalance.toString() + '"';
    data['"endgameBalanceCorrection"'] = '"' + this.endgameBalanceCorrection.toString() + '"';
    data['"endgameFall"'] = '"' + this.endgameFall.toString() + '"';
    //Ratings Tab
    data['"driveRating"'] = '"' + this.driveRating.toString() + '"';
    data['"defenceRating"'] = '"' + this.defenceRating.toString() + '"';
    return data;
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'MatchScoutingData{'
        'id: $id, '
        'team: $team, '
        'scoutName: $scoutName, '
        'alliance: $alliance, '
        'driveStation: $driveStation, '
        'facing: $facing, '
        'matchNumber: $matchNumber, '
        'robotPosition: $robotPosition, '
        'startingCells: $startingCells, '
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
