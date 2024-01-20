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
                styleFontSize:
                    Theme.of(context).textTheme.titleLarge!.fontSize!,
                textColor: Theme.of(context).textTheme.titleLarge!.color!,
                backGroundColor: Theme.of(context).primaryColor,
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
          matchScoutingData: widget.matchScoutingData,
          onChange: (MatchScoutingData newData) {
            setState(() {
              widget.onChanged!(widget.matchScoutingData);
            });
          },
          numAmpAttempt: widget.matchScoutingData.autoNumAmpAttempt,
          numAmpSuccess: widget.matchScoutingData.autoNumAmpSuccess,
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
        ),
      ],
    );
  }
}
