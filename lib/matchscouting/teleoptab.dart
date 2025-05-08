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
  TextStyle? styleBodyTextTheme = ThemeData().textTheme.bodyMedium;
  TextStyle? styleTitleTextTheme = ThemeData().textTheme.titleMedium;
  double styleFieldCellsWidth = 40.0;
  double styleFieldPadding = 5.0;
  double styleFieldPaddingSides = 10.0;
  double styleFontSizeBody = 12;
  double styleImgFieldWidth = 150;
  double styleFieldControlPanelDropDownsWidth = 550.0;
  double styleFieldControlPanelDropDownsPaddingSides = 1.0;
  double styleTimeTakenWidth = 180;
  double styleMarginLeftTrap = 90;
  double styleMarginLeftSpeaker = 82;
  double styleMarginTopAmp = 5;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    if (width < 500) {
      styleBodyTextTheme = Theme.of(context).textTheme.bodyMedium;
      styleTitleTextTheme = Theme.of(context).textTheme.titleMedium;
      styleFieldCellsWidth = 38.0;
      styleFieldPadding = 3.0;
      styleFieldPaddingSides = 3.0;
      styleFontSizeBody = 12;
      styleFieldControlPanelDropDownsWidth = 350;
      styleMarginLeftTrap = 55;
      styleMarginTopAmp = 5;
      styleMarginLeftSpeaker = 60;
    }
    if (width < 393) {
      setState(() {
        styleBodyTextTheme = Theme.of(context).textTheme.bodySmall;
        styleTitleTextTheme = Theme.of(context).textTheme.titleSmall;
        styleMarginLeftTrap = 55;
        styleMarginTopAmp = 45;
        styleMarginLeftSpeaker = 55;
      });
    }
    if (width >= 600) {
      styleFieldCellsWidth = 40.0;
      styleFieldPadding = 3.0;
      styleFieldPaddingSides = 5.0;
      styleFontSizeBody = 16;
      styleImgFieldWidth = 200;
      styleFieldControlPanelDropDownsWidth = 600.0;
      styleBodyTextTheme = Theme.of(context).textTheme.bodyLarge;
      styleTitleTextTheme = Theme.of(context).textTheme.titleLarge;
      styleMarginLeftTrap = 100;
      styleMarginTopAmp = 5;
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
              styleMarginLeftTrap: styleMarginLeftTrap,
              styleMarginLeftSpeaker: styleMarginLeftSpeaker,
              styleMarginTopAmp: styleMarginTopAmp,
              styleFontSizeBody: styleBodyTextTheme!.fontSize!,
              matchScoutingData: widget.matchScoutingData,
              numAlgaeAttempt: widget.matchScoutingData.teleNumAlgaeAttempt,
              numAlgaeL2Success: widget.matchScoutingData.teleNumAlgaeL2Success,
              numAlgaeL3Success: widget.matchScoutingData.teleNumAlgaeL3Success,
              numCoralAttempt: widget.matchScoutingData.teleNumCoralAttempt,
              numCoralL1Success: widget.matchScoutingData.teleNumCoralL1Success,
              numCoralL2Success: widget.matchScoutingData.teleNumCoralL2Success,
              numCoralL3Success: widget.matchScoutingData.teleNumCoralL3Success,
              numCoralL4Success: widget.matchScoutingData.teleNumCoralL4Success,
              numAlgaeProcessAttempt:
                  widget.matchScoutingData.teleNumAlgaeProcessAttempt,
              numAlgaeProcessSuccess:
                  widget.matchScoutingData.teleNumAlgaeProcessSuccess,
              numAlgaeNetAttempt:
                  widget.matchScoutingData.teleNumAlgaeNetAttempt,
              numAlgaeNetSuccess:
                  widget.matchScoutingData.teleNumAlgaeNetSuccess,
              onChange: (MatchScoutingData newData) {
                setState(() {
                  widget.onChange!(widget.matchScoutingData);
                });
              },
              onNumAlgaeProcessAttempt: (int value) {
                setState(() {
                  if (value < 0) {
                    value = 0;
                  }
                  widget.matchScoutingData.teleNumAlgaeProcessAttempt = value;
                  widget.onChange!(widget.matchScoutingData);
                });
              },
              onNumAlgaeProcessSuccess: (int value) {
                setState(() {
                  if (value < 0) {
                    value = 0;
                  }
                  widget.matchScoutingData.teleNumAlgaeProcessSuccess = value;
                  widget.onChange!(widget.matchScoutingData);
                });
              },
              onNumAlgaeNetAttempt: (int value) {
                setState(() {
                  if (value < 0) {
                    value = 0;
                  }
                  widget.matchScoutingData.teleNumAlgaeNetAttempt = value;
                  widget.onChange!(widget.matchScoutingData);
                });
              },
              onNumAlgaeNetSuccess: (int value) {
                setState(() {
                  if (value < 0) {
                    value = 0;
                  }
                  widget.matchScoutingData.teleNumAlgaeNetSuccess = value;
                  widget.onChange!(widget.matchScoutingData);
                });
              },
              onNumAlgaeAttempt: (int value) {
                setState(() {
                  if (value < 0) {
                    value = 0;
                  }
                  widget.matchScoutingData.teleNumAlgaeAttempt = value;
                  widget.onChange!(widget.matchScoutingData);
                });
              },
              onNumAlgaeL3Success: (int value) {
                setState(() {
                  if (value < 0) {
                    value = 0;
                  }
                  widget.matchScoutingData.teleNumAlgaeL3Success = value;
                  widget.onChange!(widget.matchScoutingData);
                });
              },
              onNumAlgaeL2Success: (int value) {
                setState(() {
                  if (value < 0) {
                    value = 0;
                  }
                  widget.matchScoutingData.teleNumAlgaeL2Success = value;
                  widget.onChange!(widget.matchScoutingData);
                });
              },
              onNumCoralL2Success: (int value) {
                setState(() {
                  if (value < 0) {
                    value = 0;
                  }
                  widget.matchScoutingData.teleNumCoralL2Success = value;
                  widget.onChange!(widget.matchScoutingData);
                });
              },
              onNumCoralL1Success: (int value) {
                setState(() {
                  if (value < 0) {
                    value = 0;
                  }
                  widget.matchScoutingData.teleNumCoralL1Success = value;
                  widget.onChange!(widget.matchScoutingData);
                });
              },
              onNumCoralAttempt: (int value) {
                setState(() {
                  if (value < 0) {
                    value = 0;
                  }
                  widget.matchScoutingData.teleNumCoralAttempt = value;
                  widget.onChange!(widget.matchScoutingData);
                });
              },
              onNumCoralL3Success: (int value) {
                setState(() {
                  if (value < 0) {
                    value = 0;
                  }
                  widget.matchScoutingData.teleNumCoralL3Success = value;
                  widget.onChange!(widget.matchScoutingData);
                });
              },
              onNumCoralL4Success: (int value) {
                setState(() {
                  if (value < 0) {
                    value = 0;
                  }
                  widget.matchScoutingData.teleNumCoralL4Success = value;
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
                  styleFontSize: styleBodyTextTheme!.fontSize!,
                  matchScoutingData: widget.matchScoutingData,
                  onChanged: (matchScoutingData) {
                    setState(() {
                      widget.onChange!(matchScoutingData);
                    });
                  },
                  onExpanded: (value) {},
                ),
              ]),
        ),
      ),
    ]);
  }
}
