import 'package:flutter/material.dart';
import 'package:projectb/class/class_macthscoutingdata.dart';
import 'package:projectb/widgets/widget_counter.dart';

import '../widgets/widget_headingmain.dart';


class GridsWidget extends StatefulWidget {
  const GridsWidget({
    Key? key,
    required this.matchScoutingData,
    this.numConeAttempt,
    this.numHighConeSuccess,
    this.numMidConeSuccess,
    this.numLowConeSuccess,

    this.numHighCubeSuccess,
    this.numMidCubeSuccess,
    this.numLowCubeSuccess,
    this.numCubeAttempt,
    //onchange
    this.onNumHighCubeSuccessChanged,
    this.onNumMidCubeSuccessChanged,
    this.onNumLowCubeSuccessChanged,
    this.onNumConeAttemptChanged,
    this.onNumHighConeSuccessChanged,
    this.onNumMidConeSuccessChanged,
    this.onNumLowConeSuccessChanged,
    this.onNumCubeAttemptChanged,
    this.onChange,
    //style
    this.styleFontSizeBody = 16,
    this.styleFontSizeHeadings = 18,
    this.styleImgFieldWidth = 150,
    this.styleCounterButtonHeight = 25,
    this.styleCounterButtonWidth = 30,
  }) : super(key: key);

  final MatchScoutingData matchScoutingData;
  final int? numConeAttempt;
  final int? numHighConeSuccess;
  final int? numCubeAttempt;
  final int? numLowConeSuccess;
  final int? numMidConeSuccess;
  final int? numHighCubeSuccess;
  final int? numMidCubeSuccess;
  final int? numLowCubeSuccess;
  final ValueChanged<int>? onNumConeAttemptChanged;
  final ValueChanged<int>? onNumCubeAttemptChanged;
  final ValueChanged<int>? onNumHighConeSuccessChanged;
  final ValueChanged<int>? onNumMidConeSuccessChanged;
  final ValueChanged<int>? onNumLowConeSuccessChanged;
  final ValueChanged<int>? onNumHighCubeSuccessChanged;
  final ValueChanged<int>? onNumMidCubeSuccessChanged;
  final ValueChanged<int>? onNumLowCubeSuccessChanged;


  final ValueChanged<MatchScoutingData>? onChange;
  final double styleFontSizeBody;
  final double styleFontSizeHeadings;
  final double styleImgFieldWidth;
  final double styleCounterButtonHeight;
  final double styleCounterButtonWidth;

  @override
  _GridsWidgetState createState() => _GridsWidgetState();
}

class _GridsWidgetState extends State<GridsWidget> {
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
              headingText: "Grids",
              styleFontSize: widget.styleFontSizeHeadings),
          Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(children: <Widget>[
                          Row(children: <Widget>[
                          SizedBox(
                            width: 110,
                            height: 90,
                            child: Container(
                              decoration: BoxDecoration(
                                //border: Border.all(color: Colors.white),
                                //color: Colors.grey,
                              ),
                              child: Image.asset("assets/imgs/Cone.png"),
                            ),
                          ),
                            ]),
                          Row(children: <Widget>[
                            Column(children: [
                              Container(
                                  margin: const EdgeInsets.only(right: 5.0, bottom: 15.0),
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.yellow),
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                  ),
                              child:                               CounterWidget(
                                styleButtonWidth: widget.styleCounterButtonWidth,
                                styleButtonHeight: widget.styleCounterButtonHeight,
                                value: widget.numConeAttempt,
                                title: "Cone ",
                                title1: " Attempt",
                                styleFontSize: widget.styleFontSizeBody,
                                onIncreaseStateChanged: (int increase) {
                                  setState(() {
                                    widget.onNumConeAttemptChanged!(
                                        widget.numConeAttempt! + 1);
                                  });
                                },
                                onDecreaseStateChanged: (int decrease) {
                                  setState(() {
                                    widget.onNumConeAttemptChanged!(
                                        widget.numConeAttempt! - 1);
                                  });
                                },
                                onSetValue: (int value) {
                                  widget.onNumConeAttemptChanged!(value);
                                },
                              ),
                              ),
                              CounterWidget(
                                styleButtonWidth: widget.styleCounterButtonWidth,
                                styleButtonHeight: widget.styleCounterButtonHeight,
                                value: widget.numHighConeSuccess,
                                title: "High ",
                                title1: " Success",
                                styleFontSize: widget.styleFontSizeBody,
                                onIncreaseStateChanged: (int increase) {
                                  setState(() {
                                    widget.onNumHighConeSuccessChanged!(
                                        widget.numHighConeSuccess! + 1);
                                    widget.onNumConeAttemptChanged!(
                                        widget.numConeAttempt! + 1);
                                    widget.onChange!(widget.matchScoutingData);
                                  });
                                },
                                onDecreaseStateChanged: (int decrease) {
                                  setState(() {
                                    widget.onNumHighConeSuccessChanged!(
                                        widget.numHighConeSuccess! - 1);
                                    widget.onNumConeAttemptChanged!(
                                        widget.numConeAttempt! - 1);
                                  });
                                },
                                onSetValue: (int value) {
                                  widget.onNumHighConeSuccessChanged!(value);
                                },
                              ),
                              CounterWidget(
                                styleButtonWidth: widget.styleCounterButtonWidth,
                                styleButtonHeight: widget.styleCounterButtonHeight,
                                value: widget.numMidConeSuccess,
                                title: "Mid ",
                                title1: " Success",
                                styleFontSize: widget.styleFontSizeBody,
                                onIncreaseStateChanged: (int increase) {
                                  setState(() {
                                    widget.onNumMidConeSuccessChanged!(
                                        widget.numMidConeSuccess! + 1);
                                    widget.onNumConeAttemptChanged!(
                                        widget.numConeAttempt! + 1);
                                  });
                                },
                                onDecreaseStateChanged: (int decrease) {
                                  setState(() {
                                    widget.onNumMidConeSuccessChanged!(
                                        widget.numMidConeSuccess! - 1);
                                    widget.onNumConeAttemptChanged!(
                                        widget.numConeAttempt! - 1);
                                  });
                                },
                                onSetValue: (int value) {
                                  widget.onNumMidConeSuccessChanged!(value);
                                },
                              ),
                              CounterWidget(
                                styleButtonWidth: widget.styleCounterButtonWidth,
                                styleButtonHeight: widget.styleCounterButtonHeight,
                                value: widget.numLowConeSuccess,
                                title: "Low ",
                                title1: " Success",
                                styleFontSize: widget.styleFontSizeBody,
                                onIncreaseStateChanged: (int increase) {
                                  setState(() {
                                    widget.onNumLowConeSuccessChanged!(
                                        widget.numLowConeSuccess! + 1);
                                    widget.onNumConeAttemptChanged!(
                                        widget.numConeAttempt! + 1);
                                  });
                                },
                                onDecreaseStateChanged: (int decrease) {
                                  setState(() {
                                    widget.onNumLowConeSuccessChanged!(
                                        widget.numLowConeSuccess! - 1);
                                    widget.onNumConeAttemptChanged!(
                                        widget.numConeAttempt! - 1);
                                  });
                                },
                                onSetValue: (int value) {
                                  widget.onNumLowConeSuccessChanged!(value);
                                },
                              ),

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
                                    margin: const EdgeInsets.only(top: 110.0),
                            child:
                            SizedBox(
                              width: 110,
                              height: 130,

                              child: Container(

                                decoration: BoxDecoration(

                                  border: Border.all(color: Colors.white),
                                  color: Colors.grey,
                                ),
                                child: Image.asset("assets/imgs/terminal.png"),
                              ),
                            ),
                                ),
                          ]),

                        ]),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(children: <Widget>[
                                Row(children: <Widget>[
                                  SizedBox(
                                    width: 110,
                                    height: 90,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        //border: Border.all(color: Colors.white),
                                        //color: Colors.grey,
                                      ),
                                      child: Image.asset("assets/imgs/Cube.png"),
                                    ),
                                  ),
                                ]),
                                Row(children: <Widget>[
                                  Column(children: [
                                    Container(
                                        margin: const EdgeInsets.only(right: 5.0, bottom: 15.0),
                                      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.yellow),
                                          color: Colors.yellow,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10)),
                                        ),
                                      child: CounterWidget(
                                        styleButtonWidth: widget.styleCounterButtonWidth,
                                        styleButtonHeight: widget.styleCounterButtonHeight,
                                        value: widget.numCubeAttempt,
                                        title: "Cube ",
                                        title1: " Attempt",
                                        styleFontSize: widget.styleFontSizeBody,
                                        onIncreaseStateChanged: (int increase) {
                                          setState(() {
                                            widget.onNumCubeAttemptChanged!(
                                                widget.numCubeAttempt! + 1);
                                          });
                                        },
                                        onDecreaseStateChanged: (int decrease) {
                                          setState(() {
                                            widget.onNumCubeAttemptChanged!(
                                                widget.numCubeAttempt! - 1);
                                          });
                                        },
                                        onSetValue: (int value) {
                                          widget.onNumCubeAttemptChanged!(value);
                                        },
                                      ),
                                    ),
                                    CounterWidget(
                                      styleButtonWidth: widget.styleCounterButtonWidth,
                                      styleButtonHeight: widget.styleCounterButtonHeight,
                                      value: widget.numHighCubeSuccess,
                                      title: "High ",
                                      title1: " Success",
                                      styleFontSize: widget.styleFontSizeBody,
                                      onIncreaseStateChanged: (int increase) {
                                        setState(() {
                                          widget.onNumHighCubeSuccessChanged!(
                                              widget.numHighCubeSuccess! + 1);
                                          widget.onNumCubeAttemptChanged!(
                                              widget.numCubeAttempt! + 1);
                                          widget.onChange!(widget.matchScoutingData);
                                        });
                                      },
                                      onDecreaseStateChanged: (int decrease) {
                                        setState(() {
                                          widget.onNumHighCubeSuccessChanged!(
                                              widget.numHighCubeSuccess! - 1);
                                          widget.onNumCubeAttemptChanged!(
                                              widget.numCubeAttempt! - 1);
                                        });
                                      },
                                      onSetValue: (int value) {
                                        widget.onNumHighCubeSuccessChanged!(value);
                                      },
                                    ),
                                    CounterWidget(
                                      styleButtonWidth: widget.styleCounterButtonWidth,
                                      styleButtonHeight: widget.styleCounterButtonHeight,
                                      value: widget.numMidCubeSuccess,
                                      title: "Mid ",
                                      title1: " Success",
                                      styleFontSize: widget.styleFontSizeBody,
                                      onIncreaseStateChanged: (int increase) {
                                        setState(() {
                                          widget.onNumMidCubeSuccessChanged!(
                                              widget.numMidCubeSuccess! + 1);
                                          widget.onNumCubeAttemptChanged!(
                                              widget.numCubeAttempt! + 1);
                                        });
                                      },
                                      onDecreaseStateChanged: (int decrease) {
                                        setState(() {
                                          widget.onNumMidCubeSuccessChanged!(
                                              widget.numMidCubeSuccess! - 1);
                                          widget.onNumCubeAttemptChanged!(
                                              widget.numCubeAttempt! - 1);
                                        });
                                      },
                                      onSetValue: (int value) {
                                        widget.onNumMidCubeSuccessChanged!(value);
                                      },
                                    ),
                                    CounterWidget(
                                      styleButtonWidth: widget.styleCounterButtonWidth,
                                      styleButtonHeight: widget.styleCounterButtonHeight,
                                      value: widget.numLowCubeSuccess,
                                      title: "Low ",
                                      title1: " Success",
                                      styleFontSize: widget.styleFontSizeBody,
                                      onIncreaseStateChanged: (int increase) {
                                        setState(() {
                                          widget.onNumLowCubeSuccessChanged!(
                                              widget.numLowCubeSuccess! + 1);
                                          widget.onNumCubeAttemptChanged!(
                                              widget.numCubeAttempt! + 1);
                                        });
                                      },
                                      onDecreaseStateChanged: (int decrease) {
                                        setState(() {
                                          widget.onNumLowCubeSuccessChanged!(
                                              widget.numLowCubeSuccess! - 1);
                                          widget.onNumCubeAttemptChanged!(
                                              widget.numCubeAttempt! - 1);
                                        });
                                      },
                                      onSetValue: (int value) {
                                        widget.onNumLowCubeSuccessChanged!(value);
                                      },
                                    ),

                                  ]),
                                ]),
                              ]),


                      ]),

                ]),
          ]),
        ),
      ]),
    ),);
  }
}
