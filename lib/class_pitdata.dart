import 'dart:io';

class PitData {
  int? id;
  bool? uploaded;
  String? txEvent;
  String? idTeam;
  String? txScoutName;
  int? numWeight;
  int? numHeight;
  int? numWidth;
  bool? flCargo;
  bool? flIntakeGround;
  bool? flIntakeHigh;
  bool? flIntakeBounce;
  bool? flIntakeSort;
  int? numStorage;
  String? txShooting;
  bool? flTargetLow;
  bool? flTargetUpper;
  bool? flTargetTerminal;
  bool? flClimb;
  String? idClimbType;
  int? numClimbHeight;
  int? numClimbWidth;
  bool? flClimbSecure;
  String? idClimbGrab;
  String? idClimbSpeed;
  //bool flClimbTilt;
  String? txClimb;
  String? idClimbPos;
  bool? flClimbMove;
  //bool flClimbOther;
  //int numClimbOther;
  bool? flClimbTransition;
  String? idTransition;
  String? idTransitionSpeed;
  bool? flHuman;
  int? intHumanAccuracy;
  //bool flPanel;
  //bool flPanelBrake;
  //bool flPanelRotation;
  //bool flPanelPos;
  //bool flPanelSensor;
  //String txPanelSensor;
  bool? flAuto;
  bool? flAutoLine;
  bool? flAutoShoot;
  bool? flAutoSort;
  int? numAutoShoot;
  int? numAutoLoad;
  String? txPitNotes;
  String? dtCreation;
  String? dtModified;
  String? txComputerName;
  File? imgTeamUniform;
  File? imgRobotFront;
  File? imgRobotSide;

  PitData({
    this.id = 0,
    this.uploaded = false,
    this.txEvent,
    this.idTeam,
    this.txScoutName = "",
    this.numWeight = 0,
    this.numHeight = 0,
    this.numWidth = 0,
    this.flCargo = false,
    this.flIntakeGround = false,
    this.flIntakeHigh = false,
    this.flIntakeBounce = false,
    this.flIntakeSort = false,
    this.numStorage = 0,
    this.txShooting,
    this.flTargetLow = false,
    this.flTargetUpper = false,
    this.flTargetTerminal = false,
    this.flClimb = false,
    this.idClimbType,
    this.numClimbHeight = 0,
    this.numClimbWidth = 0,
    this.flClimbSecure = false,
    this.idClimbGrab,
    this.idClimbSpeed,
    //this.flClimbTilt = false,
    this.txClimb,
    this.idClimbPos,
    this.flClimbMove = false,
    this.flClimbTransition = false,
    this.idTransition,
    this.idTransitionSpeed,
    this.flAuto = false,
    this.flAutoLine = false,
    this.flAutoShoot = false,
    this.flAutoSort = false,
    this.numAutoShoot = 0,
    this.numAutoLoad = 0,
    this.flHuman = false,
    this.intHumanAccuracy = 0,
    this.txPitNotes,
    this.dtCreation,
    this.dtModified,
    this.txComputerName,
    this.imgRobotFront,
    this.imgRobotSide,
    this.imgTeamUniform,
  });

  Map<String, dynamic> toLocalDB() {
    String? fileRobotFront;
    if (imgRobotFront != null) {
      fileRobotFront = imgRobotFront?.path;
    }
    String? fileImgRobotSide;
    if (imgRobotSide != null) {
      fileImgRobotSide = imgRobotSide?.path;
    }
    String? fileImgTeamUniform;
    if (imgTeamUniform != null) {
      fileImgTeamUniform = imgTeamUniform?.path;
    }

    return {
      'id': id,
      'uploaded': uploaded.toString(),
      'txEvent': txEvent,
      'idTeam': idTeam,
      'txScoutName': txScoutName,
      'numWeight': numWeight,
      'numHeight': numHeight,
      'numWidth': numWidth,
      'flCargo': flCargo.toString(),
      'flIntakeGround': flIntakeGround.toString(),
      'flIntakeHigh': flIntakeHigh.toString(),
      'flIntakeBounce': flIntakeBounce.toString(),
      'flIntakeSort': flIntakeSort.toString(),
      'numStorage': numStorage,
      'txShooting': txShooting,
      'flTargetLow': flTargetLow.toString(),
      'flTargetUpper': flTargetUpper.toString(),
      'flTargetTerminal': flTargetTerminal.toString(),
      'flClimb': flClimb.toString(),
      'idClimbType': idClimbType,
      'numClimbHeight': numClimbHeight,
      'flClimbSecure': flClimbSecure.toString(),
      'idClimbGrab': idClimbGrab,
      'idClimbSpeed': idClimbSpeed,
      'txClimb': txClimb,
      'idClimbPos': idClimbPos,
      'flClimbMove': flClimbMove.toString(),
      'flClimbTransition': flClimbTransition,
      'idTransition': idTransition,
      'idTransitionSpeed': idTransitionSpeed,
      'flAuto': flAuto.toString(),
      'flAutoLine': flAutoLine.toString(),
      'flAutoShoot': flAutoShoot.toString(),
      'numAutoShoot': numAutoShoot,
      'numAutoLoad': numAutoLoad,
      'flAutoSort': flAutoSort.toString(),
      'flHuman': flHuman.toString(),
      'intHumanAccuracy': intHumanAccuracy,
      'txPitNotes': txPitNotes,
      'dtCreation': dtCreation.toString(),
      'dtModified': dtModified.toString(),
      'txComputerName': txComputerName,
      'imgRobotFront': fileRobotFront,
      'imgRobotSide': fileImgRobotSide,
      'imgTeamUniform': fileImgTeamUniform,
    };
  }

  PitData.fromLocalDB(Map<dynamic, dynamic> map) {
    this.id = map['id'];
    this.uploaded = map['uploaded'].toString().toLowerCase() == 'true';
    this.txEvent = map['txEvent'];
    this.idTeam = map['idTeam'].toString();
    this.txScoutName = map['txScoutName'];
    this.numWeight = map['numWeight'];
    this.numHeight = map['numHeight'];
    this.numWidth = map['numWidth'];
    this.flCargo = map['flCargo'].toString().toLowerCase() == 'true';
    this.flIntakeGround =
        map['flIntakeGround'].toString().toLowerCase() == 'true';
    this.flIntakeHigh = map['flIntakeHigh'].toString().toLowerCase() == 'true';
    this.flIntakeBounce =
        map['flIntakeBounce'].toString().toLowerCase() == 'true';
    this.flIntakeSort = map['flIntakeSort'].toString().toLowerCase() == 'true';
    this.numStorage = map['numStorage'];
    this.txShooting = map['txShooting'];
    this.flTargetLow = map['flTargetLow'].toString().toLowerCase() == 'true';
    this.flTargetUpper =
        map['flTargetUpper'].toString().toLowerCase() == 'true';
    this.flTargetTerminal =
        map['flTargetTerminal'].toString().toLowerCase() == 'true';
    this.flClimb = map['flClimb'].toString().toLowerCase() == 'true';
    this.idClimbType = map['idClimbType'];
    this.numClimbHeight = map['numClimbHeight'];
    this.flClimbSecure =
        map['flClimbSecure'].toString().toLowerCase() == 'true';
    this.idClimbGrab = map['idClimbGrab'];
    this.idClimbSpeed = map['idClimbSpeed'];
    this.txClimb = map['txClimb'];
    this.idClimbPos = map['idClimbPos'];

    this.flClimbMove = map['flClimbMove'].toString().toLowerCase() == 'true';
    this.flClimbTransition =
        map['flClimbTransition'].toString().toLowerCase() == 'true';
    this.idTransition = map['idTransition'];
    this.idTransitionSpeed = map['idTransitionSpeed'];
    this.flAuto = map['flAuto'].toString().toLowerCase() == 'true';
    this.flAutoLine = map['flAutoLine'].toString().toLowerCase() == 'true';
    this.flAutoShoot = map['flAutoShoot'].toString().toLowerCase() == 'true';
    this.flAutoSort = map['flAutoSort'].toString().toLowerCase() == 'true';
    this.numAutoShoot = map['numAutoShoot'];
    this.numAutoLoad = map['numAutoLoad'];
    this.flHuman = map['flHuman'].toString().toLowerCase() == 'true';
    this.intHumanAccuracy = map['intHumanAccuracy'];
    this.txPitNotes = map['txPitNotes'];
    this.dtCreation = map['dtCreation'];
    this.dtModified = map['dtModified'];
    this.txComputerName = map['txComputerName'];
    if (map['imgRobotFront'] != null) {
      this.imgRobotFront = File(map['imgRobotFront']);
    }
    if (map['imgRobotSide'] != null) {
      this.imgRobotSide = File(map['imgRobotSide']);
    }
    if (map['imgTeamUniform'] != null) {
      this.imgTeamUniform = File(map['imgTeamUniform']);
    }
  }

  Map<String, dynamic> toMap() {
    String? fileImgRobotFront;
    if (this.imgRobotFront != null) {
      fileImgRobotFront = this.imgRobotFront?.path;
    }
    String? fileImgRobotSide;
    if (this.imgRobotSide != null) {
      fileImgRobotSide = this.imgRobotSide?.path;
    }
    String? fileImgTeamUniform;
    if (this.imgTeamUniform != null) {
      fileImgTeamUniform = this.imgTeamUniform?.path;
    }
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uploaded'] = this.uploaded;
    data['txEvent'] = this.txEvent;
    data['idTeam'] = this.idTeam;
    data['txScoutName'] = this.txScoutName;
    data['numWeight'] = this.numWeight;
    data['numHeight'] = this.numHeight;
    data['numWidth'] = this.numWidth;
    data['flCargo'] = this.flCargo;
    data['flIntakeGround'] = this.flIntakeGround;
    data['flIntakeHigh'] = this.flIntakeHigh;
    data['flIntakeBounce'] = this.flIntakeBounce;
    data['flIntakeSort'] = this.flIntakeSort;
    data['numStorage'] = this.numStorage;
    data['txShooting'] = this.txShooting;
    data['flTargetLow'] = this.flTargetLow;
    data['flTargetUpper'] = this.flTargetUpper;
    data['flTargetTerminal'] = this.flTargetTerminal;
    data['flClimb'] = this.flClimb;
    data['idClimbType'] = this.idClimbType;
    data['numClimbHeight'] = this.numClimbHeight;
    data['flClimbSecure'] = this.flClimbSecure;
    data['idClimbGrab'] = this.idClimbGrab;
    data['idClimbSpeed'] = this.idClimbSpeed;
    data['txClimb'] = this.txClimb;
    data['idClimbPos'] = this.idClimbPos;
    data['flClimbMove'] = this.flClimbMove;
    data['flClimbTransition'] = this.flClimbTransition;
    data['idTransition'] = this.idTransition;
    data['idTransitionSpeed'] = this.idTransitionSpeed;
    data['flAuto'] = this.flAuto;
    data['flAutoLine'] = this.flAutoLine;
    data['flAutoShoot'] = this.flAutoShoot;
    data['numAutoShoot'] = this.numAutoShoot;
    data['numAutoLoad'] = this.numAutoLoad;
    data['flAutoSort'] = this.flAutoSort;
    data['flHuman'] = this.flHuman;
    data['intHumanAccuracy'] = this.intHumanAccuracy;
    data['txPitNotes'] = this.txPitNotes;
    data['dtCreation'] = this.dtCreation;
    data['dtModified'] = this.dtModified;
    data['txComputerName'] = this.txComputerName;
    data['imgRobotFront'] = fileImgRobotFront;
    data['imgRobotSide'] = fileImgRobotSide;
    data['imgTeamUniform'] = fileImgTeamUniform;
    return data;
  }

  PitData.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.uploaded = map['uploaded'];
    this.txEvent = map['txEvent'];
    this.idTeam = map['idTeam'];
    this.txScoutName = map['txScoutName'];
    this.numWeight = map['numWeight'];
    this.numHeight = map['numHeight'];
    this.numWidth = map['numWidth'];
    this.flCargo = map['flCargo'];
    this.flIntakeGround = map['flIntakeGround'];
    this.flIntakeHigh = map['flIntakeHigh'];
    this.flIntakeBounce = map['flIntakeBounce'];
    this.flIntakeSort = map['flIntakeSort'];
    this.numStorage = map['numStorage'];
    this.txShooting = map['txShooting'];
    this.flTargetLow = map['flTargetLow'];
    this.flTargetUpper = map['flTargetUpper'];
    this.flTargetTerminal = map['flTargetTerminal'];
    this.flClimb = map['flClimb'];
    this.idClimbType = map['idClimbType'];
    this.numClimbHeight = map['numClimbHeight'];
    this.flClimbSecure = map['flClimbSecure'];
    this.idClimbGrab = map['idClimbGrab'];
    this.idClimbSpeed = map['idClimbSpeed'];
    this.txClimb = map['txClimb'];
    this.idClimbPos = map['idClimbPos'];
    this.flClimbMove = map['flClimbMove'];
    this.flClimbTransition = map['flClimbTransition'];
    this.idTransition = map['idTransition'];
    this.idTransitionSpeed = map['idTransitionSpeed'];
    this.flAuto = map['flAuto'];
    this.flAutoLine = map['flAutoLine'];
    this.flAutoShoot = map['flAutoShoot'];
    this.numAutoShoot = map['numAutoShoot'];
    this.flAutoSort = map['flAutoSort'];
    this.numAutoLoad = map['numAutoLoad'];
    this.flHuman = map['flHuman'];
    this.intHumanAccuracy = map['intHumanAccuracy'];
    this.txPitNotes = map['txPitNotes'];
    this.dtCreation = map['dtCreation'];
    this.dtModified = map['dtModified'];
    this.txComputerName = map['txComputerName'];
    if (map['imgRobotFront'] != null) {
      this.imgRobotFront = File(map['imgRobotFront']);
    }
    if (map['imgRobotSide'] != null) {
      this.imgRobotSide = File(map['imgRobotSide']);
    }
    if (map['imgTeamUniform'] != null) {
      this.imgTeamUniform = File(map['imgTeamUniform']);
    }
  }
}
