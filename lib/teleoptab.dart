// @dart = 2.7
import 'package:flutter/material.dart';
import 'package:projectb/localdb.dart';
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
    this.onEndgameTimeToGripChanged,
    this.onEndgameTimeFromGripToClimbChanged,
    this.onEndgameOutcomeChanged,
    this.onEndgamePreferredPositionChanged,
    this.onEndgameBuddiesChanged,
    this.onEndgameBalanceChanged,
    this.onEndgameBalanceCorrectionChanged,
    this.onEndgameFallChanged,
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
  final ValueChanged<String> onEndgameClimbChanged;
  final ValueChanged<String> onEndgameTimeToGripChanged;
  final ValueChanged<String> onEndgameTimeFromGripToClimbChanged;
  final ValueChanged<String> onEndgameOutcomeChanged;
  final ValueChanged<String> onEndgamePreferredPositionChanged;
  final ValueChanged<int> onEndgameBuddiesChanged;
  final ValueChanged<bool> onEndgameBalanceChanged;
  final ValueChanged<bool> onEndgameBalanceCorrectionChanged;
  final ValueChanged<bool> onEndgameFallChanged;

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
      intBuddies = widget.matchScoutingData.teleNumClimbOthers;
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

  final List<DropDownValue> listOutcomes = [
    DropDownValue(id: "1", value: "NA"),
    DropDownValue(id: "2", value: "Self"),
    DropDownValue(id: "3", value: "Self + Others"),
    DropDownValue(id: "4", value: "Others"),
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

  _increasePenalAttempts() async {
    setState(() {
      intPenalAttempts = intPenalAttempts + 1;
      widget.onCPPanelAttemptsChanged(intPenalAttempts);
    });
  }

  _decreasePenalAttempts() async {
    setState(() {
      intPenalAttempts = intPenalAttempts - 1;
      widget.onCPPanelAttemptsChanged(intPenalAttempts);
    });
  }

  _increasePenalSuccess() async {
    setState(() {
      intPenalAttempts = intPenalAttempts + 1;
      intPenalSuccess = intPenalSuccess + 1;
      widget.onCPPanelSuccessChanged(intPenalSuccess);
      widget.onCPPanelAttemptsChanged(intPenalAttempts);
    });
  }

  _decreasePenalSuccess() async {
    setState(() {
      intPenalAttempts = intPenalAttempts - 1;
      intPenalSuccess = intPenalSuccess - 1;
      widget.onCPPanelSuccessChanged(intPenalSuccess);
      widget.onCPPanelAttemptsChanged(intPenalAttempts);
    });
  }

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
                          Text("Park:"),
                          Switch(
                              value: widget.matchScoutingData.teleFlPark,
                              onChanged: (value) {
                                setState(() {
                                  widget.onEndgameParkChanged(value);
                                });
                              }),
                        ]),
                    DropDownIndexedWidget(
                        value: widget.matchScoutingData.teleIdClimb,
                        title: "Climb",
                        dropDownValues: listSuccessFailNA,
                        styleFieldWidth: styleFieldControlPanelDropDownsWidth,
                        onStateChanged: (String newValue) {
                          setState(() {
                            widget.onEndgameClimbChanged(newValue);
                          });
                        }),
                    DropDownIndexedWidget(
                        value: widget.matchScoutingData.teleIdClimbGrabTime,
                        title: "Time to Grip",
                        dropDownValues: listTime,
                        styleFieldWidth: styleFieldControlPanelDropDownsWidth,
                        onStateChanged: (String value) {
                          setState(() {
                            widget.onEndgameTimeToGripChanged(value);
                          });
                        }),
                    DropDownIndexedWidget(
                      value: widget.matchScoutingData.teleIdClimbTime,
                      title: "Time from Grip to Climb",
                      dropDownValues: listTime,
                      styleFieldWidth: styleFieldControlPanelDropDownsWidth,
                      onStateChanged: (String value) {
                        setState(() {
                          widget.onEndgameTimeFromGripToClimbChanged(value);
                        });
                      },
                    ),
                    DropDownIndexedWidget(
                        value: widget.matchScoutingData.teleIdClimbOutcome,
                        title: "Outcome",
                        dropDownValues: listOutcomes,
                        styleFieldWidth: styleFieldControlPanelDropDownsWidth,
                        onStateChanged: (String value) {
                          setState(() {
                            widget.onEndgameOutcomeChanged(value);
                          });
                        }),
                    DropDownIndexedWidget(
                        value: widget.matchScoutingData.teleIdClimbPos,
                        title: "Preferred Position",
                        dropDownValues: listPositions,
                        styleFieldWidth: styleFieldControlPanelDropDownsWidth,
                        onStateChanged: (String newValue) {
                          setState(() {
                            widget.onEndgamePreferredPositionChanged(newValue);
                          });
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Buddies:"),
                        CounterWidget(
                          title: "",
                          value: widget.matchScoutingData.teleNumClimbOthers,
                          onIncreaseStateChanged: (int value) {
                            setState(() {
                              intBuddies = intBuddies + 1;
                              widget.onEndgameBuddiesChanged(intBuddies);
                            });
                          },
                          onDecreaseStateChanged: (int value) {
                            setState(() {
                              intBuddies = intBuddies - 1;
                              widget.onEndgameBuddiesChanged(intBuddies);
                            });
                          },
                          onSetValue: (int value) {
                            intBuddies = value;
                            widget.onEndgameBuddiesChanged(intBuddies);
                          },
                        ),
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Balance:"),
                          Switch(
                              value:
                                  widget.matchScoutingData.teleFlClimbBalance,
                              onChanged: (bool value) {
                                setState(() {
                                  widget.onEndgameBalanceChanged(value);
                                });
                              }),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Balance Correction:"),
                          Switch(
                              value: widget
                                  .matchScoutingData.teleFlClimbCorrection,
                              onChanged: (bool value) {
                                setState(() {
                                  widget
                                      .onEndgameBalanceCorrectionChanged(value);
                                });
                              }),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Fall:"),
                          Switch(
                              value: widget.matchScoutingData.teleFlClimbFall,
                              onChanged: (bool value) {
                                setState(() {
                                  widget.onEndgameFallChanged(value);
                                });
                              }),
                        ]),
                  ]),
            ),
          ]),
        ),
      ),
      PerformanceWidget(
        numCargoHighAttempt: widget.matchScoutingData.teleNumCargoHighAttempt,
        numCargoHighSuccess: widget.matchScoutingData.teleNumCargoHighSuccess,
        numCargoLowAttempt: widget.matchScoutingData.teleNumCargoLowAttempt,
        numCargoLowSuccess: widget.matchScoutingData.teleNumCargoLowSuccess,
        numCargoTerminalAttempt:
            widget.matchScoutingData.teleNumCargoTerminalAttempt,
        numCargoTerminalSuccess:
            widget.matchScoutingData.teleNumCargoTerminalSuccess,
        onNumCargoHighAttemptChanged: (int value) {
          setState(() {
            widget.matchScoutingData.teleNumCargoHighAttempt = value;
          });
        },
        onNumCargoHighSuccessChanged: (int value) {
          setState(() {
            widget.matchScoutingData.teleNumCargoHighSuccess = value;
          });
        },
        onNumCargoLowAttemptChanged: (int value) {
          setState(() {
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
            widget.matchScoutingData.teleNumCargoTerminalAttempt = value;
          });
        },
        onNumCargoTerminalSuccessChanged: (int value) {
          setState(() {
            widget.matchScoutingData.teleNumCargoTerminalSuccess = value;
          });
        },
      ),
    ]);
  }
}
