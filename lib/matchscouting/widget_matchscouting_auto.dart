// @dart = 2.7
import 'package:flutter/material.dart';
import 'package:projectb/class_macthscoutingdata.dart';
import 'package:projectb/widget_headingmain.dart';
import 'package:projectb/widget_row_heading.dart';
import 'package:projectb/widget_counter.dart';

class MatchAuto extends StatefulWidget {
  MatchAuto({
    Key key,
    @required this.matchScoutingData,
    this.styleFontSize = 16,
    this.styleFontSizeHeadings = 18,
    this.onChanged,
    this.onExpanded,
  }) : super(key: key);

  final MatchScoutingData matchScoutingData;
  final double styleFontSize;
  final double styleFontSizeHeadings;
  final ValueChanged<MatchScoutingData> onChanged;
  final ValueChanged<bool> onExpanded;

  @override
  _MatchAutoState createState() => _MatchAutoState();
}

class _MatchAutoState extends State<MatchAuto> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.99,
      child: Container(
        margin: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
        ),
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: Column(children: <Widget>[
            HeadingMain(
              styleFontSize: widget.styleFontSizeHeadings,
              headingText: "Auto",
              //backGroundColor: Colors.green,
            ),
            RowHeading(
              styleFontSize: widget.styleFontSize,
              text: "Does Auto?",
              value: widget.matchScoutingData.autoFlStart,
              styleBackGroundColor: Colors.yellow,
              onChange: (bool value) {
                setState(() {
                  widget.matchScoutingData.autoFlStart = value;
                  widget.onChanged(widget.matchScoutingData);
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Leave Line:",
                  style: TextStyle(fontSize: widget.styleFontSize),
                ),
                Switch(
                  value: widget.matchScoutingData.autoFlBaseLine,
                  onChanged: (bool value) {
                    setState(() {
                      widget.matchScoutingData.autoFlBaseLine = value;
                      widget.onChanged(widget.matchScoutingData);
                    });
                  },
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("Pickup new Cargo?:"),
              CounterWidget(
                title: "",
                value: widget.matchScoutingData.autoNumCellLoad,
                onIncreaseStateChanged: (int value) {
                  setState(() {
                    widget.matchScoutingData.autoNumCellLoad++;
                    widget.onChanged(widget.matchScoutingData);
                  });
                },
                onDecreaseStateChanged: (int value) {
                  setState(() {
                    widget.matchScoutingData.autoNumCellLoad--;
                    widget.onChanged(widget.matchScoutingData);
                  });
                },
                onSetValue: (int value) {
                  setState(() {
                    widget.matchScoutingData.autoNumCellLoad = value;
                    widget.onChanged(widget.matchScoutingData);
                  });
                },
              ),
            ]),
          ]),
        ),
      ),
    );
  }
}
