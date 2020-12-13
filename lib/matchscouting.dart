import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:projectb/localdb.dart';
import 'dart:async';

class MatchScoutingScreen extends StatefulWidget {
  @override
  _MatchScoutingScreenState createState() => _MatchScoutingScreenState();
}

class _MatchScoutingScreenState extends State<MatchScoutingScreen> {
  LocalDB localDB = new LocalDB();
  final TextEditingController _txtScoutName = TextEditingController();
  final TextEditingController _txtMatchNumber = TextEditingController();
  final TextEditingController _txtStartingCells = TextEditingController();
  String _selectedAlliance;
  final List<String> _listAlliance = ['Red', 'Blue'];
  double styleFieldWidth = 99.0;
  double styleFieldMatchNumber = 85.0;
  double styleFieldAlliance = 75.0;
  double styleFieldPadding = 5.0;
  double styleFieldPaddingSides = 10.0;
  double styleFieldWidthFacing = 90;

  String _selectedDriveStation;
  List<String> _listDriveStation = [
    'none',
  ];
  final List<String> _listRedDriveStations = [
    'Red 1',
    'Red 2',
    'Red 3',
  ];
  final List<String> _listBlueDriveStations = [
    'Blue 1',
    'Blue 2',
    'Blue 3',
  ];

  String _selectedFacing;
  final List<String> _listFacing = ['Own Station', 'Opponent Station'];

  String _selectedRobotPosition;
  final List<String> _listRobotPosition = [
    'Trench',
    'Power Port',
    'Loading',
    'Other',
  ];

  int _selectedTab = 0;

  getDriveStationsByTeam(team) {
    if (team == "Blue") {
      setState(() {
        _selectedDriveStation = null;
        _listDriveStation = _listBlueDriveStations;
      });
    }
    if (team == "Red") {
      setState(() {
        _selectedDriveStation = null;
        _listDriveStation = _listRedDriveStations;
      });
    }
  }

  List unitMemberList;
  List<ScoringData> dataList;

  _getScoringData() async {
    List<ScoringData> list = await localDB.listScoringData();
    setState(() {
      dataList = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    print(width);
    if (width < 500) {
      styleFieldWidth = 111.0;
      styleFieldMatchNumber = 85.0;
      styleFieldAlliance = 75.0;
      styleFieldPadding = 5.0;
      styleFieldPaddingSides = 3.0;
      styleFieldWidthFacing = 154;
    }
    if (width >= 600) {
      styleFieldWidth = 150.0;
      styleFieldMatchNumber = 80.0;
      styleFieldAlliance = 100.0;
      styleFieldPadding = 5.0;
      styleFieldPaddingSides = 10.0;
      styleFieldWidthFacing = 200;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Match Scouting'),
      ),
      body: ListView(
          children: <Widget>[
            FractionallySizedBox(
                widthFactor: 0.99,
                child: Container(
                  margin: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  padding: EdgeInsets.all(4.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Event Name: Testing  Scout: ",
                          style: TextStyle(fontSize: 18),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _txtScoutName,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Scout Name'),
                          ),
                        )
                      ]),
                )),
            FractionallySizedBox(
                widthFactor: 0.99,
                child: Container(
                    margin: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    padding: EdgeInsets.all(styleFieldPadding),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: styleFieldPadding,
                                      horizontal: styleFieldPaddingSides),
                                  width: styleFieldMatchNumber,
                                  child: TextField(
                                    controller: _txtMatchNumber,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    decoration: InputDecoration(
                                      labelText: "Match #",
                                      border: InputBorder.none,
                                      isDense: true,
                                    ),
                                  ),
                                ),
                                //Expanded(
                                //child:
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: styleFieldPadding,
                                      horizontal: styleFieldPaddingSides),
                                  width: styleFieldAlliance,
                                  child: DropdownButtonFormField<String>(
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      labelText: 'Alliance',
                                      border: InputBorder.none,
                                      isDense: true,
                                    ),
                                    value: _selectedAlliance,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        _selectedAlliance = newValue;
                                      });
                                      getDriveStationsByTeam(newValue);
                                      print(_selectedAlliance);
                                    },
                                    items: _listAlliance.map((location) {
                                      return DropdownMenuItem(
                                        child: new Text(location),
                                        value: location,
                                      );
                                    }).toList(),
                                  ),
                                ),
                                // ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: styleFieldPadding,
                                      horizontal: styleFieldPaddingSides),
                                  width: styleFieldWidth,
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'Drive Station',
                                      border: InputBorder.none,
                                      isDense: true,
                                    ),
                                    value: _selectedDriveStation,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        _selectedDriveStation = newValue;
                                      });
                                    },
                                    items: _listDriveStation.map((location) {
                                      return DropdownMenuItem(
                                        child: new Text(location),
                                        value: location,
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: styleFieldPadding,
                                      horizontal: styleFieldPaddingSides),
                                  width: styleFieldWidth,
                                  child: TextField(
                                    controller: _txtScoutName,
                                    decoration: InputDecoration(
                                        labelText: "Team",
                                        border: InputBorder.none,
                                        isDense: true,
                                        hintText: 'Team'),
                                  ),
                                ),
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: styleFieldPadding,
                                      horizontal: styleFieldPaddingSides),
                                  width: styleFieldWidthFacing,
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'Facing',
                                      border: InputBorder.none,
                                      isDense: true,
                                    ),
                                    value: _selectedFacing,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        _selectedFacing = newValue;
                                      });
                                    },
                                    items: _listFacing.map((value) {
                                      return DropdownMenuItem(
                                        child: new Text(value),
                                        value: value,
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: styleFieldPadding,
                                      horizontal: styleFieldPaddingSides),
                                  width: styleFieldWidth,
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'Robot Position',
                                      border: InputBorder.none,
                                      isDense: true,
                                    ),
                                    value: _selectedRobotPosition,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        _selectedRobotPosition = newValue;
                                      });
                                    },
                                    items: _listRobotPosition.map((location) {
                                      return DropdownMenuItem(
                                        child: new Text(location),
                                        value: location,
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: styleFieldPadding,
                                      horizontal: styleFieldPaddingSides),
                                  width: styleFieldWidth,
                                  child: TextField(
                                    controller: _txtStartingCells,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    decoration: InputDecoration(
                                      labelText: "Starting Cells",
                                      border: InputBorder.none,
                                      isDense: true,
                                    ),
                                  ),
                                ),
                              ]),
                        ]))),
            FractionallySizedBox(
                widthFactor: 0.99,
                child: Container(
                  margin: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  padding: EdgeInsets.all(4.0),
                  child: Column(children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Total Robot Failure ",
                            style: TextStyle(fontSize: 18),
                          ),
                          Container(
                            child: Switch(
                              value: false,
                            ),
                          ),
                          Expanded(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    "Yellow Card ",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Container(
                                    child: Switch(
                                      value: false,
                                    ),
                                  ),
                                ]),
                          ),
                        ]),
                    Row(mainAxisAlignment: MainAxisAlignment.end,
                        //crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            "Red Card ",
                            style: TextStyle(fontSize: 18),
                          ),
                          Container(
                            child: Switch(
                              value: false,
                            ),
                          ),
                        ]),
                  ]),
                )),
            FractionallySizedBox(
                widthFactor: 0.99,
                child: Container(
                  margin: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  padding: EdgeInsets.all(4.0),
                  child: Column(children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Operational (Hanging)",
                            style: TextStyle(fontSize: 18),
                          ),
                          Container(
                            child: Switch(
                              value: false,
                            ),
                          ),
                        ]),
                    Row(mainAxisAlignment: MainAxisAlignment.start,
                        //crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            "Energised (Activated)",
                            style: TextStyle(fontSize: 18),
                          ),
                          Container(
                            child: Switch(
                              value: false,
                            ),
                          ),
                        ]),
                  ]),
                )),
            FractionallySizedBox(
                widthFactor: 0.99,
                child: Container(
                  margin: const EdgeInsets.all(5.0),
                  padding: EdgeInsets.all(4.0),
                    child: _showTab(_selectedTab)
                  ),
                ),
          ]),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        currentIndex: _selectedTab, // th
        onTap: (value) {
          setState(() => _selectedTab = value);
        }, // is will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.car_repair),
            label: 'Auto',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.engineering),
            label: 'TeleOp',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Ratings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.save),
            label: 'Finish',
          ),
        ],
      ),
    );
  }

  _showTab(int index) {
    if (index == 0) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: Column(children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            color: Colors.grey,
          ),
          child: Text(
          "Driver Position",
          style: TextStyle(fontSize: 18),
        ),

        ),
          Image.asset('assets/imgs/field.png'),
        ]),
      );
    }
    if (index == 1) {
      return Container(
        child: Column(children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: Colors.grey,
            ),
            child: Text(
              "Power Port",
              style: TextStyle(fontSize: 18),
            ),
          ),
          //Image.asset('assets/imgs/field.png'),
        ]),
      );
    }
    if (index == 2) {
      return Container(
        child: Text(
          "Quick Ratings",
          style: TextStyle(fontSize: 18),
        ),
      );
    }
    if (index == 3) {
      return Container(
        child: Text(
          "Required Fields",
          style: TextStyle(fontSize: 18),
        ),
      );
    }
    else
      {
        return Container(
          child: Text(
            "Other Tab",
            style: TextStyle(fontSize: 18),
          ),
        );
      }
  }

  @override
  void initState() {
    super.initState();
    // Call the getJSONData() method when the app initializes
    _getScoringData();
  }
}
