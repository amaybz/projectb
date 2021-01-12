import 'package:flutter/material.dart';
import 'package:projectb/dropdown_widget.dart';
import 'package:projectb/sharedprefs.dart';
import 'package:projectb/counter_widget.dart';

class TeleOpScreen extends StatefulWidget {
  const TeleOpScreen({
    Key key,
    this.intBuddies,
    this.intPenalSuccess,
    this.intCellSuccess,
    this.intCellAttempts,
    this.intPenalAttempts,
    this.onBuddiesChanged,
    this.onCellAttemptsChanged,
    this.onCellSuccessChanged,
    this.onPenalAttemptsChanged,
    this.onPenalSuccessChanged,
    this.endgameBalance,
    this.endgameBalanceCorrection,
    this.endgameClimb,
    this.endgameFall,
    this.endgameOutcome,
    this.endgamePark,
    this.endgamePreferredPosition,
    this.endgameTimeFromGripToClimb,
    this.endgameTimeToGrip,
    this.onEndgameParkChanged,
  }) : super(key: key);


  final int intCellAttempts;
  final int intCellSuccess;
  final int intPenalAttempts;
  final int intPenalSuccess;
  final int intBuddies;
  final bool endgamePark;
  final String endgameClimb;
  final String endgameTimeToGrip;
  final String endgameTimeFromGripToClimb;
  final String endgameOutcome;
  final String endgamePreferredPosition;
  final bool endgameBalance;
  final bool endgameBalanceCorrection;
  final bool endgameFall;

  final ValueChanged<int> onCellAttemptsChanged;
  final ValueChanged<int> onCellSuccessChanged;
  final ValueChanged<int> onPenalAttemptsChanged;
  final ValueChanged<int> onPenalSuccessChanged;
  final ValueChanged<int> onBuddiesChanged;
  final ValueChanged<bool> onEndgameParkChanged;


  @override
  _TeleOpScreenState createState() => _TeleOpScreenState();
}

class _TeleOpScreenState extends State<TeleOpScreen> {
  final TextEditingController _txtCellAttempts = TextEditingController();
  final TextEditingController _txtCellSuccess = TextEditingController();

  MySharedPrefs mySharedPrefs = new MySharedPrefs();

  @override
  void initState() {
    super.initState();
    //get values from SharedPrefs
    updateValuesFromSP();
  }

  updateValuesFromSP() async {
    intCellAttempts = await mySharedPrefs.readInt("CellAttempts");
    intCellSuccess = await mySharedPrefs.readInt("CellSuccess");
    intPenalAttempts = await mySharedPrefs.readInt("PenalAttempts");
    intPenalSuccess = await mySharedPrefs.readInt("PenalSuccess");
    intBuddies = await mySharedPrefs.readInt("intBuddies");
    selectedLower = await mySharedPrefs.readBool("selectedLower");
    selectedOuter = await mySharedPrefs.readBool("selectedOuter");
    selectedInner = await mySharedPrefs.readBool("selectedInner");
    selectedRotationControl =
        await mySharedPrefs.readBool("selectedRotationControl");
    selectedPositionControl =
        await mySharedPrefs.readBool("selectedPositionControl");
    selectedPark = await mySharedPrefs.readBool("selectedPark");
    selectedBalance = await mySharedPrefs.readBool("selectedBalance");
    selectedBalanceCorrection =
        await mySharedPrefs.readBool("selectedBalanceCorrection");
    selectedFall = await mySharedPrefs.readBool("selectedFall");
    setState(() {
      _txtCellAttempts.text = intCellAttempts.toString();
      _txtCellSuccess.text = intCellSuccess.toString();
    });
  }

  //Switch Varibles
  bool selectedOuter = false;
  bool selectedInner = false;
  bool selectedLower = false;
  bool selectedRotationControl = false;
  bool selectedPositionControl = false;
  bool selectedPark = false;
  bool selectedBalance = false;
  bool selectedBalanceCorrection = false;
  bool selectedFall = false;

  //counters
  int intCellAttempts = 0;
  int intCellSuccess = 0;
  int intPenalAttempts = 0;
  int intPenalSuccess = 0;
  int intBuddies = 0;

  //drop down var
  String _selectedClimb;
  String _selectedTimeToGrip;
  String _selectedTimeFromGripToClimb;
  String _selectedOutcome;
  String _selectedPreferredPosition;
  String _selectedTimeTakenRotation;
  String _selectedTimeTakenPosition;

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
    });
    mySharedPrefs.saveInt("PenalAttempts", intPenalAttempts);
  }

  _decreasePenalAttempts() async {
    setState(() {
      intPenalAttempts = intPenalAttempts - 1;
    });
    mySharedPrefs.saveInt("PenalAttempts", intPenalAttempts);
  }

  _increasePenalSuccess() async {
    setState(() {
      intPenalAttempts = intPenalAttempts + 1;
      intPenalSuccess = intPenalSuccess + 1;
    });
    mySharedPrefs.saveInt("PenalSuccess", intPenalSuccess);
    mySharedPrefs.saveInt("PenalAttempts", intPenalAttempts);
  }

  _decreasePenalSuccess() async {
    setState(() {
      intPenalSuccess = intPenalSuccess - 1;
    });
    mySharedPrefs.saveInt("PenalSuccess", intPenalSuccess);
  }

  _increaseCellAttempts() async {
    intCellAttempts = intCellAttempts + 1;
    mySharedPrefs.saveInt("CellAttempts", intCellAttempts);
    setState(() {
      _txtCellAttempts.text = intCellAttempts.toString();
      widget.onCellAttemptsChanged(intCellAttempts);
    });
  }

  _decreaseCellAttempts() async {
    intCellAttempts = intCellAttempts - 1;
    mySharedPrefs.saveInt("CellAttempts", intCellAttempts);
    setState(() {
      _txtCellAttempts.text = intCellAttempts.toString();
      widget.onCellAttemptsChanged(intCellAttempts);
    });
  }

  _updateCellAttempts(int value) {
    intCellAttempts = value;
    mySharedPrefs.saveInt("CellAttempts", intCellAttempts);
    widget.onCellAttemptsChanged(intCellAttempts);
  }

  _increaseCellSuccess() async {
    intCellSuccess = intCellSuccess + 1;
    intCellAttempts = intCellAttempts + 1;
    mySharedPrefs.saveInt("CellSuccess", intCellSuccess);
    mySharedPrefs.saveInt("CellAttempts", intCellAttempts);
    setState(() {
      _txtCellSuccess.text = intCellSuccess.toString();
      _txtCellAttempts.text = intCellAttempts.toString();
      widget.onCellSuccessChanged(intCellSuccess);
      widget.onCellAttemptsChanged(intCellAttempts);
    });
  }

  _decreaseCellSuccess() async {
    intCellSuccess = intCellSuccess - 1;
    mySharedPrefs.saveInt("CellSuccess", intCellSuccess);
    setState(() {
      _txtCellSuccess.text = intCellSuccess.toString();
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
    if (_txtCellAttempts.text == "") {
      _txtCellAttempts.text = "0";
    }
    if (_txtCellSuccess.text == "") {
      _txtCellSuccess.text = "0";
    }

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
                            value: selectedOuter,
                            onChanged: (value) {
                              mySharedPrefs.saveBool("selectedOuter", value);
                              setState(() {
                                selectedOuter = value;
                              });
                            }),
                      ]),
                      Row(children: [
                        Text("Inner"),
                        Switch(
                            value: selectedInner,
                            onChanged: (value) {
                              mySharedPrefs.saveBool("selectedInner", value);
                              setState(() {
                                selectedInner = value;
                              });
                            }),
                      ]),
                      Row(children: [
                        Text("Lower"),
                        Switch(
                            value: selectedLower,
                            onChanged: (value) {
                              mySharedPrefs.saveBool("selectedLower", value);
                              setState(() {
                                selectedLower = value;
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
                            value: selectedRotationControl,
                            onChanged: (value) {
                              mySharedPrefs.saveBool(
                                  "selectedRotationControl", value);
                              setState(() {
                                selectedRotationControl = value;
                              });
                            }),
                      ]),
                      DropDownWidget(
                          value: _selectedTimeTakenRotation,
                          title: "Time Taken",
                          list: listTime,
                        styleFieldWidth: styleTimeTakenWidth,
                        onStateChanged: (String newValue) {
                          setState(() {
                            _selectedTimeTakenRotation = newValue;
                          });
                        },),
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
                        value: intPenalSuccess,
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
                          mySharedPrefs.saveInt(
                              "PenalSuccess", intPenalSuccess);
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
                            value: selectedPositionControl,
                            onChanged: (value) {
                              mySharedPrefs.saveBool(
                                  "selectedPositionControl", value);
                              setState(() {
                                selectedPositionControl = value;
                              });
                            }),
                      ]),
                      Row(children: [
                        DropDownWidget(
                          value: _selectedTimeTakenPosition,
                          title: "Time Taken",
                          list: listTime,
                          styleFieldWidth: styleTimeTakenWidth,
                          onStateChanged: (String newValue) {
                            setState(() {
                              _selectedTimeTakenPosition = newValue;
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
                              value: widget.endgamePark,
                              onChanged: (value) {
                                mySharedPrefs.saveBool("selectedPark", value);
                                setState(() {
                                  widget.onEndgameParkChanged(value);
                                });
                              }),
                        ]),
                    DropDownWidget(
                        value: _selectedClimb,
                        title: "Climb",
                        list: listSuccessFailNA,
                        styleFieldWidth: styleFieldControlPanelDropDownsWidth,
                        onStateChanged: (String newValue) {
                          setState(() {
                            _selectedClimb = newValue;
                          });
                        }),
                    DropDownWidget(
                        value: _selectedTimeToGrip,
                        title: "Time to Grip",
                        list: listTime,
                        styleFieldWidth: styleFieldControlPanelDropDownsWidth,
                        onStateChanged: (String newValue) {
                          setState(() {
                            _selectedTimeToGrip = newValue;
                          });
                        }),
                    DropDownWidget(
                      value: _selectedTimeFromGripToClimb,
                      title: "Time from Grip to Climb",
                      list: listTime,
                      styleFieldWidth: styleFieldControlPanelDropDownsWidth,
                      onStateChanged: (String newValue) {
                        setState(() {
                          _selectedTimeFromGripToClimb = newValue;
                        });
                      },
                    ),
                    DropDownWidget(
                        value: _selectedOutcome,
                        title: "Outcome",
                        list: listOutcomes,
                        styleFieldWidth: styleFieldControlPanelDropDownsWidth,
                        onStateChanged: (String newValue) {
                          setState(() {
                            _selectedOutcome = newValue;
                          });
                        }),
                    DropDownWidget(
                        value: _selectedPreferredPosition,
                        title: "Preferred Position",
                        list: listPositions,
                        styleFieldWidth: styleFieldControlPanelDropDownsWidth,
                        onStateChanged: (String newValue) {
                          setState(() {
                            _selectedPreferredPosition = newValue;
                          });
                        }),
                    CounterWidget(
                      value: intBuddies,
                      title: 'Buddies',
                      onIncreaseStateChanged: (int value) {
                        setState(() {
                          intBuddies = intBuddies + 1;
                        });
                        mySharedPrefs.saveInt("intBuddies", intBuddies);
                      },
                      onDecreaseStateChanged: (int value) {
                        setState(() {
                          intBuddies = intBuddies - 1;
                        });
                        mySharedPrefs.saveInt("intBuddies", intBuddies);
                      },
                      onSetValue: (int value) {
                        intBuddies = value;
                        mySharedPrefs.saveInt("intBuddies", intBuddies);
                      },
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Balance:"),
                          Switch(
                              value: selectedBalance,
                              onChanged: (value) {
                                mySharedPrefs.saveBool(
                                    "selectedBalance", value);
                                setState(() {
                                  selectedBalance = value;
                                });
                              }),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Balance Correction:"),
                          Switch(
                              value: selectedBalanceCorrection,
                              onChanged: (value) {
                                mySharedPrefs.saveBool(
                                    "selectedBalanceCorrection", value);
                                setState(() {
                                  selectedBalanceCorrection = value;
                                });
                              }),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Fall:"),
                          Switch(
                              value: selectedFall,
                              onChanged: (value) {
                                mySharedPrefs.saveBool("selectedFall", value);
                                setState(() {
                                  selectedFall = value;
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
