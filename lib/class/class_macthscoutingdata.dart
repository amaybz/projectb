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
  bool? flCoop;
  bool? flCoopAll;
  bool? flRanking1;
  bool? flRanking2;
  bool? autoFlStart;
  bool? autoFlBaseLine;
  int? autoNumCellLoad;
  bool? autoFlFoul;
  bool? autoFlRobotContact;
  bool? autoFlLoseStartObject;
  bool? autoFlCrossOver;
  int? autoNumHighConeSuccess;
  int? autoNumMidConeSuccess;
  int? autoNumLowConeSuccess;
  int? autoNumHighCubeSuccess;
  int? autoNumMidCubeSuccess;
  int? autoNumLowCubeSuccess;
  int? autoNumCubeAttempt;
  int? autoNumConeAttempt;
  String? autoIdChargeAttempt;
  String? autoIdChargeOutcome;
  bool? teleFlPark;
  String? teleIdChargeAttempt;
  String? teleIdChargeOutcome;
  bool? teleFlClimbFall;
  String? teleIdChargeBalanceSpeed;
  bool? teleFlChargeAssist;
  int? teleNumChargeAssist;
  int? teleNumHighConeSuccess;
  int? teleNumMidConeSuccess;
  int? teleNumLowConeSuccess;
  int? teleNumHighCubeSuccess;
  int? teleNumMidCubeSuccess;
  int? teleNumLowCubeSuccess;
  int? teleNumCubeAttempt;
  int? teleNumConeAttempt;
  String? commIdDriveRating;
  String? commIdDefenceRating;
  String? commIdDriveTraction;
  bool? commFlStrategy;
  bool? commFlAssist;
  bool? commFlRecovery;
  bool? commFlFailure;
  bool? commFlWarning;
  bool? commFlHighlight;
  bool? commFlIntakeGround;
  bool? commFlIntakeHigh;
  bool? commFlIntakeStation;
  String? commTxNotes;

  MatchScoutingData({
    this.id,
    this.flUploaded = false,
    this.txEvent,
    this.txDeviceName,
    this.numMatch,
    this.idAlliance,
    this.idDriveStation,
    this.idTeam,
    this.txScoutName,
    this.idStartPosition,
    this.flRed = false,
    this.flYellow = false,
    this.flCrash = false,
    this.flCoop = false,
    this.flCoopAll = false,
    this.flRanking1 = false,
    this.flRanking2 = false,
    this.autoFlStart = false,
    this.autoFlBaseLine = false,
    this.autoNumCellLoad = 0,
    this.autoFlFoul = false,
    this.autoFlRobotContact = false,
    this.autoFlLoseStartObject = false,
    this.autoFlCrossOver = false,
    this.autoNumHighConeSuccess = 0,
    this.autoNumMidConeSuccess = 0,
    this.autoNumLowConeSuccess = 0,
    this.autoNumHighCubeSuccess = 0,
    this.autoNumMidCubeSuccess = 0,
    this.autoNumLowCubeSuccess = 0,
    this.autoNumCubeAttempt = 0,
    this.autoNumConeAttempt = 0,
    this.autoIdChargeAttempt,
    this.autoIdChargeOutcome,
    this.teleFlPark = false,
    this.teleIdChargeAttempt,
    this.teleIdChargeOutcome,
    this.teleFlClimbFall = false,
    this.teleIdChargeBalanceSpeed,
    this.teleFlChargeAssist = false,
    this.teleNumChargeAssist = 0,
    this.teleNumHighConeSuccess = 0,
    this.teleNumMidConeSuccess = 0,
    this.teleNumLowConeSuccess = 0,
    this.teleNumHighCubeSuccess = 0,
    this.teleNumMidCubeSuccess = 0,
    this.teleNumLowCubeSuccess = 0,
    this.teleNumCubeAttempt = 0,
    this.teleNumConeAttempt = 0,
    this.commIdDriveRating,
    this.commIdDefenceRating,
    this.commIdDriveTraction,
    this.commFlStrategy = false,
    this.commFlAssist = false,
    this.commFlRecovery = false,
    this.commFlFailure = false,
    this.commFlWarning = false,
    this.commFlHighlight = false,
    this.commFlIntakeGround = false,
    this.commFlIntakeHigh = false,
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
      'flCoop': flCoop,
      'flCoopAll': flCoopAll,
      'flRanking1': flRanking1,
      'flRanking2': flRanking2,
      'autoFlStart': autoFlStart,
      'autoFlBaseLine': autoFlBaseLine,
      'autoNumCellLoad': autoNumCellLoad,
      'autoFlFoul': autoFlFoul,
      'autoFlRobotContact': autoFlRobotContact,
      'autoFlLoseStartObject': autoFlLoseStartObject,
      'autoFlCrossOver': autoFlCrossOver,
      'autoNumHighConeSuccess': autoNumHighConeSuccess,
      'autoNumMidConeSuccess': autoNumMidConeSuccess,
      'autoNumLowConeSuccess': autoNumLowConeSuccess,
      'autoNumHighCubeSuccess': autoNumHighCubeSuccess,
      'autoNumMidCubeSuccess': autoNumMidCubeSuccess,
      'autoNumLowCubeSuccess': autoNumLowCubeSuccess,
      'autoNumCubeAttempt': autoNumCubeAttempt,
      'autoNumConeAttempt': autoNumConeAttempt,
      'autoIdChargeAttempt': autoIdChargeAttempt,
      'autoIdChargeOutcome': autoIdChargeOutcome,
      'teleFlPark': teleFlPark,
      'teleIdChargeAttempt': teleIdChargeAttempt,
      'teleIdChargeOutcome': teleIdChargeOutcome,
      'teleFlClimbFall': teleFlClimbFall,
      'teleIdChargeBalanceSpeed': teleIdChargeBalanceSpeed,
      'teleFlChargeAssist': teleFlChargeAssist,
      'teleNumChargeAssist': teleNumChargeAssist,
      'teleNumHighConeSuccess': teleNumHighConeSuccess,
      'teleNumMidConeSuccess': teleNumMidConeSuccess,
      'teleNumLowConeSuccess': teleNumLowConeSuccess,
      'teleNumHighCubeSuccess': teleNumHighCubeSuccess,
      'teleNumMidCubeSuccess': teleNumMidCubeSuccess,
      'teleNumLowCubeSuccess': teleNumLowCubeSuccess,
      'teleNumCubeAttempt': teleNumCubeAttempt,
      'teleNumConeAttempt': teleNumConeAttempt,
      'commIdDriveRating': commIdDriveRating,
      'commIdDefenceRating': commIdDefenceRating,
      'commIdDriveTraction': commIdDriveTraction,
      'commFlStrategy': commFlStrategy,
      'commFlAssist': commFlAssist,
      'commFlRecovery': commFlRecovery,
      'commFlFailure': commFlFailure,
      'commFlWarning': commFlWarning,
      'commFlHighlight': commFlHighlight,
      'commFlIntakeGround': commFlIntakeGround,
      'commFlIntakeHigh': commFlIntakeHigh,
      'commFlIntakeStation': commFlIntakeStation,
      'commTxNotes': commTxNotes,
    };
  }

  Map<String, dynamic> toLocalDB() {
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
      'flCoop': flCoop,
      'flCoopAll': flCoopAll,
      'flRanking1': flRanking1,
      'flRanking2': flRanking2,
      'autoFlStart': autoFlStart,
      'autoFlBaseLine': autoFlBaseLine,
      'autoNumCellLoad': autoNumCellLoad,
      'autoFlFoul': autoFlFoul,
      'autoFlRobotContact': autoFlRobotContact,
      'autoFlLoseStartObject': autoFlLoseStartObject,
      'autoFlCrossOver': autoFlCrossOver,
      'autoNumHighConeSuccess': autoNumHighConeSuccess,
      'autoNumMidConeSuccess': autoNumMidConeSuccess,
      'autoNumLowConeSuccess': autoNumLowConeSuccess,
      'autoNumHighCubeSuccess': autoNumHighCubeSuccess,
      'autoNumMidCubeSuccess': autoNumMidCubeSuccess,
      'autoNumLowCubeSuccess': autoNumLowCubeSuccess,
      'autoNumCubeAttempt': autoNumCubeAttempt,
      'autoNumConeAttempt': autoNumConeAttempt,
      'autoIdChargeAttempt': autoIdChargeAttempt,
      'autoIdChargeOutcome': autoIdChargeOutcome,
      'teleFlPark': teleFlPark,
      'teleIdChargeAttempt': teleIdChargeAttempt,
      'teleIdChargeOutcome': teleIdChargeOutcome,
      'teleFlClimbFall': teleFlClimbFall,
      'teleIdChargeBalanceSpeed': teleIdChargeBalanceSpeed,
      'teleFlChargeAssist': teleFlChargeAssist,
      'teleNumChargeAssist': teleNumChargeAssist,
      'teleNumHighConeSuccess': teleNumHighConeSuccess,
      'teleNumMidConeSuccess': teleNumMidConeSuccess,
      'teleNumLowConeSuccess': teleNumLowConeSuccess,
      'teleNumHighCubeSuccess': teleNumHighCubeSuccess,
      'teleNumMidCubeSuccess': teleNumMidCubeSuccess,
      'teleNumLowCubeSuccess': teleNumLowCubeSuccess,
      'teleNumCubeAttempt': teleNumCubeAttempt,
      'teleNumConeAttempt': teleNumConeAttempt,
      'commIdDriveRating': commIdDriveRating,
      'commIdDefenceRating': commIdDefenceRating,
      'commIdDriveTraction': commIdDriveTraction,
      'commFlStrategy': commFlStrategy,
      'commFlAssist': commFlAssist,
      'commFlRecovery': commFlRecovery,
      'commFlFailure': commFlFailure,
      'commFlWarning': commFlWarning,
      'commFlHighlight': commFlHighlight,
      'commFlIntakeGround': commFlIntakeGround,
      'commFlIntakeHigh': commFlIntakeHigh,
      'commFlIntakeStation': commFlIntakeStation,
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
    this.flCoop = map['flCoop'].toString().toLowerCase() == 'true';
    this.flCoopAll = map['flCoopAll'].toString().toLowerCase() == 'true';
    this.flRanking1 = map['flRanking1'].toString().toLowerCase() == 'true';
    this.flRanking2 = map['flRanking2'].toString().toLowerCase() == 'true';
    this.autoFlStart = map['autoFlStart'].toString().toLowerCase() == 'true';
    this.autoFlBaseLine =
        map['autoFlBaseLine'].toString().toLowerCase() == 'true';
    this.autoNumCellLoad = map['autoNumCellLoad'];
    this.autoFlFoul = map['autoFlFoul'].toString().toLowerCase() == 'true';
    this.autoFlRobotContact =
        map['autoFlRobotContact'].toString().toLowerCase() == 'true';
    this.autoFlLoseStartObject =
        map['autoFlLoseStartObject'].toString().toLowerCase() == 'true';
    this.autoFlCrossOver =
        map['autoFlCrossOver'].toString().toLowerCase() == 'true';
    this.autoNumHighConeSuccess = map['autoNumHighConeSuccess'];
    this.autoNumMidConeSuccess = map['autoNumMidConeSuccess'];
    this.autoNumLowConeSuccess = map['autoNumLowConeSuccess'];
    this.autoNumHighCubeSuccess = map['autoNumHighCubeSuccess'];
    this.autoNumMidCubeSuccess = map['autoNumMidCubeSuccess'];
    this.autoNumLowCubeSuccess = map['autoNumLowCubeSuccess'];
    this.autoNumCubeAttempt = map['autoNumCubeAttempt'];
    this.autoNumConeAttempt = map['autoNumConeAttempt'];
    this.autoIdChargeAttempt = map['autoIdChargeAttempt'];
    this.autoIdChargeOutcome = map['autoIdChargeOutcome'];
    this.teleFlPark = map['teleFlPark'].toString().toLowerCase() == 'true';
    this.teleIdChargeAttempt = map['teleIdChargeAttempt'];
    this.teleIdChargeOutcome = map['teleIdChargeOutcome'];
    this.teleFlClimbFall =
        map['teleFlClimbFall'].toString().toLowerCase() == 'true';
    this.teleIdChargeBalanceSpeed = map['teleIdChargeBalanceSpeed'];
    this.teleFlChargeAssist =
        map['teleFlChargeAssist'].toString().toLowerCase() == 'true';
    this.teleNumChargeAssist = map['teleNumChargeAssist'];
    this.teleNumHighConeSuccess = map['teleNumHighConeSuccess'];
    this.teleNumMidConeSuccess = map['teleNumMidConeSuccess'];
    this.teleNumLowConeSuccess = map['teleNumLowConeSuccess'];
    this.teleNumHighCubeSuccess = map['teleNumHighCubeSuccess'];
    this.teleNumMidCubeSuccess = map['teleNumMidCubeSuccess'];
    this.teleNumLowCubeSuccess = map['teleNumLowCubeSuccess'];
    this.teleNumCubeAttempt = map['teleNumCubeAttempt'];
    this.teleNumConeAttempt = map['teleNumConeAttempt'];
    this.commIdDriveRating = map['commIdDriveRating'];
    this.commIdDefenceRating = map['commIdDefenceRating'];
    this.commIdDriveTraction = map['commIdDriveTraction'];
    this.commFlStrategy =
        map['commFlStrategy'].toString().toLowerCase() == 'true';
    this.commFlAssist = map['commFlAssist'].toString().toLowerCase() == 'true';
    this.commFlRecovery =
        map['commFlRecovery'].toString().toLowerCase() == 'true';
    this.commFlFailure =
        map['commFlFailure'].toString().toLowerCase() == 'true';
    this.commFlWarning =
        map['commFlWarning'].toString().toLowerCase() == 'true';
    this.commFlHighlight =
        map['commFlHighlight'].toString().toLowerCase() == 'true';
    this.commFlIntakeGround =
        map['commFlIntakeGround'].toString().toLowerCase() == 'true';
    this.commFlIntakeHigh =
        map['commFlIntakeHigh'].toString().toLowerCase() == 'true';
    this.commFlIntakeStation =
        map['commFlIntakeStation'].toString().toLowerCase() == 'true';
    this.commTxNotes = map['commTxNotes'];
  }

  MatchScoutingData.fromMap(Map<String, dynamic> map) {
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
    this.flCoop = map['flCoop'].toString().toLowerCase() == 'true';
    this.flCoopAll = map['flCoopAll'].toString().toLowerCase() == 'true';
    this.flRanking1 = map['flRanking1'].toString().toLowerCase() == 'true';
    this.flRanking2 = map['flRanking2'].toString().toLowerCase() == 'true';
    this.autoFlStart = map['autoFlStart'].toString().toLowerCase() == 'true';
    this.autoFlBaseLine =
        map['autoFlBaseLine'].toString().toLowerCase() == 'true';
    this.autoNumCellLoad = map['autoNumCellLoad'];
    this.autoFlFoul = map['autoFlFoul'].toString().toLowerCase() == 'true';
    this.autoFlRobotContact =
        map['autoFlRobotContact'].toString().toLowerCase() == 'true';
    this.autoFlLoseStartObject =
        map['autoFlLoseStartObject'].toString().toLowerCase() == 'true';
    this.autoFlCrossOver =
        map['autoFlCrossOver'].toString().toLowerCase() == 'true';
    this.autoNumHighConeSuccess = map['autoNumHighConeSuccess'];
    this.autoNumMidConeSuccess = map['autoNumMidConeSuccess'];
    this.autoNumLowConeSuccess = map['autoNumLowConeSuccess'];
    this.autoNumHighCubeSuccess = map['autoNumHighCubeSuccess'];
    this.autoNumMidCubeSuccess = map['autoNumMidCubeSuccess'];
    this.autoNumLowCubeSuccess = map['autoNumLowCubeSuccess'];
    this.autoNumCubeAttempt = map['autoNumCubeAttempt'];
    this.autoNumConeAttempt = map['autoNumConeAttempt'];
    this.autoIdChargeAttempt = map['autoIdChargeAttempt'];
    this.autoIdChargeOutcome = map['autoIdChargeOutcome'];
    this.teleFlPark = map['teleFlPark'].toString().toLowerCase() == 'true';
    this.teleIdChargeAttempt = map['teleIdChargeAttempt'];
    this.teleIdChargeOutcome = map['teleIdChargeOutcome'];
    this.teleFlClimbFall =
        map['teleFlClimbFall'].toString().toLowerCase() == 'true';
    this.teleIdChargeBalanceSpeed = map['teleIdChargeBalanceSpeed'];
    this.teleFlChargeAssist =
        map['teleFlChargeAssist'].toString().toLowerCase() == 'true';
    this.teleNumChargeAssist = map['teleNumChargeAssist'];
    this.teleNumHighConeSuccess = map['teleNumHighConeSuccess'];
    this.teleNumMidConeSuccess = map['teleNumMidConeSuccess'];
    this.teleNumLowConeSuccess = map['teleNumLowConeSuccess'];
    this.teleNumHighCubeSuccess = map['teleNumHighCubeSuccess'];
    this.teleNumMidCubeSuccess = map['teleNumMidCubeSuccess'];
    this.teleNumLowCubeSuccess = map['teleNumLowCubeSuccess'];
    this.teleNumCubeAttempt = map['teleNumCubeAttempt'];
    this.teleNumConeAttempt = map['teleNumConeAttempt'];
    this.commIdDriveRating = map['commIdDriveRating'];
    this.commIdDefenceRating = map['commIdDefenceRating'];
    this.commIdDriveTraction = map['commIdDriveTraction'];
    this.commFlStrategy =
        map['commFlStrategy'].toString().toLowerCase() == 'true';
    this.commFlAssist = map['commFlAssist'].toString().toLowerCase() == 'true';
    this.commFlRecovery =
        map['commFlRecovery'].toString().toLowerCase() == 'true';
    this.commFlFailure =
        map['commFlFailure'].toString().toLowerCase() == 'true';
    this.commFlWarning =
        map['commFlWarning'].toString().toLowerCase() == 'true';
    this.commFlHighlight =
        map['commFlHighlight'].toString().toLowerCase() == 'true';
    this.commFlIntakeGround =
        map['commFlIntakeGround'].toString().toLowerCase() == 'true';
    this.commFlIntakeHigh =
        map['commFlIntakeHigh'].toString().toLowerCase() == 'true';
    this.commFlIntakeStation =
        map['commFlIntakeStation'].toString().toLowerCase() == 'true';
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
        'flCoop: $flCoop,'
        'flCoopAll: $flCoopAll,'
        'flRanking1: $flRanking1,'
        'flRanking2: $flRanking2,'
        'autoFlStart: $autoFlStart,'
        'autoFlBaseLine: $autoFlBaseLine,'
        'autoNumCellLoad: $autoNumCellLoad,'
        'autoFlFoul: $autoFlFoul,'
        'autoFlRobotContact: $autoFlRobotContact,'
        'autoFlLoseStartObject: $autoFlLoseStartObject,'
        'autoFlCrossOver: $autoFlCrossOver,'
        'autoNumHighConeSuccess: $autoNumHighConeSuccess,'
        'autoNumMidConeSuccess: $autoNumMidConeSuccess,'
        'autoNumLowConeSuccess: $autoNumLowConeSuccess,'
        'autoNumHighCubeSuccess: $autoNumHighCubeSuccess,'
        'autoNumMidCubeSuccess: $autoNumMidCubeSuccess,'
        'autoNumLowCubeSuccess: $autoNumLowCubeSuccess,'
        'autoNumCubeAttempt: $autoNumCubeAttempt,'
        'autoNumConeAttempt: $autoNumConeAttempt,'
        'autoIdChargeAttempt: $autoIdChargeAttempt,'
        'autoIdChargeOutcome: $autoIdChargeOutcome,'
        'teleFlPark: $teleFlPark,'
        'teleIdChargeAttempt: $teleIdChargeAttempt,'
        'teleIdChargeOutcome: $teleIdChargeOutcome,'
        'teleFlClimbFall: $teleFlClimbFall,'
        'teleIdChargeBalanceSpeed: $teleIdChargeBalanceSpeed,'
        'teleFlChargeAssist: $teleFlChargeAssist,'
        'teleNumChargeAssist: $teleNumChargeAssist,'
        'teleNumHighConeSuccess: $teleNumHighConeSuccess,'
        'teleNumMidConeSuccess: $teleNumMidConeSuccess,'
        'teleNumLowConeSuccess: $teleNumLowConeSuccess,'
        'teleNumHighCubeSuccess: $teleNumHighCubeSuccess,'
        'teleNumMidCubeSuccess: $teleNumMidCubeSuccess,'
        'teleNumLowCubeSuccess: $teleNumLowCubeSuccess,'
        'teleNumCubeAttempt: $teleNumCubeAttempt,'
        'teleNumConeAttempt: $teleNumConeAttempt,'
        'commIdDriveRating: $commIdDriveRating,'
        'commIdDefenceRating: $commIdDefenceRating,'
        'commIdDriveTraction: $commIdDriveTraction,'
        'commFlStrategy: $commFlStrategy,'
        'commFlAssist: $commFlAssist,'
        'commFlRecovery: $commFlRecovery,'
        'commFlFailure: $commFlFailure,'
        'commFlWarning: $commFlWarning,'
        'commFlHighlight: $commFlHighlight,'
        'commFlIntakeGround: $commFlIntakeGround,'
        'commFlIntakeHigh: $commFlIntakeHigh,'
        'commFlIntakeStation: $commFlIntakeStation,'
        'commTxNotes: $commTxNotes,'
        '}';
  }
}
