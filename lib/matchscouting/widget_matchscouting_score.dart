import 'package:flutter/material.dart';
import 'package:projectb/class/class_macthscoutingdata.dart';
import 'package:projectb/widgets/widget_counter.dart';

import '../widgets/widget_headingmain.dart';

class ScoreWidget extends StatefulWidget {
  const ScoreWidget({
    Key? key,
    required this.matchScoutingData,
    this.numAmpAttempt,
    this.numAmpSuccess,
    this.numTrapSuccess,
    this.numTrapAttempt,
    this.numLowConeSuccess,
    this.numSpeakerSuccess,
    this.numMidCubeSuccess,
    this.numLowCubeSuccess,
    this.numSpeakerAttempt,
    //onchange
    this.onNumSpeakerSuccessChanged,
    this.onNumMidCubeSuccessChanged,
    this.onNumLowCubeSuccessChanged,
    this.onNumAmpAttemptChanged,
    this.onNumAmpSuccessChanged,
    this.onNumTrapSuccessChanged,
    this.onNumTrapAttemptChanged,
    this.onNumLowConeSuccessChanged,
    this.onNumSpeakerAttemptChanged,
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
  final int? numAmpAttempt;
  final int? numAmpSuccess;
  final int? numSpeakerAttempt;
  final int? numLowConeSuccess;
  final int? numTrapSuccess;
  final int? numTrapAttempt;
  final int? numSpeakerSuccess;
  final int? numMidCubeSuccess;
  final int? numLowCubeSuccess;
  final ValueChanged<int>? onNumAmpAttemptChanged;
  final ValueChanged<int>? onNumSpeakerAttemptChanged;
  final ValueChanged<int>? onNumAmpSuccessChanged;
  final ValueChanged<int>? onNumTrapSuccessChanged;
  final ValueChanged<int>? onNumTrapAttemptChanged;
  final ValueChanged<int>? onNumLowConeSuccessChanged;
  final ValueChanged<int>? onNumSpeakerSuccessChanged;
  final ValueChanged<int>? onNumMidCubeSuccessChanged;
  final ValueChanged<int>? onNumLowCubeSuccessChanged;

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
              image: DecorationImage(
                image: AssetImage("assets/imgs/ScoringLocations.png"),
                fit: BoxFit.scaleDown,
              ),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(children: <Widget>[
                          Row(children: <Widget>[
                            Column(children: [
                              SizedBox(
                                height: 580,
                              )
                            ]),
                          ]),
                        ]),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.only(top: 210.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.8),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                        ),
                                        margin: EdgeInsets.only(
                                            left: widget.styleMarginLeftTrap,
                                            right: 0.0,
                                            bottom: 5.0,
                                            top: 2.0),
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
                                            value: widget.numTrapSuccess,
                                            title: "Trap",
                                            title1: "Success",
                                            styleFontSize:
                                                widget.styleFontSizeBody,
                                            onIncreaseStateChanged:
                                                (int increase) {
                                              setState(() {
                                                widget.onNumTrapSuccessChanged!(
                                                    widget.numTrapSuccess! + 1);
                                                widget.onNumTrapAttemptChanged!(
                                                    widget.numTrapAttempt! + 1);
                                              });
                                            },
                                            onDecreaseStateChanged:
                                                (int decrease) {
                                              setState(() {
                                                widget.onNumTrapSuccessChanged!(
                                                    widget.numTrapSuccess! - 1);
                                                widget.onNumTrapAttemptChanged!(
                                                    widget.numTrapAttempt! - 1);
                                              });
                                            },
                                            onSetValue: (int value) {
                                              widget.onNumSpeakerAttemptChanged!(
                                                  value);
                                            },
                                          ),
                                          CounterWidget(
                                            styleButtonWidth:
                                                widget.styleCounterButtonWidth,
                                            styleButtonHeight:
                                                widget.styleCounterButtonHeight,
                                            value: widget.numTrapAttempt,
                                            title: "Attempt",
                                            styleFontSize:
                                                widget.styleFontSizeBody,
                                            onIncreaseStateChanged:
                                                (int increase) {
                                              setState(() {
                                                widget.onNumTrapAttemptChanged!(
                                                    widget.numTrapAttempt! + 1);
                                              });
                                            },
                                            onDecreaseStateChanged:
                                                (int decrease) {
                                              setState(() {
                                                widget.onNumTrapAttemptChanged!(
                                                    widget.numTrapAttempt! - 1);
                                              });
                                              if (widget.numTrapSuccess! >=
                                                  widget.numTrapAttempt!) {
                                                widget.onNumTrapSuccessChanged!(
                                                    widget.numTrapSuccess! - 1);
                                              }
                                            },
                                            onSetValue: (int value) {
                                              widget.onNumTrapAttemptChanged!(
                                                  value);
                                            },
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ]),
                            ]),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(children: <Widget>[
                                      Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey
                                                    .withOpacity(0.8),
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10)),
                                              ),
                                              margin: EdgeInsets.only(
                                                  right: 5.0,
                                                  bottom: 10.0,
                                                  top:
                                                      widget.styleMarginTopAmp),
                                              padding: const EdgeInsets.only(
                                                  left: 5.0,
                                                  right: 5.0,
                                                  top: 5.0,
                                                  bottom: 0.0),
                                              child: Column(children: [
                                                CounterWidget(
                                                  styleButtonWidth: widget
                                                      .styleCounterButtonWidth,
                                                  styleButtonHeight: widget
                                                      .styleCounterButtonHeight,
                                                  value: widget.numAmpSuccess,
                                                  title: "AMP",
                                                  title1: "Success",
                                                  styleFontSize:
                                                      widget.styleFontSizeBody,
                                                  onIncreaseStateChanged:
                                                      (int increase) {
                                                    setState(() {
                                                      widget.onNumAmpSuccessChanged!(
                                                          widget.numAmpSuccess! +
                                                              1);
                                                      widget.onNumAmpAttemptChanged!(
                                                          widget.numAmpAttempt! +
                                                              1);
                                                    });
                                                  },
                                                  onDecreaseStateChanged:
                                                      (int decrease) {
                                                    setState(() {
                                                      widget.onNumAmpSuccessChanged!(
                                                          widget.numAmpSuccess! -
                                                              1);
                                                      widget.onNumAmpAttemptChanged!(
                                                          widget.numAmpAttempt! -
                                                              1);
                                                    });
                                                  },
                                                  onSetValue: (int value) {
                                                    widget.onNumAmpSuccessChanged!(
                                                        value);
                                                  },
                                                ),
                                                CounterWidget(
                                                  styleButtonWidth: widget
                                                      .styleCounterButtonWidth,
                                                  styleButtonHeight: widget
                                                      .styleCounterButtonHeight,
                                                  value: widget.numAmpAttempt,
                                                  title: "Attempt",
                                                  styleFontSize:
                                                      widget.styleFontSizeBody,
                                                  onIncreaseStateChanged:
                                                      (int increase) {
                                                    setState(() {
                                                      widget.onNumAmpAttemptChanged!(
                                                          widget.numAmpAttempt! +
                                                              1);
                                                    });
                                                  },
                                                  onDecreaseStateChanged:
                                                      (int decrease) {
                                                    setState(() {
                                                      widget.onNumAmpAttemptChanged!(
                                                          widget.numAmpAttempt! -
                                                              1);
                                                    });

                                                    if (widget.numAmpSuccess! >=
                                                        widget.numAmpAttempt!) {
                                                      widget.onNumAmpSuccessChanged!(
                                                          widget.numAmpSuccess! -
                                                              1);
                                                    }
                                                  },
                                                  onSetValue: (int value) {
                                                    widget.onNumAmpAttemptChanged!(
                                                        value);
                                                  },
                                                ),
                                              ]),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey
                                                    .withOpacity(0.8),
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10)),
                                              ),
                                              margin: EdgeInsets.only(
                                                  left: widget
                                                      .styleMarginLeftSpeaker,
                                                  right: 0.0,
                                                  bottom: 5.0,
                                                  top: 15.0),
                                              padding: const EdgeInsets.only(
                                                  left: 5.0,
                                                  right: 5.0,
                                                  top: 5.0,
                                                  bottom: 0.0),
                                              child: Column(children: [
                                                CounterWidget(
                                                  styleButtonWidth: widget
                                                      .styleCounterButtonWidth,
                                                  styleButtonHeight: widget
                                                      .styleCounterButtonHeight,
                                                  value:
                                                      widget.numSpeakerSuccess,
                                                  title: "Speaker",
                                                  title1: "Success",
                                                  styleFontSize:
                                                      widget.styleFontSizeBody,
                                                  onIncreaseStateChanged:
                                                      (int increase) {
                                                    setState(() {
                                                      widget.onNumSpeakerSuccessChanged!(
                                                          widget.numSpeakerSuccess! +
                                                              1);
                                                      widget.onNumSpeakerAttemptChanged!(
                                                          widget.numSpeakerAttempt! +
                                                              1);
                                                    });
                                                  },
                                                  onDecreaseStateChanged:
                                                      (int decrease) {
                                                    setState(() {
                                                      widget.onNumSpeakerSuccessChanged!(
                                                          widget.numSpeakerSuccess! -
                                                              1);
                                                      widget.onNumSpeakerAttemptChanged!(
                                                          widget.numSpeakerAttempt! -
                                                              1);
                                                    });
                                                  },
                                                  onSetValue: (int value) {
                                                    widget.onNumSpeakerAttemptChanged!(
                                                        value);
                                                  },
                                                ),
                                                CounterWidget(
                                                  styleButtonWidth: widget
                                                      .styleCounterButtonWidth,
                                                  styleButtonHeight: widget
                                                      .styleCounterButtonHeight,
                                                  value:
                                                      widget.numSpeakerAttempt,
                                                  title: "Attempt",
                                                  styleFontSize:
                                                      widget.styleFontSizeBody,
                                                  onIncreaseStateChanged:
                                                      (int increase) {
                                                    setState(() {
                                                      widget.onNumSpeakerAttemptChanged!(
                                                          widget.numSpeakerAttempt! +
                                                              1);
                                                    });
                                                  },
                                                  onDecreaseStateChanged:
                                                      (int decrease) {
                                                    setState(() {
                                                      widget.onNumSpeakerAttemptChanged!(
                                                          widget.numSpeakerAttempt! -
                                                              1);
                                                    });

                                                    if (widget
                                                            .numSpeakerSuccess! >=
                                                        widget
                                                            .numSpeakerAttempt!) {
                                                      widget.onNumSpeakerSuccessChanged!(
                                                          widget.numSpeakerSuccess! -
                                                              1);
                                                    }
                                                  },
                                                  onSetValue: (int value) {
                                                    widget.onNumSpeakerAttemptChanged!(
                                                        value);
                                                  },
                                                ),
                                              ]),
                                            ),
                                          ]),
                                    ]),
                                  ]),
                            ]),
                      ]),
                ]),
          ),
        ]),
      ),
    );
  }
}
