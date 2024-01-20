import 'dart:io';

class PitData {
  int? id;
  bool? uploaded;
  String? txEvent;
  int? idTeam;
  String? txScoutName;
  int? numWeight;
  int? numHeight;
  int? numWidth;
  File? imgTeamUniform;
  File? imgRobotFront;
  File? imgRobotSide;
  String? idDriveType;
  String? txDriveNotes;
  bool? flObject;
  bool? flObjectCatch;
  bool? flObjectAngle;
  bool? flObjectFloor;
  String? txObjectNotes;
  bool? flScoreAmp;
  bool? flScoreTrap;
  String? idScoreSpeaker;
  String? txScoringNotes;
  bool? flStage;
  String? idStageClimbPos;
  String? idStageClimbType;
  bool? flStageAssist;
  String? txStageNotes;
  bool? flAuto;
  bool? flAutoLine;
  bool? flAutoScore;
  int? numAutoScore;
  int? numAutoRings;
  String? idAutoScore;
  String? txPitNotes;
  String? dtCreation;
  String? dtModified;
  String? txComputerName;

  PitData({
    this.id = 0,
    this.uploaded = false,
    this.txEvent,
    this.idTeam = 0,
    this.txScoutName,
    this.numWeight = 0,
    this.numHeight = 0,
    this.numWidth = 0,
    this.imgTeamUniform,
    this.imgRobotFront,
    this.imgRobotSide,
    this.idDriveType = "1",
    this.txDriveNotes,
    this.flObject = false,
    this.flObjectCatch = false,
    this.flObjectAngle = false,
    this.flObjectFloor = false,
    this.txObjectNotes,
    this.flScoreAmp = false,
    this.flScoreTrap = false,
    this.idScoreSpeaker,
    this.txScoringNotes,
    this.flStage = false,
    this.idStageClimbPos = "1",
    this.idStageClimbType = "1",
    this.flStageAssist = false,
    this.txStageNotes,
    this.flAuto = false,
    this.flAutoLine = false,
    this.flAutoScore = false,
    this.numAutoScore = 0,
    this.numAutoRings = 0,
    this.idAutoScore = "1",
    this.txPitNotes,
    this.dtCreation,
    this.dtModified,
    this.txComputerName,
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
      'imgTeamUniform': fileImgTeamUniform,
      'imgRobotFront': fileRobotFront,
      'imgRobotSide': fileImgRobotSide,
      'idDriveType': idDriveType,
      'txDriveNotes': txDriveNotes,
      'flObject': flObject.toString(),
      'flObjectCatch': flObjectCatch.toString(),
      'flObjectAngle': flObjectAngle.toString(),
      'flObjectFloor': flObjectFloor.toString(),
      'txObjectNotes': txObjectNotes,
      'flScoreAmp': flScoreAmp.toString(),
      'flScoreTrap': flScoreTrap.toString(),
      'idScoreSpeaker': idScoreSpeaker,
      'txScoringNotes': txScoringNotes,
      'flStage': flStage.toString(),
      'idStageClimbPos': idStageClimbPos,
      'idStageClimbType': idStageClimbType,
      'flStageAssist': flStageAssist.toString(),
      'txStageNotes': txStageNotes,
      'flAuto': flAuto.toString(),
      'flAutoLine': flAutoLine.toString(),
      'flAutoScore': flAutoScore.toString(),
      'numAutoScore': numAutoScore,
      'numAutoRings': numAutoRings,
      'idAutoScore': idAutoScore,
      'txPitNotes': txPitNotes,
      'dtCreation': dtCreation,
      'dtModified': dtModified,
      'txComputerName': txComputerName,
    };
  }

  PitData.fromLocalDB(Map<dynamic, dynamic> map) {
    this.id = map['id'];
    this.uploaded = map['uploaded'].toString().toLowerCase() == 'true';
    this.txEvent = map['txEvent'];
    this.idTeam = map['idTeam'];
    this.txScoutName = map['txScoutName'];
    this.numWeight = map['numWeight'];
    this.numHeight = map['numHeight'];
    this.numWidth = map['numWidth'];
    this.idDriveType = map['idDriveType'];
    this.txDriveNotes = map['txDriveNotes'];
    this.flObject = map['flObject'].toString().toLowerCase() == 'true';
    this.flObjectCatch =
        map['flObjectCatch'].toString().toLowerCase() == 'true';
    this.flObjectAngle =
        map['flObjectAngle'].toString().toLowerCase() == 'true';
    this.flObjectFloor =
        map['flObjectFloor'].toString().toLowerCase() == 'true';
    this.txObjectNotes = map['txObjectNotes'];
    this.flScoreAmp = map['flScoreAmp'].toString().toLowerCase() == 'true';
    this.flScoreTrap = map['flScoreTrap'].toString().toLowerCase() == 'true';
    this.idScoreSpeaker = map['idScoreSpeaker'];
    this.txScoringNotes = map['txScoringNotes'];
    this.flStage = map['flStage'].toString().toLowerCase() == 'true';
    this.idStageClimbPos = map['idStageClimbPos'];
    this.idStageClimbType = map['idStageClimbType'];
    this.flStageAssist =
        map['flStageAssist'].toString().toLowerCase() == 'true';
    this.txStageNotes = map['txStageNotes'];
    this.flAuto = map['flAuto'].toString().toLowerCase() == 'true';
    this.flAutoLine = map['flAutoLine'].toString().toLowerCase() == 'true';
    this.flAutoScore = map['flAutoScore'].toString().toLowerCase() == 'true';
    this.numAutoScore = map['numAutoScore'];
    this.numAutoRings = map['numAutoRings'];
    this.idAutoScore = map['idAutoScore'];
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
    data['idDriveType'] = this.idDriveType;

    data['txDriveNotes'] = this.txDriveNotes;
    data['flObject'] = this.flObject;
    data['flObjectCatch'] = this.flObjectCatch;
    data['flObjectAngle'] = this.flObjectAngle;
    data['flObjectFloor'] = this.flObjectFloor;
    data['txObjectNotes'] = this.txObjectNotes;
    data['flScoreAmp'] = this.flScoreAmp;
    data['flScoreTrap'] = this.flScoreTrap;
    data['idScoreSpeaker'] = this.idScoreSpeaker;
    data['txScoringNotes'] = this.txScoringNotes;
    data['flStage'] = this.flStage;
    data['idStageClimbPos'] = this.idStageClimbPos;
    data['idChargeBalanceType'] = this.idStageClimbType;
    data['flStageAssist'] = this.flStageAssist;
    data['txStageNotes'] = this.txStageNotes;
    data['flAuto'] = this.flAuto;
    data['flAutoLine'] = this.flAutoLine;
    data['flAutoScore'] = this.flAutoScore;
    data['numAutoScore'] = this.numAutoScore;
    data['numAutoRings'] = this.numAutoRings;
    data['idAutoScore'] = this.idAutoScore;
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
    this.idDriveType = map['idDriveType'];
    this.txDriveNotes = map['txDriveNotes'];
    this.flObject = map['flObject'];
    this.flObjectCatch = map['flObjectCatch'];
    this.flObjectAngle = map['flObjectAngle'];
    this.flObjectFloor = map['flObjectFloor'];
    this.txObjectNotes = map['txObjectNotes'];
    this.flScoreAmp = map['flScoreAmp'];
    this.flScoreTrap = map['flScoreTrap'];
    this.idScoreSpeaker = map['idScoreSpeaker'];
    this.txScoringNotes = map['txScoringNotes'];
    this.flStage = map['flStage'];
    this.idStageClimbPos = map['idStageClimbPos'];
    this.idStageClimbType = map['idStageClimbType'];
    this.flStageAssist = map['flStageAssist'];
    this.txStageNotes = map['txStageNotes'];
    this.flAuto = map['flAuto'];
    this.flAutoLine = map['flAutoLine'];
    this.flAutoScore = map['flAutoScore'];
    this.numAutoScore = map['numAutoScore'];
    this.numAutoRings = map['numAutoRings'];
    this.idAutoScore = map['idAutoScore'];
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
