import 'package:flutter/material.dart';
import 'package:projectb/widget_counter.dart';
import 'package:projectb/widget_headingmain.dart';

class PerformanceWidget extends StatefulWidget {
  const PerformanceWidget({
    Key? key,
    this.numCargoHighAttempt,
    this.numCargoHighSuccess,
    this.numCargoLowAttempt,
    this.numCargoLowSuccess,
    this.numCargoTerminalAttempt,
    this.numCargoTerminalSuccess,
    //onchange
    this.onNumCargoHighAttemptChanged,
    this.onNumCargoHighSuccessChanged,
    this.onNumCargoLowAttemptChanged,
    this.onNumCargoLowSuccessChanged,
    this.onNumCargoTerminalAttemptChanged,
    this.onNumCargoTerminalSuccessChanged,
    //style
    this.styleFontSizeBody = 16,
    this.styleFontSizeHeadings = 18,
    this.styleImgFieldWidth = 150,
  }) : super(key: key);

  final int? numCargoHighAttempt;
  final int? numCargoHighSuccess;
  final int? numCargoLowAttempt;
  final int? numCargoLowSuccess;
  final int? numCargoTerminalAttempt;
  final int? numCargoTerminalSuccess;
  final ValueChanged<int>? onNumCargoHighAttemptChanged;
  final ValueChanged<int>? onNumCargoHighSuccessChanged;
  final ValueChanged<int>? onNumCargoLowAttemptChanged;
  final ValueChanged<int>? onNumCargoLowSuccessChanged;
  final ValueChanged<int>? onNumCargoTerminalAttemptChanged;
  final ValueChanged<int>? onNumCargoTerminalSuccessChanged;
  final double styleFontSizeBody;
  final double styleFontSizeHeadings;
  final double styleImgFieldWidth;

  @override
  _PerformanceWidgetState createState() => _PerformanceWidgetState();
}

class _PerformanceWidgetState extends State<PerformanceWidget> {
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
              headingText: "Performance",
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
                            value: widget.numCargoHighAttempt,
                            title: "Hub (Upper)",
                            title1: "Attempt",
                            styleFontSize: widget.styleFontSizeBody,
                            onIncreaseStateChanged: (int increase) {
                              setState(() {
                                widget.onNumCargoHighAttemptChanged!(
                                    widget.numCargoHighAttempt! + 1);
                              });
                            },
                            onDecreaseStateChanged: (int decrease) {
                              setState(() {
                                widget.onNumCargoHighAttemptChanged!(
                                    widget.numCargoHighAttempt! - 1);
                              });
                            },
                            onSetValue: (int value) {
                              widget.onNumCargoHighAttemptChanged!(value);
                            },
                          ),
                          CounterWidget(
                            value: widget.numCargoHighSuccess,
                            title: "Hub (Upper) Success",
                            styleFontSize: widget.styleFontSizeBody,
                            onIncreaseStateChanged: (int increase) {
                              setState(() {
                                widget.onNumCargoHighAttemptChanged!(
                                    widget.numCargoHighAttempt! + 1);
                                widget.onNumCargoHighSuccessChanged!(
                                    widget.numCargoHighSuccess! + 1);
                              });
                            },
                            onDecreaseStateChanged: (int decrease) {
                              setState(() {
                                widget.onNumCargoHighAttemptChanged!(
                                    widget.numCargoHighAttempt! - 1);
                                widget.onNumCargoHighSuccessChanged!(
                                    widget.numCargoHighSuccess! - 1);
                              });
                            },
                            onSetValue: (int value) {
                              widget.onNumCargoHighSuccessChanged!(value);
                            },
                          ),
                        ]),
                        Column(children: <Widget>[
                          SizedBox(
                            width: 110,
                            height: 90,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                color: Colors.grey,
                              ),
                              child: Image.asset("assets/imgs/hub.png"),
                            ),
                          ),
                        ]),
                        Column(children: [
                          CounterWidget(
                            value: widget.numCargoLowAttempt,
                            title: "Fired Low",
                            styleFontSize: widget.styleFontSizeBody,
                            onIncreaseStateChanged: (int increase) {
                              setState(() {
                                widget.onNumCargoLowAttemptChanged!(
                                    widget.numCargoLowAttempt! + 1);
                              });
                            },
                            onDecreaseStateChanged: (int decrease) {
                              setState(() {
                                widget.onNumCargoLowAttemptChanged!(
                                    widget.numCargoLowAttempt! - 1);
                              });
                            },
                            onSetValue: (int value) {
                              widget.onNumCargoLowAttemptChanged!(value);
                            },
                          ),
                          CounterWidget(
                            value: widget.numCargoLowSuccess,
                            title: "Scored Low",
                            styleFontSize: widget.styleFontSizeBody,
                            onIncreaseStateChanged: (int increase) {
                              setState(() {
                                widget.onNumCargoLowAttemptChanged!(
                                    widget.numCargoLowAttempt! + 1);
                                widget.onNumCargoLowSuccessChanged!(
                                    widget.numCargoLowSuccess! + 1);
                              });
                            },
                            onDecreaseStateChanged: (int decrease) {
                              setState(() {
                                widget.onNumCargoLowAttemptChanged!(
                                    widget.numCargoLowAttempt! - 1);
                                widget.onNumCargoLowSuccessChanged!(
                                    widget.numCargoLowSuccess! - 1);
                              });
                            },
                            onSetValue: (int value) {
                              widget.onNumCargoLowSuccessChanged!(value);
                            },
                          ),
                        ]),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(children: [
                          CounterWidget(
                            value: widget.numCargoTerminalAttempt,
                            title: "Fired Terminal",
                            styleFontSize: widget.styleFontSizeBody,
                            onIncreaseStateChanged: (int increase) {
                              setState(() {
                                widget.onNumCargoTerminalAttemptChanged!(
                                    widget.numCargoTerminalAttempt! + 1);
                              });
                            },
                            onDecreaseStateChanged: (int decrease) {
                              setState(() {
                                widget.onNumCargoTerminalAttemptChanged!(
                                    widget.numCargoTerminalAttempt! - 1);
                              });
                            },
                            onSetValue: (int value) {
                              widget.onNumCargoTerminalAttemptChanged!(value);
                            },
                          ),
                          CounterWidget(
                            value: widget.numCargoTerminalSuccess,
                            title: "Scored Terminal",
                            styleFontSize: widget.styleFontSizeBody,
                            onIncreaseStateChanged: (int increase) {
                              setState(() {
                                widget.onNumCargoTerminalAttemptChanged!(
                                    widget.numCargoTerminalAttempt! + 1);
                                widget.onNumCargoTerminalSuccessChanged!(
                                    widget.numCargoTerminalSuccess! + 1);
                              });
                            },
                            onDecreaseStateChanged: (int decrease) {
                              setState(() {
                                widget.onNumCargoTerminalAttemptChanged!(
                                    widget.numCargoTerminalAttempt! - 1);
                                widget.onNumCargoTerminalSuccessChanged!(
                                    widget.numCargoTerminalSuccess! - 1);
                              });
                            },
                            onSetValue: (int value) {
                              widget.onNumCargoTerminalSuccessChanged!(value);
                            },
                          ),
                        ]),
                        Column(children: <Widget>[
                          SizedBox(
                            width: 110,
                            height: 90,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                color: Colors.grey,
                              ),
                              child: Image.asset("assets/imgs/terminal.png"),
                            ),
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
