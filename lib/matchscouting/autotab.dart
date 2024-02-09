import 'package:flutter/material.dart';
import 'package:projectb/matchscouting/widget_matchscouting_auto.dart';
import 'package:projectb/class/class_macthscoutingdata.dart';
import 'package:projectb/matchscouting/widget_matchscouting_auto_errors.dart';
import 'package:projectb/matchscouting/widget_matchscouting_score.dart';

import '../widgets/widget_headingmain.dart';

class AutoTab extends StatefulWidget {
  const AutoTab({
    Key? key,
    required this.styleImgFieldMapWidth,
    required this.matchScoutingData,
    this.styleImgFieldPerformanceWidth = 150,
    this.onLoseStartObjectChange,
    this.onContactWithRobotChange,
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
  final ValueChanged<bool>? onFoulChange;
  final ValueChanged<bool>? onAutoNumHighConeSuccessChange;
  final ValueChanged<bool>? onAutoNumMidConeSuccessChange;
  final ValueChanged<bool>? onAutoNumLowConeSuccessChange;
  final ValueChanged<MatchScoutingData>? onChanged;

  @override
  _AutoTabState createState() => _AutoTabState();
}

class _AutoTabState extends State<AutoTab> {
  TextStyle? styleBodyTextTheme = ThemeData().textTheme.bodyMedium;
  TextStyle? styleTitleTextTheme = ThemeData().textTheme.titleMedium;
  double styleMarginLeftTrap = 90;
  double styleMarginLeftSpeaker = 82;
  double styleMarginTopAmp = 5;

  @override
  Widget build(BuildContext context) {
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
            child: Column(children: <Widget>[
              HeadingMain(
                styleFontSize: styleTitleTextTheme!.fontSize!,
                textColor: Theme.of(context).textTheme.titleLarge!.color!,
                backGroundColor: Theme.of(context).primaryColor,
                headingText: "Driver Station Diagram",
                //backGroundColor: Colors.green,
              ),
              Container(
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
                          width: widget.styleImgFieldMapWidth + 80,
                          height: (widget.styleImgFieldMapWidth),
                          child: Container(
                            decoration: BoxDecoration(
                                //border: Border.all(color: Colors.white),
                                color: Theme.of(context).canvasColor),
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
          onChange: (MatchScoutingData newData) {
            setState(() {
              widget.onChanged!(widget.matchScoutingData);
            });
          },
          numAmpAttempt: widget.matchScoutingData.autoNumAmpAttempt,
          numAmpSuccess: widget.matchScoutingData.autoNumAmpSuccess,
          numTrapAttempt: widget.matchScoutingData.autoNumTrapAttempt,
          numSpeakerAttempt: widget.matchScoutingData.autoNumSpeakerAttempt,
          numTrapSuccess: widget.matchScoutingData.autoNumTrapSuccess,
          numSpeakerSuccess: widget.matchScoutingData.autoNumSpeakerSuccess,
          onNumSpeakerSuccessChanged: (int value) {
            setState(() {
              if (value < 0) {
                value = 0;
              }
              widget.matchScoutingData.autoNumSpeakerSuccess = value;
              widget.onChanged!(widget.matchScoutingData);
            });
          },
          onNumAmpSuccessChanged: (int value) {
            setState(() {
              if (value < 0) {
                value = 0;
              }
              widget.matchScoutingData.autoNumAmpSuccess = value;
              widget.onChanged!(widget.matchScoutingData);
            });
          },
          onNumSpeakerAttemptChanged: (int value) {
            setState(() {
              if (value < 0) {
                value = 0;
              }
              widget.matchScoutingData.autoNumSpeakerAttempt = value;
              widget.onChanged!(widget.matchScoutingData);
            });
          },
          onNumAmpAttemptChanged: (int value) {
            setState(() {
              if (value < 0) {
                value = 0;
              }
              widget.matchScoutingData.autoNumAmpAttempt = value;
              widget.onChanged!(widget.matchScoutingData);
            });
          },
          onNumTrapSuccessChanged: (int value) {
            setState(() {
              if (value < 0) {
                value = 0;
              }
              widget.matchScoutingData.autoNumTrapSuccess = value;
              widget.onChanged!(widget.matchScoutingData);
            });
          },
          onNumTrapAttemptChanged: (int value) {
            setState(() {
              if (value < 0) {
                value = 0;
              }
              widget.matchScoutingData.autoNumTrapAttempt = value;
              widget.onChanged!(widget.matchScoutingData);
            });
          },
        ),
      ],
    );
  }
}
