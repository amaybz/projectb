import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';

class WebAPI {
  final String strAPIKey =
      "k9w9nJeu045mBGHOIQNIN5mL9Uii2QK6nanQdsMDvMfuMcenbxL6nL4X6cNeW0lb";
  final String strAPILink = "https://www.thebluealliance.com/api/v3/";

  Future<List<EventData>> getEventsByYear(int year) async {
    List<EventData> events;
    var headers = {'X-TBA-Auth-Key': strAPIKey};
    var request = http.Request(
        'GET',
        Uri.parse('https://www.thebluealliance.com/api/v3/events/' +
            year.toString()));
    request.body = '''''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String strEventsList = await response.stream.bytesToString();
      //print(strEventsList);

      events =(json.decode(strEventsList) as List).map((i) =>
          EventData.fromJson(i)).toList();

    } else {
      print(response.reasonPhrase);
    }
    print(events.first.key);
    return events;
  }

  Future<List<TeamsList>> getTeamsByEvent(String strEventKey) async {
    List<TeamsList> teams;
    var headers = {'X-TBA-Auth-Key': strAPIKey};
    var request = http.Request(
        'GET',
        Uri.parse('https://www.thebluealliance.com/api/v3/event/' +
            strEventKey + '/teams'));
    request.body = '''''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String strTeamsList = await response.stream.bytesToString();
      //print(strEventsList);

      teams =(json.decode(strTeamsList) as List).map((i) =>
          TeamsList.fromJson(i)).toList();

    } else {
      print(response.reasonPhrase);
    }
    print(teams.first.key);
    return teams;
  }
}

class TeamsList {
  String address;
  String city;
  String country;
  String gmapsPlaceId;
  String gmapsUrl;
  String homeChampionship;
  String key;
  String  lat;
  String lng;
  String locationName;
  String motto;
  String name;
  String nickname;
  String postalCode;
  int rookieYear;
  String schoolName;
  String stateProv;
  int teamNumber;
  String website;

  TeamsList(
      {this.address,
        this.city,
        this.country,
        this.gmapsPlaceId,
        this.gmapsUrl,
        this.homeChampionship,
        this.key,
        this.lat,
        this.lng,
        this.locationName,
        this.motto,
        this.name,
        this.nickname,
        this.postalCode,
        this.rookieYear,
        this.schoolName,
        this.stateProv,
        this.teamNumber,
        this.website});

  TeamsList.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    city = json['city'];
    country = json['country'];
    gmapsPlaceId = json['gmaps_place_id'];
    gmapsUrl = json['gmaps_url'];
    //homeChampionship = json['home_championship'];
    key = json['key'];
    lat = json['lat'];
    lng = json['lng'];
    locationName = json['location_name'];
    motto = json['motto'];
    name = json['name'];
    nickname = json['nickname'];
    postalCode = json['postal_code'];
    rookieYear = json['rookie_year'];
    schoolName = json['school_name'];
    stateProv = json['state_prov'];
    teamNumber = json['team_number'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['city'] = this.city;
    data['country'] = this.country;
    data['gmaps_place_id'] = this.gmapsPlaceId;
    data['gmaps_url'] = this.gmapsUrl;
    data['home_championship'] = this.homeChampionship;
    data['key'] = this.key;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['location_name'] = this.locationName;
    data['motto'] = this.motto;
    data['name'] = this.name;
    data['nickname'] = this.nickname;
    data['postal_code'] = this.postalCode;
    data['rookie_year'] = this.rookieYear;
    data['school_name'] = this.schoolName;
    data['state_prov'] = this.stateProv;
    data['team_number'] = this.teamNumber;
    data['website'] = this.website;
    return data;
  }
}


class EventData {
  String address;
  String city;
  String country;
  String endDate;
  String eventCode;
  int eventType;
  String eventTypeString;
  String firstEventCode;
  String firstEventId;
  String gmapsPlaceId;
  String gmapsUrl;
  String key;
  double lat;
  double lng;
  String locationName;
  String name;
  String postalCode;
  String shortName;
  String startDate;
  String stateProv;
  String timezone;
  List<WebCasts> webcasts;
  String website;
  int week;
  int year;

  EventData(
      {this.address,
      this.city,
      this.country,
      this.endDate,
      this.eventCode,
      this.eventType,
      this.eventTypeString,
      this.firstEventCode,
      this.firstEventId,
      this.gmapsPlaceId,
      this.gmapsUrl,
      this.key,
      this.lat,
      this.lng,
      this.locationName,
      this.name,
      this.postalCode,
      this.shortName,
      this.startDate,
      this.stateProv,
      this.timezone,
      this.webcasts,
      this.website,
      this.week,
      this.year});

  EventData.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    city = json['city'];
    country = json['country'];
    //district = json['district'];
    //if (json['division_keys'] != null) {
    //  divisionKeys = new List<Null>();
    //  json['division_keys'].forEach((v) {
    //    divisionKeys.add(new Null.fromJson(v));
    //   });
    //}
    endDate = json['end_date'];
    eventCode = json['event_code'];
    eventType = json['event_type'];
    eventTypeString = json['event_type_string'];
    firstEventCode = json['first_event_code'];
    firstEventId = json['first_event_id'];
    gmapsPlaceId = json['gmaps_place_id'];
    gmapsUrl = json['gmaps_url'];
    key = json['key'];
    lat = json['lat'];
    lng = json['lng'];
    locationName = json['location_name'];
    name = json['name'];
    //parentEventKey = json['parent_event_key'];
    //playoffType = json['playoff_type'];
    //playoffTypeString = json['playoff_type_string'];
    postalCode = json['postal_code'];
    shortName = json['short_name'];
    startDate = json['start_date'];
    stateProv = json['state_prov'];
    timezone = json['timezone'];
    if (json['webcasts'] != null) {
      webcasts = new List<WebCasts>();
      json['webcasts'].forEach((v) {
        webcasts.add(new WebCasts.fromJson(v));
      });
    }
    website = json['website'];
    week = json['week'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['city'] = this.city;
    data['country'] = this.country;
    //data['district'] = this.district;
    //if (this.divisionKeys != null) {
    //  //data['division_keys'] = this.divisionKeys.map((v) => v.toJson()).toList();
    //}
    data['end_date'] = this.endDate;
    data['event_code'] = this.eventCode;
    data['event_type'] = this.eventType;
    data['event_type_string'] = this.eventTypeString;
    data['first_event_code'] = this.firstEventCode;
    data['first_event_id'] = this.firstEventId;
    data['gmaps_place_id'] = this.gmapsPlaceId;
    data['gmaps_url'] = this.gmapsUrl;
    data['key'] = this.key;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['location_name'] = this.locationName;
    data['name'] = this.name;
    //data['parent_event_key'] = this.parentEventKey;
    //data['playoff_type'] = this.playoffType;
    //data['playoff_type_string'] = this.playoffTypeString;
    data['postal_code'] = this.postalCode;
    data['short_name'] = this.shortName;
    data['start_date'] = this.startDate;
    data['state_prov'] = this.stateProv;
    data['timezone'] = this.timezone;
    if (this.webcasts != null) {
      data['webcasts'] = this.webcasts.map((v) => v.toJson()).toList();
    }
    data['website'] = this.website;
    data['week'] = this.week;
    data['year'] = this.year;
    return data;
  }
  @override
  String toString() {
    return 'event{id: $key, shortName: $shortName, location: $country}';
  }
}

class WebCasts {
  String channel;
  String type;

  WebCasts({this.channel, this.type});

  WebCasts.fromJson(Map<String, dynamic> json) {
    channel = json['channel'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['channel'] = this.channel;
    data['type'] = this.type;
    return data;
  }


}
