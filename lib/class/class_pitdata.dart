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
  int? intWheels;
  String? txDriveNotes;
  bool? flCone;
  bool? flCube;
  String? idObjectPreference;
  bool? flObjectCatch;
  bool? flObjectShelf;
  bool? flObjectFloor;
  bool? flObjectSide;
  String? txObjectNotes;
  bool? flNodeBottom;
  bool? flNodeMid;
  bool? flNodeHigh;
  String? flNodeType;
  String? txScoringNotes;
  bool? flCharge;
  bool? flChargeBalance;
  String? idChargeBalanceType;
  bool? flChargeAssist;
  String? txChargeNotes;
  bool? flAuto;
  bool? flAutoLine;
  bool? flAutoScore;
  int? numAutoScore;
  bool? flAutoNodeBottom;
  bool? flAutoNodeMid;
  bool? flAutoNodeHigh;
  bool? flAutoCharge;
  bool? flAutoChargeBalance;
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
    this.idDriveType,
    this.intWheels = 0,
    this.txDriveNotes,
    this.flCone = false,
    this.flCube = false,
    this.idObjectPreference,
    this.flObjectCatch = false,
    this.flObjectShelf = false,
    this.flObjectFloor = false,
    this.flObjectSide = false,
    this.txObjectNotes,
    this.flNodeBottom = false,
    this.flNodeMid = false,
    this.flNodeHigh = false,
    this.flNodeType,
    this.txScoringNotes,
    this.flCharge = false,
    this.flChargeBalance = false,
    this.idChargeBalanceType,
    this.flChargeAssist = false,
    this.txChargeNotes,
    this.flAuto = false,
    this.flAutoLine = false,
    this.flAutoScore = false,
    this.numAutoScore = 0,
    this.flAutoNodeBottom = false,
    this.flAutoNodeMid = false,
    this.flAutoNodeHigh = false,
    this.flAutoCharge = false,
    this.flAutoChargeBalance = false,
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
      'intWheels': intWheels,
      'txDriveNotes': txDriveNotes,
      'flCone': flCone.toString(),
      'flCube': flCube.toString(),
      'idObjectPreference': idObjectPreference,
      'flObjectCatch': flObjectCatch.toString(),
      'flObjectShelf': flObjectShelf.toString(),
      'flObjectFloor': flObjectFloor.toString(),
      'flObjectSide': flObjectSide.toString(),
      'txObjectNotes': txObjectNotes,
      'flNodeBottom': flNodeBottom.toString(),
      'flNodeMid': flNodeMid.toString(),
      'flNodeHigh': flNodeHigh.toString(),
      'flNodeType': flNodeType,
      'txScoringNotes': txScoringNotes,
      'flCharge': flCharge.toString(),
      'flChargeBalance': flChargeBalance.toString(),
      'idChargeBalanceType': idChargeBalanceType,
      'flChargeAssist': flChargeAssist.toString(),
      'txChargeNotes': txChargeNotes,
      'flAuto': flAuto.toString(),
      'flAutoLine': flAutoLine.toString(),
      'flAutoScore': flAutoScore.toString(),
      'numAutoScore': numAutoScore,
      'flAutoNodeBottom': flAutoNodeBottom.toString(),
      'flAutoNodeMid': flAutoNodeMid.toString(),
      'flAutoNodeHigh': flAutoNodeHigh.toString(),
      'flAutoCharge': flAutoCharge.toString(),
      'flAutoChargeBalance': flAutoChargeBalance.toString(),
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
    this.intWheels = map['intWheels'];
    this.txDriveNotes = map['txDriveNotes'];
    this.flCone = map['flCone'].toString().toLowerCase() == 'true';
    this.flCube = map['flCube'].toString().toLowerCase() == 'true';
    this.idObjectPreference = map['idObjectPreference'];
    this.flObjectCatch = map['flObjectCatch'].toString().toLowerCase() == 'true';
    this.flObjectShelf = map['flObjectShelf'].toString().toLowerCase() == 'true';
    this.flObjectFloor = map['flObjectFloor'].toString().toLowerCase() == 'true';
    this.flObjectSide = map['flObjectSide'].toString().toLowerCase() == 'true';
    this.txObjectNotes = map['txObjectNotes'];
    this.flNodeBottom = map['flNodeBottom'].toString().toLowerCase() == 'true';
    this.flNodeMid = map['flNodeMid'].toString().toLowerCase() == 'true';
    this.flNodeHigh = map['flNodeHigh'].toString().toLowerCase() == 'true';
    this.flNodeType = map['flNodeType'];
    this.txScoringNotes = map['txScoringNotes'];
    this.flCharge = map['flCharge'].toString().toLowerCase() == 'true';
    this.flChargeBalance = map['flChargeBalance'].toString().toLowerCase() == 'true';
    this.idChargeBalanceType = map['idChargeBalanceType'];
    this.flChargeAssist = map['flChargeAssist'].toString().toLowerCase() == 'true';
    this.txChargeNotes = map['txChargeNotes'];
    this.flAuto = map['flAuto'].toString().toLowerCase() == 'true';
    this.flAutoLine = map['flAutoLine'].toString().toLowerCase() == 'true';
    this.flAutoScore = map['flAutoScore'].toString().toLowerCase() == 'true';
    this.numAutoScore = map['numAutoScore'];
    this.flAutoNodeBottom = map['flAutoNodeBottom'].toString().toLowerCase() == 'true';
    this.flAutoNodeMid = map['flAutoNodeMid'].toString().toLowerCase() == 'true';
    this.flAutoNodeHigh = map['flAutoNodeHigh'].toString().toLowerCase() == 'true';
    this.flAutoCharge = map['flAutoCharge'].toString().toLowerCase() == 'true';
    this.flAutoChargeBalance = map['flAutoChargeBalance'].toString().toLowerCase() == 'true';
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
    data['intWheels'] = this.intWheels;
    data['txDriveNotes'] = this.txDriveNotes;
    data['flCone'] = this.flCone;
    data['flCube'] = this.flCube;
    data['idObjectPreference'] = this.idObjectPreference;
    data['flObjectCatch'] = this.flObjectCatch;
    data['flObjectShelf'] = this.flObjectShelf;
    data['flObjectFloor'] = this.flObjectFloor;
    data['flObjectSide'] = this.flObjectSide;
    data['txObjectNotes'] = this.txObjectNotes;
    data['flNodeBottom'] = this.flNodeBottom;
    data['flNodeMid'] = this.flNodeMid;
    data['flNodeHigh'] = this.flNodeHigh;
    data['flNodeType'] = this.flNodeType;
    data['txScoringNotes'] = this.txScoringNotes;
    data['flCharge'] = this.flCharge;
    data['flChargeBalance'] = this.flChargeBalance;
    data['idChargeBalanceType'] = this.idChargeBalanceType;
    data['flChargeAssist'] = this.flChargeAssist;
    data['txChargeNotes'] = this.txChargeNotes;
    data['flAuto'] = this.flAuto;
    data['flAutoLine'] = this.flAutoLine;
    data['flAutoScore'] = this.flAutoScore;
    data['numAutoScore'] = this.numAutoScore;
    data['flAutoNodeBottom'] = this.flAutoNodeBottom;
    data['flAutoNodeMid'] = this.flAutoNodeMid;
    data['flAutoNodeHigh'] = this.flAutoNodeHigh;
    data['flAutoCharge'] = this.flAutoCharge;
    data['flAutoChargeBalance'] = this.flAutoChargeBalance;
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
    this.intWheels = map['intWheels'];
    this.txDriveNotes = map['txDriveNotes'];
    this.flCone = map['flCone'];
    this.flCube = map['flCube'];
    this.idObjectPreference = map['idObjectPreference'];
    this.flObjectCatch = map['flObjectCatch'];
    this.flObjectShelf = map['flObjectShelf'];
    this.flObjectFloor = map['flObjectFloor'];
    this.flObjectSide = map['flObjectSide'];
    this.txObjectNotes = map['txObjectNotes'];
    this.flNodeBottom = map['flNodeBottom'];
    this.flNodeMid = map['flNodeMid'];
    this.flNodeHigh = map['flNodeHigh'];
    this.flNodeType = map['flNodeType'];
    this.txScoringNotes = map['txScoringNotes'];
    this.flCharge = map['flCharge'];
    this.flChargeBalance = map['flChargeBalance'];
    this.idChargeBalanceType = map['idChargeBalanceType'];
    this.flChargeAssist = map['flChargeAssist'];
    this.txChargeNotes = map['txChargeNotes'];
    this.flAuto = map['flAuto'];
    this.flAutoLine = map['flAutoLine'];
    this.flAutoScore = map['flAutoScore'];
    this.numAutoScore = map['numAutoScore'];
    this.flAutoNodeBottom = map['flAutoNodeBottom'];
    this.flAutoNodeMid = map['flAutoNodeMid'];
    this.flAutoNodeHigh = map['flAutoNodeHigh'];
    this.flAutoCharge = map['flAutoCharge'];
    this.flAutoChargeBalance = map['flAutoChargeBalance'];
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
