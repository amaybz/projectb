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
    this.onNumLowConeSuccessChanged,
    this.onNumSpeakerAttemptChanged,
    this.onChange,
    //style
    this.styleFontSizeBody = 16,
    this.styleFontSizeHeadings = 18,
    this.styleImgFieldWidth = 150,
    this.styleCounterButtonHeight = 25,
    this.styleCounterButtonWidth = 30,
  }) : super(key: key);

  final MatchScoutingData matchScoutingData;
  final int? numAmpAttempt;
  final int? numAmpSuccess;
  final int? numSpeakerAttempt;
  final int? numLowConeSuccess;
  final int? numTrapSuccess;
  final int? numSpeakerSuccess;
  final int? numMidCubeSuccess;
  final int? numLowCubeSuccess;
  final ValueChanged<int>? onNumAmpAttemptChanged;
  final ValueChanged<int>? onNumSpeakerAttemptChanged;
  final ValueChanged<int>? onNumAmpSuccessChanged;
  final ValueChanged<int>? onNumTrapSuccessChanged;
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

  @override
  _ScoreWidgetState createState() => _ScoreWidgetState();
}

class _ScoreWidgetState extends State<ScoreWidget> {
  @override
  Widget build(BuildContext context) {
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
            styleFontSize: Theme.of(context).textTheme.titleLarge!.fontSize!,
            textColor: Theme.of(context).textTheme.titleLarge!.color!,
            backGroundColor: Theme.of(context).primaryColor,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              image: DecorationImage(
                image: AssetImage("assets/imgs/ScoringLocations.png"),
                fit: BoxFit.fill,
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
                                        margin: const EdgeInsets.only(
                                            left: 90.0,
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
                                            title: "Stage",
                                            title1: "Success",
                                            styleFontSize:
                                                widget.styleFontSizeBody,
                                            onIncreaseStateChanged:
                                                (int increase) {
                                              setState(() {
                                                widget.onNumTrapSuccessChanged!(
                                                    widget.numTrapSuccess! + 1);
                                              });
                                            },
                                            onDecreaseStateChanged:
                                                (int decrease) {
                                              setState(() {
                                                widget.onNumSpeakerAttemptChanged!(
                                                    widget.numTrapSuccess! - 1);
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
                                            value: widget.numAmpAttempt,
                                            title: "Attempt",
                                            styleFontSize:
                                                widget.styleFontSizeBody,
                                            onIncreaseStateChanged:
                                                (int increase) {
                                              setState(() {
                                                widget.onNumAmpAttemptChanged!(
                                                    widget.numAmpAttempt! + 1);
                                              });
                                            },
                                            onDecreaseStateChanged:
                                                (int decrease) {
                                              setState(() {
                                                widget.onNumAmpAttemptChanged!(
                                                    widget.numAmpAttempt! - 1);
                                              });
                                            },
                                            onSetValue: (int value) {
                                              widget.onNumAmpAttemptChanged!(
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
                                              margin: const EdgeInsets.only(
                                                  right: 5.0,
                                                  bottom: 10.0,
                                                  top: 5.0),
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
                                              margin: const EdgeInsets.only(
                                                  left: 82,
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
