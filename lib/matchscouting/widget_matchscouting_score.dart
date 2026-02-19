import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:projectb/class/class_macthscoutingdata.dart';
import 'package:projectb/widgets/widget_counter.dart';
import 'package:stats/stats.dart';

import '../widgets/widget_headingmain.dart';

class ScoreWidget extends StatefulWidget {
  const ScoreWidget({
    Key? key,
    required this.matchScoutingData,
    required this.listShootingTime,
    this.intScoringType = 1,
    this.onChange,
    this.onRecordTime,
    //style
    this.styleFontSizeBody = 16,
    this.styleFontSizeHeadings = 18,
    this.styleImgFieldWidth = 150,
    this.styleCounterButtonHeight = 25,
    this.styleCounterButtonWidth = 30,
    this.styleMarginLeftTrap = 90,
    this.styleMarginLeftSpeaker = 82,
    this.styleMarginTopAmp = 5,
  }) : super(key: key);

  final MatchScoutingData matchScoutingData;
  final List<int> listShootingTime;
  final int? intScoringType;
  final ValueChanged<MatchScoutingData>? onChange;
  final ValueChanged<List<int>>? onRecordTime;
  final double styleFontSizeBody;
  final double styleFontSizeHeadings;
  final double styleImgFieldWidth;
  final double styleCounterButtonHeight;
  final double styleCounterButtonWidth;
  final double styleMarginLeftTrap;
  final double styleMarginLeftSpeaker;
  final double styleMarginTopAmp;

  @override
  _ScoreWidgetState createState() => _ScoreWidgetState();
}

class _ScoreWidgetState extends State<ScoreWidget> {
  TextStyle? styleBodyTextTheme = ThemeData().textTheme.bodyMedium;
  TextStyle? styleTitleTextTheme = ThemeData().textTheme.titleMedium;
  TextStyle? styleHeadingTextTheme = ThemeData().textTheme.bodyMedium?.copyWith(
    fontWeight: FontWeight.bold,
  );

  Timer? _timer;
  int _start = 0;

  void startTimer() {
    _timer?.cancel();
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (Timer timer) {
      if (_start == 99) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start++;
        });
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    List<int> listShootingTime = widget.listShootingTime;
    if (listShootingTime[0] == 0) {
      listShootingTime.clear();
    }
    setState(() {
      listShootingTime.add(_start);
      widget.onRecordTime!(listShootingTime);
    });

    final double? average = listShootingTime.average;
    final stats = Stats.fromData(listShootingTime);
    final stddev = stats.sampleValues.standardDeviation;
    // The 'average' property can return null if the list is empty
    if (average != null) {
      print(stddev);
      print('The average is: $average'); //
      setState(() {
        widget.matchScoutingData.autoNumTimer = average.toInt();
      }); // Output: The average is: 30.0
    } else {
      print('The list is empty, cannot calculate average.');
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    if (width < 500) {
      setState(() {
        styleBodyTextTheme = Theme.of(context).textTheme.bodyMedium;
        styleTitleTextTheme = Theme.of(context).textTheme.titleMedium;
      });
    }
    if (width < 393) {
      setState(() {
        styleBodyTextTheme = Theme.of(context).textTheme.bodySmall;
        styleTitleTextTheme = Theme.of(context).textTheme.titleSmall;
      });
    }
    if (width >= 600) {
      setState(() {
        styleBodyTextTheme = Theme.of(context).textTheme.bodyLarge;
        styleTitleTextTheme = Theme.of(context).textTheme.titleLarge;
      });
    }

    return FractionallySizedBox(
      widthFactor: 0.99,
      child: Container(
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          //color: Colors.red,
        ),
        padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 4.0),
        child: Column(
          children: [
            HeadingMain(
              headingText: "Score",
              styleFontSize: styleTitleTextTheme!.fontSize!,
              textColor: Theme.of(context).textTheme.titleLarge!.color!,
              backGroundColor: Theme.of(context).primaryColor,
            ),
            Container(
              constraints: BoxConstraints(maxWidth: 600),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withAlpha(200),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    margin: EdgeInsets.only(
                                      left: 0,
                                      right: 0.0,
                                      bottom: 0.0,
                                      top: 10.0,
                                    ),
                                    padding: const EdgeInsets.only(
                                      left: 5.0,
                                      right: 5.0,
                                      top: 5.0,
                                      bottom: 5.0,
                                    ),
                                    child: Column(
                                      children: [
                                        CounterWidget(
                                          styleButtonWidth:
                                              widget.styleCounterButtonWidth,
                                          styleButtonHeight:
                                              widget.styleCounterButtonHeight,
                                          value: widget.intScoringType == 1
                                              ? widget
                                                    .matchScoutingData
                                                    .autoNumFuelShots
                                              : widget
                                                    .matchScoutingData
                                                    .teleNumFuelShots,
                                          title: "Single Shot",
                                          title1: "Attempts",
                                          styleFontSize:
                                              widget.styleFontSizeBody,
                                          onIncreaseStateChanged:
                                              (int increase) {
                                                setState(() {
                                                  if (widget.intScoringType ==
                                                      1) {
                                                    widget
                                                            .matchScoutingData
                                                            .autoNumFuelShots =
                                                        widget
                                                            .matchScoutingData
                                                            .autoNumFuelShots! +
                                                        increase;
                                                  } else if (widget
                                                          .intScoringType ==
                                                      2) {
                                                    widget
                                                            .matchScoutingData
                                                            .teleNumFuelShots =
                                                        widget
                                                            .matchScoutingData
                                                            .teleNumFuelShots! +
                                                        increase;
                                                  }
                                                  widget.onChange!(
                                                    widget.matchScoutingData,
                                                  );
                                                });
                                              },
                                          onDecreaseStateChanged:
                                              (int decrease) {
                                                setState(() {
                                                  if (widget.intScoringType ==
                                                      1) {
                                                    widget
                                                            .matchScoutingData
                                                            .autoNumFuelShots =
                                                        widget
                                                            .matchScoutingData
                                                            .autoNumFuelShots! +
                                                        decrease;
                                                  } else if (widget
                                                          .intScoringType ==
                                                      2) {
                                                    widget
                                                            .matchScoutingData
                                                            .teleNumFuelShots =
                                                        widget
                                                            .matchScoutingData
                                                            .teleNumFuelShots! +
                                                        decrease;
                                                  }
                                                  widget.onChange!(
                                                    widget.matchScoutingData,
                                                  );
                                                });
                                              },
                                          onSetValue: (int value) {
                                            widget
                                                    .matchScoutingData
                                                    .autoNumFuelShots =
                                                value;
                                            widget.onChange!(
                                              widget.matchScoutingData,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withAlpha(200),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    margin: EdgeInsets.only(
                                      left: 0,
                                      right: 0.0,
                                      bottom: 0.0,
                                      top: 20.0,
                                    ),
                                    padding: const EdgeInsets.only(
                                      left: 5.0,
                                      right: 5.0,
                                      top: 5.0,
                                      bottom: 5.0,
                                    ),
                                    child: Column(
                                      children: [
                                        CounterWidget(
                                          styleButtonWidth:
                                              widget.styleCounterButtonWidth,
                                          styleButtonHeight:
                                              widget.styleCounterButtonHeight,
                                          value: widget.intScoringType == 1
                                              ? widget
                                                    .matchScoutingData
                                                    .autoNumFuelSalvos
                                              : widget
                                                    .matchScoutingData
                                                    .teleNumFuelSalvo,
                                          title: "Salvo Attempts",
                                          title1: "",
                                          styleFontSize:
                                              widget.styleFontSizeBody,
                                          onIncreaseStateChanged:
                                              (int increase) {
                                                setState(() {
                                                  _start = 0;
                                                });
                                                startTimer();
                                                setState(() {
                                                  if (widget.intScoringType ==
                                                      1) {
                                                    widget
                                                            .matchScoutingData
                                                            .autoNumFuelSalvos =
                                                        widget
                                                            .matchScoutingData
                                                            .autoNumFuelSalvos! +
                                                        increase;
                                                  } else if (widget
                                                          .intScoringType ==
                                                      2) {
                                                    widget
                                                            .matchScoutingData
                                                            .teleNumFuelSalvo =
                                                        widget
                                                            .matchScoutingData
                                                            .teleNumFuelSalvo! +
                                                        increase;
                                                  }
                                                  widget.onChange!(
                                                    widget.matchScoutingData,
                                                  );
                                                });
                                              },
                                          onDecreaseStateChanged:
                                              (int decrease) {
                                                setState(() {
                                                  if (widget.intScoringType ==
                                                      1) {
                                                    widget
                                                            .matchScoutingData
                                                            .autoNumFuelSalvos =
                                                        widget
                                                            .matchScoutingData
                                                            .autoNumFuelSalvos! +
                                                        decrease;
                                                  } else if (widget
                                                          .intScoringType ==
                                                      2) {
                                                    widget
                                                            .matchScoutingData
                                                            .teleNumFuelSalvo =
                                                        widget
                                                            .matchScoutingData
                                                            .teleNumFuelSalvo! +
                                                        decrease;
                                                  }
                                                  widget.onChange!(
                                                    widget.matchScoutingData,
                                                  );
                                                });
                                              },
                                          onSetValue: (int value) {
                                            widget
                                                    .matchScoutingData
                                                    .autoNumFuelAccLow =
                                                value;
                                            widget.onChange!(
                                              widget.matchScoutingData,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withAlpha(200),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    margin: EdgeInsets.only(
                                      left: 0,
                                      right: 0.0,
                                      bottom: 10,
                                      top: 10.0,
                                    ),
                                    padding: const EdgeInsets.only(
                                      left: 5.0,
                                      right: 5.0,
                                      top: 5.0,
                                      bottom: 5.0,
                                    ),
                                    child: Column(
                                      children: [
                                        CounterWidget(
                                          styleButtonWidth:
                                              widget.styleCounterButtonWidth,
                                          styleButtonHeight:
                                              widget.styleCounterButtonHeight,
                                          value: widget.intScoringType == 1
                                              ? widget
                                                    .matchScoutingData
                                                    .autoNumFuelAccLow
                                              : widget
                                                    .matchScoutingData
                                                    .teleNumFuelAccLow,
                                          title: "Fuel Results",
                                          title1: "Most Shots missed",
                                          styleFontSize:
                                              widget.styleFontSizeBody,
                                          onIncreaseStateChanged: (int increase) {
                                            setState(() {
                                              if (widget.intScoringType == 1) {
                                                widget
                                                        .matchScoutingData
                                                        .autoNumFuelAccLow =
                                                    widget
                                                        .matchScoutingData
                                                        .autoNumFuelAccLow! +
                                                    increase;
                                              } else if (widget
                                                      .intScoringType ==
                                                  2) {
                                                widget
                                                        .matchScoutingData
                                                        .teleNumFuelAccLow =
                                                    widget
                                                        .matchScoutingData
                                                        .teleNumFuelAccLow! +
                                                    increase;
                                              }
                                              widget.onChange!(
                                                widget.matchScoutingData,
                                              );
                                            });
                                          },
                                          onDecreaseStateChanged: (int decrease) {
                                            setState(() {
                                              if (widget.intScoringType == 1) {
                                                widget
                                                        .matchScoutingData
                                                        .autoNumFuelAccLow =
                                                    widget
                                                        .matchScoutingData
                                                        .autoNumFuelAccLow! +
                                                    decrease;
                                              } else if (widget
                                                      .intScoringType ==
                                                  2) {
                                                widget
                                                        .matchScoutingData
                                                        .teleNumFuelAccLow =
                                                    widget
                                                        .matchScoutingData
                                                        .teleNumFuelAccLow! +
                                                    decrease;
                                              }
                                              widget.onChange!(
                                                widget.matchScoutingData,
                                              );
                                            });
                                          },
                                          onSetValue: (int value) {
                                            widget
                                                    .matchScoutingData
                                                    .autoNumFuelAccLow =
                                                value;
                                            widget.onChange!(
                                              widget.matchScoutingData,
                                            );
                                          },
                                        ),

                                        CounterWidget(
                                          styleButtonWidth:
                                              widget.styleCounterButtonWidth,
                                          styleButtonHeight:
                                              widget.styleCounterButtonHeight,
                                          value: widget.intScoringType == 1
                                              ? widget
                                                    .matchScoutingData
                                                    .autoNumFuelAccMid
                                              : widget
                                                    .matchScoutingData
                                                    .teleNumFuelAccMid,
                                          title: "Mixed results",
                                          title1: "",
                                          styleFontSize:
                                              widget.styleFontSizeBody,
                                          onIncreaseStateChanged: (int increase) {
                                            setState(() {
                                              if (widget.intScoringType == 1) {
                                                widget
                                                        .matchScoutingData
                                                        .autoNumFuelAccMid =
                                                    widget
                                                        .matchScoutingData
                                                        .autoNumFuelAccMid! +
                                                    increase;
                                              } else if (widget
                                                      .intScoringType ==
                                                  2) {
                                                widget
                                                        .matchScoutingData
                                                        .teleNumFuelAccMid =
                                                    widget
                                                        .matchScoutingData
                                                        .teleNumFuelAccMid! +
                                                    increase;
                                              }
                                              widget.onChange!(
                                                widget.matchScoutingData,
                                              );
                                            });
                                          },
                                          onDecreaseStateChanged: (int decrease) {
                                            setState(() {
                                              if (widget.intScoringType == 1) {
                                                widget
                                                        .matchScoutingData
                                                        .autoNumFuelAccMid =
                                                    widget
                                                        .matchScoutingData
                                                        .autoNumFuelAccMid! +
                                                    decrease;
                                              } else if (widget
                                                      .intScoringType ==
                                                  2) {
                                                widget
                                                        .matchScoutingData
                                                        .teleNumFuelAccMid =
                                                    widget
                                                        .matchScoutingData
                                                        .teleNumFuelAccMid! +
                                                    decrease;
                                              }
                                              widget.onChange!(
                                                widget.matchScoutingData,
                                              );
                                            });
                                          },
                                          onSetValue: (int value) {
                                            widget
                                                    .matchScoutingData
                                                    .autoNumFuelAccLow =
                                                value;
                                            widget.onChange!(
                                              widget.matchScoutingData,
                                            );
                                          },
                                        ),
                                        CounterWidget(
                                          styleButtonWidth:
                                              widget.styleCounterButtonWidth,
                                          styleButtonHeight:
                                              widget.styleCounterButtonHeight,
                                          value: widget.intScoringType == 1
                                              ? widget
                                                    .matchScoutingData
                                                    .autoNumFuelAccHigh
                                              : widget
                                                    .matchScoutingData
                                                    .teleNumFuelAccHigh,
                                          title: "Most Shots Went In",
                                          title1: "",
                                          styleFontSize:
                                              widget.styleFontSizeBody,
                                          onIncreaseStateChanged: (int increase) {
                                            setState(() {
                                              if (widget.intScoringType == 1) {
                                                widget
                                                        .matchScoutingData
                                                        .autoNumFuelAccHigh =
                                                    widget
                                                        .matchScoutingData
                                                        .autoNumFuelAccHigh! +
                                                    increase;
                                              } else if (widget
                                                      .intScoringType ==
                                                  2) {
                                                widget
                                                        .matchScoutingData
                                                        .teleNumFuelAccHigh =
                                                    widget
                                                        .matchScoutingData
                                                        .teleNumFuelAccHigh! +
                                                    increase;
                                              }
                                              widget.onChange!(
                                                widget.matchScoutingData,
                                              );
                                            });
                                          },
                                          onDecreaseStateChanged: (int decrease) {
                                            setState(() {
                                              if (widget.intScoringType == 1) {
                                                widget
                                                        .matchScoutingData
                                                        .autoNumFuelAccHigh =
                                                    widget
                                                        .matchScoutingData
                                                        .autoNumFuelAccHigh! +
                                                    decrease;
                                              } else if (widget
                                                      .intScoringType ==
                                                  2) {
                                                widget
                                                        .matchScoutingData
                                                        .teleNumFuelAccHigh =
                                                    widget
                                                        .matchScoutingData
                                                        .teleNumFuelAccHigh! +
                                                    decrease;
                                              }
                                              widget.onChange!(
                                                widget.matchScoutingData,
                                              );
                                            });
                                          },
                                          onSetValue: (int value) {
                                            widget
                                                    .matchScoutingData
                                                    .autoNumFuelAccLow =
                                                value;
                                            widget.onChange!(
                                              widget.matchScoutingData,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HeadingMain(
                        headingText: "Shooting Time Results",
                        styleFontSize: styleTitleTextTheme!.fontSize!,
                        textColor: Theme.of(
                          context,
                        ).textTheme.titleLarge!.color!,
                        backGroundColor: Theme.of(context).primaryColor,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(200),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        margin: EdgeInsets.only(
                          left: 0,
                          right: 0.0,
                          bottom: 3.0,
                          top: 5.0,
                        ),
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                          top: 5.0,
                          bottom: 5.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: EdgeInsets.symmetric(
                                  vertical: 0.0,
                                  horizontal: 10,
                                ),
                              ),
                              child: Text(
                                "Start Timer",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                setState(() {
                                  _start = 0;
                                });
                                startTimer();
                              },
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: EdgeInsets.symmetric(
                                  vertical: 5.0,
                                  horizontal: 15,
                                ),
                              ),
                              child: Text(
                                "Save Time",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                stopTimer();
                              },
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                left: 0,
                                right: 0.0,
                                bottom: 3,
                                top: 3,
                              ),
                              padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                                top: 5.0,
                                bottom: 5.0,
                              ),
                              child: Text(
                                "Current Timer: " + _start.toString(),
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(
                                left: 0,
                                right: 0.0,
                                bottom: 3,
                                top: 3,
                              ),
                              padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                                top: 5.0,
                                bottom: 5.0,
                              ),
                              child: Text(
                                "Avg: " +
                                    widget.matchScoutingData.autoNumTimer
                                        .toString(),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                left: 0,
                                right: 0.0,
                                bottom: 3,
                                top: 3,
                              ),
                              padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                                top: 5.0,
                                bottom: 5.0,
                              ),
                              child: Text(
                                "Recorded Results",
                                style: styleHeadingTextTheme,
                              ),
                            ),

                            SizedBox(
                              width: 170,
                              height: 250,
                              child: ListView.builder(
                                itemCount: widget.listShootingTime.length,
                                itemBuilder: (context, index) {
                                  return Text(
                                    (index + 1).toString() +
                                        ". Shooting Time: " +
                                        widget.listShootingTime[index]
                                            .toString(),
                                    style: TextStyle(
                                      fontSize: widget.styleFontSizeBody,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
