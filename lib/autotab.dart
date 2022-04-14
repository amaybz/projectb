import 'package:flutter/material.dart';
import 'file:///D:/SDK/projectb/projectb/lib/matchscouting/widget_matchscouting_performace.dart';
import 'file:///D:/SDK/projectb/projectb/lib/matchscouting/widget_matchscouting_human.dart';
import 'package:projectb/matchscouting/widget_matchscouting_auto.dart';
import 'package:projectb/class_macthscoutingdata.dart';

class AutoTab extends StatefulWidget {
  const AutoTab({
    Key? key,
    required this.styleImgFieldMapWidth,
    required this.matchScoutingData,
    this.styleImgFieldPerformanceWidth = 150,
    this.onLoseStartObjectChange,
    this.onContactWithRobotChange,
    this.onCrossSectorChange,
    this.onFoulChange,
    this.onAutoFlInnerChange,
    this.onAutoFlLowerChange,
    this.onAutoFlOuterChange,
    this.onAutoNumCellAttemptChange,
    this.onAutoNumCellSuccessChange,
    this.styleCounterButtonHeight = 25,
    this.styleCounterButtonWidth = 30,
    this.onChanged,
  }) : super(key: key);

  final matchScoutingData;
  final double styleImgFieldMapWidth;
  final double styleImgFieldPerformanceWidth;
  final double styleCounterButtonHeight;
  final double styleCounterButtonWidth;
  final ValueChanged<int>? onAutoNumCellAttemptChange;
  final ValueChanged<int>? onAutoNumCellSuccessChange;
  final ValueChanged<bool>? onLoseStartObjectChange;
  final ValueChanged<bool>? onContactWithRobotChange;
  final ValueChanged<bool>? onCrossSectorChange;
  final ValueChanged<bool>? onFoulChange;
  final ValueChanged<bool>? onAutoFlOuterChange;
  final ValueChanged<bool>? onAutoFlInnerChange;
  final ValueChanged<bool>? onAutoFlLowerChange;
  final ValueChanged<MatchScoutingData>? onChanged;

  @override
  _AutoTabState createState() => _AutoTabState();
}

class _AutoTabState extends State<AutoTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
            child: Column(children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: Colors.grey,
                ),
                child: Text(
                  "Driver Position",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              //Image.asset('assets/imgs/field.png'),
              Container(
                decoration: BoxDecoration(
                    //border: Border.all(color: Colors.black),
                    //image: DecorationImage(
                    // image: AssetImage("assets/imgs/field.png"),
                    // fit: BoxFit.cover,
                    //),
                    ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(5.0),
                          padding: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: Colors.blue,
                          ),
                          child: Text(
                            "1",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(5.0),
                          padding: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: Colors.blue,
                          ),
                          child: Text(
                            "2",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(5.0),
                          padding: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: Colors.blue,
                          ),
                          child: Text(
                            "3",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ]),
                      Column(children: <Widget>[
                        SizedBox(
                          width: widget.styleImgFieldMapWidth,
                          height: (widget.styleImgFieldMapWidth * 0.45),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              color: Colors.grey,
                            ),
                            child: Image.asset("assets/imgs/field.png"),
                          ),
                        ),
                      ]),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.all(5.0),
                              padding: EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: Colors.red,
                              ),
                              child: Text(
                                "3",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(5.0),
                              padding: EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: Colors.red,
                              ),
                              child: Text(
                                "2",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(5.0),
                              padding: EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: Colors.red,
                              ),
                              child: Text(
                                "1",
                                style: TextStyle(fontSize: 18),
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
            padding: EdgeInsets.all(4.0),
            margin: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            child: Column(children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: Colors.grey,
                ),
                child: Text(
                  "Errors",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    child: Text("Lose Cargo"),
                  ),
                  Switch(
                    value: widget.matchScoutingData.autoFlLoseStartObject,
                    onChanged: (bool value) {
                      setState(() {
                        widget.onLoseStartObjectChange!(value);
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    child: Text("Hit Robot"),
                  ),
                  Switch(
                      value: widget.matchScoutingData.autoFlRobotContact,
                      onChanged: (bool value) {
                        setState(() {
                          widget.onContactWithRobotChange!(value);
                        });
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    child: Text("Cross Sector"),
                  ),
                  Switch(
                      value: widget.matchScoutingData.autoFlCrossOver,
                      onChanged: (bool value) {
                        setState(() {
                          widget.onCrossSectorChange!(value);
                        });
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    child: Text("Foul"),
                  ),
                  Switch(
                    value: widget.matchScoutingData.autoFlFoul,
                    onChanged: (bool value) {
                      setState(() {
                        widget.onFoulChange!(value);
                      });
                    },
                  ),
                ],
              ),
            ]),
          ),
        ),
        MatchAuto(
          matchScoutingData: widget.matchScoutingData,
          styleCounterButtonHeight: widget.styleCounterButtonHeight,
          styleCounterButtonWidth: widget.styleCounterButtonWidth,
          onChanged: (MatchScoutingData updates) {
            setState(() {
              widget.onChanged!(updates);
            });
          },
          onExpanded: (value) {},
        ),
        PerformanceWidget(
          styleCounterButtonHeight: widget.styleCounterButtonHeight,
          styleCounterButtonWidth: widget.styleCounterButtonWidth,
          styleImgFieldWidth: widget.styleImgFieldPerformanceWidth,
          matchScoutingData: widget.matchScoutingData,
          onChange: (MatchScoutingData newData) {
            setState(() {
              widget.onChanged!(widget.matchScoutingData);
            });
          },
          numCargoHighAttempt: widget.matchScoutingData.autoNumCargoHighAttempt,
          numCargoHighSuccess: widget.matchScoutingData.autoNumCargoHighSuccess,
          numCargoLowAttempt: widget.matchScoutingData.autoNumCargoLowAttempt,
          numCargoLowSuccess: widget.matchScoutingData.autoNumCargoLowSuccess,
          numCargoTerminalAttempt:
              widget.matchScoutingData.autoNumCargoTerminalAttempt,
          numCargoTerminalSuccess:
              widget.matchScoutingData.autoNumCargoTerminalSuccess,
          onNumCargoHighAttemptChanged: (int value) {
            setState(() {
              if (value < 0) {
                value = 0;
              }
              widget.matchScoutingData.autoNumCargoHighAttempt = value;
              widget.onChanged!(widget.matchScoutingData);
            });
          },
          onNumCargoHighSuccessChanged: (int value) {
            setState(() {
              if (value < 0) {
                value = 0;
              }
              widget.matchScoutingData.autoNumCargoHighSuccess = value;
              widget.onChanged!(widget.matchScoutingData);
            });
          },
          onNumCargoLowAttemptChanged: (int value) {
            setState(() {
              if (value < 0) {
                value = 0;
              }
              widget.matchScoutingData.autoNumCargoLowAttempt = value;
              widget.onChanged!(widget.matchScoutingData);
            });
          },
          onNumCargoLowSuccessChanged: (int value) {
            setState(() {
              if (value < 0) {
                value = 0;
              }
              widget.matchScoutingData.autoNumCargoLowSuccess = value;
              widget.onChanged!(widget.matchScoutingData);
            });
          },
          onNumCargoTerminalAttemptChanged: (int value) {
            setState(() {
              if (value < 0) {
                value = 0;
              }
              widget.matchScoutingData.autoNumCargoTerminalAttempt = value;
              widget.onChanged!(widget.matchScoutingData);
            });
          },
          onNumCargoTerminalSuccessChanged: (int value) {
            setState(() {
              if (value < 0) {
                value = 0;
              }
              widget.matchScoutingData.autoNumCargoTerminalSuccess = value;
              widget.onChanged!(widget.matchScoutingData);
            });
          },
        ),
        HumanWidget(
          styleCounterButtonHeight: widget.styleCounterButtonHeight,
          styleCounterButtonWidth: widget.styleCounterButtonWidth,
          autoNumCargoHumanAttempt:
              widget.matchScoutingData.autoNumCargoHumanAttempt,
          autoNumCargoHumanHighSuccess:
              widget.matchScoutingData.autoNumCargoHumanHighSuccess,
          autoNumCargoHumanLowSuccess:
              widget.matchScoutingData.autoNumCargoHumanLowSuccess,
          autoNumCargoHumanField:
              widget.matchScoutingData.autoNumCargoHumanField,
          autoNumCargoHumanRobot:
              widget.matchScoutingData.autoNumCargoHumanRobot,
          onAutoNumCargoHumanAttemptChanged: (int value) {
            setState(() {
              if (value < 0) {
                value = 0;
              }
              widget.matchScoutingData.autoNumCargoHumanAttempt = value;
              widget.onChanged!(widget.matchScoutingData);
            });
          },
          onAutoNumCargoHumanHighSuccessChanged: (int value) {
            setState(() {
              if (value < 0) {
                value = 0;
              }
              widget.matchScoutingData.autoNumCargoHumanHighSuccess = value;
              widget.onChanged!(widget.matchScoutingData);
            });
          },
          onAutoNumCargoHumanLowSuccessChanged: (int value) {
            setState(() {
              if (value < 0) {
                value = 0;
              }
              widget.matchScoutingData.autoNumCargoHumanLowSuccess = value;
              widget.onChanged!(widget.matchScoutingData);
            });
          },
          onAutoNumCargoHumanFieldChanged: (int value) {
            setState(() {
              if (value < 0) {
                value = 0;
              }
              widget.matchScoutingData.autoNumCargoHumanField = value;
              widget.onChanged!(widget.matchScoutingData);
            });
          },
          onAutoNumCargoHumanRobotChanged: (int value) {
            setState(() {
              if (value < 0) {
                value = 0;
              }
              widget.matchScoutingData.autoNumCargoHumanRobot = value;
              widget.onChanged!(widget.matchScoutingData);
            });
          },
        ),
      ],
    );
  }
}
