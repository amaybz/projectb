// @dart = 2.7
import 'dart:io';

class MatchScoutingData {
  int id;
  String txEvent;
  String txDeviceName;
  String idTeam;
  String txScoutName;
  int numMatch;
  String idAlliance;
  String idDriveStation;
  String idStartFacing;
  String idStartPosition;
  String numStartCells;
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
    this.txDeviceName,
    this.idTeam,
    this.txScoutName,
    this.idAlliance,
    this.idDriveStation,
    this.idStartFacing,
    this.numMatch = 0,
    this.idStartPosition,
    this.numStartCells,
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
      'txEvent': txEvent,
      'txDeviceName': txDeviceName,
      'numMatch': numMatch,
      'idAlliance': idAlliance,
      'idDriveStation': idDriveStation,
      'idTeam': idTeam,
      'txScoutName': txScoutName,
      'idStartFacing': idStartFacing,
      'idStartPosition': idStartPosition,
      'numStartCells': numStartCells,
      'flRed': flRed,
      'flYellow': flYellow,
      'flCrash': flCrash,
      'flRanking1': flRanking1,
      'flRanking2': flRanking2,
      //AutoTab
      'autoFlStart': autoFlStart,
      'autoFlBaseLine': autoFlBaseLine,
      'autoNumCellLoad': autoNumCellLoad,
      'autoFlFoul': autoFlFoul,
      'autoFlRobotContact': autoFlRobotContact,
      'autoFlLoseStartObject': autoFlLoseStartObject,
      'autoFlCrossOver': autoFlCrossOver,
      'autoNumCellAttempt': autoNumCellAttempt,
      'autoNumCellSuccess': autoNumCellSuccess,
      'autoFlOuter': autoFlOuter,
      'autoFlInner': autoFlInner,
      'autoFlLower': autoFlLower,
      //Tele OP Tab
      'teleFlPanelRotation': teleFlPanelRotation,
      'teleIdPanelRotationTime': teleIdPanelRotationTime,
      'teleFlPanelPosition': teleFlPanelPosition,
      'teleIdPanelPositionTime': teleIdPanelPositionTime,
      'teleNumPanelAttempt': teleNumPanelAttempt,
      'teleNumPanelSuccess': teleNumPanelSuccess,
      'teleFlPark': teleFlPark,
      'teleIdClimb': teleIdClimb,
      'teleIdClimbGrabTime': teleIdClimbGrabTime,
      'teleIdClimbTime': teleIdClimbTime,
      'teleIdClimbOutcome': teleIdClimbOutcome,
      'teleIdClimbPos': teleIdClimbPos,
      'teleNumClimbOthers': teleNumClimbOthers,
      'teleFlClimbBalance': teleFlClimbBalance,
      'teleFlClimbCorrection': teleFlClimbCorrection,
      'teleFlClimbFall': teleFlClimbFall,
      'teleNumCellAttempt': teleNumCellAttempt,
      'teleNumCellSuccess': teleNumCellSuccess,
      'teleFlOuter': teleFlOuter,
      'teleFlInner': teleFlInner,
      'teleFlLower': teleFlLower,
      //RatingsTab
      'commFlAssist': commFlAssist,
      'commIdDriveRating': commIdDriveRating,
      'commIdDefenceRating': commIdDefenceRating,
      'commFlAlliance': commFlAlliance,
      'commFlStrategy': commFlStrategy,
      'commFlOwnThing': commFlOwnThing,
      'commFlRecovery': commFlRecovery,
      'commFlWarning': commFlWarning,
      'commFlHighlight': commFlHighlight,
      'commFlShotFar': commFlShotFar,
      'commFlShotMid': commFlShotMid,
      'commFlShotNear': commFlShotNear,
      'commFlShotWall': commFlShotWall,
      'commFlIntakeGround': commFlIntakeGround,
      'commFlIntakeHigh': commFlIntakeHigh,
      'commFlIntakeRobot': commFlIntakeRobot,
      'commTxNotes': commTxNotes,
    };
  }

  Map<String, dynamic> toLocalDB() {
    return {
      'id': id,
      'txEvent': txEvent,
      'txDeviceName': txDeviceName,
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
    this.txDeviceName = map['txDeviceName'];
    this.numMatch = map['numMatch'];
    this.idAlliance = map['idAlliance'];
    this.idDriveStation = map['idDriveStation'];
    this.idTeam = map['idTeam'];
    this.txScoutName = map['txScoutName'];
    this.idStartFacing = map['idStartFacing'];
    this.idStartPosition = map['idStartPosition'];
    this.numStartCells = map['numStartCells'];
    this.flRed = map['flRed'].toString().toLowerCase() == 'true';
    this.flYellow = map['flYellow'].toString().toLowerCase() == 'true';
    this.flCrash = map['flCrash'].toString().toLowerCase() == 'true';
    this.flRanking1 = map['flRanking1'].toString().toLowerCase() == 'true';
    this.flRanking2 = map['flRanking2'].toString().toLowerCase() == 'true';
    //Auto Tab
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
    this.autoNumCellAttempt = map['autoNumCellAttempt'];
    this.autoNumCellSuccess = map['autoNumCellSuccess'];
    this.autoFlOuter = map['autoFlOuter'].toString().toLowerCase() == 'true';
    this.autoFlInner = map['autoFlInner'].toString().toLowerCase() == 'true';
    this.autoFlLower = map['autoFlLower'].toString().toLowerCase() == 'true';
    //Tele OP Tab
    this.teleFlPanelRotation =
        map['teleFlPanelRotation'].toString().toLowerCase() == 'true';
    this.teleIdPanelRotationTime = map['teleIdPanelRotationTime'];
    this.teleFlPanelPosition =
        map['teleFlPanelPosition'].toString().toLowerCase() == 'true';
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
    this.teleFlClimbBalance =
        map['teleFlClimbBalance'].toString().toLowerCase() == 'true';
    this.teleFlClimbCorrection =
        map['teleFlClimbCorrection'].toString().toLowerCase() == 'true';
    this.teleFlClimbFall =
        map['teleFlClimbFall'].toString().toLowerCase() == 'true';
    this.teleNumCellAttempt = map['teleNumCellAttempt'];
    this.teleNumCellSuccess = map['teleNumCellSuccess'];
    this.teleFlOuter = map['teleFlOuter'].toString().toLowerCase() == 'true';
    this.teleFlInner = map['teleFlInner'].toString().toLowerCase() == 'true';
    this.teleFlLower = map['teleFlLower'].toString().toLowerCase() == 'true';
    //Ratings Tab
    this.commFlAssist = map['commFlAssist'].toString().toLowerCase() == 'true';
    this.commIdDriveRating = map['commIdDriveRating'];
    this.commIdDefenceRating = map['commIdDefenceRating'];
    this.commFlAlliance =
        map['commFlAlliance'].toString().toLowerCase() == 'true';
    this.commFlStrategy =
        map['commFlStrategy'].toString().toLowerCase() == 'true';
    this.commFlOwnThing =
        map['commFlOwnThing'].toString().toLowerCase() == 'true';
    this.commFlRecovery =
        map['commFlRecovery'].toString().toLowerCase() == 'true';
    this.commFlWarning =
        map['commFlWarning'].toString().toLowerCase() == 'true';
    this.commFlHighlight =
        map['commFlHighlight'].toString().toLowerCase() == 'true';
    this.commFlShotFar =
        map['commFlShotFar'].toString().toLowerCase() == 'true';
    this.commFlShotMid =
        map['commFlShotMid'].toString().toLowerCase() == 'true';
    this.commFlShotNear =
        map['commFlShotNear'].toString().toLowerCase() == 'true';
    this.commFlShotWall =
        map['commFlShotWall'].toString().toLowerCase() == 'true';
    this.commFlIntakeGround =
        map['commFlIntakeGround'].toString().toLowerCase() == 'true';
    this.commFlIntakeHigh =
        map['commFlIntakeHigh'].toString().toLowerCase() == 'true';
    this.commFlIntakeRobot =
        map['commFlIntakeRobot'].toString().toLowerCase() == 'true';
    this.commTxNotes = map['commTxNotes'];
  }

  MatchScoutingData.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.txEvent = map['txEvent'];
    this.txDeviceName = map['txDeviceName'];
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
        'numStartCells: $numStartCells, '
        '}';
  }
}
