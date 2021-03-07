import 'package:flutter/material.dart';
import 'package:projectb/class_pitdata.dart';
import 'package:projectb/widget_headingmain.dart';
import 'package:projectb/widget_row_heading.dart';
import 'package:projectb/widget_counter.dart';

class PitAuto extends StatefulWidget {

  PitAuto({
    Key key,
    @required this.pitData,
    this.styleFontSize = 16,
    this.styleFontSizeHeadings = 18,
    this.onChanged,
    this.onExpanded,
  }) : super(key: key);

  final PitData pitData;
  final double styleFontSize;
  final double styleFontSizeHeadings;
  final ValueChanged<PitData> onChanged;
  final ValueChanged<bool> onExpanded;

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
                value: widget.pitData.flAuto,
                onChange: (bool value) {
                  setState(() {
                    widget.pitData.flAuto = value;
                    widget.onChanged(widget.pitData);
                    widget.onExpanded(true);
                  });
                },
              ),
            ]),
          ),
        ),
      );
    }
    else {
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
                value: widget.pitData.flAuto,
                styleBackGroundColor: Colors.green,
                onChange: (bool value) {
                  setState(() {
                    widget.pitData.flAuto = value;
                    widget.onChanged(widget.pitData);
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Line:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  Switch(
                    value: widget.pitData.flAutoLine,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.flAutoLine = value;
                        widget.onChanged(widget.pitData);
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Shoot:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  Switch(
                    value: widget.pitData.flAutoShoot,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.flAutoShoot = value;
                        widget.onChanged(widget.pitData);
                      });
                    },
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("#Balls:"),
                CounterWidget(
                  title: "",
                  value: widget.pitData.numAutoShoot,
                  onIncreaseStateChanged: (int value) {
                    setState(() {
                      widget.pitData.numAutoShoot++;
                      widget.onChanged(widget.pitData);
                    });
                  },
                  onDecreaseStateChanged: (int value) {
                    setState(() {
                      widget.pitData.numAutoShoot--;
                      widget.onChanged(widget.pitData);
                    });
                  },
                  onSetValue: (int value) {
                    setState(() {
                      widget.pitData.numAutoShoot = value;
                      widget.onChanged(widget.pitData);
                    });
                  },
                ),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("#Pickup:"),
                CounterWidget(
                  title: "",
                  value: widget.pitData.numAutoLoad,
                  onIncreaseStateChanged: (int value) {
                    setState(() {
                      widget.pitData.numAutoLoad++;
                      widget.onChanged(widget.pitData);
                    });
                  },
                  onDecreaseStateChanged: (int value) {
                    setState(() {
                      widget.pitData.numAutoLoad--;
                      widget.onChanged(widget.pitData);
                    });
                  },
                  onSetValue: (int value) {
                    setState(() {
                      widget.pitData.numAutoLoad = value;
                      widget.onChanged(widget.pitData);
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
}
