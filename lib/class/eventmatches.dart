class EventMatches {
  int? actualTime;
  Alliances? alliances;
  String? compLevel;
  String? eventKey;
  String? key;
  int? matchNumber;
  int? predictedTime;
  int? setNumber;
  int? time;
  String? winningAlliance;

  EventMatches(
      {this.actualTime,
      this.alliances,
      this.compLevel,
      this.eventKey,
      this.key,
      this.matchNumber,
      this.predictedTime,
      this.setNumber,
      this.time,
      this.winningAlliance});

  EventMatches.fromJson(Map<String, dynamic> json) {
    actualTime = json['actual_time'];
    alliances = json['alliances'] != null
        ? new Alliances.fromJson(json['alliances'])
        : null;
    compLevel = json['comp_level'];
    eventKey = json['event_key'];
    key = json['key'];
    matchNumber = json['match_number'];
    predictedTime = json['predicted_time'];
    setNumber = json['set_number'];
    time = json['time'];
    winningAlliance = json['winning_alliance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['actual_time'] = this.actualTime;
    if (this.alliances != null) {
      data['alliances'] = this.alliances!.toJson();
    }
    data['comp_level'] = this.compLevel;
    data['event_key'] = this.eventKey;
    data['key'] = this.key;
    data['match_number'] = this.matchNumber;
    data['predicted_time'] = this.predictedTime;
    data['set_number'] = this.setNumber;
    data['time'] = this.time;
    data['winning_alliance'] = this.winningAlliance;
    return data;
  }
}

class Alliances {
  MatchTeams? blue;
  MatchTeams? red;

  Alliances({this.blue, this.red});

  Alliances.fromJson(Map<String, dynamic> json) {
    blue = json['blue'] != null ? new MatchTeams.fromJson(json['blue']) : null;
    red = json['red'] != null ? new MatchTeams.fromJson(json['red']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.blue != null) {
      data['blue'] = this.blue!.toJson();
    }
    if (this.red != null) {
      data['red'] = this.red!.toJson();
    }
    return data;
  }
}

class MatchTeams {
  int? score;
  List<String>? teamKeys;

  MatchTeams({this.score, this.teamKeys});

  MatchTeams.fromJson(Map<String, dynamic> json) {
    score = json['score'];
    teamKeys = json['team_keys'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['score'] = this.score;
    data['team_keys'] = this.teamKeys;
    return data;
  }
}
