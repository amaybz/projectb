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
  int idClimbGrab;
  int idClimbSpeed;
  bool flClimbTilt;
  String txClimb;
  int idClimbPos;
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
    this.numClimbHeight,
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
    this.numClimbOther,
    this.flPanel = false,
    this.flPanelBrake = false,
    this.flPanelRotation = false,
    this.flPanelPos = false,
    this.flPanelSensor = false,
    this.txPanelSensor,
    this.flAuto = false,
    this.flAutoLine = false,
    this.flAutoShoot = false,
    this.numAutoShoot,
    this.numAutoLoad,
    this.txPitNotes,
    this.dtCreation,
    this.dtModified,
    this.txComputerName,
  });
}
