import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projectb/pit/widget_pit_drivebase.dart';
import 'package:projectb/pit/widget_pit_intake.dart';
import 'package:projectb/pit/widget_pit_scoring.dart';
import 'package:projectb/settings.dart';
import 'package:projectb/widgets/widget_headingmain.dart';
import 'package:camera/camera.dart';
import 'package:projectb/sharedprefs.dart';
import 'package:projectb/localdb.dart';
import 'dart:async';
import 'package:projectb/class/class_pitdata.dart';
import 'package:projectb/finishtab.dart';
import 'package:projectb/pit/widget_pit_climb.dart';
import 'package:projectb/pit/widget_pit_auto.dart';
import 'package:projectb/pit/widget_pit_images.dart';
import 'dart:io';
import 'package:projectb/googleinterface.dart';

class PitScoutingScreen extends StatefulWidget {
  PitScoutingScreen({
    Key? key,
    @required this.eventName,
    @required this.eventKey,
    this.eventTeams,
    this.deviceName,
    this.camera,
    this.styleFontSize = 14,
  }) : super(key: key);

  final String? eventName;
  final String? eventKey;
  final String? deviceName;
  final List<LocalTeam>? eventTeams;
  final double? styleFontSize;
  final CameraDescription? camera;

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
  final TextEditingController txChargeNotes = TextEditingController();
  final TextEditingController txClimb = TextEditingController();
  final TextEditingController txPanelSensor = TextEditingController();
  final TextEditingController txPitNotes = TextEditingController();
  final TextEditingController txWeight = TextEditingController();
  final TextEditingController txHeight = TextEditingController();
  final TextEditingController txWidth = TextEditingController();
  final TextEditingController numClimbHeight = TextEditingController();
  final TextEditingController numClimbWidth = TextEditingController();
  final TextEditingController txDriveNotes = TextEditingController();
  final TextEditingController txObjectNotes = TextEditingController();
  final TextEditingController txScoringNotes = TextEditingController();

  File? imgPitTeamShirt;
  File? imgPitRobotFront;
  File? imgPitRobotSide;
  LocalTeam? selectedTeam;
  List<DropdownMenuItem<String>> ddsEventTeams = [];
  String strWeight = "lbs";
  String strDistance = "Inches";
  int googleUploadStatus = 0;
  GoogleInterface googleInterface = GoogleInterface.instance;

  @override
  void initState() {
    super.initState();
    // Call the getJSONData() method when the app initializes
    //_getScoringData();
    setEventTeams(14);
    numClimbHeight.text = "0";
    getMetricSystemValue();
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
    for (LocalTeam team in widget.eventTeams!) {
      setState(() {
        ddsEventTeams.add(new DropdownMenuItem(
            value: team.key,
            child: Text(
              team.teamNumber.toString() + " - " + team.nickName!,
              style: TextStyle(fontSize: styleFontSize),
              overflow: TextOverflow.ellipsis,
            )));
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

  void clearPit() async {
    setState(() {
      pitData = PitData();
      selectedTeam = null;
      _txtScoutName.text = "";
      txChargeNotes.text = "";
      txClimb.text = "";
      txHeight.text = "0";
      txWeight.text = "0";
      txWidth.text = "0";
      txPitNotes.text = "";
      txObjectNotes.text = "";
      txScoringNotes.text = "";
      numClimbHeight.text = "0";
      numClimbWidth.text = "0";
    });
    print("Pit Cleared");
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
            content: new Text('This will clear the current Pit?'),
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

  Future<bool> savePitData({
    int recordID = 0,
  }) async {
    print("saving record");
    pitData.id = null;
    DateTime now = new DateTime.now();
    //DateTime date = new DateTime(now.year, now.month, now.day);
    if (recordID > 0) {
      pitData.id = recordID;
      pitData.dtModified = now.toString();
    } else {
      pitData.dtCreation = now.toString();
      pitData.dtModified = now.toString();
    }
    if (selectedTeam == null) return false;
    pitData.idTeam = selectedTeam?.teamNumber;
    pitData.txEvent = widget.eventKey;
    pitData.txScoutName = _txtScoutName.text;
    pitData.txPitNotes = txPitNotes.text;
    pitData.txComputerName = widget.deviceName;
    pitData.txObjectNotes = txObjectNotes.text;
    //if (pitData.imgTeamUniform == null) return false;
    //if (pitData.imgRobotSide == null) return false;
    //if (pitData.imgRobotFront == null) return false;

    try {
      pitData.numWeight = int.parse(txWeight.text);
    } catch (e) {
      pitData.numWeight = 0;
      print("Error Converting txWeight: " + e.toString());
    }

    try {
      pitData.numHeight = int.parse(txHeight.text);
    } catch (e) {
      pitData.numHeight = 0;
      print("Error Converting txHeight: " + e.toString());
    }

    try {
      pitData.numWidth = int.parse(txWidth.text);
    } catch (e) {
      pitData.numWidth = 0;
      print("Error Converting txWidth: " + e.toString());
    }

    //insert Pit Record
    pitData.id = await localDB.insertPitData(pitData);
    if (pitData.id! > 0) {
      recordSaved = true;
      print("Record Saved: " + recordSaved.toString());
      print("Record ID: " + pitData.id.toString());
      return true;
    } else {
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
  double styleFontSizeHeadings = 18;
  double styleFieldTeamMaxWidth = 300;

  @override
  Widget build(BuildContext context) {
    //style
    double width = MediaQuery.of(context).size.width;
    print("Screen Size: " + width.toString());
    styleFieldTeamMaxWidth = width - 100;
    if (width < 500) {
      styleFontSizeHeadings = 16;
      styleFieldScoutNameMaxWidth = 250;
      styleFieldTxShootingMaxWidth = 250;
      styleFieldTxClimbMaxWidth = 240;
      styleFieldTxPitNotesMaxWidth = 300;
    }
    if (width < 395) {
      styleFontSizeHeadings = 16;
      styleFieldScoutNameMaxWidth = 200;
      styleFieldTxShootingMaxWidth = 198;
      styleFieldTxPitNotesMaxWidth = 250;
    }
    if (width >= 600) {
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
                              "Event Name: " + widget.eventName!,
                              style: TextStyle(fontSize: styleFontSizeHeadings),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Scout: ",
                                  style:
                                      TextStyle(fontSize: widget.styleFontSize),
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
                                    style: TextStyle(
                                        fontSize: widget.styleFontSize),
                                  ),
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxWidth: styleFieldTeamMaxWidth),
                                    child: DropdownButton(
                                      isExpanded: true,
                                      value: selectedTeam == null
                                          ? null
                                          : selectedTeam?.key,
                                      //title: "Team",
                                      items: ddsEventTeams,
                                      onChanged: (item) {
                                        setState(() {
                                          selectedTeam = widget.eventTeams
                                              ?.firstWhere(
                                                  (team) => team.key == item,
                                                  orElse: () =>
                                                      widget.eventTeams!.first);
                                        });
                                        print(
                                            "Team Key: " + selectedTeam!.key!);
                                      },
                                    ),
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
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: styleFieldPadding,
                                  horizontal: styleFieldPaddingSides),
                              width: 100,
                              height: 58,
                              child: TextField(
                                style:
                                    TextStyle(fontSize: widget.styleFontSize),
                                controller: txWeight,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  labelText: "Weight (" + strWeight + ")",
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: styleFieldPadding,
                                  horizontal: styleFieldPaddingSides),
                              width: 100,
                              height: 58,
                              child: TextField(
                                style:
                                    TextStyle(fontSize: widget.styleFontSize),
                                controller: txHeight,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  labelText: "Height(" + strDistance + ")",
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: styleFieldPadding,
                                  horizontal: styleFieldPaddingSides),
                              width: 100,
                              height: 58,
                              child: TextField(
                                style:
                                    TextStyle(fontSize: widget.styleFontSize),
                                controller: txWidth,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  labelText: "Width (" + strDistance + ")",
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                              ),
                            ),
                          ]),
                    ]),
                  ),
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.99,
                child: Container(
                  margin: const EdgeInsets.all(5.0),
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    child: Column(children: <Widget>[
                      HeadingMain(
                        styleFontSize: styleFontSizeHeadings,
                        headingText: "Pictures",
                        //backGroundColor: Colors.green,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            PitImages(
                              title: "Team Shirt",
                              camera: widget.camera!,
                              onCapture: (newImage) {
                                setState(() {
                                  pitData.imgTeamUniform = newImage;
                                });
                              },
                              image: pitData.imgTeamUniform,
                            ),
                            PitImages(
                              title: "Robot Side",
                              camera: widget.camera!,
                              onCapture: (newImage) {
                                setState(() {
                                  pitData.imgRobotSide = newImage;
                                });
                              },
                              image: pitData.imgRobotSide,
                            ),
                            PitImages(
                              title: "Robot Front",
                              camera: widget.camera!,
                              onCapture: (newImage) {
                                setState(() {
                                  pitData.imgRobotFront = newImage;
                                });
                              },
                              image: pitData.imgRobotFront,
                            ),
                          ]),
                    ]),
                  ),
                ),
              ),
              PitDriveBase(
                pitData: pitData,
                txDriveNotes: txDriveNotes,
                onChanged: (PitData updates) {
                  setState(() {
                    pitData = updates;
                  });
                },
                onExpanded: (value) {
                  (value == true) ? scrollDown(50) : scrollDown(0);
                },
              ),
              PitIntake(
                pitData: pitData,
                txNotes: txObjectNotes,
                onChanged: (PitData updates) {
                  setState(() {
                    pitData = updates;
                  });
                },
              ),
              PitScoring(
                pitData: pitData,
                txScoringNotes: txScoringNotes,
                onChanged: (PitData updates) {
                  setState(() {
                    pitData = updates;
                  });
                },
              ),
              PitClimb(
                pitData: pitData,
                txChargeNotes: txChargeNotes,
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
              PitAuto(
                pitData: pitData,
                strDistance: strDistance,
                strWeight: strWeight,
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
                              style: TextStyle(fontSize: widget.styleFontSize),
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth: styleFieldTxPitNotesMaxWidth),
                              child: TextField(
                                controller: txPitNotes,
                                decoration:
                                    InputDecoration(hintText: 'General Notes'),
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
                    await savePitData(recordID: pitData.id!);
                  } else {
                    await savePitData();
                  }
                  String alertMsg;
                  alertMsg = (recordSaved == true)
                      ? "Pit has been saved to Local Database"
                      : "FAILED to Save Record: The following fields must be filled in: Team";
                  showAlertOKDialog(context, "Saved", alertMsg);
                },
                googleUploadStatus: googleUploadStatus,
                onUploadToGoogle: (bool value) async {
                  if (recordSaved == true) {
                    await savePitData(recordID: pitData.id!);
                  } else {
                    await savePitData();
                  }
                  if (recordSaved == true) {
                    _uploadDataToGoogleDrive(pitData);
                  }
                  String alertMsg = (recordSaved == true)
                      ? "Pit has been saved to Local Database."
                      : "FAILED to Save Record: The following fields must be filled in: Team, Team Shirt, Robot Pictures";
                  showAlertOKDialog(context, "Saved", alertMsg);
                },
              ),
            ]),
      ),
    );
  }

  _uploadDataToGoogleDrive(PitData pitData) async {
    setState(() {
      googleUploadStatus = 1;
    });
    File file = await googleInterface.uploadPitData(pitData);
    await file.length();
    setState(() {
      googleUploadStatus = 2;
    });
  }
}
