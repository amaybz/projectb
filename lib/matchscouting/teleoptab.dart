import 'package:flutter/material.dart';
import 'package:projectb/matchscouting/widget_matchscouting_endgame.dart';
import 'package:projectb/matchscouting/widget_matchscouting_human.dart';
import 'package:projectb/sharedprefs.dart';
import 'package:projectb/matchscouting/widget_matchscouting_score.dart';

import 'package:projectb/class/class_macthscoutingdata.dart';
import 'package:projectb/widgets/widget_dropdown_indexed.dart';

class TeleOpScreen extends StatefulWidget {
  const TeleOpScreen({
    Key? key,
    required this.matchScoutingData,
    this.styleCounterButtonHeight = 25,
    this.styleCounterButtonWidth = 30,
    //onchange
    this.onCellAttemptsChanged,
    this.onCellSuccessChanged,
    this.onPowerPortInnerChanged,
    this.onPowerPortLowerChanged,
    this.onPowerPortOuterChanged,
    this.onCPRotationControlChanged,
    this.onCPRotationTimeTakenChange,
    this.onCPPositionControlChanged,
    this.onCPPositionTimeTakenChange,
    this.onCPPanelAttemptsChanged,
    this.onCPPanelSuccessChanged,
    this.onChange,
  }) : super(key: key);

  final MatchScoutingData matchScoutingData;

  //onchange
  final ValueChanged<bool>? onPowerPortLowerChanged;
  final ValueChanged<bool>? onPowerPortInnerChanged;
  final ValueChanged<bool>? onPowerPortOuterChanged;
  final ValueChanged<int>? onCellAttemptsChanged;
  final ValueChanged<int>? onCellSuccessChanged;
  final ValueChanged<bool>? onCPRotationControlChanged;
  final ValueChanged<String>? onCPRotationTimeTakenChange;
  final ValueChanged<bool>? onCPPositionControlChanged;
  final ValueChanged<String>? onCPPositionTimeTakenChange;
  final ValueChanged<int>? onCPPanelAttemptsChanged;
  final ValueChanged<int>? onCPPanelSuccessChanged;
  final ValueChanged<MatchScoutingData>? onChange;
  final double styleCounterButtonHeight;
  final double styleCounterButtonWidth;

  @override
  _TeleOpScreenState createState() => _TeleOpScreenState();
}

class _TeleOpScreenState extends State<TeleOpScreen> {
  MySharedPrefs mySharedPrefs = new MySharedPrefs();

  @override
  void initState() {
    super.initState();
    //get values from SharedPrefs
    updateValues();
  }

  updateValues() async {
    setState(() {});
  }

  //counters
  int intCellAttempts = 0;
  int intCellSuccess = 0;
  int intPenalAttempts = 0;
  int intPenalSuccess = 0;
  int intBuddies = 0;

  //lists
  //final List<String> listSuccessFailNA = ['NA', 'Success', 'Fail'];
  final List<DropDownValue> listSuccessFailNA = [
    DropDownValue(id: "1", value: "NA"),
    DropDownValue(id: "2", value: "Fail"),
    DropDownValue(id: "3", value: "Success"),
  ];

  final List<DropDownValue> listTime = [
    DropDownValue(id: "1", value: "NA"),
    DropDownValue(id: "2", value: "Slow (> 7 Secs)"),
    DropDownValue(id: "3", value: "Medium (3-7 Secs)"),
    DropDownValue(id: "4", value: "Fast <3 Secs"),
  ];

  List<DropdownMenuItem<String>> ddsSpeed = [
    DropdownMenuItem(value: "1", child: Text("NA")),
    DropdownMenuItem(value: "2", child: Text("Slow (> 7 Secs)")),
    DropdownMenuItem(value: "3", child: Text("Medium (3-7 Secs)")),
    DropdownMenuItem(value: "4", child: Text("Fast <3 Secs")),
  ];

  final List<DropDownValue> listPositions = [
    DropDownValue(id: "1", value: "NA"),
    DropDownValue(id: "2", value: "Inner"),
    DropDownValue(id: "3", value: "Middle"),
    DropDownValue(id: "4", value: "Outer"),
  ];

  //style
  double styleFieldCellsWidth = 40.0;
  double styleFieldPadding = 5.0;
  double styleFieldPaddingSides = 10.0;
  double styleFontSizeBody = 12;
  double styleImgFieldWidth = 150;
  double styleFieldControlPanelDropDownsWidth = 550.0;
  double styleFieldControlPanelDropDownsPaddingSides = 1.0;
  double styleTimeTakenWidth = 180;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    if (width < 500) {
      styleFieldCellsWidth = 38.0;
      styleFieldPadding = 3.0;
      styleFieldPaddingSides = 3.0;
      styleFontSizeBody = 12;
      styleFieldControlPanelDropDownsWidth = 350;
    }
    if (width >= 600) {
      styleFieldCellsWidth = 40.0;
      styleFieldPadding = 3.0;
      styleFieldPaddingSides = 5.0;
      styleFontSizeBody = 16;
      styleImgFieldWidth = 200;
      styleFieldControlPanelDropDownsWidth = 600.0;
    }

    return Column(children: [
      FractionallySizedBox(
        widthFactor: 0.99,
        child: Container(
          padding: const EdgeInsets.all(5.0),
          child: Column(children: <Widget>[
            ScoreWidget(
              styleCounterButtonHeight: widget.styleCounterButtonHeight,
              styleCounterButtonWidth: widget.styleCounterButtonWidth,
              matchScoutingData: widget.matchScoutingData,
              numSpeakerSuccess: widget.matchScoutingData.teleNumSpeakerSuccess,
              numSpeakerAttempt: widget.matchScoutingData.teleNumSpeakerAttempt,
              numAmpAttempt: widget.matchScoutingData.teleNumAmpAttempt,
              numAmpSuccess: widget.matchScoutingData.teleNumAmpSuccess,
              numTrapSuccess: widget.matchScoutingData.teleNumTrapSuccess,
              onChange: (MatchScoutingData newData) {
                setState(() {
                  widget.onChange!(widget.matchScoutingData);
                });
              },
              onNumSpeakerSuccessChanged: (int value) {
                setState(() {
                  if (value < 0) {
                    value = 0;
                  }
                  widget.matchScoutingData.teleNumSpeakerSuccess = value;
                  widget.onChange!(widget.matchScoutingData);
                });
              },
              onNumAmpSuccessChanged: (int value) {
                setState(() {
                  if (value < 0) {
                    value = 0;
                  }
                  widget.matchScoutingData.teleNumAmpSuccess = value;
                  widget.onChange!(widget.matchScoutingData);
                });
              },
              onNumSpeakerAttemptChanged: (int value) {
                setState(() {
                  if (value < 0) {
                    value = 0;
                  }
                  widget.matchScoutingData.teleNumSpeakerAttempt = value;
                  widget.onChange!(widget.matchScoutingData);
                });
              },
              onNumAmpAttemptChanged: (int value) {
                setState(() {
                  if (value < 0) {
                    value = 0;
                  }
                  widget.matchScoutingData.teleNumAmpAttempt = value;
                  widget.onChange!(widget.matchScoutingData);
                });
              },
              onNumTrapSuccessChanged: (int value) {
                setState(() {
                  if (value < 0) {
                    value = 0;
                  }
                  widget.matchScoutingData.teleNumTrapSuccess = value;
                  widget.onChange!(widget.matchScoutingData);
                });
              },
            ),
          ]),
        ),
      ),
      FractionallySizedBox(
        widthFactor: 0.99,
        child: Container(
          padding: const EdgeInsets.all(5.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EndGame(
                  styleCounterButtonHeight: widget.styleCounterButtonHeight,
                  styleCounterButtonWidth: widget.styleCounterButtonWidth,
                  matchScoutingData: widget.matchScoutingData,
                  onChanged: (matchScoutingData) {
                    setState(() {
                      widget.onChange!(matchScoutingData);
                    });
                  },
                  onExpanded: (value) {},
                ),
                HumanWidget(
                  matchScoutingData: widget.matchScoutingData,
                  onChange: (matchScoutingData) {
                    setState(() {
                      widget.onChange!(matchScoutingData);
                    });
                  },
                )
              ]),
        ),
      ),
    ]);
  }
}
