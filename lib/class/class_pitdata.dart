import 'dart:io';

class PitData {
  int? id;
  String? pitTxEvent;
  String? pitTxScoutName;
  int? pitIdTeam;
  int? pitNumWeight;
  int? pitNumHeight;
  int? pitNumWidth;
  File? pitImgTeamUniform;
  File? pitImgRobotFront;
  File? pitImgRobotSide;
  String? pitIdDriveType;
  String? pitIdFieldAccess;
  String? pitTxDriveNotes;
  bool? pitFlObject;
  bool? pitFlObjectCatch;
  bool? pitFlObjectFloor;
  String? pitTxObjectNotes;
  String? pitIdCapacity;
  String? pitIdThrough;
  bool? pitFlScoreFuel;
  bool? pitFlDeliverFuel;
  int? pitNumLauncher;
  String? pitIdShooterHeight;
  String? pitIdShooterType;
  String? pitTxScoringNotes;
  bool? pitFlClimb;
  String? pitIdClimbPos;
  String? pitIdClimbHeightMax;
  String? pitIdClimbHeightPref;
  bool? pitFlClimbRelease;
  String? pitTxClimbNotes;
  bool? pitFlAuto;
  bool? pitFlAutoScoreFuel;
  int? pitNumAutoScore;
  int? pitNumAutoFuel;
  String? pitIdAutoReloadPoints;
  bool? pitFlAutoClimb;
  String? pitTxAutoNotes;
  String? pitTxPitNotes;
  String? dtCreation;
  String? dtModified;
  String? txComputerName;
  bool? uploaded;

  PitData({
    this.id = 0,
    this.pitTxEvent,
    this.pitTxScoutName,
    this.pitIdTeam = 0,
    this.pitNumWeight = 0,
    this.pitNumHeight = 0,
    this.pitNumWidth = 0,
    this.pitImgTeamUniform,
    this.pitImgRobotFront,
    this.pitImgRobotSide,
    this.pitIdDriveType = "1",
    this.pitIdFieldAccess = "1",
    this.pitTxDriveNotes,
    this.pitFlObject = false,
    this.pitFlObjectCatch = false,
    this.pitFlObjectFloor = false,
    this.pitTxObjectNotes,
    this.pitIdCapacity = "1",
    this.pitIdThrough = "1",
    this.pitFlScoreFuel = false,
    this.pitFlDeliverFuel = false,
    this.pitNumLauncher = 0,
    this.pitIdShooterHeight,
    this.pitIdShooterType,
    this.pitTxScoringNotes,
    this.pitFlClimb = false,
    this.pitIdClimbPos = "1",
    this.pitIdClimbHeightMax = "1",
    this.pitIdClimbHeightPref = "1",
    this.pitFlClimbRelease = false,
    this.pitTxClimbNotes,
    this.pitFlAuto = false,
    this.pitFlAutoScoreFuel = false,
    this.pitNumAutoScore = 0,
    this.pitNumAutoFuel = 0,
    this.pitIdAutoReloadPoints = "1",
    this.pitFlAutoClimb = false,
    this.pitTxAutoNotes,
    this.pitTxPitNotes,
    this.dtCreation,
    this.dtModified,
    this.txComputerName,
    this.uploaded = false,
  });

  Map<String, dynamic> toLocalDB() {
    String? fileRobotFront;
    if (pitImgRobotFront != null) {
      fileRobotFront = pitImgRobotFront?.path;
    }
    String? fileImgRobotSide;
    if (pitImgRobotSide != null) {
      fileImgRobotSide = pitImgRobotSide?.path;
    }
    String? fileImgTeamUniform;
    if (pitImgTeamUniform != null) {
      fileImgTeamUniform = pitImgTeamUniform?.path;
    }

    return {
      'pitImgTeamUniform': fileImgTeamUniform,
      'pitImgRobotFront': fileRobotFront,
      'pitImgRobotSide': fileImgRobotSide,
      'id': id,
      'pitTxEvent': pitTxEvent,
      'pitTxScoutName': pitTxScoutName,
      'pitIdTeam': pitIdTeam,
      'pitNumWeight': pitNumWeight,
      'pitNumHeight': pitNumHeight,
      'pitNumWidth': pitNumWidth,
      //'pitImgTeamUniform': pitImgTeamUniform,
      //'pitImgRobotFront': pitImgRobotFront,
      //'pitImgRobotSide': pitImgRobotSide,
      'pitIdDriveType': pitIdDriveType,
      'pitIdFieldAccess': pitIdFieldAccess,
      'pitTxDriveNotes': pitTxDriveNotes,
      'pitFlObject': pitFlObject.toString(),
      'pitFlObjectCatch': pitFlObjectCatch.toString(),
      'pitFlObjectFloor': pitFlObjectFloor.toString(),
      'pitTxObjectNotes': pitTxObjectNotes,
      'pitIdCapacity': pitIdCapacity,
      'pitIdThrough': pitIdThrough,
      'pitFlScoreFuel': pitFlScoreFuel.toString(),
      'pitFlDeliverFuel': pitFlDeliverFuel.toString(),
      'pitNumLauncher': pitNumLauncher,
      'pitIdShooterHeight': pitIdShooterHeight,
      'pitIdShooterType': pitIdShooterType,
      'pitTxScoringNotes': pitTxScoringNotes,
      'pitFlClimb': pitFlClimb.toString(),
      'pitIdClimbPos': pitIdClimbPos,
      'pitIdClimbHeightMax': pitIdClimbHeightMax,
      'pitIdClimbHeightPref': pitIdClimbHeightPref,
      'pitFlClimbRelease': pitFlClimbRelease.toString(),
      'pitTxClimbNotes': pitTxClimbNotes,
      'pitFlAuto': pitFlAuto.toString(),
      'pitFlAutoScoreFuel': pitFlAutoScoreFuel.toString(),
      'pitNumAutoScore': pitNumAutoScore,
      'pitNumAutoFuel': pitNumAutoFuel,
      'pitIdAutoReloadPoints': pitIdAutoReloadPoints,
      'pitFlAutoClimb': pitFlAutoClimb.toString(),
      'pitTxAutoNotes': pitTxAutoNotes,
      'pitTxPitNotes': pitTxPitNotes,
      'dtCreation': dtCreation,
      'dtModified': dtModified,
      'txComputerName': txComputerName,
      'uploaded': uploaded.toString(),
    };
  }

  PitData.fromLocalDB(Map<dynamic, dynamic> map) {
    this.id = map['id'];
    this.pitTxEvent = map['pitTxEvent'];
    this.pitTxScoutName = map['pitTxScoutName'];
    this.pitIdTeam = map['pitIdTeam'];
    this.pitNumWeight = map['pitNumWeight'];
    this.pitNumHeight = map['pitNumHeight'];
    this.pitNumWidth = map['pitNumWidth'];
    //this.pitImgTeamUniform = map['pitImgTeamUniform'];
    //this.pitImgRobotFront = map['pitImgRobotFront'];
    //this.pitImgRobotSide = map['pitImgRobotSide'];
    this.pitIdDriveType = map['pitIdDriveType'];
    this.pitIdFieldAccess = map['pitIdFieldAccess'];
    this.pitTxDriveNotes = map['pitTxDriveNotes'];
    this.pitFlObject = map['pitFlObject'].toString().toLowerCase() == 'true';
    this.pitFlObjectCatch =
        map['pitFlObjectCatch'].toString().toLowerCase() == 'true';
    this.pitFlObjectFloor =
        map['pitFlObjectFloor'].toString().toLowerCase() == 'true';
    this.pitTxObjectNotes = map['pitTxObjectNotes'];
    this.pitIdCapacity = map['pitIdCapacity'];
    this.pitIdThrough = map['pitIdThrough'];
    this.pitFlScoreFuel =
        map['pitFlScoreFuel'].toString().toLowerCase() == 'true';
    this.pitFlDeliverFuel =
        map['pitFlDeliverFuel'].toString().toLowerCase() == 'true';
    this.pitNumLauncher = map['pitNumLauncher'];
    this.pitIdShooterHeight = map['pitIdShooterHeight'];
    this.pitIdShooterType = map['pitIdShooterType'];
    this.pitTxScoringNotes = map['pitTxScoringNotes'];
    this.pitFlClimb = map['pitFlClimb'].toString().toLowerCase() == 'true';
    this.pitIdClimbPos = map['pitIdClimbPos'];
    this.pitIdClimbHeightMax = map['pitIdClimbHeightMax'];
    this.pitIdClimbHeightPref = map['pitIdClimbHeightPref'];
    this.pitFlClimbRelease =
        map['pitFlClimbRelease'].toString().toLowerCase() == 'true';
    this.pitTxClimbNotes = map['pitTxClimbNotes'];
    this.pitFlAuto = map['pitFlAuto'].toString().toLowerCase() == 'true';
    this.pitFlAutoScoreFuel =
        map['pitFlAutoScoreFuel'].toString().toLowerCase() == 'true';
    this.pitNumAutoScore = map['pitNumAutoScore'];
    this.pitNumAutoFuel = map['pitNumAutoFuel'];
    this.pitIdAutoReloadPoints = map['pitIdAutoReloadPoints'];
    this.pitFlAutoClimb =
        map['pitFlAutoClimb'].toString().toLowerCase() == 'true';
    this.pitTxAutoNotes = map['pitTxAutoNotes'];
    this.pitTxPitNotes = map['pitTxPitNotes'];
    this.dtCreation = map['dtCreation'];
    this.dtModified = map['dtModified'];
    this.txComputerName = map['txComputerName'];
    this.uploaded = map['uploaded'].toString().toLowerCase() == 'true';
    if (map['pitImgRobotFront'] != null) {
      this.pitImgRobotFront = File(map['pitImgRobotFront']);
    }
    if (map['pitImgRobotSide'] != null) {
      this.pitImgRobotSide = File(map['pitImgRobotSide']);
    }
    if (map['pitImgTeamUniform'] != null) {
      this.pitImgTeamUniform = File(map['pitImgTeamUniform']);
    }
  }

  Map<String, dynamic> toMap() {
    String? fileImgRobotFront;
    if (this.pitImgRobotFront != null) {
      fileImgRobotFront = this.pitImgRobotFront?.path;
    }
    String? fileImgRobotSide;
    if (this.pitImgRobotSide != null) {
      fileImgRobotSide = this.pitImgRobotSide?.path;
    }
    String? fileImgTeamUniform;
    if (this.pitImgTeamUniform != null) {
      fileImgTeamUniform = this.pitImgTeamUniform?.path;
    }
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pitImgTeamUniform'] = fileImgTeamUniform;
    data['pitImgRobotFront'] = fileImgRobotFront;
    data['pitImgRobotSide'] = fileImgRobotSide;
    data['id'] = this.id;
    data['pitTxEvent'] = this.pitTxEvent;
    data['pitTxScoutName'] = this.pitTxScoutName;
    data['pitIdTeam'] = this.pitIdTeam;
    data['pitNumWeight'] = this.pitNumWeight;
    data['pitNumHeight'] = this.pitNumHeight;
    data['pitNumWidth'] = this.pitNumWidth;
    //data['pitImgTeamUniform'] = this.pitImgTeamUniform;
    //data['pitImgRobotFront'] = this.pitImgRobotFront;
    //data['pitImgRobotSide'] = this.pitImgRobotSide;
    data['pitIdDriveType'] = this.pitIdDriveType;
    data['pitIdFieldAccess'] = this.pitIdFieldAccess;
    data['pitTxDriveNotes'] = this.pitTxDriveNotes;
    data['pitFlObject'] = this.pitFlObject;
    data['pitFlObjectCatch'] = this.pitFlObjectCatch;
    data['pitFlObjectFloor'] = this.pitFlObjectFloor;
    data['pitTxObjectNotes'] = this.pitTxObjectNotes;
    data['pitIdCapacity'] = this.pitIdCapacity;
    data['pitIdThrough'] = this.pitIdThrough;
    data['pitFlScoreFuel'] = this.pitFlScoreFuel;
    data['pitFlDeliverFuel'] = this.pitFlDeliverFuel;
    data['pitNumLauncher'] = this.pitNumLauncher;
    data['pitIdShooterHeight'] = this.pitIdShooterHeight;
    data['pitIdShooterType'] = this.pitIdShooterType;
    data['pitTxScoringNotes'] = this.pitTxScoringNotes;
    data['pitFlClimb'] = this.pitFlClimb;
    data['pitIdClimbPos'] = this.pitIdClimbPos;
    data['pitIdClimbHeightMax'] = this.pitIdClimbHeightMax;
    data['pitIdClimbHeightPref'] = this.pitIdClimbHeightPref;
    data['pitFlClimbRelease'] = this.pitFlClimbRelease;
    data['pitTxClimbNotes'] = this.pitTxClimbNotes;
    data['pitFlAuto'] = this.pitFlAuto;
    data['pitFlAutoScoreFuel'] = this.pitFlAutoScoreFuel;
    data['pitNumAutoScore'] = this.pitNumAutoScore;
    data['pitNumAutoFuel'] = this.pitNumAutoFuel;
    data['pitIdAutoReloadPoints'] = this.pitIdAutoReloadPoints;
    data['pitFlAutoClimb'] = this.pitFlAutoClimb;
    data['pitTxAutoNotes'] = this.pitTxAutoNotes;
    data['pitTxPitNotes'] = this.pitTxPitNotes;
    data['dtCreation'] = this.dtCreation;
    data['dtModified'] = this.dtModified;
    data['txComputerName'] = this.txComputerName;
    data['uploaded'] = this.uploaded;
    return data;
  }

  PitData.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.pitTxEvent = map['pitTxEvent'];
    this.pitTxScoutName = map['pitTxScoutName'];
    this.pitIdTeam = map['pitIdTeam'];
    this.pitNumWeight = map['pitNumWeight'];
    this.pitNumHeight = map['pitNumHeight'];
    this.pitNumWidth = map['pitNumWidth'];
    //this.pitImgTeamUniform = map['pitImgTeamUniform'];
    //this.pitImgRobotFront = map['pitImgRobotFront'];
    //this.pitImgRobotSide = map['pitImgRobotSide'];
    this.pitIdDriveType = map['pitIdDriveType'];
    this.pitIdFieldAccess = map['pitIdFieldAccess'];
    this.pitTxDriveNotes = map['pitTxDriveNotes'];
    this.pitFlObject = map['pitFlObject'];
    this.pitFlObjectCatch = map['pitFlObjectCatch'];
    this.pitFlObjectFloor = map['pitFlObjectFloor'];
    this.pitTxObjectNotes = map['pitTxObjectNotes'];
    this.pitIdCapacity = map['pitIdCapacity'];
    this.pitIdThrough = map['pitIdThrough'];
    this.pitFlScoreFuel = map['pitFlScoreFuel'];
    this.pitFlDeliverFuel = map['pitFlDeliverFuel'];
    this.pitNumLauncher = map['pitNumLauncher'];
    this.pitIdShooterHeight = map['pitIdShooterHeight'];
    this.pitIdShooterType = map['pitIdShooterType'];
    this.pitTxScoringNotes = map['pitTxScoringNotes'];
    this.pitFlClimb = map['pitFlClimb'];
    this.pitIdClimbPos = map['pitIdClimbPos'];
    this.pitIdClimbHeightMax = map['pitIdClimbHeightMax'];
    this.pitIdClimbHeightPref = map['pitIdClimbHeightPref'];
    this.pitFlClimbRelease = map['pitFlClimbRelease'];
    this.pitTxClimbNotes = map['pitTxClimbNotes'];
    this.pitFlAuto = map['pitFlAuto'];
    this.pitFlAutoScoreFuel = map['pitFlAutoScoreFuel'];
    this.pitNumAutoScore = map['pitNumAutoScore'];
    this.pitNumAutoFuel = map['pitNumAutoFuel'];
    this.pitIdAutoReloadPoints = map['pitIdAutoReloadPoints'];
    this.pitFlAutoClimb = map['pitFlAutoClimb'];
    this.pitTxAutoNotes = map['pitTxAutoNotes'];
    this.pitTxPitNotes = map['pitTxPitNotes'];
    this.dtCreation = map['dtCreation'];
    this.dtModified = map['dtModified'];
    this.txComputerName = map['txComputerName'];
    this.uploaded = map['uploaded'];
    if (map['pitImgRobotFront'] != null) {
      this.pitImgRobotFront = File(map['pitImgRobotFront']);
    }
    if (map['pitImgRobotSide'] != null) {
      this.pitImgRobotSide = File(map['pitImgRobotSide']);
    }
    if (map['pitImgTeamUniform'] != null) {
      this.pitImgTeamUniform = File(map['pitImgTeamUniform']);
    }
  }
}
