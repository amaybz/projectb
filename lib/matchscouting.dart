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
import 'package:projectb/widget_dropdown.dart';
import 'package:projectb/ratingstab.dart';
import 'package:projectb/finishtab.dart';

class MatchScoutingScreen extends StatefulWidget {
  MatchScoutingScreen({
    Key key,
    @required this.eventName,
    @required this.eventKey,
    this.eventTeams,
  }) : super(key: key);

  final String eventName;
  final String eventKey;
  final List<LocalTeam> eventTeams;

  @override
  _MatchScoutingScreenState createState() => _MatchScoutingScreenState();
}

class _MatchScoutingScreenState extends State<MatchScoutingScreen> {
  LocalDB localDB = LocalDB.instance;
  MySharedPrefs mySharedPrefs = new MySharedPrefs();

  //manage save record
  bool recordSaved = false;
  int recordID;

  int _selectedTab = 0;

  //define text controllers
  final TextEditingController _txtScoutName = TextEditingController();
  final TextEditingController _txtMatchNumber = TextEditingController();
  final TextEditingController _txtStartingCells = TextEditingController();

  final List<String> _listAlliance = ['Red', 'Blue'];

  MatchScoutingData matchScoutingData = MatchScoutingData( );


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

  //String _selectedFacing;
  final List<String> _listFacing = ['Own Station', 'Opponent Station'];

  //String _selectedRobotPosition;
  final List<String> _listRobotPosition = [
    'Trench',
    'Power Port',
    'Loading',
    'Other',
  ];

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
  double styleFontSizeHeadings = 18;
  double styleRedBoxSize = 300;

  LocalTeam selectedTeam;
  List<DropdownMenuItem<String>> eventTeamsListDropDown = [];

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
            )));
      });
    }

    //update dropdown box with Teams
    for (LocalTeam team in widget.eventTeams) {
      setState(() {
        eventTeamsListDropDown.add(new DropdownMenuItem(
            value: team.key,
            child: Text(
              team.teamNumber + " - " + team.nickName,
              style: TextStyle(fontSize: styleFontSize),
            )));
      });
    }
  }

  getDriveStationsByTeam(team) {
    if (team == "Blue") {
      setState(() {
        matchScoutingData.idDriveStation = null;
        _listDriveStation = _listBlueDriveStations;
      });
    }
    if (team == "Red") {
      setState(() {
        matchScoutingData.idDriveStation = null;
        _listDriveStation = _listRedDriveStations;
      });
    }
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

  showAlertOKDialog(BuildContext context, String heading, String text) {
    // set up the buttons
    Widget okButton = FlatButton(
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
    recordSaved = false;
    setState(() {
      matchScoutingData = null;
      matchScoutingData = MatchScoutingData();
      _selectedTab = 0;
      _txtStartingCells.text = '0';
      _txtMatchNumber.text = '0';
      selectedTeam = null;

    });
  }

  void saveMatchScout({
    int recordID = 0,
  }) async {
    print("saving record");
    if (recordID > 0) {
      matchScoutingData.id = recordID;
    }
    matchScoutingData.txEvent = widget.eventKey;
    matchScoutingData.idTeam = selectedTeam.teamNumber;
    matchScoutingData.numMatch = int.parse(_txtMatchNumber.text);
    matchScoutingData.numStartCells = int.parse(_txtStartingCells.text);
    matchScoutingData.txScoutName = _txtScoutName.text;
    this.recordID = await localDB.insertScoringData(matchScoutingData);
    if (this.recordID > 0) {
      recordSaved = true;
    }
    print("Record Saved: " + recordSaved.toString());
    print("Record ID: " + this.recordID.toString());
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
    print("Screen Size: " + width.toString());

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
      styleFontSizeHeadings = 16;
      styleRedBoxSize = 180;
    }
    if (width < 395) {
      styleFieldWidth = 100.0;
      styleFieldMatchNumber = 80.0;
      styleFieldAlliance = 75.0;
      styleFieldPadding = 2.0;
      styleFieldPaddingSides = 2.0;
      styleFieldWidthFacing = 140;
      styleImgFieldWidth = 250;
      styleFieldWidthTeam = 250;
      styleFontSizeBody = 11;
      styleFontSizeHeadings = 16;
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
                              value: matchScoutingData.idAlliance,
                              title: "Alliance",
                              list: _listAlliance,
                              styleFontSize: styleFontSizeBody,
                              styleFieldWidth: styleFieldAlliance,
                              styleFieldPadding: styleFieldPadding,
                              styleFieldPaddingSides: styleFieldPaddingSides,
                              onStateChanged: (String newValue) {
                                setState(() {
                                  matchScoutingData.idAlliance = newValue;
                                });
                                getDriveStationsByTeam(newValue);
                                print(matchScoutingData.idAlliance);
                              }),

                          DropDownWidget(
                              value: matchScoutingData.idDriveStation,
                              title: "Drive Station",
                              list: _listDriveStation,
                              styleFontSize: styleFontSizeBody,
                              styleFieldWidth: styleFieldWidth,
                              styleFieldPadding: styleFieldPadding,
                              styleFieldPaddingSides: styleFieldPaddingSides,
                              onStateChanged: (String newValue) {
                                setState(() {
                                  matchScoutingData.idDriveStation = newValue;
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
                              value: matchScoutingData.idStartFacing,
                              title: "Facing",
                              list: _listFacing,
                              styleFontSize: styleFontSizeBody,
                              styleFieldWidth: styleFieldWidthFacing,
                              onStateChanged: (String newValue) {
                                setState(() {
                                  matchScoutingData.idStartFacing = newValue;
                                });
                              }),
                          DropDownWidget(
                              value: matchScoutingData.idStartPosition,
                              title: "Robot Position",
                              list: _listRobotPosition,
                              styleFontSize: styleFontSizeBody,
                              styleFieldWidth: styleFieldWidth,
                              styleFieldPadding: styleFieldPadding,
                              styleFieldPaddingSides: styleFieldPaddingSides,
                              onStateChanged: (String newValue) {
                                setState(() {
                                  matchScoutingData.idStartPosition = newValue;
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
                                    value: matchScoutingData.flCrash,
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
                                      fontSize: styleFontSizeBody,
                                      fontWeight: FontWeight.bold),
                                ),
                                Switch(
                                  value: matchScoutingData.flYellow,
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
                                      fontSize: styleFontSizeBody,
                                      fontWeight: FontWeight.bold),
                                ),
                                Switch(
                                  value: matchScoutingData.flRed,
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
                                    "Operational (Hanging)",
                                    style: TextStyle(
                                        fontSize: styleFontSizeBody,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    child: Switch(
                                      value: matchScoutingData.flRanking1,
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
                                    "Energised (Activated)",
                                    style: TextStyle(
                                        fontSize: styleFontSizeBody,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                    child: Switch(
                                      value: matchScoutingData.flRanking2,
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
        styleImgFieldWidth: styleImgFieldWidth,
        boolLoseStartObject: matchScoutingData.loseStartObject,
        boolContactWithRobot: matchScoutingData.contactWithRobot,
        boolCrossSector: matchScoutingData.crossSector,
        boolFoul: matchScoutingData.foul,
        boolDoesAuto: matchScoutingData.doesAuto,
        boolLeaveLine: matchScoutingData.leaveLine,
        onLoseStartObjectChange: (bool value) {
          //save values
          setState(() {
            matchScoutingData.loseStartObject = value;
          });
        },
        onContactWithRobotChange: (bool value) {
          //save values
          setState(() {
            matchScoutingData.contactWithRobot = value;
          });
        },
        onCrossSectorChange: (bool value) {
          //save values
          setState(() {
            matchScoutingData.crossSector = value;
          });
        },
        onFoulChange: (bool value) {
          //save values
          setState(() {
            matchScoutingData.foul = value;
          });
        },
        onDoesAutoChange: (bool value) {
          //save values
          setState(() {
            matchScoutingData.doesAuto = value;
          });
        },
        onLeaveLineChange: (bool value) {
          //save values
          setState(() {
            matchScoutingData.leaveLine = value;
          });
        },
      );
    }
    if (index == 1) {
      return TeleOpScreen(
        matchScoutingData: matchScoutingData,
        onCellAttemptsChanged: (int value) {
          setState(() {
            matchScoutingData.cellAttempts = value;
          });
        },
        onCellSuccessChanged: (int value) {
          setState(() {
            matchScoutingData.cellSuccess = value;
          });
          print(matchScoutingData.cellSuccess);
        },
        onEndgameParkChanged: (bool value) {
          setState(() {
            matchScoutingData.endgamePark = value;
          });
        },
        onEndgameClimbChanged: (String value) {
          matchScoutingData.endgameClimb = value;
        },
        onPowerPortOuterChanged: (bool value) {
          setState(() {
            matchScoutingData.powerPortOuter = value;
          });
        },
        onPowerPortInnerChanged: (bool value) {
          setState(() {
            matchScoutingData.powerPortInner = value;
          });
        },
        onPowerPortLowerChanged: (bool value) {
          setState(() {
            matchScoutingData.powerPortLower = value;
          });
        },
        onCPRotationControlChanged: (bool value) {
          setState(() {
            matchScoutingData.cpRotationControl = value;
          });
        },
        onCPRotationTimeTakenChange: (String value) {
          setState(() {
            matchScoutingData.cpRotationTimeTaken = value;
          });
        },
        onCPPositionControlChanged: (bool value) {
          setState(() {
            matchScoutingData.cpPositionControl = value;
          });
        },
        onCPPositionTimeTakenChange: (String value) {
          setState(() {
            matchScoutingData.cpPositionTimeTaken = value;
          });
        },
        onCPPanelAttemptsChanged: (int value) {
          setState(() {
            matchScoutingData.cpPanelAttempts = value;
          });
        },
        onCPPanelSuccessChanged: (int value) {
          setState(() {
            matchScoutingData.cpPanelSuccess = value;
          });
        },
        onEndgameTimeToGripChanged: (String value) {
          setState(() {
            matchScoutingData.endgameTimeToGrip = value;
          });
        },
        onEndgameTimeFromGripToClimbChanged: (String value) {
          setState(() {
            matchScoutingData.endgameTimeFromGripToClimb = value;
          });
        },
        onEndgameOutcomeChanged: (String value) {
          setState(() {
            matchScoutingData.endgameOutcome = value;
          });
        },
        onEndgamePreferredPositionChanged: (String value) {
          setState(() {
            matchScoutingData.endgamePreferredPosition = value;
          });
        },
        onEndgameBuddiesChanged: (int value) {
          setState(() {
            matchScoutingData.endgameBuddies = value;
          });
        },
        onEndgameBalanceChanged: (bool value) {
          setState(() {
            matchScoutingData.endgameBalance = value;
          });
        },
        onEndgameBalanceCorrectionChanged: (bool value) {
          setState(() {
            matchScoutingData.endgameBalanceCorrection = value;
          });
        },
        onEndgameFallChanged: (bool value) {
          setState(() {
            matchScoutingData.endgameFall = value;
          });
        },
      );
    }
    if (index == 2) {
      return Container(
        child: RatingsTab(
          matchScoutingData: matchScoutingData,
          styleFontSize: styleFontSizeBody,
          styleFontSizeHeadings: styleFontSizeHeadings,
          onShootingWallZoneChanged: (bool value) {
            //Update Value
            setState(() {
              matchScoutingData.shootingWall = value;
            });
          },
          onShootingNearZoneChanged: (bool value) {
            //Update Value
            setState(() {
              matchScoutingData.shootingNearZone = value;
            });
          },
          onShootingMidZoneChanged: (bool value) {
            //Update Value
            setState(() {
              matchScoutingData.shootingMidZone = value;
            });
          },
          onShootingFarZoneChanged: (bool value) {
            //Update Value
            setState(() {
              matchScoutingData.shootingFarZone = value;
            });
          },
          onOtherRobotChanged: (bool value) {
            //Update Value
            setState(() {
              matchScoutingData.intakeOtherRobot = value;
            });
          },
          onHighIntakeChanged: (bool value) {
            //Update Value
            setState(() {
              matchScoutingData.intakeHigh = value;
            });
          },
          onGroundIntakeChanged: (bool value) {
            //Update Value
            setState(() {
              matchScoutingData.intakeGround = value;
            });
          },
          onAssistOtherRobotChanged: (bool value) {
            //Update Value
            setState(() {
              matchScoutingData.quickRatingsAssistRobot = value;
            });
          },
          onSelectedDriveRatingChanged: (String value) {
            //Update Value
            setState(() {
              matchScoutingData.quickRatingsDriveRating = value;
            });
          },
          onSelectedDefenceRatingChanged: (String value) {
            //Update Value
            setState(() {
              matchScoutingData.quickRatingsDefenceRating = value;
            });
          },
          onRecoveredChanged: (bool value) {
            //Update Value
            setState(() {
              matchScoutingData.quickRatingsRecovered = value;
            });
          },
          onNoTeamWorkChanged: (bool value) {
            //Update Value
            setState(() {
              matchScoutingData.quickRatingsNoTeamWork = value;
            });
          },
          onWorkedToStrategyChanged: (bool value) {
            //Update Value
            setState(() {
              matchScoutingData.quickRatingsWorkedToAStrategy = value;
            });
          },
          onWorkedWithAllianceChanged: (bool value) {
            //Update Value
            setState(() {
              matchScoutingData.quickRatingsWorkedWithAlliance = value;
            });
          },
          onWarningChanged: (bool value) {
            //Update Value
            setState(() {
              matchScoutingData.warning = value;
            });
          },
          onHighlightTeamChanged: (bool value) {
            //Update Value
            setState(() {
              matchScoutingData.highlightTeam = value;
            });

          },
          onCommentsChanged: (String value) {
            //Update Value
            setState(() {
              matchScoutingData.comments = value;
            });

          },
        ),
      );
    }
    if (index == 3) {
      return FinishTab(
        onSavePressed: (bool value) {
          if (recordSaved == true) {
            saveMatchScout(recordID: recordID);
          } else {
            saveMatchScout();
          }
          showAlertOKDialog(
              context, "Saved", "Match has been saved to Local Database");
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
    //_getScoringData();
    setEventTeams(14);
  }
}
