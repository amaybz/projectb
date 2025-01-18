import 'dart:io';

class PitData {
  int? id;
  String? txEvent;
  String? txScoutName;
  int? idTeam;
  int? numWeight;
  int? numHeight;
  File? imgTeamUniform;
  File? imgRobotFront;
  File? imgRobotSide;
  String? idDriveType;
  String? txDriveNotes;
  bool? flObjectCoral;
  bool? flObjectAlgae;
  bool? flObjectCatch;
  bool? flObjectAlgaeFloor;
  bool? flObjectCoralFloor;
  String? txObjectNotes;
  bool? flScoreCoralL1;
  bool? flScoreCoralL2;
  bool? flScoreCoralL3;
  bool? flScoreCoralL4;
  bool? flScoreAlgaeBarge;
  bool? flScoreAlgaeProcess;
  String? txScoringNotes;
  bool? flClimb;
  String? idClimbPos;
  String? txClimbNotes;
  bool? flAuto;
  bool? flAutoLine;
  bool? flAutoScoreCoral;
  int? numAutoScoreCoralL1;
  int? numAutoScoreCoralL2;
  int? numAutoScoreCoralL3;
  int? numAutoScoreCoralL4;
  bool? flAutoScoreAlgae;
  int? numAutoScoreAlgaeL2;
  int? numAutoScoreAlgaeL3;
  int? numAutoScoreAlgaeGround;
  int? numAutoScoreAlgaeBarge;
  String? numAutoScoreAlgaeProcess;
  String? txAutoNotes;
  String? txPitNotes;
  String? dtCreation;
  String? dtModified;
  String? txComputerName;
  bool? uploaded;

  PitData({
    this.id = 0,
    this.txEvent,
    this.txScoutName,
    this.idTeam = 0,
    this.numWeight = 0,
    this.numHeight = 0,
    this.imgTeamUniform,
    this.imgRobotFront,
    this.imgRobotSide,
    this.idDriveType = "1",
    this.txDriveNotes,
    this.flObjectCoral = false,
    this.flObjectAlgae = false,
    this.flObjectCatch = false,
    this.flObjectAlgaeFloor = false,
    this.flObjectCoralFloor = false,
    this.txObjectNotes,
    this.flScoreCoralL1 = false,
    this.flScoreCoralL2 = false,
    this.flScoreCoralL3 = false,
    this.flScoreCoralL4 = false,
    this.flScoreAlgaeBarge = false,
    this.flScoreAlgaeProcess = false,
    this.txScoringNotes,
    this.flClimb = false,
    this.idClimbPos = "1",
    this.txClimbNotes,
    this.flAuto = false,
    this.flAutoLine = false,
    this.flAutoScoreCoral = false,
    this.numAutoScoreCoralL1 = 0,
    this.numAutoScoreCoralL2 = 0,
    this.numAutoScoreCoralL3 = 0,
    this.numAutoScoreCoralL4 = 0,
    this.flAutoScoreAlgae = false,
    this.numAutoScoreAlgaeL2 = 0,
    this.numAutoScoreAlgaeL3 = 0,
    this.numAutoScoreAlgaeGround = 0,
    this.numAutoScoreAlgaeBarge = 0,
    this.numAutoScoreAlgaeProcess,
    this.txAutoNotes,
    this.txPitNotes,
    this.dtCreation,
    this.dtModified,
    this.txComputerName,
    this.uploaded = false,
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
      'txEvent': txEvent,
      'txScoutName': txScoutName,
      'idTeam': idTeam,
      'numWeight': numWeight,
      'numHeight': numHeight,
      'imgTeamUniform': fileImgTeamUniform,
      'imgRobotFront': fileRobotFront,
      'imgRobotSide': fileImgRobotSide,
      'idDriveType': idDriveType,
      'txDriveNotes': txDriveNotes,
      'flObjectCoral': flObjectCoral.toString(),
      'flObjectAlgae': flObjectAlgae.toString(),
      'flObjectCatch': flObjectCatch.toString(),
      'flObjectAlgaeFloor': flObjectAlgaeFloor.toString(),
      'flObjectCoralFloor': flObjectCoralFloor.toString(),
      'txObjectNotes': txObjectNotes,
      'flScoreCoralL1': flScoreCoralL1.toString(),
      'flScoreCoralL2': flScoreCoralL2.toString(),
      'flScoreCoralL3': flScoreCoralL3.toString(),
      'flScoreCoralL4': flScoreCoralL4.toString(),
      'flScoreAlgaeBarge': flScoreAlgaeBarge.toString(),
      'flScoreAlgaeProcess': flScoreAlgaeProcess.toString(),
      'txScoringNotes': txScoringNotes,
      'flClimb': flClimb.toString(),
      'idClimbPos': idClimbPos,
      'txClimbNotes': txClimbNotes,
      'flAuto': flAuto.toString(),
      'flAutoLine': flAutoLine.toString(),
      'flAutoScoreCoral': flAutoScoreCoral.toString(),
      'numAutoScoreCoralL1': numAutoScoreCoralL1,
      'numAutoScoreCoralL2': numAutoScoreCoralL2,
      'numAutoScoreCoralL3': numAutoScoreCoralL3,
      'numAutoScoreCoralL4': numAutoScoreCoralL4,
      'flAutoScoreAlgae': flAutoScoreAlgae.toString(),
      'numAutoScoreAlgaeL2': numAutoScoreAlgaeL2,
      'numAutoScoreAlgaeL3': numAutoScoreAlgaeL3,
      'numAutoScoreAlgaeGround': numAutoScoreAlgaeGround,
      'numAutoScoreAlgaeBarge': numAutoScoreAlgaeBarge,
      'numAutoScoreAlgaeProcess': numAutoScoreAlgaeProcess,
      'txAutoNotes': txAutoNotes,
      'txPitNotes': txPitNotes,
      'dtCreation': dtCreation,
      'dtModified': dtModified,
      'txComputerName': txComputerName,
      'uploaded': uploaded.toString(),
    };
  }

  PitData.fromLocalDB(Map<dynamic, dynamic> map) {
    this.id = map['id'];
    this.txEvent = map['txEvent'];
    this.txScoutName = map['txScoutName'];
    this.idTeam = map['idTeam'];
    this.numWeight = map['numWeight'];
    this.numHeight = map['numHeight'];
    //this.imgTeamUniform = map['imgTeamUniform'];
    //this.imgRobotFront = map['imgRobotFront'];
    //this.imgRobotSide = map['imgRobotSide'];
    this.idDriveType = map['idDriveType'];
    this.txDriveNotes = map['txDriveNotes'];
    this.flObjectCoral =
        map['flObjectCoral'].toString().toLowerCase() == 'true';
    this.flObjectAlgae =
        map['flObjectAlgae'].toString().toLowerCase() == 'true';
    this.flObjectCatch =
        map['flObjectCatch'].toString().toLowerCase() == 'true';
    this.flObjectAlgaeFloor =
        map['flObjectAlgaeFloor'].toString().toLowerCase() == 'true';
    this.flObjectCoralFloor =
        map['flObjectCoralFloor'].toString().toLowerCase() == 'true';
    this.txObjectNotes = map['txObjectNotes'];
    this.flScoreCoralL1 =
        map['flScoreCoralL1'].toString().toLowerCase() == 'true';
    this.flScoreCoralL2 =
        map['flScoreCoralL2'].toString().toLowerCase() == 'true';
    this.flScoreCoralL3 =
        map['flScoreCoralL3'].toString().toLowerCase() == 'true';
    this.flScoreCoralL4 =
        map['flScoreCoralL4'].toString().toLowerCase() == 'true';
    this.flScoreAlgaeBarge =
        map['flScoreAlgaeBarge'].toString().toLowerCase() == 'true';
    this.flScoreAlgaeProcess =
        map['flScoreAlgaeProcess'].toString().toLowerCase() == 'true';
    this.txScoringNotes = map['txScoringNotes'];
    this.flClimb = map['flClimb'].toString().toLowerCase() == 'true';
    this.idClimbPos = map['idClimbPos'];
    this.txClimbNotes = map['txClimbNotes'];
    this.flAuto = map['flAuto'].toString().toLowerCase() == 'true';
    this.flAutoLine = map['flAutoLine'].toString().toLowerCase() == 'true';
    this.flAutoScoreCoral =
        map['flAutoScoreCoral'].toString().toLowerCase() == 'true';
    this.numAutoScoreCoralL1 = map['numAutoScoreCoralL1'];
    this.numAutoScoreCoralL2 = map['numAutoScoreCoralL2'];
    this.numAutoScoreCoralL3 = map['numAutoScoreCoralL3'];
    this.numAutoScoreCoralL4 = map['numAutoScoreCoralL4'];
    this.flAutoScoreAlgae =
        map['flAutoScoreAlgae'].toString().toLowerCase() == 'true';
    this.numAutoScoreAlgaeL2 = map['numAutoScoreAlgaeL2'];
    this.numAutoScoreAlgaeL3 = map['numAutoScoreAlgaeL3'];
    this.numAutoScoreAlgaeGround = map['numAutoScoreAlgaeGround'];
    this.numAutoScoreAlgaeBarge = map['numAutoScoreAlgaeBarge'];
    this.numAutoScoreAlgaeProcess = map['numAutoScoreAlgaeProcess'];
    this.txAutoNotes = map['txAutoNotes'];
    this.txPitNotes = map['txPitNotes'];
    this.dtCreation = map['dtCreation'];
    this.dtModified = map['dtModified'];
    this.txComputerName = map['txComputerName'];
    this.uploaded = map['uploaded'].toString().toLowerCase() == 'true';
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
    data['txEvent'] = this.txEvent;
    data['txScoutName'] = this.txScoutName;
    data['idTeam'] = this.idTeam;
    data['numWeight'] = this.numWeight;
    data['numHeight'] = this.numHeight;
    data['imgTeamUniform'] = fileImgTeamUniform;
    data['imgRobotFront'] = fileImgRobotFront;
    data['imgRobotSide'] = fileImgRobotSide;
    data['idDriveType'] = this.idDriveType;
    data['txDriveNotes'] = this.txDriveNotes;
    data['flObjectCoral'] = this.flObjectCoral;
    data['flObjectAlgae'] = this.flObjectAlgae;
    data['flObjectCatch'] = this.flObjectCatch;
    data['flObjectAlgaeFloor'] = this.flObjectAlgaeFloor;
    data['flObjectCoralFloor'] = this.flObjectCoralFloor;
    data['txObjectNotes'] = this.txObjectNotes;
    data['flScoreCoralL1'] = this.flScoreCoralL1;
    data['flScoreCoralL2'] = this.flScoreCoralL2;
    data['flScoreCoralL3'] = this.flScoreCoralL3;
    data['flScoreCoralL4'] = this.flScoreCoralL4;
    data['flScoreAlgaeBarge'] = this.flScoreAlgaeBarge;
    data['flScoreAlgaeProcess'] = this.flScoreAlgaeProcess;
    data['txScoringNotes'] = this.txScoringNotes;
    data['flClimb'] = this.flClimb;
    data['idClimbPos'] = this.idClimbPos;
    data['txClimbNotes'] = this.txClimbNotes;
    data['flAuto'] = this.flAuto;
    data['flAutoLine'] = this.flAutoLine;
    data['flAutoScoreCoral'] = this.flAutoScoreCoral;
    data['numAutoScoreCoralL1'] = this.numAutoScoreCoralL1;
    data['numAutoScoreCoralL2'] = this.numAutoScoreCoralL2;
    data['numAutoScoreCoralL3'] = this.numAutoScoreCoralL3;
    data['numAutoScoreCoralL4'] = this.numAutoScoreCoralL4;
    data['flAutoScoreAlgae'] = this.flAutoScoreAlgae;
    data['numAutoScoreAlgaeL2'] = this.numAutoScoreAlgaeL2;
    data['numAutoScoreAlgaeL3'] = this.numAutoScoreAlgaeL3;
    data['numAutoScoreAlgaeGround'] = this.numAutoScoreAlgaeGround;
    data['numAutoScoreAlgaeBarge'] = this.numAutoScoreAlgaeBarge;
    data['numAutoScoreAlgaeProcess'] = this.numAutoScoreAlgaeProcess;

    data['txPitNotes'] = this.txPitNotes;
    data['dtCreation'] = this.dtCreation;
    data['dtModified'] = this.dtModified;
    data['txComputerName'] = this.txComputerName;
    data['uploaded'] = this.uploaded;
    return data;
  }

  PitData.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.txEvent = map['txEvent'];
    this.txScoutName = map['txScoutName'];
    this.idTeam = map['idTeam'];
    this.numWeight = map['numWeight'];
    this.numHeight = map['numHeight'];
    //this.imgTeamUniform = map['imgTeamUniform'];
    //this.imgRobotFront = map['imgRobotFront'];
    //this.imgRobotSide = map['imgRobotSide'];
    this.idDriveType = map['idDriveType'];
    this.txDriveNotes = map['txDriveNotes'];
    this.flObjectCoral = map['flObjectCoral'];
    this.flObjectAlgae = map['flObjectAlgae'];
    this.flObjectCatch = map['flObjectCatch'];
    this.flObjectAlgaeFloor = map['flObjectAlgaeFloor'];
    this.flObjectCoralFloor = map['flObjectCoralFloor'];
    this.txObjectNotes = map['txObjectNotes'];
    this.flScoreCoralL1 = map['flScoreCoralL1'];
    this.flScoreCoralL2 = map['flScoreCoralL2'];
    this.flScoreCoralL3 = map['flScoreCoralL3'];
    this.flScoreCoralL4 = map['flScoreCoralL4'];
    this.flScoreAlgaeBarge = map['flScoreAlgaeBarge'];
    this.flScoreAlgaeProcess = map['flScoreAlgaeProcess'];
    this.txScoringNotes = map['txScoringNotes'];
    this.flClimb = map['flClimb'];
    this.idClimbPos = map['idClimbPos'];
    this.txClimbNotes = map['txClimbNotes'];
    this.flAuto = map['flAuto'];
    this.flAutoLine = map['flAutoLine'];
    this.flAutoScoreCoral = map['flAutoScoreCoral'];
    this.numAutoScoreCoralL1 = map['numAutoScoreCoralL1'];
    this.numAutoScoreCoralL2 = map['numAutoScoreCoralL2'];
    this.numAutoScoreCoralL3 = map['numAutoScoreCoralL3'];
    this.numAutoScoreCoralL4 = map['numAutoScoreCoralL4'];
    this.flAutoScoreAlgae = map['flAutoScoreAlgae'];
    this.numAutoScoreAlgaeL2 = map['numAutoScoreAlgaeL2'];
    this.numAutoScoreAlgaeL3 = map['numAutoScoreAlgaeL3'];
    this.numAutoScoreAlgaeGround = map['numAutoScoreAlgaeGround'];
    this.numAutoScoreAlgaeBarge = map['numAutoScoreAlgaeBarge'];
    this.numAutoScoreAlgaeProcess = map['numAutoScoreAlgaeProcess'];

    this.txPitNotes = map['txPitNotes'];
    this.dtCreation = map['dtCreation'];
    this.dtModified = map['dtModified'];
    this.txComputerName = map['txComputerName'];
    this.uploaded = map['uploaded'];
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
