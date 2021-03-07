import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:projectb/widget_counter.dart';
import 'package:projectb/widget_headingmain.dart';
import 'package:projectb/pit/widget_pit_controlpenal.dart';

import 'package:projectb/sharedprefs.dart';
import 'package:projectb/localdb.dart';
import 'dart:async';
import 'package:projectb/class_pitdata.dart';
import 'package:projectb/pit/widget_pit_climb.dart';
import 'package:projectb/finishtab.dart';
import 'package:projectb/pit/widget_pit_powercells.dart';
import 'package:projectb/pit/widget_pit_auto.dart';

class PitScoutingScreen extends StatefulWidget {
  PitScoutingScreen({
    Key key,
    @required this.eventName,
    @required this.eventKey,
    this.eventTeams,
    this.deviceName,

  }) : super(key: key);

  final String eventName;
  final String eventKey;
  final String deviceName;
  final List<LocalTeam> eventTeams;

  @override
  _PitScoutingScreenState createState() => _PitScoutingScreenState();
}

class _PitScoutingScreenState extends State<PitScoutingScreen> {
  ScrollController _scrollController = new ScrollController();
  LocalDB localDB = LocalDB.instance;
  MySharedPrefs mySharedPrefs = new MySharedPrefs();
  PitData pitData = PitData();
  //manage save record
  bool recordSaved = false;
  //define text controllers
  final TextEditingController _txtScoutName = TextEditingController();
  final TextEditingController txShooting = TextEditingController();
  final TextEditingController txClimb = TextEditingController();
  final TextEditingController txPanelSensor = TextEditingController();
  final TextEditingController txPitNotes = TextEditingController();

  LocalTeam selectedTeam;
  List<DropdownMenuItem<String>> ddsEventTeams = [];

  @override
  void initState() {
    super.initState();
    // Call the getJSONData() method when the app initializes
    //_getScoringData();
    setEventTeams(14);
  }

  setEventTeams(double styleFontSize) async {
    //clear current selected event and dropdown box
    setState(() {
      selectedTeam = null;
      pitData.idTeam = null;
      ddsEventTeams.clear();
    });
    //get events based on location
    if (widget.eventTeams == null) {
      //show no teams
      setState(() {
        ddsEventTeams.add(new DropdownMenuItem(
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
        ddsEventTeams.add(new DropdownMenuItem(
            value: team.key,
            child: Text(
              team.teamNumber + " - " + team.nickName,
              style: TextStyle(fontSize: styleFontSize),
            )));
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
        clearPit();
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

  scrollDown(double amount) async {
    // After 1 second, it takes you to the bottom of the ListView
    double newPos = _scrollController.offset + amount;
    Timer(
        Duration(milliseconds: 75),
        () => _scrollController.animateTo(
              newPos,
              duration: Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
            ));
    print(_scrollController.position);
  }

  void clearPit() async {
    setState(() {
      pitData = null;
      pitData = PitData();
      selectedTeam = null;
      txShooting.text = "";
      txClimb.text = "";
    });
    print("Pit Cleared");
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
            content: new Text('This will clear the current Pit?'),
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

  Future<bool> savePitData ({
    int recordID = 0,
  }) async {
    print("saving record");
    pitData.id = null;
    DateTime now = new DateTime.now();
    //DateTime date = new DateTime(now.year, now.month, now.day);
    if (recordID > 0) {
      pitData.id = recordID;
      pitData.dtModified = now.toString();
    }
    else{
      pitData.dtCreation = now.toString();
      pitData.dtModified = now.toString();
    }
    if(selectedTeam == null) return false;
    pitData.idTeam = selectedTeam.teamNumber;
    pitData.txEvent = widget.eventKey;
    pitData.txScoutName = _txtScoutName.text;
    pitData.txComputerName = widget.deviceName;
    //insert Pit Record
    pitData.id = await localDB.insertPitData(pitData);
    if (pitData.id > 0) {
      recordSaved = true;
      print("Record Saved: " + recordSaved.toString());
      print("Record ID: " + pitData.id.toString());
      return true;
    }
    else
      {
        print("ERROR Saving Record: " + recordSaved.toString());
        return false;
      }


  }

  void handleMenuClick(String value) async {
    switch (value) {
      case 'Clear Pit':
        print("clear PIT Selected");
        showAlertDialogClearMatch(context);
        break;
      case 'Settings':
        print("Settings Selected");
        break;
    }
  }

  //style
  double styleFieldWidth = 99.0;
  double styleFieldMatchNumber = 85.0;
  double styleFieldAlliance = 75.0;
  double styleFieldPadding = 5.0;
  double styleFieldPaddingSides = 10.0;
  double styleFieldScoutNameMaxWidth = 300;
  double styleFieldTxShootingMaxWidth = 350;
  double styleFieldTxClimbMaxWidth = 350;
  double styleFieldTxPitNotesMaxWidth = 350;
  double styleFieldWidthTeam = 90;
  double styleImgFieldWidth = 90;
  double styleFontSizeBody = 15;
  double styleFontSizeHeadings = 18;

  @override
  Widget build(BuildContext context) {
    //style
    double width = MediaQuery.of(context).size.width;
    print("Screen Size: " + width.toString());
    if (width < 500) {
      styleFontSizeBody = 12;
      styleFontSizeHeadings = 16;
      styleFieldScoutNameMaxWidth = 250;
      styleFieldTxShootingMaxWidth = 250;
      styleFieldTxClimbMaxWidth = 240;
    }
    if (width < 395) {
      styleFontSizeBody = 11;
      styleFontSizeHeadings = 16;
      styleFieldScoutNameMaxWidth = 200;
      styleFieldTxShootingMaxWidth = 198;
    }
    if (width >= 600) {
      styleFontSizeBody = 15;
      styleFieldTxShootingMaxWidth = 400;
      styleFieldScoutNameMaxWidth = 400;
      styleFieldTxPitNotesMaxWidth = 500;
      styleFieldTxClimbMaxWidth = 420;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(title: Text('Pit Scouting'), actions: <Widget>[
          PopupMenuButton<String>(
              onSelected: handleMenuClick,
              itemBuilder: (BuildContext context) {
                return {'Clear Pit', 'Settings'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              }),
        ]),
        body: ListView(
            controller: _scrollController,
            reverse: false,
            shrinkWrap: true,
            children: <Widget>[
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Event Name: " + widget.eventName,
                              style: TextStyle(fontSize: styleFontSizeBody),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Scout: ",
                                  style: TextStyle(fontSize: styleFontSizeBody),
                                ),
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                      maxWidth: styleFieldScoutNameMaxWidth),
                                  child: TextField(
                                    controller: _txtScoutName,
                                    decoration:
                                        InputDecoration(hintText: 'Scout Name'),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Team ",
                                    style:
                                        TextStyle(fontSize: styleFontSizeBody),
                                  ),
                                  DropdownButton(
                                    value: selectedTeam == null
                                        ? null
                                        : selectedTeam.key,
                                    //title: "Team",
                                    items: ddsEventTeams,
                                    onChanged: (item) {
                                      setState(() {
                                        selectedTeam = widget.eventTeams
                                            .firstWhere(
                                                (team) => team.key == item,
                                                orElse: () =>
                                                    widget.eventTeams.first);
                                      });
                                      print("Team Key: " + selectedTeam.key);
                                    },
                                  ),
                                ]),
                          ]),
                    ),
                  ),
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.99,
                child: Container(
                  margin: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    child: Column(children: <Widget>[
                      HeadingMain(
                        styleFontSize: styleFontSizeHeadings,
                        headingText: "Robot Stats",
                        //backGroundColor: Colors.green,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CounterWidget(
                              value: pitData.numWeight,
                              title: "Weight",
                              onIncreaseStateChanged: (int value) {
                                setState(() {
                                  pitData.numWeight++;
                                });
                              },
                              onDecreaseStateChanged: (int value) {
                                setState(() {
                                  pitData.numWeight--;
                                });
                              },
                              onSetValue: (int value) {
                                setState(() {
                                  pitData.numWeight = value;
                                });
                              },
                            ),
                            CounterWidget(
                              value: pitData.numHeight,
                              title: "Height",
                              onIncreaseStateChanged: (int value) {
                                setState(() {
                                  pitData.numHeight++;
                                });
                              },
                              onDecreaseStateChanged: (int value) {
                                setState(() {
                                  pitData.numHeight--;
                                });
                              },
                              onSetValue: (int value) {
                                setState(() {
                                  pitData.numHeight = value;
                                });
                              },
                            ),
                          ]),
                    ]),
                  ),
                ),
              ),
              PitPowerCells(
                pitData: pitData,
                txShooting: txShooting,
                styleFieldTxShootingMaxWidth: styleFieldTxShootingMaxWidth,
                onChanged: (PitData updates) {
                  setState(() {
                    pitData = updates;
                  });
                },
                onExpanded: (value) {
                  (value == true) ? scrollDown(180) : scrollDown(0);
                },

              ),
              PitClimb(
                pitData: pitData,
                txClimb: txClimb,
                styleFieldTxClimbMaxWidth: styleFieldTxClimbMaxWidth,
                onChanged: (PitData updates) {
                  setState(() {
                    pitData = updates;
                  });
                },
                onExpanded: (value) {
                  (value == true) ? scrollDown(180) : scrollDown(0);
                },
              ),
              PitControlPanel(
                pitData: pitData,
                txPanelSensor: txPanelSensor,
                onChanged: (PitData updates) {
                  setState(() {
                    pitData = updates;
                    print("Pit_Climb: Updated to Parent");
                  });
                },
                onExpanded: (value) {
                  (value == true) ? scrollDown(180) : scrollDown(0);
                },
              ),
              PitAuto(
                pitData: pitData,
                onChanged: (PitData updates) {
                  setState(() {
                    pitData = updates;
                  });
                },
                onExpanded: (value) {
                  (value == true) ? scrollDown(100) : scrollDown(0);
                },
              ),
              FractionallySizedBox(
                widthFactor: 0.99,
                child: Container(
                  margin: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    child: Column(children: <Widget>[
                      HeadingMain(
                        styleFontSize: styleFontSizeHeadings,
                        headingText: "Comments",
                        //backGroundColor: Colors.green,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Notes: ",
                              style: TextStyle(fontSize: styleFontSizeBody),
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth: styleFieldTxPitNotesMaxWidth),
                              child: TextField(
                                controller: txPitNotes,
                                decoration: InputDecoration(
                                    hintText: 'General Notes'),
                                onChanged: (String text) {
                                  setState(() {
                                    txPitNotes.text = text;
                                  });
                                },
                              ),
                            ),
                          ]),
                    ]),
                  ),
                ),
              ),
              FinishTab(
                onSavePressed: (bool value) async {
                  if (recordSaved == true) {
                    await savePitData(recordID: pitData.id);
                  } else {
                    await savePitData();
                  }
                  String alertMsg;
                  alertMsg = (recordSaved == true) ? "Pit has been saved to Local Database" : "FAILED to Save Record";
                  showAlertOKDialog(
                      context, "Saved", alertMsg);

                },
              ),

            ]),

      ),
    );
  }
}
