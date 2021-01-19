class PitData {
  int id;
  String txEvent;
  String idTeam;
  String txScoutName;
  int numWeight;
  int numHeight;
  bool flCells;
  bool flIntakeGround;
  bool flIntakeHigh;
  int numStorage;
  String txShooting;
  bool flTargetLow;
  bool flTargetOuter;
  bool flTargetInner;
  bool flClimb;
  String idClimbType;
  int numClimbHeight;
  bool flClimbSecure;
  String idClimbGrab;
  String idClimbSpeed;
  bool flClimbTilt;
  String txClimb;
  String idClimbPos;
  bool flClimbLevel;
  bool flClimbLevelSelf;
  bool flClimbLevelOther;
  bool flClimbMove;
  bool flClimbOther;
  int numClimbOther;
  bool flPanel;
  bool flPanelBrake;
  bool flPanelRotation;
  bool flPanelPos;
  bool flPanelSensor;
  String txPanelSensor;
  bool flAuto;
  bool flAutoLine;
  bool flAutoShoot;
  int numAutoShoot;
  int numAutoLoad;
  String txPitNotes;
  String dtCreation;
  String dtModified;
  String txComputerName;

  PitData({
    this.id = 0,
    this.txEvent,
    this.idTeam,
    this.txScoutName,
    this.numWeight = 0,
    this.numHeight = 0,
    this.flCells = false,
    this.flIntakeGround = false,
    this.flIntakeHigh = false,
    this.numStorage = 0,
    this.txShooting,
    this.flTargetLow = false,
    this.flTargetOuter = false,
    this.flTargetInner = false,
    this.flClimb = false,
    this.idClimbType,
    this.numClimbHeight = 0,
    this.flClimbSecure = false,
    this.idClimbGrab,
    this.idClimbSpeed,
    this.flClimbTilt = false,
    this.txClimb,
    this.idClimbPos,
    this.flClimbLevel = false,
    this.flClimbLevelSelf = false,
    this.flClimbLevelOther = false,
    this.flClimbMove = false,
    this.flClimbOther = false,
    this.numClimbOther = 0,
    this.flPanel = false,
    this.flPanelBrake = false,
    this.flPanelRotation = false,
    this.flPanelPos = false,
    this.flPanelSensor = false,
    this.txPanelSensor,
    this.flAuto = false,
    this.flAutoLine = false,
    this.flAutoShoot = false,
    this.numAutoShoot = 0,
    this.numAutoLoad = 0,
    this.txPitNotes,
    this.dtCreation,
    this.dtModified,
    this.txComputerName,
  });

  Map<String, dynamic> toLocalDB() {
    return {
      'id': id,
      'txEvent': txEvent,
      'idTeam': idTeam,
      'txScoutName': txScoutName,
      'numWeight': numWeight,
      'numHeight': numHeight,
      'flCells': flCells.toString(),
      'flIntakeGround': flIntakeGround.toString(),
      'flIntakeHigh': flIntakeHigh.toString(),
      'numStorage': numStorage,
      'txShooting': txShooting,
      'flTargetLow': flTargetLow.toString(),
      'flTargetOuter': flTargetOuter.toString(),
      'flTargetInner': flTargetInner.toString(),
      'flClimb': flClimb.toString(),
      'idClimbType': idClimbType,
      'numClimbHeight': numClimbHeight,
      'flClimbSecure': flClimbSecure.toString(),
      'idClimbGrab': idClimbGrab,
      'idClimbSpeed': idClimbSpeed,
      'flClimbTilt': flClimbTilt.toString(),
      'txClimb': txClimb,
      'idClimbPos': idClimbPos,
      'flClimbLevel': flClimbLevel.toString(),
      'flClimbLevelSelf': flClimbLevelSelf.toString(),
      'flClimbLevelOther': flClimbLevelOther.toString(),
      'flClimbMove': flClimbMove.toString(),
      'flClimbOther': flClimbOther.toString(),
      'numClimbOther': numClimbOther,
      'flPanel': flPanel.toString(),
      'flPanelBrake': flPanelBrake.toString(),
      'flPanelRotation': flPanelRotation.toString(),
      'flPanelPos': flPanelPos.toString(),
      'flPanelSensor': flPanelSensor.toString(),
      'txPanelSensor': txPanelSensor,
      'flAuto': flAuto.toString(),
      'flAutoLine': flAutoLine.toString(),
      'flAutoShoot': flAutoShoot.toString(),
      'numAutoShoot': numAutoShoot,
      'numAutoLoad': numAutoLoad,
      'txPitNotes': txPitNotes,
      'dtCreation': dtCreation.toString(),
      'dtModified': dtModified.toString(),
      'txComputerName': txComputerName,
    };
  }

  PitData.fromLocalDB(Map<String, dynamic> map) {
    this.id = map['id'];
    this.txEvent = map['txEvent'];
    this.idTeam = map['idTeam'].toString();
    this.txScoutName = map['txScoutName'];
    this.numWeight = map['numWeight'];
    this.numHeight = map['numHeight'];
    this.flCells = map['flCells'].toString().toLowerCase() == 'true';
    this.flIntakeGround = map['flIntakeGround'].toString().toLowerCase() == 'true';
    this.flIntakeHigh = map['flIntakeHigh'].toString().toLowerCase() == 'true';
    this.numStorage = map['numStorage'];
    this.txShooting = map['txShooting'];
    this.flTargetLow = map['flTargetLow'].toString().toLowerCase() == 'true';
    this.flTargetOuter = map['flTargetOuter'].toString().toLowerCase() == 'true';
    this.flTargetInner = map['flTargetInner'].toString().toLowerCase() == 'true';
    this.flClimb = map['flClimb'].toString().toLowerCase() == 'true';
    this.idClimbType = map['idClimbType'];
    this.numClimbHeight = map['numClimbHeight'];
    this.flClimbSecure = map['flClimbSecure'].toString().toLowerCase() == 'true';
    this.idClimbGrab = map['idClimbGrab'];
    this.idClimbSpeed = map['idClimbSpeed'];
    this.flClimbTilt = map['flClimbTilt'].toString().toLowerCase() == 'true';
    this.txClimb = map['txClimb'];
    this.idClimbPos = map['idClimbPos'];
    this.flClimbLevel = map['flClimbLevel'].toString().toLowerCase() == 'true';
    this.flClimbLevelSelf = map['flClimbLevelSelf'].toString().toLowerCase() == 'true';
    this.flClimbLevelOther = map['flClimbLevelOther'].toString().toLowerCase() == 'true';
    this.flClimbMove = map['flClimbMove'].toString().toLowerCase() == 'true';
    this.flClimbOther = map['flClimbOther'].toString().toLowerCase() == 'true';
    this.numClimbOther = map['numClimbOther'];
    this.flPanel = map['flPanel'].toString().toLowerCase() == 'true';
    this.flPanelBrake = map['flPanelBrake'].toString().toLowerCase() == 'true';
    this.flPanelRotation = map['flPanelRotation'].toString().toLowerCase() == 'true';
    this.flPanelPos = map['flPanelPos'].toString().toLowerCase() == 'true';
    this.flPanelSensor = map['flPanelSensor'].toString().toLowerCase() == 'true';
    this.txPanelSensor = map['txPanelSensor'];
    this.flAuto = map['flAuto'].toString().toLowerCase() == 'true';
    this.flAutoLine = map['flAutoLine'].toString().toLowerCase() == 'true';
    this.flAutoShoot = map['flAutoShoot'].toString().toLowerCase() == 'true';
    this.numAutoShoot = map['numAutoShoot'];
    this.numAutoLoad = map['numAutoLoad'];
    this.txPitNotes = map['txPitNotes'];
    this.dtCreation = map['dtCreation'];
    this.dtModified = map['dtModified'];
    this.txComputerName = map['txComputerName'];

  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['txEvent'] = this.txEvent;
    return data;
  }

  PitData.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.txEvent = map['txEvent'];
  }
}
