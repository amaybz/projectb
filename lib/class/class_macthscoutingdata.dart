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
  bool? autoFlBaseLine;
  int? autoNumCellLoad;
  bool? autoFlFoul;
  bool? autoFlRobotContact;
  bool? autoFlLoseStartObject;
  bool? autoFlFail;
  int? autoNumCoralAttempt;
  int? autoNumCoralL1Success;
  int? autoNumCoralL2Success;
  int? autoNumCoralL3Success;
  int? autoNumCoralL4Success;
  int? autoNumAlgaeAttempt;
  int? autoNumAlgaeL2Success;
  int? autoNumAlgaeL3Success;
  int? autoNumAlgaeNetAttempt;
  int? autoNumAlgaeNetSuccess;
  int? autoNumAlgaeProcessAttempt;
  int? autoNumAlgaeProcessSuccess;
  int? teleNumCoralAttempt;
  int? teleNumCoralL1Success;
  int? teleNumCoralL2Success;
  int? teleNumCoralL3Success;
  int? teleNumCoralL4Success;
  int? teleNumAlgaeAttempt;
  int? teleNumAlgaeL2Success;
  int? teleNumAlgaeL3Success;
  int? teleNumAlgaeNetAttempt;
  int? teleNumAlgaeNetSuccess;
  int? teleNumAlgaeProcessAttempt;
  int? teleNumAlgaeProcessSuccess;
  bool? teleFlPark;
  String? teleIdClimbOutcome;
  String? teleIdClimbType;
  String? teleIdStageClimbSpeed;
  String? teleHumanIdTeam;
  int? teleIntAlgaeBarge;
  int? teleIntAlgaeProcess;
  String? commIdDriveRating;
  String? commIdDefenceRating;
  String? commIdDefenceType;
  bool? commFlStrategy;
  bool? commFlShuttle;
  bool? commFlRecovery;
  bool? commFlFailure;
  bool? commFlWarning;
  bool? commFlHighlight;
  bool? commFlIntakeGroundCoral;
  bool? commFlIntakeStation;
  bool? commFlIntakeGroundAlgae;
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
    this.idStartPosition,
    this.flRed = false,
    this.flYellow = false,
    this.flCrash = false,
    this.flAutoStop = false,
    this.autoFlStart = false,
    this.autoFlBaseLine = false,
    this.autoNumCellLoad = 0,
    this.autoFlFoul = false,
    this.autoFlRobotContact = false,
    this.autoFlLoseStartObject = false,
    this.autoFlFail = false,
    this.autoNumCoralAttempt = 0,
    this.autoNumCoralL1Success = 0,
    this.autoNumCoralL2Success = 0,
    this.autoNumCoralL3Success = 0,
    this.autoNumCoralL4Success = 0,
    this.autoNumAlgaeAttempt = 0,
    this.autoNumAlgaeL2Success = 0,
    this.autoNumAlgaeL3Success = 0,
    this.autoNumAlgaeNetAttempt = 0,
    this.autoNumAlgaeNetSuccess = 0,
    this.autoNumAlgaeProcessAttempt = 0,
    this.autoNumAlgaeProcessSuccess = 0,
    this.teleNumCoralAttempt = 0,
    this.teleNumCoralL1Success = 0,
    this.teleNumCoralL2Success = 0,
    this.teleNumCoralL3Success = 0,
    this.teleNumCoralL4Success = 0,
    this.teleNumAlgaeAttempt = 0,
    this.teleNumAlgaeL2Success = 0,
    this.teleNumAlgaeL3Success = 0,
    this.teleNumAlgaeNetAttempt = 0,
    this.teleNumAlgaeNetSuccess = 0,
    this.teleNumAlgaeProcessAttempt = 0,
    this.teleNumAlgaeProcessSuccess = 0,
    this.teleFlPark = false,
    this.teleIdClimbOutcome = "1",
    this.teleIdClimbType = "1",
    this.teleIdStageClimbSpeed = "1",
    this.teleHumanIdTeam,
    this.teleIntAlgaeBarge = 0,
    this.teleIntAlgaeProcess = 0,
    this.commIdDriveRating = "1",
    this.commIdDefenceRating = "1",
    this.commIdDefenceType = "1",
    this.commFlStrategy = false,
    this.commFlShuttle = false,
    this.commFlRecovery = false,
    this.commFlFailure = false,
    this.commFlWarning = false,
    this.commFlHighlight = false,
    this.commFlIntakeGroundCoral = false,
    this.commFlIntakeStation = false,
    this.commFlIntakeGroundAlgae = false,
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
      'autoFlBaseLine': autoFlBaseLine,
      'autoNumCellLoad': autoNumCellLoad,
      'autoFlFoul': autoFlFoul,
      'autoFlRobotContact': autoFlRobotContact,
      'autoFlLoseStartObject': autoFlLoseStartObject,
      'autoFlFail': autoFlFail,
      'autoNumCoralAttempt': autoNumCoralAttempt,
      'autoNumCoralL1Success': autoNumCoralL1Success,
      'autoNumCoralL2Success': autoNumCoralL2Success,
      'autoNumCoralL3Success': autoNumCoralL3Success,
      'autoNumCoralL4Success': autoNumCoralL4Success,
      'autoNumAlgaeAttempt': autoNumAlgaeAttempt,
      'autoNumAlgaeL2Success': autoNumAlgaeL2Success,
      'autoNumAlgaeL3Success': autoNumAlgaeL3Success,
      'autoNumAlgaeNetAttempt': autoNumAlgaeNetAttempt,
      'autoNumAlgaeNetSuccess': autoNumAlgaeNetSuccess,
      'autoNumAlgaeProcessAttempt': autoNumAlgaeProcessAttempt,
      'autoNumAlgaeProcessSuccess': autoNumAlgaeProcessSuccess,
      'teleNumCoralAttempt': teleNumCoralAttempt,
      'teleNumCoralL1Success': teleNumCoralL1Success,
      'teleNumCoralL2Success': teleNumCoralL2Success,
      'teleNumCoralL3Success': teleNumCoralL3Success,
      'teleNumCoralL4Success': teleNumCoralL4Success,
      'teleNumAlgaeAttempt': teleNumAlgaeAttempt,
      'teleNumAlgaeL2Success': teleNumAlgaeL2Success,
      'teleNumAlgaeL3Success': teleNumAlgaeL3Success,
      'teleNumAlgaeNetAttempt': teleNumAlgaeNetAttempt,
      'teleNumAlgaeNetSuccess': teleNumAlgaeNetSuccess,
      'teleNumAlgaeProcessAttempt': teleNumAlgaeProcessAttempt,
      'teleNumAlgaeProcessSuccess': teleNumAlgaeProcessSuccess,
      'teleFlPark': teleFlPark,
      'teleIdClimbOutcome': teleIdClimbOutcome,
      'teleIdClimbType': teleIdClimbType,
      'teleIdStageClimbSpeed': teleIdStageClimbSpeed,
      'teleHumanIdTeam': teleHumanIdTeam,
      'teleIntAlgaeBarge': teleIntAlgaeBarge,
      'teleIntAlgaeProcess': teleIntAlgaeProcess,
      'commIdDriveRating': commIdDriveRating,
      'commIdDefenceRating': commIdDefenceRating,
      'commIdDefenceType': commIdDefenceType,
      'commFlStrategy': commFlStrategy,
      'commFlShuttle': commFlShuttle,
      'commFlRecovery': commFlRecovery,
      'commFlFailure': commFlFailure,
      'commFlWarning': commFlWarning,
      'commFlHighlight': commFlHighlight,
      'commFlIntakeGroundCoral': commFlIntakeGroundCoral,
      'commFlIntakeStation': commFlIntakeStation,
      'commFlIntakeGroundAlgae': commFlIntakeGroundAlgae,
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
      'autoFlBaseLine': autoFlBaseLine.toString(),
      'autoNumCellLoad': autoNumCellLoad,
      'autoFlFoul': autoFlFoul.toString(),
      'autoFlRobotContact': autoFlRobotContact.toString(),
      'autoFlLoseStartObject': autoFlLoseStartObject.toString(),
      'autoFlFail': autoFlFail.toString(),
      'autoNumCoralAttempt': autoNumCoralAttempt,
      'autoNumCoralL1Success': autoNumCoralL1Success,
      'autoNumCoralL2Success': autoNumCoralL2Success,
      'autoNumCoralL3Success': autoNumCoralL3Success,
      'autoNumCoralL4Success': autoNumCoralL4Success,
      'autoNumAlgaeAttempt': autoNumAlgaeAttempt,
      'autoNumAlgaeL2Success': autoNumAlgaeL2Success,
      'autoNumAlgaeL3Success': autoNumAlgaeL3Success,
      'autoNumAlgaeNetAttempt': autoNumAlgaeNetAttempt,
      'autoNumAlgaeNetSuccess': autoNumAlgaeNetSuccess,
      'autoNumAlgaeProcessAttempt': autoNumAlgaeProcessAttempt,
      'autoNumAlgaeProcessSuccess': autoNumAlgaeProcessSuccess,
      'teleNumCoralAttempt': teleNumCoralAttempt,
      'teleNumCoralL1Success': teleNumCoralL1Success,
      'teleNumCoralL2Success': teleNumCoralL2Success,
      'teleNumCoralL3Success': teleNumCoralL3Success,
      'teleNumCoralL4Success': teleNumCoralL4Success,
      'teleNumAlgaeAttempt': teleNumAlgaeAttempt,
      'teleNumAlgaeL2Success': teleNumAlgaeL2Success,
      'teleNumAlgaeL3Success': teleNumAlgaeL3Success,
      'teleNumAlgaeNetAttempt': teleNumAlgaeNetAttempt,
      'teleNumAlgaeNetSuccess': teleNumAlgaeNetSuccess,
      'teleNumAlgaeProcessAttempt': teleNumAlgaeProcessAttempt,
      'teleNumAlgaeProcessSuccess': teleNumAlgaeProcessSuccess,
      'teleFlPark': teleFlPark.toString(),
      'teleIdClimbOutcome': teleIdClimbOutcome,
      'teleIdClimbType': teleIdClimbType,
      'teleIdStageClimbSpeed': teleIdStageClimbSpeed,
      'teleHumanIdTeam': teleHumanIdTeam,
      'teleIntAlgaeBarge': teleIntAlgaeBarge,
      'teleIntAlgaeProcess': teleIntAlgaeProcess,
      'commIdDriveRating': commIdDriveRating,
      'commIdDefenceRating': commIdDefenceRating,
      'commIdDefenceType': commIdDefenceType,
      'commFlStrategy': commFlStrategy.toString(),
      'commFlShuttle': commFlShuttle.toString(),
      'commFlRecovery': commFlRecovery.toString(),
      'commFlFailure': commFlFailure.toString(),
      'commFlWarning': commFlWarning.toString(),
      'commFlHighlight': commFlHighlight.toString(),
      'commFlIntakeGroundCoral': commFlIntakeGroundCoral.toString(),
      'commFlIntakeStation': commFlIntakeStation.toString(),
      'commFlIntakeGroundAlgae': commFlIntakeGroundAlgae.toString(),
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
    this.autoFlBaseLine =
        map['autoFlBaseLine'].toString().toLowerCase() == 'true';
    this.autoNumCellLoad = map['autoNumCellLoad'];
    this.autoFlFoul = map['autoFlFoul'].toString().toLowerCase() == 'true';
    this.autoFlRobotContact =
        map['autoFlRobotContact'].toString().toLowerCase() == 'true';
    this.autoFlLoseStartObject =
        map['autoFlLoseStartObject'].toString().toLowerCase() == 'true';
    this.autoFlFail = map['autoFlFail'].toString().toLowerCase() == 'true';
    this.autoNumCoralAttempt = map['autoNumCoralAttempt'];
    this.autoNumCoralL1Success = map['autoNumCoralL1Success'];
    this.autoNumCoralL2Success = map['autoNumCoralL2Success'];
    this.autoNumCoralL3Success = map['autoNumCoralL3Success'];
    this.autoNumCoralL4Success = map['autoNumCoralL4Success'];
    this.autoNumAlgaeAttempt = map['autoNumAlgaeAttempt'];
    this.autoNumAlgaeL2Success = map['autoNumAlgaeL2Success'];
    this.autoNumAlgaeL3Success = map['autoNumAlgaeL3Success'];
    this.autoNumAlgaeNetAttempt = map['autoNumAlgaeNetAttempt'];
    this.autoNumAlgaeNetSuccess = map['autoNumAlgaeNetSuccess'];
    this.autoNumAlgaeProcessAttempt = map['autoNumAlgaeProcessAttempt'];
    this.autoNumAlgaeProcessSuccess = map['autoNumAlgaeProcessSuccess'];
    this.teleNumCoralAttempt = map['teleNumCoralAttempt'];
    this.teleNumCoralL1Success = map['teleNumCoralL1Success'];
    this.teleNumCoralL2Success = map['teleNumCoralL2Success'];
    this.teleNumCoralL3Success = map['teleNumCoralL3Success'];
    this.teleNumCoralL4Success = map['teleNumCoralL4Success'];
    this.teleNumAlgaeAttempt = map['teleNumAlgaeAttempt'];
    this.teleNumAlgaeL2Success = map['teleNumAlgaeL2Success'];
    this.teleNumAlgaeL3Success = map['teleNumAlgaeL3Success'];
    this.teleNumAlgaeNetAttempt = map['teleNumAlgaeNetAttempt'];
    this.teleNumAlgaeNetSuccess = map['teleNumAlgaeNetSuccess'];
    this.teleNumAlgaeProcessAttempt = map['teleNumAlgaeProcessAttempt'];
    this.teleNumAlgaeProcessSuccess = map['teleNumAlgaeProcessSuccess'];
    this.teleFlPark = map['teleFlPark'].toString().toLowerCase() == 'true';
    this.teleIdClimbOutcome = map['teleIdClimbOutcome'];
    this.teleIdClimbType = map['teleIdClimbType'];
    this.teleIdStageClimbSpeed = map['teleIdStageClimbSpeed'];
    this.teleHumanIdTeam = map['teleHumanIdTeam'];
    this.teleIntAlgaeBarge = map['teleIntAlgaeBarge'];
    this.teleIntAlgaeProcess = map['teleIntAlgaeProcess'];
    this.commIdDriveRating = map['commIdDriveRating'];
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
    this.commFlWarning =
        map['commFlWarning'].toString().toLowerCase() == 'true';
    this.commFlHighlight =
        map['commFlHighlight'].toString().toLowerCase() == 'true';
    this.commFlIntakeGroundCoral =
        map['commFlIntakeGroundCoral'].toString().toLowerCase() == 'true';
    this.commFlIntakeStation =
        map['commFlIntakeStation'].toString().toLowerCase() == 'true';
    this.commFlIntakeGroundAlgae =
        map['commFlIntakeGroundAlgae'].toString().toLowerCase() == 'true';
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
    this.autoFlBaseLine = map['autoFlBaseLine'];
    this.autoNumCellLoad = map['autoNumCellLoad'];
    this.autoFlFoul = map['autoFlFoul'];
    this.autoFlRobotContact = map['autoFlRobotContact'];
    this.autoFlLoseStartObject = map['autoFlLoseStartObject'];
    this.autoFlFail = map['autoFlFail'];
    this.autoNumCoralAttempt = map['autoNumCoralAttempt'];
    this.autoNumCoralL1Success = map['autoNumCoralL1Success'];
    this.autoNumCoralL2Success = map['autoNumCoralL2Success'];
    this.autoNumCoralL3Success = map['autoNumCoralL3Success'];
    this.autoNumCoralL4Success = map['autoNumCoralL4Success'];
    this.autoNumAlgaeAttempt = map['autoNumAlgaeAttempt'];
    this.autoNumAlgaeL2Success = map['autoNumAlgaeL2Success'];
    this.autoNumAlgaeL3Success = map['autoNumAlgaeL3Success'];
    this.autoNumAlgaeNetAttempt = map['autoNumAlgaeNetAttempt'];
    this.autoNumAlgaeNetSuccess = map['autoNumAlgaeNetSuccess'];
    this.autoNumAlgaeProcessAttempt = map['autoNumAlgaeProcessAttempt'];
    this.autoNumAlgaeProcessSuccess = map['autoNumAlgaeProcessSuccess'];
    this.teleNumCoralAttempt = map['teleNumCoralAttempt'];
    this.teleNumCoralL1Success = map['teleNumCoralL1Success'];
    this.teleNumCoralL2Success = map['teleNumCoralL2Success'];
    this.teleNumCoralL3Success = map['teleNumCoralL3Success'];
    this.teleNumCoralL4Success = map['teleNumCoralL4Success'];
    this.teleNumAlgaeAttempt = map['teleNumAlgaeAttempt'];
    this.teleNumAlgaeL2Success = map['teleNumAlgaeL2Success'];
    this.teleNumAlgaeL3Success = map['teleNumAlgaeL3Success'];
    this.teleNumAlgaeNetAttempt = map['teleNumAlgaeNetAttempt'];
    this.teleNumAlgaeNetSuccess = map['teleNumAlgaeNetSuccess'];
    this.teleNumAlgaeProcessAttempt = map['teleNumAlgaeProcessAttempt'];
    this.teleNumAlgaeProcessSuccess = map['teleNumAlgaeProcessSuccess'];
    this.teleFlPark = map['teleFlPark'];
    this.teleIdClimbOutcome = map['teleIdClimbOutcome'];
    this.teleIdClimbType = map['teleIdClimbType'];
    this.teleIdStageClimbSpeed = map['teleIdStageClimbSpeed'];
    this.teleHumanIdTeam = map['teleHumanIdTeam'];
    this.teleIntAlgaeBarge = map['teleIntAlgaeBarge'];
    this.teleIntAlgaeProcess = map['teleIntAlgaeProcess'];
    this.commIdDriveRating = map['commIdDriveRating'];
    this.commIdDefenceRating = map['commIdDefenceRating'];
    this.commIdDefenceType = map['commIdDefenceType'];
    this.commFlStrategy = map['commFlStrategy'];
    this.commFlShuttle = map['commFlShuttle'];
    this.commFlRecovery = map['commFlRecovery'];
    this.commFlFailure = map['commFlFailure'];
    this.commFlWarning = map['commFlWarning'];
    this.commFlHighlight = map['commFlHighlight'];
    this.commFlIntakeGroundCoral = map['commFlIntakeGroundCoral'];
    this.commFlIntakeStation = map['commFlIntakeStation'];
    this.commFlIntakeGroundAlgae = map['commFlIntakeGroundAlgae'];
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
        'autoFlBaseLine: $autoFlBaseLine,'
        'autoNumCellLoad: $autoNumCellLoad,'
        'autoFlFoul: $autoFlFoul,'
        'autoFlRobotContact: $autoFlRobotContact,'
        'autoFlLoseStartObject: $autoFlLoseStartObject,'
        'autoFlFail: $autoFlFail,'
        'autoNumCoralAttempt: $autoNumCoralAttempt,'
        'autoNumCoralL1Success: $autoNumCoralL1Success,'
        'autoNumCoralL2Success: $autoNumCoralL2Success,'
        'autoNumCoralL3Success: $autoNumCoralL3Success,'
        'autoNumCoralL4Success: $autoNumCoralL4Success,'
        'autoNumAlgaeAttempt: $autoNumAlgaeAttempt,'
        'autoNumAlgaeL2Success: $autoNumAlgaeL2Success,'
        'autoNumAlgaeL3Success: $autoNumAlgaeL3Success,'
        'autoNumAlgaeNetAttempt: $autoNumAlgaeNetAttempt,'
        'autoNumAlgaeNetSuccess: $autoNumAlgaeNetSuccess,'
        'autoNumAlgaeProcessAttempt: $autoNumAlgaeProcessAttempt,'
        'autoNumAlgaeProcessSuccess: $autoNumAlgaeProcessSuccess,'
        'teleNumCoralAttempt: $teleNumCoralAttempt,'
        'teleNumCoralL1Success: $teleNumCoralL1Success,'
        'teleNumCoralL2Success: $teleNumCoralL2Success,'
        'teleNumCoralL3Success: $teleNumCoralL3Success,'
        'teleNumCoralL4Success: $teleNumCoralL4Success,'
        'teleNumAlgaeAttempt: $teleNumAlgaeAttempt,'
        'teleNumAlgaeL2Success: $teleNumAlgaeL2Success,'
        'teleNumAlgaeL3Success: $teleNumAlgaeL3Success,'
        'teleNumAlgaeNetAttempt: $teleNumAlgaeNetAttempt,'
        'teleNumAlgaeNetSuccess: $teleNumAlgaeNetSuccess,'
        'teleNumAlgaeProcessAttempt: $teleNumAlgaeProcessAttempt,'
        'teleNumAlgaeProcessSuccess: $teleNumAlgaeProcessSuccess,'
        'teleFlPark: $teleFlPark,'
        'teleIdClimbOutcome: $teleIdClimbOutcome,'
        'teleIdClimbType: $teleIdClimbType,'
        'teleIdStageClimbSpeed: $teleIdStageClimbSpeed,'
        'teleHumanIdTeam: $teleHumanIdTeam,'
        'teleIntAlgaeBarge: $teleIntAlgaeBarge,'
        'teleIntAlgaeProcess: $teleIntAlgaeProcess,'
        'commIdDriveRating: $commIdDriveRating,'
        'commIdDefenceRating: $commIdDefenceRating,'
        'commIdDefenceType: $commIdDefenceType,'
        'commFlStrategy: $commFlStrategy,'
        'commFlShuttle: $commFlShuttle,'
        'commFlRecovery: $commFlRecovery,'
        'commFlFailure: $commFlFailure,'
        'commFlWarning: $commFlWarning,'
        'commFlHighlight: $commFlHighlight,'
        'commFlIntakeGroundCoral: $commFlIntakeGroundCoral,'
        'commFlIntakeStation: $commFlIntakeStation,'
        'commFlIntakeGroundAlgae: $commFlIntakeGroundAlgae,'
        'commTxNotes: $commTxNotes,'
        '}';
  }
}
