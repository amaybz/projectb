import 'package:flutter/material.dart';
import 'package:projectb/matchscouting/widget_matchscouting_auto.dart';
import 'package:projectb/class/class_macthscoutingdata.dart';
import 'package:projectb/matchscouting/widget_matchscouting_charge_station.dart';
import 'package:projectb/matchscouting/widget_matchscouting_human.dart';
import 'package:projectb/matchscouting/widget_matchscouting_grids.dart';

import '../widgets/widget_headingmain.dart';

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
    this.onAutoNumMidConeSuccessChange,
    this.onAutoNumLowConeSuccessChange,
    this.onAutoNumHighConeSuccessChange,
    this.onAutoNumCubeAttemptChange,
    this.onAutoNumCellSuccessChange,
    this.styleCounterButtonHeight = 25,
    this.styleCounterButtonWidth = 30,
    this.styleFontSizeHeadings = 18,
    this.onChanged,
  }) : super(key: key);

  final MatchScoutingData matchScoutingData;
  final double styleImgFieldMapWidth;
  final double styleImgFieldPerformanceWidth;
  final double styleCounterButtonHeight;
  final double styleCounterButtonWidth;
  final double styleFontSizeHeadings;
  final ValueChanged<int>? onAutoNumCubeAttemptChange;
  final ValueChanged<int>? onAutoNumCellSuccessChange;
  final ValueChanged<bool>? onLoseStartObjectChange;
  final ValueChanged<bool>? onContactWithRobotChange;
  final ValueChanged<bool>? onCrossSectorChange;
  final ValueChanged<bool>? onFoulChange;
  final ValueChanged<bool>? onAutoNumHighConeSuccessChange;
  final ValueChanged<bool>? onAutoNumMidConeSuccessChange;
  final ValueChanged<bool>? onAutoNumLowConeSuccessChange;
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
            child: Column(children: <Widget>[

              HeadingMain(
                styleFontSize: widget.styleFontSizeHeadings,
                headingText: "Driver Position",
                //backGroundColor: Colors.green,
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
        FractionallySizedBox(
          widthFactor: 0.99,
          child: Container(
            padding: EdgeInsets.all(4.0),
            margin: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(

            ),
            child: Column(children: <Widget>[
              HeadingMain(
                styleFontSize: widget.styleFontSizeHeadings,
                headingText: "Errors",
                //backGroundColor: Colors.green,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    child: Text("Lose Cargo"),
                  ),
                  Switch(
                    value: widget.matchScoutingData.autoFlLoseStartObject!,
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
                      value: widget.matchScoutingData.autoFlRobotContact!,
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
                      value: widget.matchScoutingData.autoFlCrossOver!,
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
                    value: widget.matchScoutingData.autoFlFoul!,
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

        GridsWidget(
          styleCounterButtonHeight: widget.styleCounterButtonHeight,
          styleCounterButtonWidth: widget.styleCounterButtonWidth,
          styleImgFieldWidth: widget.styleImgFieldPerformanceWidth,
          matchScoutingData: widget.matchScoutingData,
          onChange: (MatchScoutingData newData) {
            setState(() {
              widget.onChanged!(widget.matchScoutingData);
            });
          },
          numConeAttempt: widget.matchScoutingData.autoNumConeAttempt,
          numHighConeSuccess: widget.matchScoutingData.autoNumHighConeSuccess,
          numCubeAttempt: widget.matchScoutingData.autoNumCubeAttempt,
          numLowConeSuccess: widget.matchScoutingData.autoNumLowConeSuccess,
          numMidConeSuccess:
              widget.matchScoutingData.autoNumMidConeSuccess,
          numHighCubeSuccess:
              widget.matchScoutingData.autoNumHighCubeSuccess,
          numMidCubeSuccess: widget.matchScoutingData.autoNumMidCubeSuccess,
          numLowCubeSuccess: widget.matchScoutingData.autoNumLowCubeSuccess,
          onNumHighCubeSuccessChanged: (int value) {
            setState(() {
              if (value < 0) {
                value = 0;
              }
              widget.matchScoutingData.autoNumHighCubeSuccess = value;
              widget.onChanged!(widget.matchScoutingData);
            });
          },
          onNumHighConeSuccessChanged: (int value) {
            setState(() {
              if (value < 0) {
                value = 0;
              }
              widget.matchScoutingData.autoNumHighConeSuccess = value;
              widget.onChanged!(widget.matchScoutingData);
            });
          },
          onNumCubeAttemptChanged: (int value) {
            setState(() {
              if (value < 0) {
                value = 0;
              }
              widget.matchScoutingData.autoNumCubeAttempt = value;
              widget.onChanged!(widget.matchScoutingData);
            });
          },
          onNumLowConeSuccessChanged: (int value) {
            setState(() {
              if (value < 0) {
                value = 0;
              }
              widget.matchScoutingData.autoNumLowConeSuccess = value;
              widget.onChanged!(widget.matchScoutingData);
            });
          },
          onNumConeAttemptChanged: (int value) {
            setState(() {
              if (value < 0) {
                value = 0;
              }
              widget.matchScoutingData.autoNumConeAttempt = value;
              widget.onChanged!(widget.matchScoutingData);
            });
          },
          onNumMidConeSuccessChanged: (int value) {
            setState(() {
              if (value < 0) {
                value = 0;
              }
              widget.matchScoutingData.autoNumMidConeSuccess = value;
              widget.onChanged!(widget.matchScoutingData);
            });
          },
          onNumMidCubeSuccessChanged: (int value) {
            setState(() {
              if (value < 0) {
                value = 0;
              }
              widget.matchScoutingData.autoNumMidCubeSuccess = value;
              widget.onChanged!(widget.matchScoutingData);
            });
          },
          onNumLowCubeSuccessChanged: (int value) {
            setState(() {
              if (value < 0) {
                value = 0;
              }
              widget.matchScoutingData.autoNumLowCubeSuccess = value;
              widget.onChanged!(widget.matchScoutingData);
            });
          },
        ),
        ChargeStation(matchScoutingData: widget.matchScoutingData,
        onChanged: (matchScoutingData) {
          widget.onChanged!(matchScoutingData);
        }
        )
      ],
    );
  }
}
