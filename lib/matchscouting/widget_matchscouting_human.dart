import 'package:flutter/material.dart';
import 'package:projectb/widget_counter.dart';
import 'package:projectb/widget_headingmain.dart';

class HumanWidget extends StatefulWidget {
  const HumanWidget({
    Key? key,
    this.autoNumCargoHumanAttempt,
    this.autoNumCargoHumanHighSuccess,
    this.autoNumCargoHumanLowSuccess,
    this.autoNumCargoHumanField,
    this.autoNumCargoHumanRobot,
    //onchange
    this.onAutoNumCargoHumanAttemptChanged,
    this.onAutoNumCargoHumanHighSuccessChanged,
    this.onAutoNumCargoHumanLowSuccessChanged,
    this.onAutoNumCargoHumanFieldChanged,
    this.onAutoNumCargoHumanRobotChanged,
    //style
    this.styleFontSizeBody = 16,
    this.styleFontSizeHeadings = 18,
    this.styleImgFieldWidth = 150,
  }) : super(key: key);

  final int? autoNumCargoHumanAttempt;
  final int? autoNumCargoHumanHighSuccess;
  final int? autoNumCargoHumanLowSuccess;
  final int? autoNumCargoHumanField;
  final int? autoNumCargoHumanRobot;
  final ValueChanged<int>? onAutoNumCargoHumanAttemptChanged;
  final ValueChanged<int>? onAutoNumCargoHumanHighSuccessChanged;
  final ValueChanged<int>? onAutoNumCargoHumanLowSuccessChanged;
  final ValueChanged<int>? onAutoNumCargoHumanFieldChanged;
  final ValueChanged<int>? onAutoNumCargoHumanRobotChanged;
  final double styleFontSizeBody;
  final double styleFontSizeHeadings;
  final double styleImgFieldWidth;

  @override
  _HumanWidgetState createState() => _HumanWidgetState();
}

class _HumanWidgetState extends State<HumanWidget> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.99,
      child: Container(
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          //color: Colors.red,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
        ),
        padding: EdgeInsets.all(4.0),
        child: Column(children: [
          HeadingMain(
              headingText: "Human",
              styleFontSize: widget.styleFontSizeHeadings),
          Container(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(children: [
                          CounterWidget(
                            value: widget.autoNumCargoHumanAttempt,
                            title: "Human",
                            title1: "Fired",
                            styleFontSize: widget.styleFontSizeBody,
                            onIncreaseStateChanged: (int increase) {
                              setState(() {
                                widget.onAutoNumCargoHumanAttemptChanged!(
                                    widget.autoNumCargoHumanAttempt! + 1);
                              });
                            },
                            onDecreaseStateChanged: (int decrease) {
                              setState(() {
                                widget.onAutoNumCargoHumanAttemptChanged!(
                                    widget.autoNumCargoHumanAttempt! - 1);
                              });
                            },
                            onSetValue: (int value) {
                              widget.onAutoNumCargoHumanAttemptChanged!(value);
                            },
                          ),
                        ]),
                        Column(children: [
                          CounterWidget(
                            value: widget.autoNumCargoHumanHighSuccess,
                            title: " ",
                            title1: "High Scored",
                            styleFontSize: widget.styleFontSizeBody,
                            onIncreaseStateChanged: (int increase) {
                              setState(() {
                                widget.onAutoNumCargoHumanAttemptChanged!(
                                    widget.autoNumCargoHumanAttempt! + 1);
                                widget.onAutoNumCargoHumanHighSuccessChanged!(
                                    widget.autoNumCargoHumanHighSuccess! + 1);
                              });
                            },
                            onDecreaseStateChanged: (int decrease) {
                              setState(() {
                                widget.onAutoNumCargoHumanAttemptChanged!(
                                    widget.autoNumCargoHumanAttempt! - 1);
                                widget.onAutoNumCargoHumanHighSuccessChanged!(
                                    widget.autoNumCargoHumanHighSuccess! - 1);
                              });
                            },
                            onSetValue: (int value) {
                              widget.onAutoNumCargoHumanHighSuccessChanged!(
                                  value);
                            },
                          ),
                          CounterWidget(
                            value: widget.autoNumCargoHumanLowSuccess,
                            title: " ",
                            title1: "Low Scored",
                            styleFontSize: widget.styleFontSizeBody,
                            onIncreaseStateChanged: (int increase) {
                              setState(() {
                                widget.onAutoNumCargoHumanAttemptChanged!(
                                    widget.autoNumCargoHumanAttempt! + 1);
                                widget.onAutoNumCargoHumanLowSuccessChanged!(
                                    widget.autoNumCargoHumanLowSuccess! + 1);
                              });
                            },
                            onDecreaseStateChanged: (int decrease) {
                              setState(() {
                                widget.onAutoNumCargoHumanAttemptChanged!(
                                    widget.autoNumCargoHumanAttempt! - 1);
                                widget.onAutoNumCargoHumanLowSuccessChanged!(
                                    widget.autoNumCargoHumanLowSuccess! - 1);
                              });
                            },
                            onSetValue: (int value) {
                              widget
                                  .onAutoNumCargoHumanLowSuccessChanged!(value);
                            },
                          ),
                        ]),
                        Column(children: [
                          CounterWidget(
                            value: widget.autoNumCargoHumanField,
                            title: "Cargo Thrown",
                            title1: "  on field",
                            styleFontSize: widget.styleFontSizeBody,
                            onIncreaseStateChanged: (int increase) {
                              setState(() {
                                widget.onAutoNumCargoHumanFieldChanged!(
                                    widget.autoNumCargoHumanField! + 1);
                              });
                            },
                            onDecreaseStateChanged: (int decrease) {
                              setState(() {
                                widget.onAutoNumCargoHumanFieldChanged!(
                                    widget.autoNumCargoHumanField! - 1);
                              });
                            },
                            onSetValue: (int value) {
                              widget.onAutoNumCargoHumanFieldChanged!(value);
                            },
                          ),
                          CounterWidget(
                            value: widget.autoNumCargoHumanRobot,
                            title: "Cargo caught",
                            title1: " by robot",
                            styleFontSize: widget.styleFontSizeBody,
                            onIncreaseStateChanged: (int increase) {
                              setState(() {
                                widget.onAutoNumCargoHumanRobotChanged!(
                                    widget.autoNumCargoHumanRobot! + 1);
                              });
                            },
                            onDecreaseStateChanged: (int decrease) {
                              setState(() {
                                widget.onAutoNumCargoHumanRobotChanged!(
                                    widget.autoNumCargoHumanRobot! - 1);
                              });
                            },
                            onSetValue: (int value) {
                              widget.onAutoNumCargoHumanRobotChanged!(value);
                            },
                          ),
                        ]),
                      ]),
                ]),
          ),
        ]),
      ),
    );
  }
}
