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
  bool? flAutoStop;
  bool? autoFlStart;
  bool? autoFlBaseLine;
  int? autoNumCellLoad;
  bool? autoFlFoul;
  bool? autoFlRobotContact;
  bool? autoFlLoseStartObject;
  bool? autoFlFail;
  int? autoNumAmpSuccess;
  int? autoNumTrapSuccess;
  int? autoNumSpeakerSuccess;
  int? autoNumSpeakerAttempt;
  int? autoNumAmpAttempt;
  int? autoNumTrapAttempt;
  String? autoIdChargeAttempt;
  String? autoIdChargeOutcome;
  bool? teleFlPark;
  String? teleIdChargeAttempt;
  String? teleIdStageOutcome;
  String? teleIdStageClimbSpeed;
  bool? teleFlStageAssist;
  int? teleNumHighConeSuccess;
  int? teleNumMidConeSuccess;
  int? teleNumLowConeSuccess;
  int? teleNumHighCubeSuccess;
  int? teleNumMidCubeSuccess;
  int? teleNumLowCubeSuccess;
  int? teleNumCubeAttempt;
  int? teleNumConeAttempt;
  bool? teleFlSpotlight;
  String? commIdDriveRating;
  String? commIdDefenceRating;
  String? commIdDriveTraction;
  bool? commFlStrategy;
  bool? commFlAssist;
  bool? commFlShuttle;
  bool? commFlRecovery;
  bool? commFlFailure;
  bool? commFlWarning;
  bool? commFlHighlight;
  bool? commFlIntakeGround;
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
    this.flAutoStop = false,
    this.autoFlStart = false,
    this.autoFlBaseLine = false,
    this.autoNumCellLoad = 0,
    this.autoFlFoul = false,
    this.autoFlRobotContact = false,
    this.autoFlLoseStartObject = false,
    this.autoFlFail = false,
    this.autoNumAmpSuccess = 0,
    this.autoNumTrapSuccess = 0,
    this.autoNumSpeakerSuccess = 0,
    this.autoNumSpeakerAttempt = 0,
    this.autoNumAmpAttempt = 0,
    this.autoNumTrapAttempt = 0,
    this.autoIdChargeAttempt,
    this.autoIdChargeOutcome,
    this.teleFlPark = false,
    this.teleIdChargeAttempt,
    this.teleIdStageOutcome,
    this.teleIdStageClimbSpeed,
    this.teleFlStageAssist = false,
    this.teleNumHighConeSuccess = 0,
    this.teleNumMidConeSuccess = 0,
    this.teleNumLowConeSuccess = 0,
    this.teleNumHighCubeSuccess = 0,
    this.teleNumMidCubeSuccess = 0,
    this.teleNumLowCubeSuccess = 0,
    this.teleNumCubeAttempt = 0,
    this.teleNumConeAttempt = 0,
    this.teleFlSpotlight = false,
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
    this.commFlShuttle = false,
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
      'flAutoStop': flAutoStop,
      'autoFlStart': autoFlStart,
      'autoFlBaseLine': autoFlBaseLine,
      'autoNumCellLoad': autoNumCellLoad,
      'autoFlFoul': autoFlFoul,
      'autoFlRobotContact': autoFlRobotContact,
      'autoFlLoseStartObject': autoFlLoseStartObject,
      'autoFlFail': autoFlFail,
      'autoNumAmpSuccess': autoNumAmpSuccess,
      'autoNumTrapSuccess': autoNumTrapSuccess,
      'autoNumSpeakerSuccess': autoNumSpeakerSuccess,
      'autoNumTrapAttempt': autoNumTrapAttempt,
      'autoNumSpeakerAttempt': autoNumSpeakerAttempt,
      'autoNumAmpAttempt': autoNumAmpAttempt,
      'autoIdChargeAttempt': autoIdChargeAttempt,
      'autoIdChargeOutcome': autoIdChargeOutcome,
      'teleFlPark': teleFlPark,
      'teleIdChargeAttempt': teleIdChargeAttempt,
      'teleIdStageOutcome': teleIdStageOutcome,
      'teleIdStageClimbSpeed': teleIdStageClimbSpeed,
      'teleFlStageAssist': teleFlStageAssist,
      'teleNumHighConeSuccess': teleNumHighConeSuccess,
      'teleNumMidConeSuccess': teleNumMidConeSuccess,
      'teleNumLowConeSuccess': teleNumLowConeSuccess,
      'teleNumHighCubeSuccess': teleNumHighCubeSuccess,
      'teleNumMidCubeSuccess': teleNumMidCubeSuccess,
      'teleNumLowCubeSuccess': teleNumLowCubeSuccess,
      'teleNumCubeAttempt': teleNumCubeAttempt,
      'teleNumConeAttempt': teleNumConeAttempt,
      'teleFlSpotlight': teleFlSpotlight,
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
      'commFlShuttle': commFlShuttle,
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
      'flAutoStop': flAutoStop,
      'autoFlStart': autoFlStart,
      'autoFlBaseLine': autoFlBaseLine,
      'autoNumCellLoad': autoNumCellLoad,
      'autoFlFoul': autoFlFoul,
      'autoFlRobotContact': autoFlRobotContact,
      'autoFlLoseStartObject': autoFlLoseStartObject,
      'autoFlFail': autoFlFail,
      'autoNumAmpSuccess': autoNumAmpSuccess,
      'autoNumTrapSuccess': autoNumTrapSuccess,
      'autoNumSpeakerSuccess': autoNumSpeakerSuccess,
      'autoNumTrapAttempt': autoNumTrapAttempt,
      'autoNumSpeakerAttempt': autoNumSpeakerAttempt,
      'autoNumAmpAttempt': autoNumAmpAttempt,
      'autoIdChargeAttempt': autoIdChargeAttempt,
      'autoIdChargeOutcome': autoIdChargeOutcome,
      'teleFlPark': teleFlPark,
      'teleIdChargeAttempt': teleIdChargeAttempt,
      'teleIdStageOutcome': teleIdStageOutcome,
      'teleIdStageClimbSpeed': teleIdStageClimbSpeed,
      'teleFlStageAssist': teleFlStageAssist,
      'teleNumHighConeSuccess': teleNumHighConeSuccess,
      'teleNumMidConeSuccess': teleNumMidConeSuccess,
      'teleNumLowConeSuccess': teleNumLowConeSuccess,
      'teleNumHighCubeSuccess': teleNumHighCubeSuccess,
      'teleNumMidCubeSuccess': teleNumMidCubeSuccess,
      'teleNumLowCubeSuccess': teleNumLowCubeSuccess,
      'teleFlSpotlight': teleFlSpotlight,
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
      'commFlShuttle': commFlShuttle,
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
    this.flAutoStop = map['flAutoStop'].toString().toLowerCase() == 'true';
    this.autoFlStart = map['autoFlStart'].toString().toLowerCase() == 'true';
    this.autoFlBaseLine =
        map['autoFlBaseLine'].toString().toLowerCase() == 'true';
    this.autoNumCellLoad = map['autoNumCellLoad'];
    this.autoFlFoul = map['autoFlFoul'].toString().toLowerCase() == 'true';
    this.autoFlRobotContact =
        map['autoFlRobotContact'].toString().toLowerCase() == 'true';
    this.autoFlLoseStartObject =
        map['autoFlLoseStartObject'].toString().toLowerCase() == 'true';
    this.autoFlFail = map['autoFlFail'].toString().toLowerCase() == 'true';
    this.autoNumAmpSuccess = map['autoNumAmpSuccess'];
    this.autoNumTrapSuccess = map['autoNumTrapSuccess'];
    this.autoNumSpeakerSuccess = map['autoNumSpeakerSuccess'];
    this.autoNumTrapAttempt = map['autoNumTrapAttempt'];
    this.autoNumSpeakerAttempt = map['autoNumSpeakerAttempt'];
    this.autoNumAmpAttempt = map['autoNumAmpAttempt'];
    this.autoIdChargeAttempt = map['autoIdChargeAttempt'];
    this.autoIdChargeOutcome = map['autoIdChargeOutcome'];
    this.teleFlPark = map['teleFlPark'].toString().toLowerCase() == 'true';
    this.teleIdChargeAttempt = map['teleIdChargeAttempt'];
    this.teleIdStageOutcome = map['teleIdStageOutcome'];
    this.teleIdStageClimbSpeed = map['teleIdStageClimbSpeed'];
    this.teleFlStageAssist =
        map['teleFlStageAssist'].toString().toLowerCase() == 'true';
    this.teleNumHighConeSuccess = map['teleNumHighConeSuccess'];
    this.teleNumMidConeSuccess = map['teleNumMidConeSuccess'];
    this.teleNumLowConeSuccess = map['teleNumLowConeSuccess'];
    this.teleNumHighCubeSuccess = map['teleNumHighCubeSuccess'];
    this.teleNumMidCubeSuccess = map['teleNumMidCubeSuccess'];
    this.teleNumLowCubeSuccess = map['teleNumLowCubeSuccess'];
    this.teleNumCubeAttempt = map['teleNumCubeAttempt'];
    this.teleNumConeAttempt = map['teleNumConeAttempt'];
    this.teleFlSpotlight =
        map['teleFlSpotlight'].toString().toLowerCase() == 'true';
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
    this.commFlShuttle =
        map['commFlShuttle'].toString().toLowerCase() == 'true';
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
    this.autoFlStart = map['autoFlStart'].toString().toLowerCase() == 'true';
    this.autoFlBaseLine =
        map['autoFlBaseLine'].toString().toLowerCase() == 'true';
    this.autoNumCellLoad = map['autoNumCellLoad'];
    this.autoFlFoul = map['autoFlFoul'].toString().toLowerCase() == 'true';
    this.autoFlRobotContact =
        map['autoFlRobotContact'].toString().toLowerCase() == 'true';
    this.autoFlLoseStartObject =
        map['autoFlLoseStartObject'].toString().toLowerCase() == 'true';
    this.autoNumAmpSuccess = map['autoNumAmpSuccess'];
    this.autoNumTrapSuccess = map['autoNumTrapSuccess'];
    this.autoNumSpeakerSuccess = map['autoNumSpeakerSuccess'];
    this.autoNumTrapAttempt = map['autoNumTrapAttempt'];
    this.autoNumSpeakerAttempt = map['autoNumSpeakerAttempt'];
    this.autoNumAmpAttempt = map['autoNumAmpAttempt'];
    this.autoIdChargeAttempt = map['autoIdChargeAttempt'];
    this.autoIdChargeOutcome = map['autoIdChargeOutcome'];
    this.teleFlPark = map['teleFlPark'].toString().toLowerCase() == 'true';
    this.teleIdChargeAttempt = map['teleIdChargeAttempt'];
    this.teleIdStageOutcome = map['teleIdStageOutcome'];
    this.teleIdStageClimbSpeed = map['teleIdStageClimbSpeed'];
    this.teleFlStageAssist =
        map['teleFlStageAssist'].toString().toLowerCase() == 'true';
    this.teleNumHighConeSuccess = map['teleNumHighConeSuccess'];
    this.teleNumMidConeSuccess = map['teleNumMidConeSuccess'];
    this.teleNumLowConeSuccess = map['teleNumLowConeSuccess'];
    this.teleNumHighCubeSuccess = map['teleNumHighCubeSuccess'];
    this.teleNumMidCubeSuccess = map['teleNumMidCubeSuccess'];
    this.teleNumLowCubeSuccess = map['teleNumLowCubeSuccess'];
    this.teleNumCubeAttempt = map['teleNumCubeAttempt'];
    this.teleNumConeAttempt = map['teleNumConeAttempt'];
    this.teleFlSpotlight =
        map['teleFlSpotlight'].toString().toLowerCase() == 'true';
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
    this.commFlShuttle =
        map['commFlShuttle'].toString().toLowerCase() == 'true';
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
        'flAutoStop: $flAutoStop,'
        'autoFlStart: $autoFlStart,'
        'autoFlBaseLine: $autoFlBaseLine,'
        'autoNumCellLoad: $autoNumCellLoad,'
        'autoFlFoul: $autoFlFoul,'
        'autoFlRobotContact: $autoFlRobotContact,'
        'autoFlLoseStartObject: $autoFlLoseStartObject,'
        'autoFlFail: $autoFlFail,'
        'autoNumAmpSuccess: $autoNumAmpSuccess,'
        'autoNumTrapSuccess: $autoNumTrapSuccess,'
        'autoNumSpeakerSuccess: $autoNumSpeakerSuccess,'
        'autoNumTrapAttempt: $autoNumTrapAttempt,'
        'autoNumSpeakerAttempt: $autoNumSpeakerAttempt,'
        'autoNumAmpAttempt: $autoNumAmpAttempt,'
        'autoIdChargeAttempt: $autoIdChargeAttempt,'
        'autoIdChargeOutcome: $autoIdChargeOutcome,'
        'teleFlPark: $teleFlPark,'
        'teleIdChargeAttempt: $teleIdChargeAttempt,'
        'teleIdStageOutcome: $teleIdStageOutcome,'
        'teleIdStageClimbSpeed: $teleIdStageClimbSpeed,'
        'teleFlStageAssist: $teleFlStageAssist,'
        'teleNumHighConeSuccess: $teleNumHighConeSuccess,'
        'teleNumMidConeSuccess: $teleNumMidConeSuccess,'
        'teleNumLowConeSuccess: $teleNumLowConeSuccess,'
        'teleNumHighCubeSuccess: $teleNumHighCubeSuccess,'
        'teleNumMidCubeSuccess: $teleNumMidCubeSuccess,'
        'teleNumLowCubeSuccess: $teleNumLowCubeSuccess,'
        'teleNumCubeAttempt: $teleNumCubeAttempt,'
        'teleNumConeAttempt: $teleNumConeAttempt,'
        'teleFlSpotlight: $teleFlSpotlight,'
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
        'commFlShuttle: $commFlShuttle,'
        'commFlIntakeStation: $commFlIntakeStation,'
        'commTxNotes: $commTxNotes,'
        '}';
  }
}
