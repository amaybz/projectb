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
  int autoNumCargoHighAttempt;
  int autoNumCargoHighSuccess;
  int autoNumCargoLowAttempt;
  int autoNumCargoLowSuccess;
  int autoNumCargoTerminalAttempt;
  int autoNumCargoTerminalSuccess;

  //Auto - Human
  int autoNumCargoHumanAttempt;
  int autoNumCargoHumanHighSuccess;
  int autoNumCargoHumanLowSuccess;
  int autoNumCargoHumanField;
  int autoNumCargoHumanRobot;

  //Tele Op Tab
  //Tele Op - EndGame
  bool teleFlHanger;
  String teleNumClimbTime;
  String teleIdClimb;
  String teleIdClimbGrabTime;
  String teleIdClimbTime;
  String teleIdClimbOutcome;
  String teleIdClimbPos;
  int teleNumClimbOthers;
  bool teleFlClimbBalance;
  bool teleFlClimbCorrection;
  bool teleFlClimbFall;
  //Tele Op - Performance
  int teleNumCargoHighAttempt;
  int teleNumCargoHighSuccess;
  int teleNumCargoLowAttempt;
  int teleNumCargoLowSuccess;
  int teleNumCargoTerminalAttempt;
  int teleNumCargoTerminalSuccess;

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
    this.autoNumCargoHighAttempt = 0,
    this.autoNumCargoHighSuccess = 0,
    this.autoNumCargoLowAttempt = 0,
    this.autoNumCargoLowSuccess = 0,
    this.autoNumCargoTerminalAttempt = 0,
    this.autoNumCargoTerminalSuccess = 0,
    //Auto - Human
    this.autoNumCargoHumanAttempt = 0,
    this.autoNumCargoHumanHighSuccess = 0,
    this.autoNumCargoHumanLowSuccess = 0,
    this.autoNumCargoHumanField = 0,
    this.autoNumCargoHumanRobot = 0,

    //Tele OP Tab

    //Tele - Endgame
    this.teleFlHanger = false,
    this.teleNumClimbTime = "00:00",
    this.teleIdClimb = "1",
    this.teleIdClimbGrabTime,
    this.teleIdClimbTime,
    this.teleIdClimbOutcome,
    this.teleIdClimbPos,
    this.teleNumClimbOthers = 0,
    this.teleFlClimbBalance = false,
    this.teleFlClimbCorrection = false,
    this.teleFlClimbFall = false,

    //Tele - Performance
    this.teleNumCargoHighAttempt = 0,
    this.teleNumCargoHighSuccess = 0,
    this.teleNumCargoLowAttempt = 0,
    this.teleNumCargoLowSuccess = 0,
    this.teleNumCargoTerminalAttempt = 0,
    this.teleNumCargoTerminalSuccess = 0,

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
      'autoNumCargoHighAttempt': autoNumCargoHighAttempt,
      'autoNumCargoHighSuccess': autoNumCargoHighSuccess,
      'autoNumCargoLowAttempt': autoNumCargoLowAttempt,
      'autoNumCargoLowSuccess': autoNumCargoLowSuccess,
      'autoNumCargoTerminalAttempt': autoNumCargoTerminalAttempt,
      'autoNumCargoTerminalSuccess': autoNumCargoTerminalSuccess,
      'autoNumCargoHumanAttempt': autoNumCargoHumanAttempt,
      'autoNumCargoHumanHighSuccess': autoNumCargoHumanHighSuccess,
      'autoNumCargoHumanLowSuccess': autoNumCargoHumanLowSuccess,
      'autoNumCargoHumanField': autoNumCargoHumanField,
      'autoNumCargoHumanRobot': autoNumCargoHumanRobot,

      //Tele OP Tab
      //Tele EndGame
      'teleFlHanger': teleFlHanger,
      'teleNumClimbTime': teleNumClimbTime,
      'teleIdClimb': teleIdClimb,
      'teleIdClimbGrabTime': teleIdClimbGrabTime,
      'teleIdClimbTime': teleIdClimbTime,
      'teleIdClimbOutcome': teleIdClimbOutcome,
      'teleIdClimbPos': teleIdClimbPos,
      'teleNumClimbOthers': teleNumClimbOthers,
      'teleFlClimbBalance': teleFlClimbBalance,
      'teleFlClimbCorrection': teleFlClimbCorrection,
      'teleFlClimbFall': teleFlClimbFall,
      'teleNumCargoHighAttempt': teleNumCargoHighAttempt,
      'teleNumCargoHighSuccess': teleNumCargoHighSuccess,
      'teleNumCargoLowAttempt': teleNumCargoLowAttempt,
      'teleNumCargoLowSuccess': teleNumCargoLowSuccess,
      'teleNumCargoTerminalAttempt': teleNumCargoTerminalAttempt,
      'teleNumCargoTerminalSuccess': teleNumCargoTerminalSuccess,
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
      'autoNumCargoHighAttempt': autoNumCargoHighAttempt,
      'autoNumCargoHighSuccess': autoNumCargoHighSuccess,
      'autoNumCargoLowAttempt': autoNumCargoLowAttempt,
      'autoNumCargoLowSuccess': autoNumCargoLowSuccess,
      'autoNumCargoTerminalAttempt': autoNumCargoTerminalAttempt,
      'autoNumCargoTerminalSuccess': autoNumCargoTerminalSuccess,
      'autoNumCargoHumanAttempt': autoNumCargoHumanAttempt,
      'autoNumCargoHumanHighSuccess': autoNumCargoHumanHighSuccess,
      'autoNumCargoHumanLowSuccess': autoNumCargoHumanLowSuccess,
      'autoNumCargoHumanField': autoNumCargoHumanField,
      'autoNumCargoHumanRobot': autoNumCargoHumanRobot,

      //Tele OP Tab
      //Tele EndGame
      'teleFlHanger': teleFlHanger.toString(),
      'teleNumClimbTime': teleNumClimbTime,
      'teleIdClimb': teleIdClimb,
      'teleIdClimbGrabTime': teleIdClimbGrabTime,
      'teleIdClimbTime': teleIdClimbTime,
      'teleIdClimbOutcome': teleIdClimbOutcome,
      'teleIdClimbPos': teleIdClimbPos,
      'teleNumClimbOthers': teleNumClimbOthers,
      'teleFlClimbBalance': teleFlClimbBalance.toString(),
      'teleFlClimbCorrection': teleFlClimbCorrection.toString(),
      'teleFlClimbFall': teleFlClimbFall.toString(),
      'teleNumCargoHighAttempt': teleNumCargoHighAttempt,
      'teleNumCargoHighSuccess': teleNumCargoHighSuccess,
      'teleNumCargoLowAttempt': teleNumCargoLowAttempt,
      'teleNumCargoLowSuccess': teleNumCargoLowSuccess,
      'teleNumCargoTerminalAttempt': teleNumCargoTerminalAttempt,
      'teleNumCargoTerminalSuccess': teleNumCargoTerminalSuccess,

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
    this.autoNumCargoHighAttempt = map['autoNumCargoHighAttempt'];
    this.autoNumCargoHighSuccess = map['autoNumCargoHighSuccess'];
    this.autoNumCargoLowAttempt = map['autoNumCargoLowAttempt'];
    this.autoNumCargoLowSuccess = map['autoNumCargoLowSuccess'];
    this.autoNumCargoTerminalAttempt = map['autoNumCargoTerminalAttempt'];
    this.autoNumCargoTerminalSuccess = map['autoNumCargoTerminalSuccess'];
    this.autoNumCargoHumanAttempt = map['autoNumCargoHumanAttempt'];
    this.autoNumCargoHumanHighSuccess = map['autoNumCargoHumanHighSuccess'];
    this.autoNumCargoHumanLowSuccess = map['autoNumCargoHumanLowSuccess'];
    this.autoNumCargoHumanField = map['autoNumCargoHumanField'];
    this.autoNumCargoHumanRobot = map['autoNumCargoHumanRobot'];

    //Tele OP Tab
    //Tele EndGame
    this.teleFlHanger = map['teleFlHanger'].toString().toLowerCase() == 'true';
    this.teleNumClimbTime = map['teleNumClimbTime'];
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
    this.teleNumCargoHighAttempt = map['teleNumCargoHighAttempt'];
    this.teleNumCargoHighSuccess = map['teleNumCargoHighSuccess'];
    this.teleNumCargoLowAttempt = map['teleNumCargoLowAttempt'];
    this.teleNumCargoLowSuccess = map['teleNumCargoLowSuccess'];
    this.teleNumCargoTerminalAttempt = map['teleNumCargoTerminalAttempt'];
    this.teleNumCargoTerminalSuccess = map['teleNumCargoTerminalSuccess'];

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
    this.autoNumCargoHighAttempt = map['autoNumCargoHighAttempt'];
    this.autoNumCargoHighSuccess = map['autoNumCargoHighSuccess'];
    this.autoNumCargoLowAttempt = map['autoNumCargoLowAttempt'];
    this.autoNumCargoLowSuccess = map['autoNumCargoLowSuccess'];
    this.autoNumCargoTerminalAttempt = map['autoNumCargoTerminalAttempt'];
    this.autoNumCargoTerminalSuccess = map['autoNumCargoTerminalSuccess'];
    this.autoNumCargoHumanAttempt = map['autoNumCargoHumanAttempt'];
    this.autoNumCargoHumanHighSuccess = map['autoNumCargoHumanHighSuccess'];
    this.autoNumCargoHumanLowSuccess = map['autoNumCargoHumanLowSuccess'];
    this.autoNumCargoHumanField = map['autoNumCargoHumanField'];
    this.autoNumCargoHumanRobot = map['autoNumCargoHumanRobot'];

    //Tele OP Tab
    //Tele Performance
    this.teleFlHanger = map['teleFlHanger'];
    this.teleNumClimbTime = map['teleNumClimbTime'];
    this.teleIdClimb = map['teleIdClimb'];
    this.teleIdClimbGrabTime = map['teleIdClimbGrabTime'];
    this.teleIdClimbTime = map['teleIdClimbTime'];
    this.teleIdClimbOutcome = map['teleIdClimbOutcome'];
    this.teleIdClimbPos = map['teleIdClimbPos'];
    this.teleNumClimbOthers = map['teleNumClimbOthers'];
    this.teleFlClimbBalance = map['teleFlClimbBalance'];
    this.teleFlClimbCorrection = map['teleFlClimbCorrection'];
    this.teleFlClimbFall = map['teleFlClimbFall'];
    this.teleNumCargoHighAttempt = map['teleNumCargoHighAttempt'];
    this.teleNumCargoHighSuccess = map['teleNumCargoHighSuccess'];
    this.teleNumCargoLowAttempt = map['teleNumCargoLowAttempt'];
    this.teleNumCargoLowSuccess = map['teleNumCargoLowSuccess'];
    this.teleNumCargoTerminalAttempt = map['teleNumCargoTerminalAttempt'];
    this.teleNumCargoTerminalSuccess = map['teleNumCargoTerminalSuccess'];

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
