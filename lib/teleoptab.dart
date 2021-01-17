import 'package:flutter/material.dart';
import 'package:projectb/widget_dropdown.dart';
import 'package:projectb/localdb.dart';
import 'package:projectb/sharedprefs.dart';
import 'package:projectb/widget_counter.dart';

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
      intPenalAttempts = widget.matchScoutingData.cpPanelAttempts;
      intPenalSuccess = widget.matchScoutingData.cpPanelSuccess;
      intBuddies = widget.matchScoutingData.endgameBuddies;
      intCellAttempts = widget.matchScoutingData.cellAttempts;
      intCellSuccess = widget.matchScoutingData.cellSuccess;
    });
  }

  //counters
  int intCellAttempts = 0;
  int intCellSuccess = 0;
  int intPenalAttempts = 0;
  int intPenalSuccess = 0;
  int intBuddies = 0;

  //lists
  final List<String> listSuccessFailNA = ['NA', 'Success', 'Fail'];

  final List<String> listTime = [
    'NA',
    'Slow (> 7 Secs)',
    'Medium ( 3-7 Secs)',
    'Fast ( <3 Secs)',
  ];

  final List<String> listOutcomes = [
    'NA',
    'Self',
    'Self + Others',
    'Others',
  ];

  final List<String> listPositions = [
    'NA',
    'Inner',
    'Middle',
    'Outer',
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
      intPenalSuccess = intPenalSuccess - 1;
      widget.onCPPanelSuccessChanged(intPenalSuccess);
    });
  }

  _increaseCellAttempts() async {
    intCellAttempts = intCellAttempts + 1;
    setState(() {
      widget.onCellAttemptsChanged(intCellAttempts);
    });
  }

  _decreaseCellAttempts() async {
    setState(() {
      intCellAttempts = intCellAttempts - 1;
      widget.onCellAttemptsChanged(intCellAttempts);
    });
  }

  _updateCellAttempts(int value) {
    setState(() {
      intCellAttempts = value;
      widget.onCellAttemptsChanged(intCellAttempts);
    });
  }

  _increaseCellSuccess() async {
    intCellSuccess = intCellSuccess + 1;
    intCellAttempts = intCellAttempts + 1;
    setState(() {
      widget.onCellSuccessChanged(intCellSuccess);
      widget.onCellAttemptsChanged(intCellAttempts);
    });
  }

  _decreaseCellSuccess() async {
    intCellSuccess = intCellSuccess - 1;
    setState(() {
      widget.onCellSuccessChanged(intCellSuccess);
    });
  }

  _updateCellSuccess(int value) {
    intCellSuccess = value;
    mySharedPrefs.saveInt("CellSuccess", intCellSuccess);
    widget.onCellSuccessChanged(intCellSuccess);
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
                Text("Power Port"),
              ]),
            ),
            Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(children: [
                      CounterWidget(
                        value: intCellAttempts,
                        title: "Cell Attempts",
                        styleFontSize: styleFontSizeBody,
                        onIncreaseStateChanged: (int increase) {
                          _increaseCellAttempts();
                        },
                        onDecreaseStateChanged: (int decrease) {
                          _decreaseCellAttempts();
                        },
                        onSetValue: (int value) {
                          _updateCellAttempts(value);
                        },
                      ),
                      CounterWidget(
                        value: intCellSuccess,
                        title: "Cell Success",
                        styleFontSize: styleFontSizeBody,
                        onIncreaseStateChanged: (int increase) {
                          _increaseCellSuccess();
                        },
                        onDecreaseStateChanged: (int decrease) {
                          _decreaseCellSuccess();
                        },
                        onSetValue: (int value) {
                          _updateCellSuccess(value);
                        },
                      ),
                    ]),
                    Column(children: [
                      Row(children: [
                        SizedBox(
                          width: styleImgFieldWidth,
                          height: (styleImgFieldWidth * 0.5),
                          child: Container(
                            decoration: BoxDecoration(
                                //border: Border.all(color: Colors.grey),
                                //color: Colors.white,
                                ),
                            child: Image.asset("assets/imgs/ports.png"),
                          ),
                        ),
                      ])
                    ]),
                    Column(children: [
                      Row(children: [
                        Text("Outer"),
                        Switch(
                            value: widget.matchScoutingData.powerPortOuter,
                            onChanged: (value) {
                              mySharedPrefs.saveBool("selectedOuter", value);
                              setState(() {
                                widget.onPowerPortOuterChanged(value);
                              });
                            }),
                      ]),
                      Row(children: [
                        Text("Inner"),
                        Switch(
                            value: widget.matchScoutingData.powerPortInner,
                            onChanged: (value) {
                              mySharedPrefs.saveBool("selectedInner", value);
                              setState(() {
                                widget.onPowerPortInnerChanged(value);
                              });
                            }),
                      ]),
                      Row(children: [
                        Text("Lower"),
                        Switch(
                            value: widget.matchScoutingData.powerPortLower,
                            onChanged: (value) {
                              setState(() {
                                widget.onPowerPortLowerChanged(value);
                              });
                            }),
                      ]),
                    ]),
                  ]),
            ),
          ]),
        ),
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
                Text("Control Panel"),
              ]),
            ),
            Container(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Rotation Control:"),
                                Switch(
                                    value: widget
                                        .matchScoutingData.cpRotationControl,
                                    onChanged: (value) {
                                      mySharedPrefs.saveBool(
                                          "selectedRotationControl", value);
                                      setState(() {
                                        widget
                                            .onCPRotationControlChanged(value);
                                      });
                                    }),
                              ]),
                          DropDownWidget(
                            value: widget.matchScoutingData.cpRotationTimeTaken,
                            title: "Time Taken",
                            list: listTime,
                            styleFieldWidth: styleTimeTakenWidth,
                            onStateChanged: (String value) {
                              setState(() {
                                widget.onCPRotationTimeTakenChange(value);
                              });
                            },
                          ),
                          CounterWidget(
                            value: intPenalAttempts,
                            title: "Panel Attempts",
                            styleFontSize: styleFontSizeBody,
                            onIncreaseStateChanged: (int increase) {
                              _increasePenalAttempts();
                            },
                            onDecreaseStateChanged: (int decrease) {
                              _decreasePenalAttempts();
                            },
                            onSetValue: (int value) {
                              intPenalAttempts = value;
                              mySharedPrefs.saveInt(
                                  "PenalAttempts", intPenalAttempts);
                            },
                          ),
                          CounterWidget(
                            value: widget.matchScoutingData.cpPanelSuccess,
                            title: "Panel Success",
                            styleFontSize: styleFontSizeBody,
                            onIncreaseStateChanged: (int increase) {
                              _increasePenalSuccess();
                            },
                            onDecreaseStateChanged: (int decrease) {
                              _decreasePenalSuccess();
                            },
                            onSetValue: (int value) {
                              intPenalSuccess = value;
                              widget.onCPPanelSuccessChanged(value);
                            },
                          ),
                        ]),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Position Control:"),
                                Switch(
                                    value: widget
                                        .matchScoutingData.cpPositionControl,
                                    onChanged: (value) {
                                      setState(() {
                                        widget
                                            .onCPPositionControlChanged(value);
                                      });
                                    }),
                              ]),
                          Row(children: [
                            DropDownWidget(
                              value:
                                  widget.matchScoutingData.cpPositionTimeTaken,
                              title: "Time Taken",
                              list: listTime,
                              styleFieldWidth: styleTimeTakenWidth,
                              onStateChanged: (String value) {
                                setState(() {
                                  widget.onCPPositionTimeTakenChange(value);
                                });
                              },
                            ),
                          ]),
                          SizedBox(
                            width: styleImgFieldWidth,
                            height: (styleImgFieldWidth * 0.5),
                            child: Container(
                              decoration: BoxDecoration(
                                  //border: Border.all(color: Colors.grey),
                                  //color: Colors.white,
                                  ),
                              child: Image.asset("assets/imgs/tele.png"),
                            ),
                          ),
                        ]),
                  ]),
            ),
          ]),
        ),
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
                          Text("Park:"),
                          Switch(
                              value: widget.matchScoutingData.endgamePark,
                              onChanged: (value) {
                                setState(() {
                                  widget.onEndgameParkChanged(value);
                                });
                              }),
                        ]),
                    DropDownWidget(
                        value: widget.matchScoutingData.endgameClimb,
                        title: "Climb",
                        list: listSuccessFailNA,
                        styleFieldWidth: styleFieldControlPanelDropDownsWidth,
                        onStateChanged: (String newValue) {
                          setState(() {
                            widget.onEndgameClimbChanged(newValue);
                          });
                        }),
                    DropDownWidget(
                        value: widget.matchScoutingData.endgameTimeToGrip,
                        title: "Time to Grip",
                        list: listTime,
                        styleFieldWidth: styleFieldControlPanelDropDownsWidth,
                        onStateChanged: (String value) {
                          setState(() {
                            widget.onEndgameTimeToGripChanged(value);
                          });
                        }),
                    DropDownWidget(
                      value:
                          widget.matchScoutingData.endgameTimeFromGripToClimb,
                      title: "Time from Grip to Climb",
                      list: listTime,
                      styleFieldWidth: styleFieldControlPanelDropDownsWidth,
                      onStateChanged: (String value) {
                        setState(() {
                          widget.onEndgameTimeFromGripToClimbChanged(value);
                        });
                      },
                    ),
                    DropDownWidget(
                        value: widget.matchScoutingData.endgameOutcome,
                        title: "Outcome",
                        list: listOutcomes,
                        styleFieldWidth: styleFieldControlPanelDropDownsWidth,
                        onStateChanged: (String value) {
                          setState(() {
                            widget.onEndgameOutcomeChanged(value);
                          });
                        }),
                    DropDownWidget(
                        value:
                            widget.matchScoutingData.endgamePreferredPosition,
                        title: "Preferred Position",
                        list: listPositions,
                        styleFieldWidth: styleFieldControlPanelDropDownsWidth,
                        onStateChanged: (String newValue) {
                          setState(() {
                            widget.onEndgamePreferredPositionChanged(newValue);
                          });
                        }),
                    CounterWidget(
                      value: widget.matchScoutingData.endgameBuddies,
                      title: 'Buddies',
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
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Balance:"),
                          Switch(
                              value: widget.matchScoutingData.endgameBalance,
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
                                  .matchScoutingData.endgameBalanceCorrection,
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
                              value: widget.matchScoutingData.endgameFall,
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
    ]);
  }
}
