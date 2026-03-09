class MatchScoutingData {
  int? id;
  bool? flUploaded;
  String? txEvent;
  String? txDeviceName;
  int? numMatch;
  String? idAlliance;
  String? idDriveStation;
  String? idTeam;
  String? txScoutName;
  String? idStartPosition;
  bool? flRed;
  bool? flYellow;
  bool? flCrash;
  bool? flAutoStop;
  bool? autoFlStart;
  int? autoNumReload;
  bool? autoFlFoul;
  bool? autoFlRobotContact;
  bool? autoFlLoseStartObject;
  bool? autoFlFail;
  int? autoNumFuelShots;
  int? autoNumFuelSalvos;
  int? autoNumFuelAccLow;
  int? autoNumFuelAccMid;
  int? autoNumFuelAccHigh;
  int? autoNumTimer;
  bool? autoFlClimb;
  bool? autoFLClimbRelease;
  String? autoIdClimbOutcome;
  String? autoIdClimbPos;
  String? autoIdStageClimbSpeed;
  bool? teleFlClimbRelease;
  int? teleNumFuelShots;
  int? teleNumFuelSalvo;
  int? teleNumFuelAccLow;
  int? teleNumFuelAccMid;
  int? teleNumFuelAccHigh;
  int? teleNumTimer;
  int? teleNumFuelShuttle;
  int? teleNumShuttleFuelAccLow;
  int? teleNumShuttleFuelAccMid;
  int? teleNumShuttleFuelAccHigh;
  String? teleIdClimbOutcome;
  String? teleIdClimbPos;
  String? teleIdClimbHeight;
  String? teleIdClimbSpeed;
  bool? teleFlFed;
  String? IdThrough;
  bool? commFLHuman;
  bool? commFlTimer;
  int? commNumAvgTime;
  int? commNumStDev;
  String? commIdDriveRating;
  String? commIdFieldAccess;
  String? commIdDefenceRating;
  String? commIdDefenceType;
  bool? commFlStrategy;
  bool? commFlShuttle;
  bool? commFlRecovery;
  bool? commFlFailure;
  bool? commFlInactiveScore;
  bool? commFlWarning;
  bool? commFlHighlight;
  bool? commFlIntakeGround;
  bool? commFlIntakeStation;
  String? commTxNotes;

  MatchScoutingData({
    this.id = 0,
    this.flUploaded = false,
    this.txEvent,
    this.txDeviceName,
    this.numMatch,
    this.idAlliance,
    this.idDriveStation,
    this.idTeam,
    this.txScoutName,
    this.idStartPosition = "1",
    this.flRed = false,
    this.flYellow = false,
    this.flCrash = false,
    this.flAutoStop = false,
    this.autoFlStart = false,
    this.autoNumReload = 0,
    this.autoFlFoul = false,
    this.autoFlRobotContact = false,
    this.autoFlLoseStartObject = false,
    this.autoFlFail = false,
    this.autoNumFuelShots = 0,
    this.autoNumFuelSalvos = 0,
    this.autoNumFuelAccLow = 0,
    this.autoNumFuelAccMid = 0,
    this.autoNumFuelAccHigh = 0,
    this.autoNumTimer = 0,
    this.autoFlClimb = false,
    this.autoFLClimbRelease = false,
    this.autoIdClimbOutcome = "1",
    this.autoIdClimbPos = "1",
    this.autoIdStageClimbSpeed = "1",
    this.teleFlClimbRelease = true,
    this.teleNumFuelShots = 0,
    this.teleNumFuelSalvo = 0,
    this.teleNumFuelAccLow = 0,
    this.teleNumFuelAccMid = 0,
    this.teleNumFuelAccHigh = 0,
    this.teleNumTimer = 0,
    this.teleNumFuelShuttle = 0,
    this.teleNumShuttleFuelAccLow = 0,
    this.teleNumShuttleFuelAccMid = 0,
    this.teleNumShuttleFuelAccHigh = 0,
    this.teleIdClimbOutcome = "1",
    this.teleIdClimbPos = "1",
    this.teleIdClimbHeight = "1",
    this.teleIdClimbSpeed = "1",
    this.teleFlFed = false,
    this.IdThrough = "1",
    this.commFLHuman = false,
    this.commFlTimer = false,
    this.commNumAvgTime = 0,
    this.commNumStDev = 0,
    this.commIdDriveRating = "1",
    this.commIdFieldAccess = "1",
    this.commIdDefenceRating = "1",
    this.commIdDefenceType = "1",
    this.commFlStrategy = false,
    this.commFlShuttle = false,
    this.commFlRecovery = false,
    this.commFlFailure = false,
    this.commFlInactiveScore = false,
    this.commFlWarning = false,
    this.commFlHighlight = false,
    this.commFlIntakeGround = false,
    this.commFlIntakeStation = false,
    this.commTxNotes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'flUploaded': flUploaded,
      'txEvent': txEvent,
      'txDeviceName': txDeviceName,
      'numMatch': numMatch,
      'idAlliance': idAlliance,
      'idDriveStation': idDriveStation,
      'idTeam': idTeam,
      'txScoutName': txScoutName,
      'idStartPosition': idStartPosition,
      'flRed': flRed,
      'flYellow': flYellow,
      'flCrash': flCrash,
      'flAutoStop': flAutoStop,
      'autoFlStart': autoFlStart,
      'autoNumReload': autoNumReload,
      'autoFlFoul': autoFlFoul,
      'autoFlRobotContact': autoFlRobotContact,
      'autoFlLoseStartObject': autoFlLoseStartObject,
      'autoFlFail': autoFlFail,
      'autoNumFuelShots': autoNumFuelShots,
      'autoNumFuelSalvos': autoNumFuelSalvos,
      'autoNumFuelAccLow': autoNumFuelAccLow,
      'autoNumFuelAccMid': autoNumFuelAccMid,
      'autoNumFuelAccHigh': autoNumFuelAccHigh,
      'autoNumTimer': autoNumTimer,
      'autoFlClimb': autoFlClimb,
      'autoFLClimbRelease': autoFLClimbRelease,
      'autoIdClimbOutcome': autoIdClimbOutcome,
      'autoIdClimbPos': autoIdClimbPos,
      'autoIdStageClimbSpeed': autoIdStageClimbSpeed,
      'teleFlClimbRelease': teleFlClimbRelease,
      'teleNumFuelShots': teleNumFuelShots,
      'teleNumFuelSalvo': teleNumFuelSalvo,
      'teleNumFuelAccLow': teleNumFuelAccLow,
      'teleNumFuelAccMid': teleNumFuelAccMid,
      'teleNumFuelAccHigh': teleNumFuelAccHigh,
      'teleNumTimer': teleNumTimer,
      'teleNumFuelShuttle': teleNumFuelShuttle,
      'teleNumShuttleFuelAccLow': teleNumShuttleFuelAccLow,
      'teleNumShuttleFuelAccMid': teleNumShuttleFuelAccMid,
      'teleNumShuttleFuelAccHigh': teleNumShuttleFuelAccHigh,
      'teleIdClimbOutcome': teleIdClimbOutcome,
      'teleIdClimbPos': teleIdClimbPos,
      'teleIdClimbHeight': teleIdClimbHeight,
      'teleIdClimbSpeed': teleIdClimbSpeed,
      'teleFlFed': teleFlFed,
      'IdThrough': IdThrough,
      'commFLHuman': commFLHuman,
      'commFlTimer': commFlTimer,
      'commNumAvgTime': commNumAvgTime,
      'commNumStDev': commNumStDev,
      'commIdDriveRating': commIdDriveRating,
      'commIdFieldAccess': commIdFieldAccess,
      'commIdDefenceRating': commIdDefenceRating,
      'commIdDefenceType': commIdDefenceType,
      'commFlStrategy': commFlStrategy,
      'commFlShuttle': commFlShuttle,
      'commFlRecovery': commFlRecovery,
      'commFlFailure': commFlFailure,
      'commFlInactiveScore': commFlInactiveScore,
      'commFlWarning': commFlWarning,
      'commFlHighlight': commFlHighlight,
      'commFlIntakeGround': commFlIntakeGround,
      'commFlIntakeStation': commFlIntakeStation,
      'commTxNotes': commTxNotes,
    };
  }

  Map<String, dynamic> toLocalDB() {
    return {
      'id': id,
      'flUploaded': flUploaded.toString(),
      'txEvent': txEvent,
      'txDeviceName': txDeviceName,
      'numMatch': numMatch,
      'idAlliance': idAlliance,
      'idDriveStation': idDriveStation,
      'idTeam': idTeam,
      'txScoutName': txScoutName,
      'idStartPosition': idStartPosition,
      'flRed': flRed.toString(),
      'flYellow': flYellow.toString(),
      'flCrash': flCrash.toString(),
      'flAutoStop': flAutoStop.toString(),
      'autoFlStart': autoFlStart.toString(),
      'autoNumReload': autoNumReload,
      'autoFlFoul': autoFlFoul.toString(),
      'autoFlRobotContact': autoFlRobotContact.toString(),
      'autoFlLoseStartObject': autoFlLoseStartObject.toString(),
      'autoFlFail': autoFlFail.toString(),
      'autoNumFuelShots': autoNumFuelShots,
      'autoNumFuelSalvos': autoNumFuelSalvos,
      'autoNumFuelAccLow': autoNumFuelAccLow,
      'autoNumFuelAccMid': autoNumFuelAccMid,
      'autoNumFuelAccHigh': autoNumFuelAccHigh,
      'autoNumTimer': autoNumTimer,
      'autoFlClimb': autoFlClimb.toString(),
      'autoFLClimbRelease': autoFLClimbRelease.toString(),
      'autoIdClimbOutcome': autoIdClimbOutcome,
      'autoIdClimbPos': autoIdClimbPos,
      'autoIdStageClimbSpeed': autoIdStageClimbSpeed,
      'teleFlClimbRelease': teleFlClimbRelease.toString(),
      'teleNumFuelShots': teleNumFuelShots,
      'teleNumFuelSalvo': teleNumFuelSalvo,
      'teleNumFuelAccLow': teleNumFuelAccLow,
      'teleNumFuelAccMid': teleNumFuelAccMid,
      'teleNumFuelAccHigh': teleNumFuelAccHigh,
      'teleNumTimer': teleNumTimer,
      'teleNumFuelShuttle': teleNumFuelShuttle,
      'teleNumShuttleFuelAccLow': teleNumShuttleFuelAccLow,
      'teleNumShuttleFuelAccMid': teleNumShuttleFuelAccMid,
      'teleNumShuttleFuelAccHigh': teleNumShuttleFuelAccHigh,
      'teleIdClimbOutcome': teleIdClimbOutcome,
      'teleIdClimbPos': teleIdClimbPos,
      'teleIdClimbHeight': teleIdClimbHeight,
      'teleIdClimbSpeed': teleIdClimbSpeed,
      'teleFlFed': teleFlFed.toString(),
      'IdThrough': IdThrough,
      'commFLHuman': commFLHuman.toString(),
      'commFlTimer': commFlTimer.toString(),
      'commNumAvgTime': commNumAvgTime,
      'commNumStDev': commNumStDev,
      'commIdDriveRating': commIdDriveRating,
      'commIdFieldAccess': commIdFieldAccess,
      'commIdDefenceRating': commIdDefenceRating,
      'commIdDefenceType': commIdDefenceType,
      'commFlStrategy': commFlStrategy.toString(),
      'commFlShuttle': commFlShuttle.toString(),
      'commFlRecovery': commFlRecovery.toString(),
      'commFlFailure': commFlFailure.toString(),
      'commFlInactiveScore': commFlInactiveScore.toString(),
      'commFlWarning': commFlWarning.toString(),
      'commFlHighlight': commFlHighlight.toString(),
      'commFlIntakeGround': commFlIntakeGround.toString(),
      'commFlIntakeStation': commFlIntakeStation.toString(),
      'commTxNotes': commTxNotes,
    };
  }

  MatchScoutingData.fromLocalDB(Map<dynamic, dynamic> map) {
    this.id = map['id'];
    this.flUploaded = map['flUploaded'].toString().toLowerCase() == 'true';
    this.txEvent = map['txEvent'];
    this.txDeviceName = map['txDeviceName'];
    this.numMatch = map['numMatch'];
    this.idAlliance = map['idAlliance'];
    this.idDriveStation = map['idDriveStation'];
    this.idTeam = map['idTeam'];
    this.txScoutName = map['txScoutName'];
    this.idStartPosition = map['idStartPosition'];
    this.flRed = map['flRed'].toString().toLowerCase() == 'true';
    this.flYellow = map['flYellow'].toString().toLowerCase() == 'true';
    this.flCrash = map['flCrash'].toString().toLowerCase() == 'true';
    this.flAutoStop = map['flAutoStop'].toString().toLowerCase() == 'true';
    this.autoFlStart = map['autoFlStart'].toString().toLowerCase() == 'true';
    this.autoNumReload = map['autoNumReload'];
    this.autoFlFoul = map['autoFlFoul'].toString().toLowerCase() == 'true';
    this.autoFlRobotContact =
        map['autoFlRobotContact'].toString().toLowerCase() == 'true';
    this.autoFlLoseStartObject =
        map['autoFlLoseStartObject'].toString().toLowerCase() == 'true';
    this.autoFlFail = map['autoFlFail'].toString().toLowerCase() == 'true';
    this.autoNumFuelShots = map['autoNumFuelShots'];
    this.autoNumFuelSalvos = map['autoNumFuelSalvos'];
    this.autoNumFuelAccLow = map['autoNumFuelAccLow'];
    this.autoNumFuelAccMid = map['autoNumFuelAccMid'];
    this.autoNumFuelAccHigh = map['autoNumFuelAccHigh'];
    this.autoNumTimer = map['autoNumTimer'];
    this.autoFlClimb = map['autoFlClimb'].toString().toLowerCase() == 'true';
    this.autoFLClimbRelease =
        map['autoFLClimbRelease'].toString().toLowerCase() == 'true';
    this.autoIdClimbOutcome = map['autoIdClimbOutcome'];
    this.autoIdClimbPos = map['autoIdClimbPos'];
    this.autoIdStageClimbSpeed = map['autoIdStageClimbSpeed'];
    this.teleFlClimbRelease =
        map['teleFlClimbRelease'].toString().toLowerCase() == 'true';
    this.teleNumFuelShots = map['teleNumFuelShots'];
    this.teleNumFuelSalvo = map['teleNumFuelSalvo'];
    this.teleNumFuelAccLow = map['teleNumFuelAccLow'];
    this.teleNumFuelAccMid = map['teleNumFuelAccMid'];
    this.teleNumFuelAccHigh = map['teleNumFuelAccHigh'];
    this.teleNumTimer = map['teleNumTimer'];
    this.teleNumFuelShuttle = map['teleNumFuelShuttle'];
    this.teleNumShuttleFuelAccLow = map['teleNumShuttleFuelAccLow'];
    this.teleNumShuttleFuelAccMid = map['teleNumShuttleFuelAccMid'];
    this.teleNumShuttleFuelAccHigh = map['teleNumShuttleFuelAccHigh'];
    this.teleIdClimbOutcome = map['teleIdClimbOutcome'];
    this.teleIdClimbPos = map['teleIdClimbPos'];
    this.teleIdClimbHeight = map['teleIdClimbHeight'];
    this.teleIdClimbSpeed = map['teleIdClimbSpeed'];
    this.teleFlFed = map['teleFlFed'].toString().toLowerCase() == 'true';
    this.IdThrough = map['IdThrough'];
    this.commFLHuman = map['commFLHuman'].toString().toLowerCase() == 'true';
    this.commFlTimer = map['commFlTimer'].toString().toLowerCase() == 'true';
    this.commNumAvgTime = map['commNumAvgTime'];
    this.commNumStDev = map['commNumStDev'];
    this.commIdDriveRating = map['commIdDriveRating'];
    this.commIdFieldAccess = map['commIdFieldAccess'];
    this.commIdDefenceRating = map['commIdDefenceRating'];
    this.commIdDefenceType = map['commIdDefenceType'];
    this.commFlStrategy =
        map['commFlStrategy'].toString().toLowerCase() == 'true';
    this.commFlShuttle =
        map['commFlShuttle'].toString().toLowerCase() == 'true';
    this.commFlRecovery =
        map['commFlRecovery'].toString().toLowerCase() == 'true';
    this.commFlFailure =
        map['commFlFailure'].toString().toLowerCase() == 'true';
    this.commFlInactiveScore =
        map['commFlInactiveScore'].toString().toLowerCase() == 'true';
    this.commFlWarning =
        map['commFlWarning'].toString().toLowerCase() == 'true';
    this.commFlHighlight =
        map['commFlHighlight'].toString().toLowerCase() == 'true';
    this.commFlIntakeGround =
        map['commFlIntakeGround'].toString().toLowerCase() == 'true';
    this.commFlIntakeStation =
        map['commFlIntakeStation'].toString().toLowerCase() == 'true';
    this.commTxNotes = map['commTxNotes'];
  }

  MatchScoutingData.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.flUploaded = map['flUploaded'];
    this.txEvent = map['txEvent'];
    this.txDeviceName = map['txDeviceName'];
    this.numMatch = map['numMatch'];
    this.idAlliance = map['idAlliance'];
    this.idDriveStation = map['idDriveStation'];
    this.idTeam = map['idTeam'];
    this.txScoutName = map['txScoutName'];
    this.idStartPosition = map['idStartPosition'];
    this.flRed = map['flRed'];
    this.flYellow = map['flYellow'];
    this.flCrash = map['flCrash'];
    this.flAutoStop = map['flAutoStop'];
    this.autoFlStart = map['autoFlStart'];
    this.autoNumReload = map['autoNumReload'];
    this.autoFlFoul = map['autoFlFoul'];
    this.autoFlRobotContact = map['autoFlRobotContact'];
    this.autoFlLoseStartObject = map['autoFlLoseStartObject'];
    this.autoFlFail = map['autoFlFail'];
    this.autoNumFuelShots = map['autoNumFuelShots'];
    this.autoNumFuelSalvos = map['autoNumFuelSalvos'];
    this.autoNumFuelAccLow = map['autoNumFuelAccLow'];
    this.autoNumFuelAccMid = map['autoNumFuelAccMid'];
    this.autoNumFuelAccHigh = map['autoNumFuelAccHigh'];
    this.autoNumTimer = map['autoNumTimer'];
    this.autoFlClimb = map['autoFlClimb'];
    this.autoFLClimbRelease = map['autoFLClimbRelease'];
    this.autoIdClimbOutcome = map['autoIdClimbOutcome'];
    this.autoIdClimbPos = map['autoIdClimbPos'];
    this.autoIdStageClimbSpeed = map['autoIdStageClimbSpeed'];
    this.teleFlClimbRelease = map['teleFlClimbRelease'];
    this.teleNumFuelShots = map['teleNumFuelShots'];
    this.teleNumFuelSalvo = map['teleNumFuelSalvo'];
    this.teleNumFuelAccLow = map['teleNumFuelAccLow'];
    this.teleNumFuelAccMid = map['teleNumFuelAccMid'];
    this.teleNumFuelAccHigh = map['teleNumFuelAccHigh'];
    this.teleNumTimer = map['teleNumTimer'];
    this.teleNumFuelShuttle = map['teleNumFuelShuttle'];
    this.teleNumShuttleFuelAccLow = map['teleNumShuttleFuelAccLow'];
    this.teleNumShuttleFuelAccMid = map['teleNumShuttleFuelAccMid'];
    this.teleNumShuttleFuelAccHigh = map['teleNumShuttleFuelAccHigh'];
    this.teleIdClimbOutcome = map['teleIdClimbOutcome'];
    this.teleIdClimbPos = map['teleIdClimbPos'];
    this.teleIdClimbHeight = map['teleIdClimbHeight'];
    this.teleIdClimbSpeed = map['teleIdClimbSpeed'];
    this.teleFlFed = map['teleFlFed'];
    this.IdThrough = map['IdThrough'];
    this.commFLHuman = map['commFLHuman'];
    this.commFlTimer = map['commFlTimer'];
    this.commNumAvgTime = map['commNumAvgTime'];
    this.commNumStDev = map['commNumStDev'];
    this.commIdDriveRating = map['commIdDriveRating'];
    this.commIdFieldAccess = map['commIdFieldAccess'];
    this.commIdDefenceRating = map['commIdDefenceRating'];
    this.commIdDefenceType = map['commIdDefenceType'];
    this.commFlStrategy = map['commFlStrategy'];
    this.commFlShuttle = map['commFlShuttle'];
    this.commFlRecovery = map['commFlRecovery'];
    this.commFlFailure = map['commFlFailure'];
    this.commFlInactiveScore = map['commFlInactiveScore'];
    this.commFlWarning = map['commFlWarning'];
    this.commFlHighlight = map['commFlHighlight'];
    this.commFlIntakeGround = map['commFlIntakeGround'];
    this.commFlIntakeStation = map['commFlIntakeStation'];
    this.commTxNotes = map['commTxNotes'];
  }

  // Implement toString to make it easier to see information about
  @override
  String toString() {
    return 'MatchScoutingData{'
        'id: $id,'
        'flUploaded: $flUploaded,'
        'txEvent: $txEvent,'
        'txDeviceName: $txDeviceName,'
        'numMatch: $numMatch,'
        'idAlliance: $idAlliance,'
        'idDriveStation: $idDriveStation,'
        'idTeam: $idTeam,'
        'txScoutName: $txScoutName,'
        'idStartPosition: $idStartPosition,'
        'flRed: $flRed,'
        'flYellow: $flYellow,'
        'flCrash: $flCrash,'
        'flAutoStop: $flAutoStop,'
        'autoFlStart: $autoFlStart,'
        'autoNumReload: $autoNumReload,'
        'autoFlFoul: $autoFlFoul,'
        'autoFlRobotContact: $autoFlRobotContact,'
        'autoFlLoseStartObject: $autoFlLoseStartObject,'
        'autoFlFail: $autoFlFail,'
        'autoNumFuelShots: $autoNumFuelShots,'
        'autoNumFuelSalvos: $autoNumFuelSalvos,'
        'autoNumFuelAccLow: $autoNumFuelAccLow,'
        'autoNumFuelAccMid: $autoNumFuelAccMid,'
        'autoNumFuelAccHigh: $autoNumFuelAccHigh,'
        'autoNumTimer: $autoNumTimer,'
        'autoFlClimb: $autoFlClimb,'
        'autoFLClimbRelease: $autoFLClimbRelease,'
        'autoIdClimbOutcome: $autoIdClimbOutcome,'
        'autoIdClimbPos: $autoIdClimbPos,'
        'autoIdStageClimbSpeed: $autoIdStageClimbSpeed,'
        'teleFlClimbRelease: $teleFlClimbRelease,'
        'teleNumFuelShots: $teleNumFuelShots,'
        'teleNumFuelSalvo: $teleNumFuelSalvo,'
        'teleNumFuelAccLow: $teleNumFuelAccLow,'
        'teleNumFuelAccMid: $teleNumFuelAccMid,'
        'teleNumFuelAccHigh: $teleNumFuelAccHigh,'
        'teleNumTimer: $teleNumTimer,'
        'teleNumFuelShuttle: $teleNumFuelShuttle,'
        'teleNumShuttleFuelAccLow: $teleNumShuttleFuelAccLow,'
        'teleNumShuttleFuelAccMid: $teleNumShuttleFuelAccMid,'
        'teleNumShuttleFuelAccHigh: $teleNumShuttleFuelAccHigh,'
        'teleIdClimbOutcome: $teleIdClimbOutcome,'
        'teleIdClimbPos: $teleIdClimbPos,'
        'teleIdClimbHeight: $teleIdClimbHeight,'
        'teleIdClimbSpeed: $teleIdClimbSpeed,'
        'teleFlFed: $teleFlFed,'
        'IdThrough: $IdThrough,'
        'commFLHuman: $commFLHuman,'
        'commIdDriveRating: $commIdDriveRating,'
        'commIdFieldAccess: $commIdFieldAccess,'
        'commIdDefenceRating: $commIdDefenceRating,'
        'commIdDefenceType: $commIdDefenceType,'
        'commFlStrategy: $commFlStrategy,'
        'commFlShuttle: $commFlShuttle,'
        'commFlRecovery: $commFlRecovery,'
        'commFlFailure: $commFlFailure,'
        'commFlInactiveScore: $commFlInactiveScore,'
        'commFlWarning: $commFlWarning,'
        'commFlHighlight: $commFlHighlight,'
        'commFlIntakeGround: $commFlIntakeGround,'
        'commFlIntakeStation: $commFlIntakeStation,'
        'commTxNotes: $commTxNotes,'
        '}';
  }
}
