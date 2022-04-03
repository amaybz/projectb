// @dart = 2.7

import 'package:flutter/material.dart';
import 'package:projectb/class_pitdata.dart';
import 'package:projectb/widget_counter.dart';
import 'package:projectb/widget_headingmain.dart';
import 'package:projectb/widget_row_heading.dart';

class PitPowerCells extends StatefulWidget {
  PitPowerCells({
    Key key,
    @required this.pitData,
    this.styleFontSize = 16,
    this.styleFontSizeHeadings = 18,
    this.styleFieldTxShootingMaxWidth = 300,
    this.onChanged,
    this.txShooting,
    this.onExpanded,
  }) : super(key: key);

  final PitData pitData;
  final double styleFontSize;
  final double styleFontSizeHeadings;
  final double styleFieldTxShootingMaxWidth;
  final ValueChanged<PitData> onChanged;
  final TextEditingController txShooting;
  final ValueChanged<bool> onExpanded;

  @override
  _PitPowerCellsState createState() => _PitPowerCellsState();
}

class _PitPowerCellsState extends State<PitPowerCells> {
  @override
  Widget build(BuildContext context) {
    if (widget.pitData.flCargo == false) {
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
                styleFontSize: widget.styleFontSize,
                headingText: "Cargo",
                //backGroundColor: Colors.green,
              ),
              RowHeading(
                styleFontSize: widget.styleFontSize,
                text: "Manipulate Cargo:",
                value: widget.pitData.flCargo,
                onChange: (bool value) {
                  setState(() {
                    widget.pitData.flCargo = value;
                    widget.onChanged(widget.pitData);
                    widget.onExpanded(true);
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
                styleFontSize: widget.styleFontSize,
                headingText: "Cargo",
                //backGroundColor: Colors.green,
              ),
              RowHeading(
                styleFontSize: widget.styleFontSize,
                text: "Manipulate Cargo:",
                value: widget.pitData.flCargo,
                styleBackGroundColor: Colors.green,
                onChange: (bool value) {
                  setState(() {
                    widget.pitData.flCargo = value;
                    widget.onChanged(widget.pitData);
                    widget.onExpanded(true);
                  });
                },
              ),
              HeadingMain(
                styleFontSize: widget.styleFontSize,
                headingText: "Intake",
                //backGroundColor: Colors.green,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Ground Intake:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  Switch(
                    value: widget.pitData.flIntakeGround,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.flIntakeGround = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Terminal Intake:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  Switch(
                    value: widget.pitData.flIntakeHigh,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.flIntakeHigh = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Bounce Intake:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  Switch(
                    value: widget.pitData.flIntakeBounce,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.flIntakeBounce = value;
                      });
                    },
                  ),
                ],
              ),
              HeadingMain(
                styleFontSize: widget.styleFontSize,
                headingText: "Scoring",
                //backGroundColor: Colors.green,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Reject Wrong Cargo:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  Switch(
                    value: widget.pitData.flIntakeSort,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.flIntakeSort = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hub (Lower):",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  Switch(
                    value: widget.pitData.flTargetLow,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.flTargetLow = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hub (Upper):",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  Switch(
                    value: widget.pitData.flTargetUpper,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.flTargetUpper = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Terminal:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  Switch(
                    value: widget.pitData.flTargetTerminal,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.flTargetTerminal = value;
                      });
                    },
                  ),
                ],
              ),
              HeadingMain(
                styleFontSize: widget.styleFontSize,
                headingText: "General",
                //backGroundColor: Colors.green,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("Storage Capacity:"),
                CounterWidget(
                  title: "",
                  value: widget.pitData.numStorage,
                  onIncreaseStateChanged: (int value) {
                    setState(() {
                      widget.pitData.numStorage++;
                    });
                  },
                  onDecreaseStateChanged: (int value) {
                    setState(() {
                      widget.pitData.numStorage--;
                    });
                  },
                  onSetValue: (int value) {
                    setState(() {
                      widget.pitData.numStorage = value;
                    });
                  },
                ),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Delivery Mechanism: ",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: widget.styleFieldTxShootingMaxWidth),
                    child: TextField(
                      controller: widget.txShooting,
                      decoration: InputDecoration(
                          hintText:
                              'Cannon, hooded shooter, twin flywheel etc'),
                    ),
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
