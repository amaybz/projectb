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
import 'package:projectb/class_pitdata.dart';

class PitScoutingScreen extends StatefulWidget {
  PitScoutingScreen({
    Key key,
    @required this.eventName,
    @required this.eventKey,
    this.eventTeams,
  }) : super(key: key);

  final String eventName;
  final String eventKey;
  final List<LocalTeam> eventTeams;

  @override
  _PitScoutingScreenState createState() => _PitScoutingScreenState();
}

class _PitScoutingScreenState extends State<PitScoutingScreen> {
  LocalDB localDB = LocalDB.instance;
  MySharedPrefs mySharedPrefs = new MySharedPrefs();
  PitData pitData = PitData();
  //manage save record
  bool recordSaved = false;
  //define text controllers
  final TextEditingController _txtScoutName = TextEditingController();

  LocalTeam selectedTeam;
  List<DropdownMenuItem<String>> eventTeamsListDropDown = [];

  setEventTeams(double styleFontSize) async {
    //clear current selected event and dropdown box
    setState(() {
      selectedTeam = null;
      pitData.idTeam = null;
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

  void clearPit() async {
    setState(() {
      pitData = null;
      pitData = PitData();
      selectedTeam = null;
    });
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

  void savePitData({
    int recordID = 0,
  }) async {
    print("saving record");
    if (recordID > 0) {
      pitData.id = recordID;
    }
    pitData.idTeam = selectedTeam.teamNumber;
    pitData.txEvent = widget.eventKey;
    pitData.txScoutName = _txtScoutName.text;
    //insert Pit Record
    //pitData.id = await localDB.insertPitData(pitData);
    if (pitData.id > 0) {
      recordSaved = true;
    }
    print("Record Saved: " + recordSaved.toString());
    print("Record ID: " + pitData.id.toString());
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
  double styleFieldWidthTeam = 90;
  double styleImgFieldWidth = 90;
  double styleFontSizeBody = 18;
  double styleRedBoxSize = 300;

  @override
  Widget build(BuildContext context) {
    //style
    double width = MediaQuery.of(context).size.width;
    print("Screen Size: " + width.toString());
    if (width < 500) {
      styleFontSizeBody = 12;
      styleFieldScoutNameMaxWidth = 250;
    }
    if (width < 395) {
      styleFontSizeBody = 11;
      styleFieldScoutNameMaxWidth = 200;
    }
    if (width >= 600) {
      styleFontSizeBody = 15;
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
        Container(
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            color: Colors.grey,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5)),
          ),

          child: Text(
            "Robot Stats",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ]),
    ),),),


          ])),
    );
  }
}
