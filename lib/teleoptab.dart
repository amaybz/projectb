// @dart = 2.7
import 'package:flutter/material.dart';
import 'package:projectb/localdb.dart';
import 'package:projectb/matchscouting/widget_matchscouting_endgame_climb.dart';
import 'package:projectb/sharedprefs.dart';
import 'package:projectb/widget_counter.dart';
import 'file:///D:/SDK/projectb/projectb/lib/matchscouting/widget_matchscouting_performace.dart';
import 'package:projectb/widget_dropdown_indexed.dart';
import 'package:projectb/class_macthscoutingdata.dart';

class TeleOpScreen extends StatefulWidget {
  const TeleOpScreen({
    Key key,
    this.matchScoutingData,
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
    this.onEndgameParkChanged,
    this.onEndgameClimbChanged,
    this.onEndgameFallChanged,
    this.onChange,
  }) : super(key: key);

  final MatchScoutingData matchScoutingData;
  //onchange
  final ValueChanged<bool> onPowerPortLowerChanged;
  final ValueChanged<bool> onPowerPortInnerChanged;
  final ValueChanged<bool> onPowerPortOuterChanged;
  final ValueChanged<int> onCellAttemptsChanged;
  final ValueChanged<int> onCellSuccessChanged;
  final ValueChanged<bool> onCPRotationControlChanged;
  final ValueChanged<String> onCPRotationTimeTakenChange;
  final ValueChanged<bool> onCPPositionControlChanged;
  final ValueChanged<String> onCPPositionTimeTakenChange;
  final ValueChanged<int> onCPPanelAttemptsChanged;
  final ValueChanged<int> onCPPanelSuccessChanged;
  final ValueChanged<bool> onEndgameParkChanged;
  final ValueChanged<MatchScoutingData> onEndgameClimbChanged;
  final ValueChanged<bool> onEndgameFallChanged;
  final ValueChanged<MatchScoutingData> onChange;

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
    setState(() {
      intCellAttempts = widget.matchScoutingData.teleNumCargoHighAttempt;
      intCellSuccess = widget.matchScoutingData.teleNumCargoHighSuccess;
    });
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
      PerformanceWidget(
        numCargoHighAttempt: widget.matchScoutingData.teleNumCargoHighAttempt,
        numCargoHighSuccess: widget.matchScoutingData.teleNumCargoHighSuccess,
        numCargoLowAttempt: widget.matchScoutingData.teleNumCargoLowAttempt,
        numCargoLowSuccess: widget.matchScoutingData.teleNumCargoLowSuccess,
        onChange: (MatchScoutingData newData) {
          setState(() {
            widget.matchScoutingData.teleNumCargoHighAttempt =
                newData.teleNumCargoHighAttempt;
            widget.matchScoutingData.teleNumCargoHighSuccess =
                newData.teleNumCargoHighSuccess;
            widget.onChange(widget.matchScoutingData);
          });
        },
        numCargoTerminalAttempt:
            widget.matchScoutingData.teleNumCargoTerminalAttempt,
        numCargoTerminalSuccess:
            widget.matchScoutingData.teleNumCargoTerminalSuccess,
        onNumCargoHighAttemptChanged: (int value) {
          setState(() {
            if (value < 0) {
              value = 0;
            }
            widget.matchScoutingData.teleNumCargoHighAttempt = value;
          });
        },
        onNumCargoHighSuccessChanged: (int value) {
          setState(() {
            if (value < 0) {
              value = 0;
            }
            widget.matchScoutingData.teleNumCargoHighSuccess = value;
          });
        },
        onNumCargoLowAttemptChanged: (int value) {
          setState(() {
            if (value < 0) {
              value = 0;
            }
            widget.matchScoutingData.teleNumCargoLowAttempt = value;
          });
        },
        onNumCargoLowSuccessChanged: (int value) {
          setState(() {
            widget.matchScoutingData.teleNumCargoLowSuccess = value;
          });
        },
        onNumCargoTerminalAttemptChanged: (int value) {
          setState(() {
            if (value < 0) {
              value = 0;
            }
            widget.matchScoutingData.teleNumCargoTerminalAttempt = value;
          });
        },
        onNumCargoTerminalSuccessChanged: (int value) {
          setState(() {
            if (value < 0) {
              value = 0;
            }
            widget.matchScoutingData.teleNumCargoTerminalSuccess = value;
          });
        },
      ),
      FractionallySizedBox(
        widthFactor: 0.99,
        child: Container(
          margin: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            //color: Colors.red,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
          ),
          padding: EdgeInsets.all(4.0),
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: Colors.grey,
              ),
              child: Column(children: [
                Text("End Game"),
              ]),
            ),
            Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Hangar:"),
                          Switch(
                              value: widget.matchScoutingData.teleFlHanger,
                              onChanged: (value) {
                                setState(() {
                                  widget.onEndgameParkChanged(value);
                                });
                              }),
                        ]),
                    EndGameClimb(
                      matchScoutingData: widget.matchScoutingData,
                      onChanged: (matchScoutingData) {
                        setState(() {
                          widget.onEndgameClimbChanged(matchScoutingData);
                        });
                      },
                      onExpanded: (value) {},
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Transition?:"),
                          Switch(
                              value: widget.matchScoutingData.flClimbTransition,
                              onChanged: (value) {
                                setState(() {
                                  widget.matchScoutingData.flClimbTransition =
                                      value;
                                  widget.onChange(widget.matchScoutingData);
                                });
                              }),
                        ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Time (Transition):",
                        ),
                        DropdownButton(
                          value:
                              widget.matchScoutingData.idTransitionSpeed == null
                                  ? null
                                  : widget.matchScoutingData.idTransitionSpeed,
                          items: ddsSpeed,
                          onChanged: (item) {
                            setState(() {
                              widget.matchScoutingData.idTransitionSpeed = item;
                              widget.onChange(widget.matchScoutingData);
                            });
                            print("idTransitionSpeed: " +
                                widget.matchScoutingData.idTransitionSpeed);
                          },
                        ),
                      ],
                    ),
                  ]),
            ),
          ]),
        ),
      ),
    ]);
  }
}
