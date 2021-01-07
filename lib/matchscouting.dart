import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:projectb/autotab.dart';
import 'package:projectb/sharedprefs.dart';
import 'package:projectb/localdb.dart';
import 'dart:async';
import 'package:projectb/teleoptab.dart';
import 'package:projectb/dropdown_widget.dart';
import 'package:projectb/ratingstab.dart';
import 'package:projectb/webapi.dart';
import 'package:projectb/finishtab.dart';
import 'package:projectb/localdb.dart';

class MatchScoutingScreen extends StatefulWidget {
  MatchScoutingScreen({
    Key key,
    @required this.eventName,
    @required this.eventKey,
    this.eventTeams,
  }) : super(key: key);

  final String eventName;
  final String eventKey;
  final List<TeamsList> eventTeams;

  @override
  _MatchScoutingScreenState createState() => _MatchScoutingScreenState();
}

class _MatchScoutingScreenState extends State<MatchScoutingScreen> {
  LocalDB localDB = LocalDB.instance;
  MySharedPrefs mySharedPrefs = new MySharedPrefs();
  final TextEditingController _txtScoutName = TextEditingController();
  final TextEditingController _txtMatchNumber = TextEditingController();
  final TextEditingController _txtStartingCells = TextEditingController();

  final List<String> _listAlliance = ['Red', 'Blue'];

  String _selectedAlliance;
  String _selectedDriveStation;

  //variables to control switchs
  bool _selectedRobotFail = false;
  bool _selectedYellowCard = false;
  bool _selectedRedCard = false;
  bool _selectedOperational = false;
  bool _selectedEnergised = false;

  //autotab variables
  bool _selectedLoseStartObject = false;
  bool _selectedContactWithRobot = false;
  bool _selectedCrossSector = false;
  bool _selectedFoul = false;
  bool _selectedDoesAuto = false;
  bool _selectedLeaveLine = false;

  //Ratings Tab variables
  bool _assistOtherRobot = false;
  bool _workedWithAlliance = false;
  bool _workedToStrategy = false;
  bool _recovered = false;
  bool _noTeamWork = false;
  bool _highIntake = false;
  bool _groundIntake = false;
  bool _otherRobot = false;
  bool _shootingWall = false;
  bool _shootingNearZone = false;
  bool _shootingMidZone = false;
  bool _shootingFarZone = false;
  String _selectedDriveRating;
  String _selectedDefenceRating;

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

  //style
  double styleFieldWidth = 99.0;
  double styleFieldMatchNumber = 85.0;
  double styleFieldAlliance = 75.0;
  double styleFieldPadding = 5.0;
  double styleFieldPaddingSides = 10.0;
  double styleFieldWidthFacing = 90;
  double styleFieldWidthTeam = 90;
  double styleImgFieldWidth = 90;
  double styleFontSizeBody = 18;
  double styleRedBoxSize = 300;

  TeamsList selectedTeam;
  List<DropdownMenuItem<String>> eventTeamsListDropDown = [];

  setEventTeams(double styleFontSize) async {
    //clear current selected event and dropdown box
    setState(() {
      selectedTeam = null;
      eventTeamsListDropDown.clear();
    });
    //get events based on location
    if (widget.eventTeams == null) {
      //get teams here

    }

    //update dropdown box with the new events
    for (TeamsList team in widget.eventTeams) {
      setState(() {
        eventTeamsListDropDown.add(new DropdownMenuItem(
            value: team.key,
            child: Text(
              team.teamNumber.toString() + " - " + team.nickname,
              style: TextStyle(fontSize: styleFontSize),
            )));
      });
    }
  }

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

  List<ScoringData> dataList;

  _getScoringData() async {
    List<ScoringData> list = await localDB.listScoringData();
    setState(() {
      dataList = list;
    });
  }

  showAlertDialogClearMatch(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
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

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('EXIT?'),
            content: new Text('This will clear the current Match?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  void clearMatch() async {
    mySharedPrefs.saveInt("CellAttempts", 0);
    mySharedPrefs.saveInt("CellSuccess", 0);
    mySharedPrefs.saveInt("PenalAttempts", 0);
    mySharedPrefs.saveInt("PenalSuccess", 0);
    mySharedPrefs.saveInt("intBuddies", 0);
    mySharedPrefs.saveBool("selectedLower", false);
    mySharedPrefs.saveBool("selectedOuter", false);
    mySharedPrefs.saveBool("selectedInner", false);
    mySharedPrefs.saveBool("selectedRotationControl", false);
    mySharedPrefs.saveBool("selectedPositionControl", false);
    mySharedPrefs.saveBool("selectedPark", false);
    mySharedPrefs.saveBool("selectedBalance", false);
    mySharedPrefs.saveBool("selectedBalanceCorrection", false);
    mySharedPrefs.saveBool("selectedFall", false);
    setState(() {
      _selectedDriveStation = null;
      _selectedDriveStation = null;
      _selectedTab = 0;
      _selectedRobotPosition = null;
      _selectedFacing = null;
      _selectedDriveRating = null;
      _selectedDefenceRating = null;
      selectedTeam = null;
      _selectedAlliance = null;
      _txtStartingCells.text = '0';
      _txtMatchNumber.text = '0';
      _selectedRobotFail = false;
      _selectedYellowCard = false;
      _selectedRedCard = false;
      _selectedOperational = false;
      _selectedEnergised = false;
      _selectedLoseStartObject = false;
      _selectedContactWithRobot = false;
      _selectedCrossSector = false;
      _selectedFoul = false;
      _selectedLeaveLine = false;
      _selectedDoesAuto = false;
      _assistOtherRobot = false;
      _workedWithAlliance = false;
      _workedToStrategy = false;
      _recovered = false;
      _noTeamWork = false;
      _groundIntake = false;
      _highIntake = false;
      _otherRobot = false;
      _shootingWall = false;
      _shootingNearZone = false;
      _shootingMidZone = false;
      _shootingFarZone = false;
    });
  }

  void saveMatchScout() async {
    print("save record");
    ScoringData scoringData = ScoringData(
      id: 1,
      team: selectedTeam.key,
      scoutName: _txtScoutName.text,
      matchNumber: int.parse(_txtMatchNumber.text),
      alliance: _selectedAlliance,
      driveStation: _selectedDriveStation,
      facing: _selectedFacing,
      robotPosition: _selectedRobotPosition,
      startingCells: int.parse(_txtStartingCells.text)
    );
    localDB.insertScoringData(scoringData);

    //END TESTING CODE
  }

  void handleMenuClick(String value) async {
    switch (value) {
      case 'Clear Match':
        print("clear Match Selected");
        showAlertDialogClearMatch(context);
        break;
      case 'Settings':
        print("Settings Selected");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    print(width);
    if (width < 500) {
      styleFieldWidth = 111.0;
      styleFieldMatchNumber = 80.0;
      styleFieldAlliance = 75.0;
      styleFieldPadding = 3.0;
      styleFieldPaddingSides = 3.0;
      styleFieldWidthFacing = 140;
      styleImgFieldWidth = 250;
      styleFieldWidthTeam = 300;
      styleFontSizeBody = 12;
      styleRedBoxSize = 180;
    }
    if (width >= 600) {
      styleFieldWidth = 150.0;
      styleFieldMatchNumber = 80.0;
      styleFieldAlliance = 100.0;
      styleFieldPadding = 3.0;
      styleFieldPaddingSides = 10.0;
      styleFieldWidthFacing = 200;
      styleImgFieldWidth = 400;
      styleFieldWidthTeam = 400;
      styleFontSizeBody = 16;
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
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Event Name: " + widget.eventName,
                            style: TextStyle(fontSize: styleFontSizeBody),
                          ),
                          Text(
                            " - Scout: ",
                            style: TextStyle(fontSize: styleFontSizeBody),
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
                              style: TextStyle(fontSize: styleFontSizeBody),
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
                          DropDownWidget(
                              value: _selectedAlliance,
                              title: "Alliance",
                              list: _listAlliance,
                              styleFontSize: styleFontSizeBody,
                              styleFieldWidth: styleFieldAlliance,
                              styleFieldPadding: styleFieldPadding,
                              styleFieldPaddingSides: styleFieldPaddingSides,
                              onStateChanged: (String newValue) {
                                setState(() {
                                  _selectedAlliance = newValue;
                                });
                                getDriveStationsByTeam(newValue);
                                print(_selectedAlliance);
                              }),

                          DropDownWidget(
                              value: _selectedDriveStation,
                              title: "Drive Station",
                              list: _listDriveStation,
                              styleFontSize: styleFontSizeBody,
                              styleFieldWidth: styleFieldWidth,
                              styleFieldPadding: styleFieldPadding,
                              styleFieldPaddingSides: styleFieldPaddingSides,
                              onStateChanged: (String newValue) {
                                setState(() {
                                  _selectedDriveStation = newValue;
                                });
                              }),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Team ",
                            style: TextStyle(fontSize: styleFontSizeBody),
                          ),
                          DropdownButton(
                            value:
                                selectedTeam == null ? null : selectedTeam.key,
                            //title: "Team",
                            items: eventTeamsListDropDown,
                            onChanged: (item) {
                              setState(() {
                                selectedTeam = widget.eventTeams.firstWhere(
                                    (team) => team.key == item,
                                    orElse: () => widget.eventTeams.first);
                              });
                              print("Key: " + selectedTeam.key);
                            },
                            //styleFontSize: styleFontSizeBody,
                            //styleFieldWidth: styleFieldWidthTeam,
                            //styleFieldPadding: styleFieldPadding,
                            //styleFieldPaddingSides: styleFieldPaddingSides,
                          ),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          DropDownWidget(
                              value: _selectedFacing,
                              title: "Facing",
                              list: _listFacing,
                              styleFontSize: styleFontSizeBody,
                              styleFieldWidth: styleFieldWidthFacing,
                              onStateChanged: (String newValue) {
                                setState(() {
                                  _selectedFacing = newValue;
                                });
                              }),
                          DropDownWidget(
                              value: _selectedRobotPosition,
                              title: "Robot Position",
                              list: _listRobotPosition,
                              styleFontSize: styleFontSizeBody,
                              styleFieldWidth: styleFieldWidth,
                              styleFieldPadding: styleFieldPadding,
                              styleFieldPaddingSides: styleFieldPaddingSides,
                              onStateChanged: (String newValue) {
                                setState(() {
                                  _selectedRobotPosition = newValue;
                                });
                              }),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: styleFieldPadding,
                                horizontal: styleFieldPaddingSides),
                            width: styleFieldWidth,
                            child: TextField(
                              style: TextStyle(fontSize: styleFontSizeBody),
                              controller: _txtStartingCells,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                labelText: "Starting Cells",
                                labelStyle:
                                    TextStyle(fontSize: styleFontSizeBody),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                            ),
                          ),
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
                                    "Total Robot Failure ",
                                    style: TextStyle(
                                        fontSize: styleFontSizeBody,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Switch(
                                    value: _selectedRobotFail,
                                    onChanged: (bool value) {
                                      setState(() {
                                        _selectedRobotFail = value;
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
                                      fontSize: styleFontSizeBody,
                                      fontWeight: FontWeight.bold),
                                ),
                                Switch(
                                  value: _selectedYellowCard,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _selectedYellowCard = value;
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
                                      fontSize: styleFontSizeBody,
                                      fontWeight: FontWeight.bold),
                                ),
                                Switch(
                                  value: _selectedRedCard,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _selectedRedCard = value;
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
                                    "Operational (Hanging)",
                                    style: TextStyle(
                                        fontSize: styleFontSizeBody,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    child: Switch(
                                      value: _selectedOperational,
                                      onChanged: (bool value) {
                                        setState(() {
                                          _selectedOperational = value;
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
                                    "Energised (Activated)",
                                    style: TextStyle(
                                        fontSize: styleFontSizeBody,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    child: Switch(
                                      value: _selectedEnergised,
                                      onChanged: (bool value) {
                                        setState(() {
                                          _selectedEnergised = value;
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
        styleImgFieldWidth: styleImgFieldWidth,
        boolLoseStartObject: _selectedLoseStartObject,
        boolContactWithRobot: _selectedContactWithRobot,
        boolCrossSector: _selectedCrossSector,
        boolFoul: _selectedFoul,
        boolDoesAuto: _selectedDoesAuto,
        boolLeaveLine: _selectedLeaveLine,
        onLoseStartObjectChange: (bool value) {
          //save values
          setState(() {
            _selectedLoseStartObject = value;
          });
        },
        onContactWithRobotChange: (bool value) {
          //save values
          setState(() {
            _selectedContactWithRobot = value;
          });
        },
        onCrossSectorChange: (bool value) {
          //save values
          setState(() {
            _selectedCrossSector = value;
          });
        },
        onFoulChange: (bool value) {
          //save values
          setState(() {
            _selectedFoul = value;
          });
        },
        onDoesAutoChange: (bool value) {
          //save values
          setState(() {
            _selectedDoesAuto = value;
          });
        },
        onLeaveLineChange: (bool value) {
          //save values
          setState(() {
            _selectedLeaveLine = value;
          });
        },
      );
    }
    if (index == 1) {
      return TeleOpScreen();
    }
    if (index == 2) {
      return Container(
        child: RatingsTab(
          assistOtherRobot: _assistOtherRobot,
          selectedDriveRating: _selectedDriveRating,
          selectedDefenceRating: _selectedDefenceRating,
          workedWithAlliance: _workedWithAlliance,
          workedToStrategy: _workedToStrategy,
          recovered: _recovered,
          noTeamWork: _noTeamWork,
          highIntake: _highIntake,
          groundIntake: _groundIntake,
          otherRobot: _otherRobot,
          shootingFarZone: _shootingFarZone,
          shootingMidZone: _shootingMidZone,
          shootingNearZone: _shootingNearZone,
          shootingWall: _shootingWall,
          onShootingWallZoneChanged: (bool value) {
            //Update Value
            setState(() {
              _shootingWall = value;
            });
          },
          onShootingNearZoneChanged: (bool value) {
            //Update Value
            setState(() {
              _shootingNearZone = value;
            });
          },
          onShootingMidZoneChanged: (bool value) {
            //Update Value
            setState(() {
              _shootingMidZone = value;
            });
          },
          onShootingFarZoneChanged: (bool value) {
            //Update Value
            setState(() {
              _shootingFarZone = value;
            });
          },
          onOtherRobotChanged: (bool value) {
            //Update Value
            setState(() {
              _otherRobot = value;
            });
          },
          onHighIntakeChanged: (bool value) {
            //Update Value
            setState(() {
              _highIntake = value;
            });
          },
          onGroundIntakeChanged: (bool value) {
            //Update Value
            setState(() {
              _groundIntake = value;
            });
          },
          onAssistOtherRobotChanged: (bool value) {
            //Update Value
            setState(() {
              _assistOtherRobot = value;
            });
          },
          onSelectedDriveRatingChanged: (String value) {
            //Update Value
            setState(() {
              _selectedDriveRating = value;
            });
          },
          onSelectedDefenceRatingChanged: (String value) {
            //Update Value
            setState(() {
              _selectedDefenceRating = value;
            });
          },
          onRecoveredChanged: (bool value) {
            //Update Value
            setState(() {
              _recovered = value;
            });
          },
          onNoTeamWorkChanged: (bool value) {
            //Update Value
            setState(() {
              _noTeamWork = value;
            });
          },
          onWorkedToStrategyChanged: (bool value) {
            //Update Value
            setState(() {
              _workedToStrategy = value;
            });
          },
          onWorkedWithAllianceChanged: (bool value) {
            //Update Value
            setState(() {
              _workedWithAlliance = value;
            });
          },
        ),
      );
    }
    if (index == 3) {
      return FinishTab(
        onSavePressed: (bool value) {
          saveMatchScout();

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

  @override
  void initState() {
    super.initState();
    // Call the getJSONData() method when the app initializes
    _getScoringData();
    setEventTeams(14);
  }
}

