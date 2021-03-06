import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    this.styleFontSize = 16,
  }) : super(key: key);

  final String eventName;
  final String eventKey;
  final List<LocalTeam> eventTeams;

  //style
  final double styleFontSize;

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

  MatchScoutingData matchScoutingData = MatchScoutingData();

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
  double styleImgFieldMapWidth = 90;
  double styleImgFieldPerformanceWidth = 150;

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
      styleImgFieldMapWidth = 250;
      styleFieldWidthTeam = 300;

      styleFontSizeHeadings = 16;
      styleRedBoxSize = 180;
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

        styleFontSizeHeadings = 16;
        styleRedBoxSize = 180;
      });
    }
    if (width >= 600) {
      styleFieldWidth = 150.0;
      styleFieldMatchNumber = 80.0;
      styleFieldAlliance = 100.0;
      styleFieldPadding = 3.0;
      styleFieldPaddingSides = 10.0;
      styleFieldWidthFacing = 200;
      styleImgFieldMapWidth = 400;
      styleFieldWidthTeam = 400;
      styleImgFieldPerformanceWidth = 200;
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
                            style: TextStyle(fontSize: widget.styleFontSize),
                          ),
                          Text(
                            " - Scout: ",
                            style: TextStyle(fontSize: widget.styleFontSize),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _txtScoutName,
                              style: TextStyle(fontSize: widget.styleFontSize),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Scout Name',
                              ),
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
                              style: TextStyle(fontSize: widget.styleFontSize),
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
                              styleFontSize: widget.styleFontSize,
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
                              styleFontSize: widget.styleFontSize,
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
                            style: TextStyle(fontSize: widget.styleFontSize),
                          ),
                          DropdownButton(
                            isDense: true,
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
                              styleFontSize: widget.styleFontSize,
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
                              styleFontSize: widget.styleFontSize,
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
                              style: TextStyle(fontSize: widget.styleFontSize),
                              controller: _txtStartingCells,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                labelText: "Starting Cells",
                                labelStyle:
                                    TextStyle(fontSize: widget.styleFontSize),
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
                                        fontSize: widget.styleFontSize,
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
                                      fontSize: widget.styleFontSize,
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
                                      fontSize: widget.styleFontSize,
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
                                    "RP #1",
                                    style: TextStyle(
                                        fontSize: widget.styleFontSize,
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
                                    "RP #2",
                                    style: TextStyle(
                                        fontSize: widget.styleFontSize,
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
        styleImgFieldPerformanceWidth: styleImgFieldPerformanceWidth,
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
        onCellAttemptsChanged: (int value) {
          setState(() {
            matchScoutingData.teleNumCellAttempt = value;
          });
        },
        onCellSuccessChanged: (int value) {
          setState(() {
            matchScoutingData.teleNumCellSuccess = value;
          });
          print(matchScoutingData.teleNumCellSuccess);
        },
        onEndgameParkChanged: (bool value) {
          setState(() {
            matchScoutingData.teleFlPark = value;
          });
        },
        onEndgameClimbChanged: (String value) {
          matchScoutingData.teleIdClimb = value;
        },
        onPowerPortOuterChanged: (bool value) {
          setState(() {
            matchScoutingData.teleFlOuter = value;
          });
        },
        onPowerPortInnerChanged: (bool value) {
          setState(() {
            matchScoutingData.teleFlInner = value;
          });
        },
        onPowerPortLowerChanged: (bool value) {
          setState(() {
            matchScoutingData.teleFlLower = value;
          });
        },
        onCPRotationControlChanged: (bool value) {
          setState(() {
            matchScoutingData.teleFlPanelRotation = value;
          });
        },
        onCPRotationTimeTakenChange: (String value) {
          setState(() {
            matchScoutingData.teleIdPanelRotationTime = value;
          });
        },
        onCPPositionControlChanged: (bool value) {
          setState(() {
            matchScoutingData.teleFlPanelPosition = value;
          });
        },
        onCPPositionTimeTakenChange: (String value) {
          setState(() {
            matchScoutingData.teleIdPanelPositionTime = value;
          });
        },
        onCPPanelAttemptsChanged: (int value) {
          setState(() {
            matchScoutingData.teleNumPanelAttempt = value;
          });
        },
        onCPPanelSuccessChanged: (int value) {
          setState(() {
            matchScoutingData.teleNumPanelSuccess = value;
          });
        },
        onEndgameTimeToGripChanged: (String value) {
          setState(() {
            matchScoutingData.teleIdClimbGrabTime = value;
          });
        },
        onEndgameTimeFromGripToClimbChanged: (String value) {
          setState(() {
            matchScoutingData.teleIdClimbTime = value;
          });
        },
        onEndgameOutcomeChanged: (String value) {
          setState(() {
            matchScoutingData.teleIdClimbOutcome = value;
          });
        },
        onEndgamePreferredPositionChanged: (String value) {
          setState(() {
            matchScoutingData.teleIdClimbPos = value;
          });
        },
        onEndgameBuddiesChanged: (int value) {
          setState(() {
            matchScoutingData.teleNumClimbOthers = value;
          });
        },
        onEndgameBalanceChanged: (bool value) {
          setState(() {
            matchScoutingData.teleFlClimbBalance = value;
          });
        },
        onEndgameBalanceCorrectionChanged: (bool value) {
          setState(() {
            matchScoutingData.teleFlClimbCorrection = value;
          });
        },
        onEndgameFallChanged: (bool value) {
          setState(() {
            matchScoutingData.teleFlClimbFall = value;
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
          onWorkedWithAllianceChanged: (bool value) {
            //Update Value
            setState(() {
              matchScoutingData.commFlAlliance = value;
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
    setEventTeams(widget.styleFontSize);
  }
}
