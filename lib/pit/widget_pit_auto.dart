import 'package:flutter/material.dart';
import 'package:projectb/class/class_pitdata.dart';
import 'package:projectb/widgets/widget_headingmain.dart';
import 'package:projectb/widgets/widget_counter.dart';

import '../widgets/widget_row_heading.dart';

class PitAuto extends StatefulWidget {
  PitAuto(
      {Key? key,
      required this.pitData,
      this.styleFontSize = 16,
      this.styleFontSizeHeadings = 18,
      this.onChanged,
      this.onExpanded,
      this.strWeight = "lbs",
      this.strDistance = "inches"})
      : super(key: key);

  final PitData pitData;
  final double styleFontSize;
  final double styleFontSizeHeadings;
  final ValueChanged<PitData>? onChanged;
  final ValueChanged<bool>? onExpanded;
  final String strWeight;
  final String strDistance;

  @override
  _PitAutoState createState() => _PitAutoState();
}

class _PitAutoState extends State<PitAuto> {
  @override
  Widget build(BuildContext context) {
    if (widget.pitData.flAuto == false) {
      return FractionallySizedBox(
        widthFactor: 0.99,
        child: Container(
          margin: const EdgeInsets.all(5.0),

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
                value: widget.pitData.flAuto,
                onChange: (bool value) {
                  setState(() {
                    widget.pitData.flAuto = value;
                    widget.onChanged!(widget.pitData);
                    widget.onExpanded!(true);
                  });
                },
              ),
            ]),
          ),
        ),
      );
    } else {
      return FractionallySizedBox(
        widthFactor: 0.99,
        child: Container(
          margin: const EdgeInsets.all(5.0),

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
                value: widget.pitData.flAuto,
                styleBackGroundColor: Colors.green,
                onChange: (bool value) {
                  setState(() {
                    widget.pitData.flAuto = value;
                    widget.onChanged!(widget.pitData);
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Mobility:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  Switch(
                    value: widget.pitData.flAutoLine!,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.flAutoLine = value;
                        widget.onChanged!(widget.pitData);
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Score:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  Switch(
                    value: widget.pitData.flAutoScore!,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.flAutoScore = value;
                        widget.onChanged!(widget.pitData);
                      });
                    },
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("#Objects Scored:"),
                CounterWidget(
                  title: "",
                  value: widget.pitData.numAutoScore,
                  onIncreaseStateChanged: (int value) {
                    setState(() {
                      widget.pitData.numAutoScore =
                          widget.pitData.numAutoScore! + 1;
                      widget.onChanged!(widget.pitData);
                    });
                  },
                  onDecreaseStateChanged: (int value) {
                    setState(() {
                      widget.pitData.numAutoScore =
                          widget.pitData.numAutoScore! - 1;
                      widget.onChanged!(widget.pitData);
                    });
                  },
                  onSetValue: (int value) {
                    setState(() {
                      widget.pitData.numAutoScore = value;
                      widget.onChanged!(widget.pitData);
                    });
                  },
                ),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Score on Hybrid Node:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  Switch(
                    value: widget.pitData.flAutoNodeBottom!,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.flAutoNodeBottom = value;
                        widget.onChanged!(widget.pitData);
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Score on Middle Node:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  Switch(
                    value: widget.pitData.flAutoNodeMid!,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.flAutoNodeMid = value;
                        widget.onChanged!(widget.pitData);
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Score on High Node:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  Switch(
                    value: widget.pitData.flAutoNodeHigh!,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.flAutoNodeHigh = value;
                        widget.onChanged!(widget.pitData);
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Reach Charge Station:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  Switch(
                    value: widget.pitData.flAutoCharge!,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.flAutoCharge = value;
                        widget.onChanged!(widget.pitData);
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Balance Charge Station:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  Switch(
                    value: widget.pitData.flAutoChargeBalance!,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.flAutoChargeBalance = value;
                        widget.onChanged!(widget.pitData);
                      });
                    },
                  ),
                ],
              ),


            ]),
          ),
        ),
      );
    }
  }
}
