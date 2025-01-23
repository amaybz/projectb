import 'package:flutter/material.dart';
import 'package:projectb/class/class_macthscoutingdata.dart';
import 'package:projectb/widgets/widget_counter.dart';

import '../widgets/widget_headingmain.dart';

class ScoreWidget extends StatefulWidget {
  const ScoreWidget({
    Key? key,
    required this.matchScoutingData,
    this.numCoralAttempt,
    this.numCoralL1Success,
    this.numCoralL4Success,
    this.numCoralL2Success,
    this.numCoralL3Success,
    this.numAlgaeAttempt,
    this.numAlgaeL2Success,
    this.numAlgaeL3Success,
    this.numAlgaeNetAttempt,
    this.numAlgaeNetSuccess,
    this.numAlgaeProcessAttempt,
    this.numAlgaeProcessSuccess,
    //onchange
    this.onNumAlgaeL2Success,
    this.onNumAlgaeL3Success,
    this.onNumCoralAttempt,
    this.onNumCoralL2Success,
    this.onNumCoralL3Success,
    this.onNumCoralL4Success,
    this.onNumAlgaeAttempt,
    this.onNumCoralL1Success,
    this.onNumAlgaeNetAttempt,
    this.onNumAlgaeNetSuccess,
    this.onNumAlgaeProcessAttempt,
    this.onNumAlgaeProcessSuccess,
    this.onChange,
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
  final int? numCoralAttempt;
  final int? numCoralL1Success;
  final int? numCoralL2Success;
  final int? numCoralL3Success;
  final int? numCoralL4Success;
  final int? numAlgaeAttempt;
  final int? numAlgaeL2Success;
  final int? numAlgaeL3Success;
  final int? numAlgaeNetAttempt;
  final int? numAlgaeNetSuccess;
  final int? numAlgaeProcessAttempt;
  final int? numAlgaeProcessSuccess;
  final ValueChanged<int>? onNumCoralAttempt;
  final ValueChanged<int>? onNumCoralL1Success;
  final ValueChanged<int>? onNumCoralL2Success;
  final ValueChanged<int>? onNumCoralL3Success;
  final ValueChanged<int>? onNumCoralL4Success;
  final ValueChanged<int>? onNumAlgaeAttempt;
  final ValueChanged<int>? onNumAlgaeL2Success;
  final ValueChanged<int>? onNumAlgaeL3Success;
  final ValueChanged<int>? onNumAlgaeNetAttempt;
  final ValueChanged<int>? onNumAlgaeNetSuccess;
  final ValueChanged<int>? onNumAlgaeProcessAttempt;
  final ValueChanged<int>? onNumAlgaeProcessSuccess;

  final ValueChanged<MatchScoutingData>? onChange;
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
        child: Column(children: [
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
                  bottomRight: Radius.circular(10)),
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                left: 1, right: 5.0, bottom: 1.0, top: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            child: SizedBox(
                              width: 215,
                              height: 400,
                              child: Image.asset(
                                "assets/imgs/ScoringLocations.png",
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        ]),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(children: <Widget>[
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.8),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    margin: EdgeInsets.only(
                                        left: 0,
                                        right: 0.0,
                                        bottom: 0.0,
                                        top: 5.0),
                                    padding: const EdgeInsets.only(
                                        left: 5.0,
                                        right: 5.0,
                                        top: 5.0,
                                        bottom: 0.0),
                                    child: Column(children: [
                                      CounterWidget(
                                        styleButtonWidth:
                                            widget.styleCounterButtonWidth,
                                        styleButtonHeight:
                                            widget.styleCounterButtonHeight,
                                        value: widget.numCoralAttempt,
                                        title: "Coral",
                                        title1: "Attempts",
                                        styleFontSize: widget.styleFontSizeBody,
                                        onIncreaseStateChanged: (int increase) {
                                          setState(() {
                                            widget.onNumCoralAttempt!(
                                                widget.numCoralAttempt! + 1);
                                          });
                                        },
                                        onDecreaseStateChanged: (int decrease) {
                                          setState(() {
                                            widget.onNumCoralAttempt!(
                                                widget.numCoralAttempt! - 1);
                                          });
                                        },
                                        onSetValue: (int value) {
                                          widget.onNumCoralAttempt!(value);
                                        },
                                      ),
                                      CounterWidget(
                                        styleButtonWidth:
                                            widget.styleCounterButtonWidth,
                                        styleButtonHeight:
                                            widget.styleCounterButtonHeight,
                                        value: widget.numCoralL4Success,
                                        title: "L4",
                                        styleFontSize: widget.styleFontSizeBody,
                                        onIncreaseStateChanged: (int increase) {
                                          setState(() {
                                            widget.onNumCoralL4Success!(
                                                widget.numCoralL4Success! + 1);
                                            widget.onNumCoralAttempt!(
                                                widget.numCoralAttempt! + 1);
                                          });
                                        },
                                        onDecreaseStateChanged: (int decrease) {
                                          setState(() {
                                            widget.onNumCoralL4Success!(
                                                widget.numCoralL4Success! - 1);
                                            widget.onNumCoralAttempt!(
                                                widget.numCoralAttempt! - 1);
                                          });
                                        },
                                        onSetValue: (int value) {
                                          widget.onNumCoralL4Success!(value);
                                        },
                                      ),
                                      CounterWidget(
                                        styleButtonWidth:
                                            widget.styleCounterButtonWidth,
                                        styleButtonHeight:
                                            widget.styleCounterButtonHeight,
                                        value: widget.numCoralL3Success,
                                        title: "L3",
                                        styleFontSize: widget.styleFontSizeBody,
                                        onIncreaseStateChanged: (int increase) {
                                          setState(() {
                                            widget.onNumCoralL3Success!(
                                                widget.numCoralL3Success! + 1);
                                            widget.onNumCoralAttempt!(
                                                widget.numCoralAttempt! + 1);
                                          });
                                        },
                                        onDecreaseStateChanged: (int decrease) {
                                          setState(() {
                                            widget.onNumCoralL3Success!(
                                                widget.numCoralL3Success! - 1);
                                            widget.onNumCoralAttempt!(
                                                widget.numCoralAttempt! - 1);
                                          });
                                        },
                                        onSetValue: (int value) {
                                          widget.onNumCoralL3Success!(value);
                                        },
                                      ),
                                      CounterWidget(
                                        styleButtonWidth:
                                            widget.styleCounterButtonWidth,
                                        styleButtonHeight:
                                            widget.styleCounterButtonHeight,
                                        value: widget.numCoralL2Success,
                                        title: "L2",
                                        styleFontSize: widget.styleFontSizeBody,
                                        onIncreaseStateChanged: (int increase) {
                                          setState(() {
                                            widget.onNumCoralL2Success!(
                                                widget.numCoralL2Success! + 1);
                                            widget.onNumCoralAttempt!(
                                                widget.numCoralAttempt! + 1);
                                          });
                                        },
                                        onDecreaseStateChanged: (int decrease) {
                                          setState(() {
                                            widget.onNumCoralL2Success!(
                                                widget.numCoralL2Success! - 1);
                                            widget.onNumCoralAttempt!(
                                                widget.numCoralAttempt! - 1);
                                          });
                                        },
                                        onSetValue: (int value) {
                                          widget.onNumCoralL2Success!(value);
                                        },
                                      ),
                                      CounterWidget(
                                        styleButtonWidth:
                                            widget.styleCounterButtonWidth,
                                        styleButtonHeight:
                                            widget.styleCounterButtonHeight,
                                        value: widget.numCoralL1Success,
                                        title: "L1",
                                        styleFontSize: widget.styleFontSizeBody,
                                        onIncreaseStateChanged: (int increase) {
                                          setState(() {
                                            widget.onNumCoralL1Success!(
                                                widget.numCoralL1Success! + 1);
                                            widget.onNumCoralAttempt!(
                                                widget.numCoralAttempt! + 1);
                                          });
                                        },
                                        onDecreaseStateChanged: (int decrease) {
                                          setState(() {
                                            widget.onNumCoralL1Success!(
                                                widget.numCoralL1Success! - 1);
                                            widget.onNumCoralAttempt!(
                                                widget.numCoralAttempt! - 1);
                                          });
                                        },
                                        onSetValue: (int value) {
                                          widget.onNumCoralL1Success!(value);
                                        },
                                      ),
                                    ]),
                                  ),
                                ]),
                          ]),
                        ]),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(
                                left: 1, right: 5.0, bottom: 1.0, top: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            child: SizedBox(
                              width: 215,
                              height: 200,
                              child: Image.asset(
                                "assets/imgs/ScoringLocations2.png",
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ),
                        ]),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(children: <Widget>[
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.8),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    margin: EdgeInsets.only(
                                        left: 0,
                                        right: 0.0,
                                        bottom: 0.0,
                                        top: 5.0),
                                    padding: const EdgeInsets.only(
                                        left: 5.0,
                                        right: 5.0,
                                        top: 5.0,
                                        bottom: 0.0),
                                    child: Column(children: [
                                      CounterWidget(
                                        styleButtonWidth:
                                            widget.styleCounterButtonWidth,
                                        styleButtonHeight:
                                            widget.styleCounterButtonHeight,
                                        value: widget.numAlgaeAttempt,
                                        title: "Algae",
                                        title1: "Attempts",
                                        styleFontSize: widget.styleFontSizeBody,
                                        onIncreaseStateChanged: (int increase) {
                                          setState(() {
                                            widget.onNumAlgaeAttempt!(
                                                widget.numAlgaeAttempt! + 1);
                                          });
                                        },
                                        onDecreaseStateChanged: (int decrease) {
                                          setState(() {
                                            widget.onNumAlgaeAttempt!(
                                                widget.numAlgaeAttempt! - 1);
                                          });
                                        },
                                        onSetValue: (int value) {
                                          widget.onNumAlgaeAttempt!(value);
                                        },
                                      ),
                                      CounterWidget(
                                        styleButtonWidth:
                                            widget.styleCounterButtonWidth,
                                        styleButtonHeight:
                                            widget.styleCounterButtonHeight,
                                        value: widget.numAlgaeL3Success,
                                        title: "L3",
                                        styleFontSize: widget.styleFontSizeBody,
                                        onIncreaseStateChanged: (int increase) {
                                          setState(() {
                                            widget.onNumAlgaeL3Success!(
                                                widget.numAlgaeL3Success! + 1);
                                            widget.onNumAlgaeAttempt!(
                                                widget.numAlgaeAttempt! + 1);
                                          });
                                        },
                                        onDecreaseStateChanged: (int decrease) {
                                          setState(() {
                                            widget.onNumAlgaeL3Success!(
                                                widget.numAlgaeL3Success! - 1);
                                            widget.onNumAlgaeAttempt!(
                                                widget.numAlgaeAttempt! - 1);
                                          });
                                        },
                                        onSetValue: (int value) {
                                          widget.onNumAlgaeL3Success!(value);
                                        },
                                      ),
                                      CounterWidget(
                                        styleButtonWidth:
                                            widget.styleCounterButtonWidth,
                                        styleButtonHeight:
                                            widget.styleCounterButtonHeight,
                                        value: widget.numAlgaeL2Success,
                                        title: "L2",
                                        styleFontSize: widget.styleFontSizeBody,
                                        onIncreaseStateChanged: (int increase) {
                                          setState(() {
                                            widget.onNumAlgaeL2Success!(
                                                widget.numAlgaeL2Success! + 1);
                                            widget.onNumAlgaeAttempt!(
                                                widget.numAlgaeAttempt! + 1);
                                          });
                                        },
                                        onDecreaseStateChanged: (int decrease) {
                                          setState(() {
                                            widget.onNumAlgaeL2Success!(
                                                widget.numAlgaeL2Success! - 1);
                                            widget.onNumAlgaeAttempt!(
                                                widget.numAlgaeAttempt! - 1);
                                          });
                                        },
                                        onSetValue: (int value) {
                                          widget.onNumAlgaeL2Success!(value);
                                        },
                                      ),
                                    ]),
                                  ),
                                ]),
                          ]),
                        ]),
                  ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.8),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      ),
                      margin: EdgeInsets.only(
                          left: 0, right: 0.0, bottom: 0.0, top: 5.0),
                      padding: const EdgeInsets.only(
                          left: 5.0, right: 5.0, top: 5.0, bottom: 0.0),
                      child: Column(children: [
                        CounterWidget(
                          styleButtonWidth: widget.styleCounterButtonWidth,
                          styleButtonHeight: widget.styleCounterButtonHeight,
                          value: widget.numAlgaeProcessAttempt,
                          title: "Algae Processor",
                          title1: "Attempts",
                          styleFontSize: widget.styleFontSizeBody,
                          onIncreaseStateChanged: (int increase) {
                            setState(() {
                              widget.onNumAlgaeProcessAttempt!(
                                  widget.numAlgaeProcessAttempt! + 1);
                            });
                          },
                          onDecreaseStateChanged: (int decrease) {
                            setState(() {
                              widget.onNumAlgaeProcessAttempt!(
                                  widget.numAlgaeProcessAttempt! - 1);
                            });
                          },
                          onSetValue: (int value) {
                            widget.onNumAlgaeProcessAttempt!(value);
                          },
                        ),
                        CounterWidget(
                          styleButtonWidth: widget.styleCounterButtonWidth,
                          styleButtonHeight: widget.styleCounterButtonHeight,
                          value: widget.numAlgaeProcessSuccess,
                          title: "Success",
                          styleFontSize: widget.styleFontSizeBody,
                          onIncreaseStateChanged: (int increase) {
                            setState(() {
                              widget.onNumAlgaeProcessSuccess!(
                                  widget.numAlgaeProcessSuccess! + 1);
                              widget.onNumAlgaeProcessAttempt!(
                                  widget.numAlgaeProcessAttempt! + 1);
                            });
                          },
                          onDecreaseStateChanged: (int decrease) {
                            setState(() {
                              widget.onNumAlgaeProcessSuccess!(
                                  widget.numAlgaeProcessSuccess! - 1);
                              widget.onNumAlgaeProcessAttempt!(
                                  widget.numAlgaeProcessAttempt! - 1);
                            });
                          },
                          onSetValue: (int value) {
                            widget.onNumAlgaeProcessSuccess!(value);
                          },
                        ),
                      ]),
                    ),
                  ]),
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.8),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      ),
                      margin: EdgeInsets.only(
                          left: 0, right: 0.0, bottom: 0.0, top: 5.0),
                      padding: const EdgeInsets.only(
                          left: 5.0, right: 5.0, top: 5.0, bottom: 0.0),
                      child: Column(children: [
                        CounterWidget(
                          styleButtonWidth: widget.styleCounterButtonWidth,
                          styleButtonHeight: widget.styleCounterButtonHeight,
                          value: widget.numAlgaeNetAttempt,
                          title: "Algae Net",
                          title1: "Attempts",
                          styleFontSize: widget.styleFontSizeBody,
                          onIncreaseStateChanged: (int increase) {
                            setState(() {
                              widget.onNumAlgaeNetAttempt!(
                                  widget.numAlgaeNetAttempt! + 1);
                            });
                          },
                          onDecreaseStateChanged: (int decrease) {
                            setState(() {
                              widget.onNumAlgaeNetAttempt!(
                                  widget.numAlgaeNetAttempt! - 1);
                            });
                          },
                          onSetValue: (int value) {
                            widget.onNumAlgaeNetAttempt!(value);
                          },
                        ),
                        CounterWidget(
                          styleButtonWidth: widget.styleCounterButtonWidth,
                          styleButtonHeight: widget.styleCounterButtonHeight,
                          value: widget.numAlgaeNetSuccess,
                          title: "Success",
                          styleFontSize: widget.styleFontSizeBody,
                          onIncreaseStateChanged: (int increase) {
                            setState(() {
                              widget.onNumAlgaeNetSuccess!(
                                  widget.numAlgaeNetSuccess! + 1);
                              widget.onNumAlgaeNetAttempt!(
                                  widget.numAlgaeNetAttempt! + 1);
                            });
                          },
                          onDecreaseStateChanged: (int decrease) {
                            setState(() {
                              widget.onNumAlgaeNetSuccess!(
                                  widget.numAlgaeNetSuccess! - 1);
                              widget.onNumAlgaeNetAttempt!(
                                  widget.numAlgaeNetAttempt! - 1);
                            });
                          },
                          onSetValue: (int value) {
                            widget.onNumAlgaeNetSuccess!(value);
                          },
                        ),
                      ]),
                    ),
                  ]),
                ],
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
