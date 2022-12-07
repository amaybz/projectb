import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projectb/autotab.dart';
import 'package:projectb/settings.dart';
import 'package:projectb/sharedprefs.dart';
import 'package:projectb/localdb.dart';
import 'dart:async';
import 'package:projectb/teleoptab.dart';
import 'package:projectb/widget_dropdown.dart';
import 'package:projectb/widget_dropdown_indexed.dart';
import 'package:projectb/ratingstab.dart';
import 'package:projectb/finishtab.dart';
import 'package:projectb/class_macthscoutingdata.dart';
import 'dart:io';
import 'package:projectb/googleinterface.dart';

class MatchScoutingScreen extends StatefulWidget {
  MatchScoutingScreen({
    Key? key,
    required this.eventName,
    required this.eventKey,
    this.eventTeams,
    this.styleFontSize = 14,
    this.deviceName,
  }) : super(key: key);

  final String? eventName;
  final String? eventKey;
  final List<LocalTeam>? eventTeams;
  final String? deviceName;
  //style
  final double styleFontSize;

  @override
  _MatchScoutingScreenState createState() => _MatchScoutingScreenState();
}

class _MatchScoutingScreenState extends State<MatchScoutingScreen> {
  LocalDB localDB = LocalDB.instance;
  MySharedPrefs mySharedPrefs = new MySharedPrefs();
  String strWeight = "lbs";
  String strDistance = "Inches";
  //manage save record
  bool recordSaved = false;
  int? recordID;
  int googleUploadStatus = 0;
  GoogleInterface googleInterface = GoogleInterface.instance;
  Color colorFilter = Colors.white;
  bool filterTeams = false;
  int _selectedTab = 0;

  //define text controllers
  final TextEditingController _txtScoutName = TextEditingController();
  final TextEditingController _txtMatchNumber = TextEditingController();

  //final List<String> _listAlliance = ['Red', 'Blue'];
  final List<DropDownValue> _listAlliance = [
    DropDownValue(id: "1", value: "Red"),
    DropDownValue(id: "2", value: "Blue")
  ];

  MatchScoutingData matchScoutingData = MatchScoutingData();

  final List<String> _listStartingCargo = [
    '0',
    '1',
  ];

  //String _selectedFacing;
  //final List<String> _listFacing = ['Own Station', 'Opponent Station'];
  final List<DropDownValue> _listFacing = [
    DropDownValue(id: "1", value: "Own Station"),
    DropDownValue(id: "2", value: "Opponent Station"),
    DropDownValue(id: "3", value: "Other")
  ];

  final List<DropDownValue> _listRobotPosition = [
    DropDownValue(id: "1", value: "N/A"),
    DropDownValue(id: "2", value: "Shared Tarmac"),
    DropDownValue(id: "3", value: "Solo Tarmac"),
  ];

  //style
  double styleFieldWidth = 99.0;
  double styleFieldMatchNumber = 85.0;
  double styleFieldWidthStartingCells = 99.0;
  double styleFieldAlliance = 75.0;
  double styleFieldPadding = 5.0;
  double styleFieldPaddingSides = 10.0;
  double styleFieldWidthFacing = 90;
  double styleFieldWidthTeam = 90;
  double styleImgFieldMapWidth = 90;
  double styleImgFieldPerformanceWidth = 150;
  double styleFieldScoutName = 300;
  double styleFieldTeamMaxWidth = 200;
  double styleCounterButtonHeight = 25;
  double styleCounterButtonWidth = 30;
  double styleFontSizeHeadings = 16;
  double styleRedBoxSize = 300;

  LocalTeam? selectedTeam;
  List<DropdownMenuItem<String>> eventTeamsListDropDown = [];
  List<DropDownValue> listDriveStations = [];

  setEventTeams(double styleFontSize) async {
    //clear current selected event and dropdown box
    setState(() {
      selectedTeam = null;
      matchScoutingData.idTeam = null;
      eventTeamsListDropDown.clear();
    });
    //get events based on location
    if (widget.eventTeams == null) {
      //show no teams
      setState(() {
        eventTeamsListDropDown.add(new DropdownMenuItem(
            value: "0",
            child: Text(
              "NO TEAMS for this EVENT",
              style: TextStyle(fontSize: styleFontSize),
              overflow: TextOverflow.ellipsis,
            )));
      });
    }

    //update dropdown box with Teams
    List<LocalTeam> listMatchTeams = [];
    List<LocalTeam> listAllTeams = widget.eventTeams!;
    List<LocalTeam> listDropDownTeams = [];
    listMatchTeams.clear();

    if (_txtMatchNumber.text != "") {
      List<MatchTeam> matchTeams = await localDB.listMatchTeams();
      print("LocalDB");
      print(matchTeams);
      List<MatchTeam> matchTeamsFiltered = matchTeams
          .where((i) => i.matchNum.toString() == _txtMatchNumber.text)
          .toList();
      print("Filtered");
      print(matchTeamsFiltered);
      for (MatchTeam matchTeam in matchTeamsFiltered) {
        List<LocalTeam> team = widget.eventTeams!
            .where((i) => i.key == matchTeam.teamKey)
            .toList();
        if (team.length > 0) {
          print(team[0].key);
          listMatchTeams.add(LocalTeam(
              key: team[0].key,
              teamNumber: team[0].teamNumber,
              name: team[0].name,
              nickName: team[0].nickName));
        }
      }
    }

    if (filterTeams == true) {
      if (listMatchTeams.length > 0) {
        listDropDownTeams = listMatchTeams;
        print(listMatchTeams);
        colorFilter = Colors.black;
      } else {
        listDropDownTeams = listAllTeams;
        colorFilter = Colors.white;
      }
    } else {
      listDropDownTeams = listAllTeams;
      colorFilter = Colors.white;
    }

    for (LocalTeam team in listDropDownTeams) {
      setState(() {
        eventTeamsListDropDown.add(new DropdownMenuItem(
            value: team.key,
            child: Text(
              team.teamNumber! + " - " + team.nickName!,
              style: TextStyle(fontSize: styleFontSize),
            )));
      });
    }
  }

  void getMetricSystemValue() async {
    bool currentMetricSystem = await mySharedPrefs.readBool("metricSystem");
    print("current Metric System: " + currentMetricSystem.toString());
    if (currentMetricSystem == true) {
      strWeight = "kgs";
      strDistance = "cm";
    } else {
      strWeight = "lbs";
      strDistance = "inches";
    }
    setState(() {
      strWeight = strWeight;
      strDistance = strDistance;
    });
    print("strWeight " + strWeight);
    print("strDistance " + strDistance);
  }

  getDriveStationsByTeam(team, double styleFontSize) {
    if (team == "1") {
      setState(() {
        matchScoutingData.idDriveStation = null;
        listDriveStations.clear();
        listDriveStations.add(DropDownValue(id: "1", value: "Red 1"));
        listDriveStations.add(DropDownValue(id: "2", value: "Red 2"));
        listDriveStations.add(DropDownValue(id: "3", value: "Red 3"));
      });
    }
    if (team == "2") {
      setState(() {
        matchScoutingData.idDriveStation = null;
        listDriveStations.clear();
        listDriveStations.add(DropDownValue(id: "1", value: "Blue 1"));
        listDriveStations.add(DropDownValue(id: "2", value: "Blue 2"));
        listDriveStations.add(DropDownValue(id: "3", value: "Blue 3"));
      });
    }
  }

  showAlertDialogClearMatch(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Clear Data"),
      onPressed: () {
        Navigator.of(context).pop();
        clearMatch();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("WARNING"),
      content: Text("This will clear all data?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertOKDialog(BuildContext context, String heading, String text) {
    // set up the buttons
    Widget okButton = TextButton(
      child: Text("ok"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(heading),
      content: Text(text),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('EXIT?'),
            content: new Text('This will clear the current Match?'),
            actions: <Widget>[
              new TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  void clearMatch() async {
    mySharedPrefs.saveStr("Weight", "lbs");
    mySharedPrefs.readStr("Weight");

    recordSaved = false;
    setState(() {
      //matchScoutingData = MatchScoutingData();
      matchScoutingData = MatchScoutingData();
      _selectedTab = 0;
      //_txtStartingCells.text = '0';
      _txtMatchNumber.text = '0';
      selectedTeam = null;
    });
  }

  Future<bool> saveMatchScout({
    int recordID = 0,
  }) async {
    print("saving record");
    if (recordID > 0) {
      matchScoutingData.id = recordID;
    }
    if (selectedTeam == null) return false;
    if (_txtMatchNumber.text == "") return false;
    matchScoutingData.txDeviceName = widget.deviceName;
    matchScoutingData.txEvent = widget.eventKey;
    matchScoutingData.idTeam = selectedTeam!.teamNumber;
    matchScoutingData.numMatch = int.parse(_txtMatchNumber.text);
    matchScoutingData.txScoutName = _txtScoutName.text;
    this.recordID = await localDB.insertScoringData(matchScoutingData);
    if (this.recordID! > 0) {
      recordSaved = true;
      print("Record Saved: " + recordSaved.toString());
      print("Record ID: " + this.recordID.toString());
      return true;
    } else {
      recordSaved = false;
      print("ERROR Saving Record: " + recordSaved.toString());
      return false;
    }
  }

  void handleMenuClick(String value) async {
    switch (value) {
      case 'Clear Match':
        print("clear Match Selected");
        showAlertDialogClearMatch(context);
        break;
      case 'Settings':
        print("Settings Selected");
        _navigateToSettings(context);
        break;
    }
  }

  _navigateToSettings(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => SettingsScreen()),
    );
    getMetricSystemValue();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    print("Screen Size: " + width.toString());
    styleFieldTeamMaxWidth = width - 120;
    if (width < 500) {
      styleFieldWidth = 111.0;
      styleFieldMatchNumber = 80.0;
      styleFieldAlliance = 75.0;
      styleFieldPadding = 3.0;
      styleFieldPaddingSides = 3.0;
      styleFieldWidthFacing = 140;
      styleImgFieldMapWidth = 250;
      styleFieldWidthTeam = 300;
      styleFontSizeHeadings = 15;
      styleRedBoxSize = 180;
      styleCounterButtonHeight = 35;
      styleCounterButtonWidth = 40;
    }
    if (width < 393) {
      setState(() {
        styleFieldWidth = 100.0;
        styleFieldMatchNumber = 80.0;
        styleFieldAlliance = 75.0;
        styleFieldPadding = 2.0;
        styleFieldPaddingSides = 2.0;
        styleFieldWidthFacing = 140;
        styleImgFieldMapWidth = 250;
        styleFieldWidthTeam = 210;

        styleFontSizeHeadings = 15;
        styleRedBoxSize = 180;
        styleCounterButtonHeight = 25;
        styleCounterButtonWidth = 30;
      });
    }
    if (width >= 600) {
      styleFontSizeHeadings = 15;
      styleFieldWidth = 150.0;
      styleFieldMatchNumber = 80.0;
      styleFieldAlliance = 100.0;
      styleFieldPadding = 3.0;
      styleFieldPaddingSides = 10.0;
      styleFieldWidthFacing = 190;
      styleImgFieldMapWidth = 400;
      styleFieldWidthTeam = 400;
      styleImgFieldPerformanceWidth = 200;
      styleFieldWidthStartingCells = 150;
      styleCounterButtonHeight = 35;
      styleCounterButtonWidth = 40;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(title: Text('Match Scouting'), actions: <Widget>[
          PopupMenuButton<String>(
              onSelected: handleMenuClick,
              itemBuilder: (BuildContext context) {
                return {'Clear Match', 'Settings'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              }),
        ]),
        body: ListView(children: <Widget>[
          FractionallySizedBox(
            widthFactor: 0.99,
            child: Center(
              child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 800.0),
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
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Event Name: " + widget.eventName!,
                                style:
                                    TextStyle(fontSize: widget.styleFontSize),
                              ),
                            ]),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: styleFieldPadding,
                              horizontal: styleFieldPaddingSides),
                          width: styleFieldScoutName,
                          height: 50,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Scout Name: ",
                                  style:
                                      TextStyle(fontSize: widget.styleFontSize),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: _txtScoutName,
                                    style: TextStyle(
                                        fontSize: widget.styleFontSize),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Scout Name',
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: styleFieldPadding,
                                horizontal: styleFieldPaddingSides),
                            width: styleFieldMatchNumber,
                            height: 58,
                            child: TextField(
                              style: TextStyle(fontSize: widget.styleFontSize),
                              controller: _txtMatchNumber,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onEditingComplete: () {
                                if (filterTeams == true) {
                                  setEventTeams(widget.styleFontSize);
                                }
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              decoration: InputDecoration(
                                labelText: "Match #",
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
                          //Expanded(
                          //child:
                          DropDownIndexedWidget(
                              value: matchScoutingData.idAlliance,
                              title: "Alliance",
                              dropDownValues: _listAlliance,
                              styleFontSize: widget.styleFontSize,
                              styleFieldWidth: styleFieldAlliance,
                              styleFieldPadding: styleFieldPadding,
                              styleFieldPaddingSides: styleFieldPaddingSides,
                              onStateChanged: (String newValue) {
                                setState(() {
                                  matchScoutingData.idAlliance = newValue;
                                });
                                getDriveStationsByTeam(
                                    newValue, widget.styleFontSize);
                                print(matchScoutingData.idAlliance);
                              }),

                          DropDownIndexedWidget(
                              value: matchScoutingData.idDriveStation,
                              title: "Drive Station",
                              dropDownValues: listDriveStations,
                              styleFontSize: widget.styleFontSize,
                              styleFieldWidth: styleFieldWidth,
                              styleFieldPadding: styleFieldPadding,
                              styleFieldPaddingSides: styleFieldPaddingSides,
                              onStateChanged: (String newValue) {
                                setState(() {
                                  matchScoutingData.idDriveStation = newValue;
                                  print(matchScoutingData.idDriveStation);
                                });
                              }),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Team ",
                            style: TextStyle(fontSize: widget.styleFontSize),
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                                maxHeight: 200,
                                maxWidth: styleFieldTeamMaxWidth),
                            child: DropdownButton(
                              isExpanded: true,
                              isDense: true,
                              value: selectedTeam == null
                                  ? null
                                  : selectedTeam!.key,
                              //title: "Team",
                              items: eventTeamsListDropDown,
                              onChanged: (item) {
                                setState(() {
                                  selectedTeam = widget.eventTeams!.firstWhere(
                                      (team) => team.key == item,
                                      orElse: () => widget.eventTeams!.first);
                                });
                                print("Key: " + selectedTeam!.key!);
                              },
                            ),
                          ),
                          SizedBox.fromSize(
                            size: Size(30, 30),
                            child: ClipOval(
                              child: Material(
                                color: Colors.amberAccent,
                                child: InkWell(
                                  splashColor: Colors.green,
                                  onTap: () {
                                    filterTeams == true
                                        ? filterTeams = false
                                        : filterTeams = true;
                                    setEventTeams(widget.styleFontSize);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.filter_alt,
                                        color: colorFilter,
                                      ), // <-- Icon// <-- Text
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          DropDownIndexedWidget(
                              value: matchScoutingData.idStartFacing,
                              title: "Facing",
                              dropDownValues: _listFacing,
                              styleFontSize: widget.styleFontSize,
                              styleFieldWidth: styleFieldWidthFacing,
                              onStateChanged: (String newValue) {
                                FocusScope.of(context).unfocus();
                                setState(() {
                                  matchScoutingData.idStartFacing = newValue;
                                });
                              }),
                          DropDownIndexedWidget(
                              value: matchScoutingData.idStartPosition,
                              title: "Robot Position",
                              dropDownValues: _listRobotPosition,
                              styleFontSize: widget.styleFontSize,
                              styleFieldWidth: styleFieldWidth,
                              styleFieldPadding: styleFieldPadding,
                              styleFieldPaddingSides: styleFieldPaddingSides,
                              onStateChanged: (String newValue) {
                                setState(() {
                                  matchScoutingData.idStartPosition = newValue;
                                });
                              }),
                          DropDownWidget(
                              value: matchScoutingData.numStartCargo,
                              title: "Starting Cargo",
                              list: _listStartingCargo,
                              styleFontSize: widget.styleFontSize,
                              styleFieldWidth: styleFieldWidthStartingCells,
                              styleFieldPadding: styleFieldPadding,
                              styleFieldPaddingSides: styleFieldPaddingSides,
                              onStateChanged: (String newValue) {
                                setState(() {
                                  matchScoutingData.numStartCargo = newValue;
                                });
                              }),
                        ]),
                  ]),
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.99,
            child: Container(
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                //border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              padding: EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      left: 0.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(0)),
                    ),
                    constraints: BoxConstraints.expand(
                        width: styleRedBoxSize, height: 160.0),
                    padding: EdgeInsets.all(4.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Total Failure ",
                                    style: TextStyle(
                                        fontSize: widget.styleFontSize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Switch(
                                    value: matchScoutingData.flCrash!,
                                    onChanged: (bool value) {
                                      setState(() {
                                        matchScoutingData.flCrash = value;
                                      });
                                    },
                                  ),
                                ]),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Yellow Card ",
                                  style: TextStyle(
                                      fontSize: widget.styleFontSize,
                                      fontWeight: FontWeight.bold),
                                ),
                                Switch(
                                  value: matchScoutingData.flYellow!,
                                  onChanged: (bool value) {
                                    setState(() {
                                      matchScoutingData.flYellow = value;
                                    });
                                  },
                                ),
                              ]),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Red Card ",
                                  style: TextStyle(
                                      fontSize: widget.styleFontSize,
                                      fontWeight: FontWeight.bold),
                                ),
                                Switch(
                                  value: matchScoutingData.flRed!,
                                  onChanged: (bool value) {
                                    setState(() {
                                      matchScoutingData.flRed = value;
                                    });
                                  },
                                ),
                              ]),
                        ]),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 5.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        color: Colors.green,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(10)),
                      ),
                      constraints: BoxConstraints.expand(height: 160.0),
                      padding: EdgeInsets.all(4.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "RP #1",
                                    style: TextStyle(
                                        fontSize: widget.styleFontSize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    child: Switch(
                                      value: matchScoutingData.flRanking1!,
                                      onChanged: (bool value) {
                                        setState(() {
                                          matchScoutingData.flRanking1 = value;
                                        });
                                      },
                                    ),
                                  ),
                                ]),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                //crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    "RP #2",
                                    style: TextStyle(
                                        fontSize: widget.styleFontSize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    child: Switch(
                                      value: matchScoutingData.flRanking2!,
                                      onChanged: (bool value) {
                                        setState(() {
                                          matchScoutingData.flRanking2 = value;
                                        });
                                      },
                                    ),
                                  ),
                                ]),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.all(0.0),
              padding: EdgeInsets.all(0.0),
              child: _showTab(_selectedTab)),
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
      ),
    );
  }

  _showTab(int index) {
    if (index == 0) {
      return AutoTab(
        styleImgFieldPerformanceWidth: styleImgFieldPerformanceWidth,
        styleCounterButtonWidth: styleCounterButtonWidth,
        styleCounterButtonHeight: styleCounterButtonHeight,
        matchScoutingData: matchScoutingData,
        styleImgFieldMapWidth: styleImgFieldMapWidth,
        onChanged: (MatchScoutingData updates) {
          setState(() {
            matchScoutingData = updates;
          });
        },
        onLoseStartObjectChange: (bool value) {
          //save values
          setState(() {
            matchScoutingData.autoFlLoseStartObject = value;
          });
        },
        onContactWithRobotChange: (bool value) {
          //save values
          setState(() {
            matchScoutingData.autoFlRobotContact = value;
          });
        },
        onCrossSectorChange: (bool value) {
          //save values
          setState(() {
            matchScoutingData.autoFlCrossOver = value;
          });
        },
        onFoulChange: (bool value) {
          //save values
          setState(() {
            matchScoutingData.autoFlFoul = value;
          });
        },
      );
    }
    if (index == 1) {
      return TeleOpScreen(
        matchScoutingData: matchScoutingData,
        styleCounterButtonWidth: styleCounterButtonWidth,
        styleCounterButtonHeight: styleCounterButtonHeight,
        onCellAttemptsChanged: (int value) {
          setState(() {
            matchScoutingData.teleNumCargoHighAttempt = value;
          });
        },
        onCellSuccessChanged: (int value) {
          setState(() {
            matchScoutingData.teleNumCargoHighSuccess = value;
          });
          print(matchScoutingData.teleNumCargoHighSuccess);
        },
        onEndgameClimbChanged: (MatchScoutingData value) {
          matchScoutingData = value;
        },
        onEndgameFallChanged: (bool value) {
          setState(() {
            matchScoutingData.teleFlClimbFall = value;
          });
        },
        onChange: (MatchScoutingData updatedData) {
          setState(() {
            matchScoutingData = updatedData;
          });
        },
      );
    }
    if (index == 2) {
      return Container(
        child: RatingsTab(
          matchScoutingData: matchScoutingData,
          styleFontSize: widget.styleFontSize,
          styleFontSizeHeadings: styleFontSizeHeadings,
          onChange: (updates) {
            setState(() {
              matchScoutingData = updates;
            });
          },
          onShootingWallZoneChanged: (bool value) {
            //Update Value
            setState(() {
              matchScoutingData.commFlShotWall = value;
            });
          },
          onShootingNearZoneChanged: (bool value) {
            //Update Value
            setState(() {
              matchScoutingData.commFlShotNear = value;
            });
          },
          onShootingMidZoneChanged: (bool value) {
            //Update Value
            setState(() {
              matchScoutingData.commFlShotMid = value;
            });
          },
          onShootingFarZoneChanged: (bool value) {
            //Update Value
            setState(() {
              matchScoutingData.commFlShotFar = value;
            });
          },
          onOtherRobotChanged: (bool value) {
            //Update Value
            setState(() {
              matchScoutingData.commFlIntakeRobot = value;
            });
          },
          onHighIntakeChanged: (bool value) {
            //Update Value
            setState(() {
              matchScoutingData.commFlIntakeHigh = value;
            });
          },
          onGroundIntakeChanged: (bool value) {
            //Update Value
            setState(() {
              matchScoutingData.commFlIntakeGround = value;
            });
          },
          onAssistOtherRobotChanged: (bool value) {
            //Update Value
            setState(() {
              matchScoutingData.commFlAssist = value;
            });
          },
          onSelectedDriveRatingChanged: (String value) {
            //Update Value
            setState(() {
              matchScoutingData.commIdDriveRating = value;
            });
          },
          onSelectedDefenceRatingChanged: (String value) {
            //Update Value
            setState(() {
              matchScoutingData.commIdDefenceRating = value;
            });
          },
          onRecoveredChanged: (bool value) {
            //Update Value
            setState(() {
              matchScoutingData.commFlRecovery = value;
            });
          },
          onNoTeamWorkChanged: (bool value) {
            //Update Value
            setState(() {
              matchScoutingData.commFlOwnThing = value;
            });
          },
          onWorkedToStrategyChanged: (bool value) {
            //Update Value
            setState(() {
              matchScoutingData.commFlStrategy = value;
            });
          },
          onWarningChanged: (bool value) {
            //Update Value
            setState(() {
              matchScoutingData.commFlWarning = value;
            });
          },
          onHighlightTeamChanged: (bool value) {
            //Update Value
            setState(() {
              matchScoutingData.commFlHighlight = value;
            });
          },
          onCommentsChanged: (String value) {
            //Update Value
            setState(() {
              matchScoutingData.commTxNotes = value;
            });
          },
        ),
      );
    }
    if (index == 3) {
      return FinishTab(
        googleUploadStatus: googleUploadStatus,
        onSavePressed: (bool value) async {
          if (recordSaved == true) {
            await saveMatchScout(recordID: recordID!);
          } else {
            await saveMatchScout();
          }
          String alertMsg;
          alertMsg = (recordSaved == true)
              ? "Match has been saved to Local Database"
              : "FAILED to Save Record: The following fields must be filled in: Team, Match#";
          showAlertOKDialog(context, "Saved", alertMsg);
        },
        onUploadToGoogle: (bool value) {
          if (recordSaved == true) {
            saveMatchScout(recordID: recordID!);
          } else {
            saveMatchScout();
          }
          _uploadDataToGoogleDrive(matchScoutingData);
        },
      );
    } else {
      return Container(
        child: Text(
          "HOW did you get HERE?????",
          style: TextStyle(fontSize: 18),
        ),
      );
    }
  }

  _uploadDataToGoogleDrive(MatchScoutingData matchScoutingData) async {
    setState(() {
      googleUploadStatus = 1;
    });
    File file =
        await googleInterface.uploadMatchScoutingData(matchScoutingData);
    await file.length();
    setState(() {
      googleUploadStatus = 2;
    });
  }

  @override
  void initState() {
    super.initState();
    // Call the getJSONData() method when the app initializes
    //_getScoringData();
    setEventTeams(widget.styleFontSize);
    getMetricSystemValue();
  }
}
