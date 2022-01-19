import 'package:flutter/material.dart';
import 'package:projectb/widget_counter.dart';
import 'package:projectb/widget_headingmain.dart';

class PerformanceWidget extends StatefulWidget {
  const PerformanceWidget({
    Key? key,
    this.numCellAttempt,
    this.numCellSuccess,
    this.flLower,
    this.flInner,
    this.flOuter,
    //onchange
    this.onCellAttemptsChanged,
    this.onCellSuccessChanged,
    this.onFlInnerChanged,
    this.onFlLowerChanged,
    this.onFlOuterChanged,
    //style
    this.styleFontSizeBody = 16,
    this.styleFontSizeHeadings = 18,
    this.styleImgFieldWidth = 150,
  }) : super(key: key);

  final int? numCellAttempt;
  final int? numCellSuccess;
  final bool? flOuter;
  final bool? flInner;
  final bool? flLower;
  final ValueChanged<bool>? onFlLowerChanged;
  final ValueChanged<bool>? onFlInnerChanged;
  final ValueChanged<bool>? onFlOuterChanged;
  final ValueChanged<int>? onCellAttemptsChanged;
  final ValueChanged<int>? onCellSuccessChanged;
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
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(children: [
                    CounterWidget(
                      value: widget.numCellAttempt,
                      title: "Cells Fired",
                      styleFontSize: widget.styleFontSizeBody,
                      onIncreaseStateChanged: (int increase) {
                        setState(() {
                          widget.onCellAttemptsChanged!(
                              widget.numCellAttempt! + 1);
                        });
                      },
                      onDecreaseStateChanged: (int decrease) {
                        setState(() {
                          widget.onCellAttemptsChanged!(
                              widget.numCellAttempt! - 1);
                        });
                      },
                      onSetValue: (int value) {
                        widget.onCellAttemptsChanged!(value);
                      },
                    ),
                    CounterWidget(
                      value: widget.numCellSuccess,
                      title: "Cells Scored",
                      styleFontSize: widget.styleFontSizeBody,
                      onIncreaseStateChanged: (int increase) {
                        setState(() {
                          widget.onCellAttemptsChanged!(
                              widget.numCellAttempt! + 1);
                          widget.onCellSuccessChanged!(
                              widget.numCellSuccess! + 1);
                        });
                      },
                      onDecreaseStateChanged: (int decrease) {
                        setState(() {
                          widget.onCellAttemptsChanged!(
                              widget.numCellAttempt! - 1);
                          widget.onCellSuccessChanged!(
                              widget.numCellSuccess! - 1);
                        });
                      },
                      onSetValue: (int value) {
                        widget.onCellSuccessChanged!(value);
                      },
                    ),
                  ]),
                  Column(children: [
                    Row(children: [
                      Text("Outer"),
                      Switch(
                          value: widget.flOuter!,
                          onChanged: (value) {
                            setState(() {
                              widget.onFlOuterChanged!(value);
                            });
                          }),
                    ]),
                    Row(children: [
                      Text("Inner"),
                      Switch(
                          value: widget.flInner!,
                          onChanged: (value) {
                            setState(() {
                              widget.onFlInnerChanged!(value);
                            });
                          }),
                    ]),
                    Row(children: [
                      Text("Lower"),
                      Switch(
                          value: widget.flLower!,
                          onChanged: (value) {
                            setState(() {
                              widget.onFlLowerChanged!(value);
                            });
                          }),
                    ]),
                  ]),
                ]),
          ),
        ]),
      ),
    );
  }
}
