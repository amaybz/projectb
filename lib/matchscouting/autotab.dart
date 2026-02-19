import 'package:flutter/material.dart';
import 'package:projectb/matchscouting/widget_matchscouting_auto.dart';
import 'package:projectb/class/class_macthscoutingdata.dart';
import 'package:projectb/matchscouting/widget_matchscouting_auto_climb.dart';
import 'package:projectb/matchscouting/widget_matchscouting_auto_errors.dart';
import 'package:projectb/matchscouting/widget_matchscouting_score.dart';
import 'package:projectb/widgets/widget_driver_positions.dart';

import '../widgets/widget_headingmain.dart';

class AutoTab extends StatefulWidget {
  const AutoTab({
    Key? key,
    required this.styleImgFieldMapWidth,
    required this.matchScoutingData,
    required this.listShootingTime,
    this.styleImgFieldPerformanceWidth = 150,
    this.onLoseStartObjectChange,
    this.onContactWithRobotChange,
    this.onFoulChange,
    this.styleCounterButtonHeight = 25,
    this.styleCounterButtonWidth = 30,
    this.styleFontSizeHeadings = 18,
    this.onChanged,
    required this.onRecordTime,
  }) : super(key: key);

  final MatchScoutingData matchScoutingData;
  final double styleImgFieldMapWidth;
  final double styleImgFieldPerformanceWidth;
  final double styleCounterButtonHeight;
  final double styleCounterButtonWidth;
  final double styleFontSizeHeadings;
  final ValueChanged<bool>? onLoseStartObjectChange;
  final ValueChanged<bool>? onContactWithRobotChange;
  final ValueChanged<bool>? onFoulChange;
  final List<int> listShootingTime;

  final ValueChanged<MatchScoutingData>? onChanged;
  final ValueChanged<List<int>>? onRecordTime;

  @override
  _AutoTabState createState() => _AutoTabState();
}

class _AutoTabState extends State<AutoTab> {
  TextStyle? styleBodyTextTheme = ThemeData().textTheme.bodyMedium;
  TextStyle? styleTitleTextTheme = ThemeData().textTheme.titleMedium;
  double styleMarginLeftTrap = 90;
  double styleMarginLeftSpeaker = 82;
  double styleMarginTopAmp = 5;
  bool swapLocation = false;
  Color colorLeftSide = Colors.blue;
  Color colorRightSide = Colors.red;
  String teamLeftSide = "2";
  String teamRightSide = "1";
  Image imgFieldMap = Image.asset("assets/imgs/field.png");
  bool highLightLeft1 = false;
  bool highLightLeft2 = false;
  bool highLightLeft3 = false;
  bool highLightRight1 = false;
  bool highLightRight2 = false;
  bool highLightRight3 = false;

  _swapFieldDirections() async {
    if (swapLocation == true) {
      setState(() {
        colorLeftSide = Colors.red;
        colorRightSide = Colors.blue;
        teamLeftSide = "1";
        teamRightSide = "2";
        swapLocation = false;
        imgFieldMap = Image.asset("assets/imgs/fieldinverted.png");
        ;
      });
    } else {
      setState(() {
        colorLeftSide = Colors.blue;
        colorRightSide = Colors.red;
        teamLeftSide = "2";
        teamRightSide = "1";
        swapLocation = true;
        imgFieldMap = Image.asset("assets/imgs/field.png");
      });
    }
    _highlightDriverLocation();
  }

  _highlightDriverLocation() async {
    if (teamLeftSide == widget.matchScoutingData.idAlliance) {
      if (widget.matchScoutingData.idDriveStation == "1") {
        highLightLeft1 = true;
      } else {
        highLightLeft1 = false;
      }
      if (widget.matchScoutingData.idDriveStation == "2") {
        highLightLeft2 = true;
      } else {
        highLightLeft2 = false;
      }
      if (widget.matchScoutingData.idDriveStation == "3") {
        highLightLeft3 = true;
      } else {
        highLightLeft3 = false;
      }
    } else {
      highLightLeft1 = false;
      highLightLeft2 = false;
      highLightLeft3 = false;
    }
    if (teamRightSide == widget.matchScoutingData.idAlliance) {
      if (widget.matchScoutingData.idDriveStation == "1") {
        setState(() {
          highLightRight1 = true;
        });
      } else {
        setState(() {
          highLightRight1 = false;
        });
      }
      if (widget.matchScoutingData.idDriveStation == "2") {
        setState(() {
          highLightRight2 = true;
        });
      } else {
        setState(() {
          highLightRight2 = false;
        });
      }
      if (widget.matchScoutingData.idDriveStation == "3") {
        setState(() {
          highLightRight3 = true;
        });
      } else {
        setState(() {
          highLightRight3 = false;
        });
      }
    } else {
      highLightRight1 = false;
      highLightRight2 = false;
      highLightRight3 = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    _highlightDriverLocation();
    double width = MediaQuery.of(context).size.width;
    if (width < 500) {
      setState(() {
        styleBodyTextTheme = Theme.of(context).textTheme.bodyMedium;
        styleTitleTextTheme = Theme.of(context).textTheme.titleMedium;
        styleMarginLeftTrap = 64;
        styleMarginTopAmp = 5;
        styleMarginLeftSpeaker = 64;
      });
    }
    if (width < 393) {
      setState(() {
        styleBodyTextTheme = Theme.of(context).textTheme.bodySmall;
        styleTitleTextTheme = Theme.of(context).textTheme.titleSmall;
        styleMarginLeftTrap = 63;
        styleMarginTopAmp = 45;
        styleMarginLeftSpeaker = 63;
      });
    }
    if (width >= 600) {
      setState(() {
        styleBodyTextTheme = Theme.of(context).textTheme.bodyLarge;
        styleTitleTextTheme = Theme.of(context).textTheme.titleLarge;
        styleMarginLeftTrap = 100;
        styleMarginTopAmp = 5;
      });
    }

    return Column(
      children: [
        FractionallySizedBox(
          widthFactor: 0.99,
          child: Container(
            margin: const EdgeInsets.all(5.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    HeadingMain(
                      styleFontSize: styleTitleTextTheme!.fontSize!,
                      textColor: Theme.of(context).textTheme.titleLarge!.color!,
                      backGroundColor: Theme.of(context).primaryColor,
                      headingText: "Driver Station Diagram",
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _swapFieldDirections();
                      },
                      child: Image.asset(
                        'assets/imgs/flipImage.png',
                        scale: 25,
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      DriverPositions(
                        LeftSide: true,
                        color: colorLeftSide,
                        highLight1: highLightLeft1,
                        highLight2: highLightLeft2,
                        highLight3: highLightLeft3,
                      ),
                      Column(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: widget.styleImgFieldMapWidth + 80,
                            height: (widget.styleImgFieldMapWidth),
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationY(0),
                              child: imgFieldMap,
                            ),
                          ),
                        ],
                      ),
                      DriverPositions(
                        LeftSide: false,
                        color: colorRightSide,
                        highLight1: highLightRight1,
                        highLight2: highLightRight2,
                        highLight3: highLightRight3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
        MatchAutoErrors(
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
        ScoreWidget(
          styleCounterButtonHeight: widget.styleCounterButtonHeight,
          styleCounterButtonWidth: widget.styleCounterButtonWidth,
          styleImgFieldWidth: widget.styleImgFieldPerformanceWidth,
          styleMarginLeftTrap: styleMarginLeftTrap,
          styleMarginLeftSpeaker: styleMarginLeftSpeaker,
          styleMarginTopAmp: styleMarginTopAmp,
          matchScoutingData: widget.matchScoutingData,
          intScoringType: 1,
          listShootingTime: widget.listShootingTime,
          onRecordTime: (List<int> updatedList) {
            setState(() {
              widget.onRecordTime!(updatedList);
            });
          },
          onChange: (MatchScoutingData newData) {
            setState(() {
              widget.onChanged!(newData);
            });
          },
        ),
        AutoClimb(
          styleCounterButtonHeight: widget.styleCounterButtonHeight,
          styleCounterButtonWidth: widget.styleCounterButtonWidth,
          onChanged: (MatchScoutingData newData) {
            setState(() {
              widget.onChanged!(newData);
            });
          },
          matchScoutingData: widget.matchScoutingData,
        ),
      ],
    );
  }
}
