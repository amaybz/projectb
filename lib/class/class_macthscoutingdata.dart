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
  int? autoNumAmpSuccess;
  int? autoNumTrapSuccess;
  int? teleNumTrapAttempt;
  int? autoNumSpeakerSuccess;
  int? autoNumSpeakerAttempt;
  int? autoNumAmpAttempt;
  int? autoNumTrapAttempt;
  bool? teleFlPark;
  String? teleIdStageOutcome;
  String? teleIdStageClimbSpeed;
  bool? teleFlStageAssist;
  int? teleNumAmpSuccess;
  int? teleNumTrapSuccess;
  int? teleNumSpeakerSuccess;
  int? teleNumSpeakerAttempt;
  int? teleNumAmpAttempt;
  bool? teleFlSpotlight;
  String? commIdDriveRating;
  String? commIdDefenceRating;
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
    this.teleFlPark = false,
    this.teleIdStageOutcome = "1",
    this.teleIdStageClimbSpeed = "1",
    this.teleFlStageAssist = false,
    this.teleNumAmpSuccess = 0,
    this.teleNumTrapSuccess = 0,
    this.teleNumTrapAttempt = 0,
    this.teleNumSpeakerSuccess = 0,
    this.teleNumSpeakerAttempt = 0,
    this.teleNumAmpAttempt = 0,
    this.teleFlSpotlight = false,
    this.commIdDriveRating = "1",
    this.commIdDefenceRating = "1",
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
      'teleNumTrapAttempt': teleNumTrapAttempt,
      'autoNumSpeakerSuccess': autoNumSpeakerSuccess,
      'autoNumTrapAttempt': autoNumTrapAttempt,
      'autoNumSpeakerAttempt': autoNumSpeakerAttempt,
      'autoNumAmpAttempt': autoNumAmpAttempt,
      'teleFlPark': teleFlPark,
      'teleIdStageOutcome': teleIdStageOutcome,
      'teleIdStageClimbSpeed': teleIdStageClimbSpeed,
      'teleFlStageAssist': teleFlStageAssist,
      'teleNumAmpSuccess': teleNumAmpSuccess,
      'teleNumTrapSuccess': teleNumTrapSuccess,
      'teleNumSpeakerSuccess': teleNumSpeakerSuccess,
      'teleNumSpeakerAttempt': teleNumSpeakerAttempt,
      'teleNumAmpAttempt': teleNumAmpAttempt,
      'teleFlSpotlight': teleFlSpotlight,
      'commIdDriveRating': commIdDriveRating,
      'commIdDefenceRating': commIdDefenceRating,
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
      'autoNumAmpSuccess': autoNumAmpSuccess,
      'autoNumTrapSuccess': autoNumTrapSuccess,
      'teleNumTrapAttempt': teleNumTrapAttempt,
      'autoNumSpeakerSuccess': autoNumSpeakerSuccess,
      'autoNumTrapAttempt': autoNumTrapAttempt,
      'autoNumSpeakerAttempt': autoNumSpeakerAttempt,
      'autoNumAmpAttempt': autoNumAmpAttempt,
      'teleFlPark': teleFlPark.toString(),
      'teleIdStageOutcome': teleIdStageOutcome,
      'teleIdStageClimbSpeed': teleIdStageClimbSpeed,
      'teleFlStageAssist': teleFlStageAssist.toString(),
      'teleNumAmpSuccess': teleNumAmpSuccess,
      'teleNumTrapSuccess': teleNumTrapSuccess,
      'teleNumSpeakerSuccess': teleNumSpeakerSuccess,
      'teleFlSpotlight': teleFlSpotlight.toString(),
      'teleNumSpeakerAttempt': teleNumSpeakerAttempt,
      'teleNumAmpAttempt': teleNumAmpAttempt,
      'commIdDriveRating': commIdDriveRating,
      'commIdDefenceRating': commIdDefenceRating,
      'commFlStrategy': commFlStrategy.toString(),
      'commFlAssist': commFlAssist.toString(),
      'commFlRecovery': commFlRecovery.toString(),
      'commFlFailure': commFlFailure.toString(),
      'commFlWarning': commFlWarning.toString(),
      'commFlHighlight': commFlHighlight.toString(),
      'commFlIntakeGround': commFlIntakeGround.toString(),
      'commFlShuttle': commFlShuttle.toString(),
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
    this.teleFlPark = map['teleFlPark'].toString().toLowerCase() == 'true';
    this.teleIdStageOutcome = map['teleIdStageOutcome'];
    this.teleIdStageClimbSpeed = map['teleIdStageClimbSpeed'];
    this.teleFlStageAssist =
        map['teleFlStageAssist'].toString().toLowerCase() == 'true';
    this.teleNumAmpSuccess = map['teleNumAmpSuccess'];
    this.teleNumTrapSuccess = map['teleNumTrapSuccess'];
    this.teleNumTrapAttempt = map['teleNumTrapAttempt'];
    this.teleNumSpeakerSuccess = map['teleNumSpeakerSuccess'];
    this.teleNumSpeakerAttempt = map['teleNumSpeakerAttempt'];
    this.teleNumAmpAttempt = map['teleNumAmpAttempt'];
    this.teleFlSpotlight =
        map['teleFlSpotlight'].toString().toLowerCase() == 'true';
    this.commIdDriveRating = map['commIdDriveRating'];
    this.commIdDefenceRating = map['commIdDefenceRating'];
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
    this.teleFlPark = map['teleFlPark'].toString().toLowerCase() == 'true';
    this.teleIdStageOutcome = map['teleIdStageOutcome'];
    this.teleIdStageClimbSpeed = map['teleIdStageClimbSpeed'];
    this.teleFlStageAssist =
        map['teleFlStageAssist'].toString().toLowerCase() == 'true';
    this.teleNumAmpSuccess = map['teleNumAmpSuccess'];
    this.teleNumTrapSuccess = map['teleNumTrapSuccess'];
    this.teleNumTrapAttempt = map['teleNumTrapAttempt'];
    this.teleNumSpeakerSuccess = map['teleNumSpeakerSuccess'];
    this.teleNumSpeakerAttempt = map['teleNumSpeakerAttempt'];
    this.teleNumAmpAttempt = map['teleNumAmpAttempt'];
    this.teleFlSpotlight =
        map['teleFlSpotlight'].toString().toLowerCase() == 'true';
    this.commIdDriveRating = map['commIdDriveRating'];
    this.commIdDefenceRating = map['commIdDefenceRating'];
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
        'teleFlPark: $teleFlPark,'
        'teleIdStageOutcome: $teleIdStageOutcome,'
        'teleIdStageClimbSpeed: $teleIdStageClimbSpeed,'
        'teleFlStageAssist: $teleFlStageAssist,'
        'teleNumAmpSuccess: $teleNumAmpSuccess,'
        'teleNumTrapSuccess: $teleNumTrapSuccess,'
        'teleNumTrapAttempt: $teleNumTrapAttempt,'
        'teleNumSpeakerSuccess: $teleNumSpeakerSuccess,'
        'teleNumSpeakerAttempt: $teleNumSpeakerAttempt,'
        'teleNumAmpAttempt: $teleNumAmpAttempt,'
        'teleFlSpotlight: $teleFlSpotlight,'
        'commIdDriveRating: $commIdDriveRating,'
        'commIdDefenceRating: $commIdDefenceRating,'
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
