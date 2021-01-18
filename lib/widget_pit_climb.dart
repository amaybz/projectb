import 'package:flutter/material.dart';
import 'package:projectb/class_pitdata.dart';
import 'package:projectb/widget_counter.dart';
import 'package:projectb/widget_headingmain.dart';
import 'package:projectb/widget_row_heading.dart';

class PitClimb extends StatefulWidget {
  PitClimb({
    Key key,
    @required this.pitData,
    this.styleFontSize = 16,
    this.styleFontSizeHeadings = 18,
    this.styleFieldTxClimbMaxWidth = 300,
    this.onChanged,
    this.txClimb,
    this.onExpanded
  }) : super(key: key);

  final PitData pitData;
  final double styleFontSize;
  final double styleFontSizeHeadings;
  final double styleFieldTxClimbMaxWidth;
  final ValueChanged<PitData> onChanged;
  final ValueChanged<bool> onExpanded;
  final TextEditingController txClimb;

  @override
  _PitClimbState createState() => _PitClimbState();
}

class _PitClimbState extends State<PitClimb> {
  List<DropdownMenuItem<String>> ddsSpeed = [
    DropdownMenuItem(value: "1", child: Text("NA")),
    DropdownMenuItem(value: "2", child: Text("Slow")),
    DropdownMenuItem(value: "3", child: Text("Med")),
    DropdownMenuItem(value: "4", child: Text("Fast")),
  ];

  List<DropdownMenuItem<String>> ddsPosition = [
    DropdownMenuItem(value: "1", child: Text("NA")),
    DropdownMenuItem(value: "2", child: Text("Any")),
    DropdownMenuItem(value: "3", child: Text("Inner")),
    DropdownMenuItem(value: "4", child: Text("Middle")),
    DropdownMenuItem(value: "5", child: Text("Outer")),
  ];

  List<DropdownMenuItem<String>> ddsIdClimbType = [
    DropdownMenuItem(value: "1", child: Text("NA")),
    DropdownMenuItem(value: "2", child: Text("Flexible")),
  ];

  @override
  Widget build(BuildContext context) {
    if (widget.pitData.flClimb == false) {
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
                headingText: "Climb",
                //backGroundColor: Colors.green,
              ),
              RowHeading(
                styleFontSize: widget.styleFontSize,
                text: "Can Climb?",
                value: widget.pitData.flClimb,
                onChange: (bool value) {
                  setState(() {
                    widget.pitData.flClimb = value;
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
                styleFontSize: widget.styleFontSizeHeadings,
                headingText: "Climb",
                //backGroundColor: Colors.green,
              ),
              RowHeading(
                styleFontSize: widget.styleFontSize,
                text: "Can Climb?",
                value: widget.pitData.flClimb,
                styleBackGroundColor: Colors.green,
                onChange: (bool value) {
                  setState(() {
                    widget.pitData.flClimb = value;
                    widget.onChanged(widget.pitData);
                  });
                },
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                CounterWidget(
                  value: widget.pitData.numClimbHeight,
                  title: "Height",
                  onIncreaseStateChanged: (int value) {
                    setState(() {
                      widget.pitData.numClimbHeight++;
                      widget.onChanged(widget.pitData);
                    });
                  },
                  onDecreaseStateChanged: (int value) {
                    PitData newPitData = widget.pitData;
                    setState(() {
                      newPitData.numClimbHeight--;
                      widget.onChanged(newPitData);
                    });
                  },
                  onSetValue: (int value) {
                    setState(() {
                      widget.pitData.numClimbHeight = value;
                      widget.onChanged(widget.pitData);
                    });
                  },
                ),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Climb Type:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  DropdownButton(
                    value: widget.pitData.idClimbType == null
                        ? null
                        : widget.pitData.idClimbType,
                    items: ddsIdClimbType,
                    onChanged: (item) {
                      setState(() {
                        widget.pitData.idClimbType = item;
                        widget.onChanged(widget.pitData);
                      });
                      print("idClimbType: " + widget.pitData.idClimbType);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Time (Grip):",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  DropdownButton(
                    value: widget.pitData.idClimbGrab == null
                        ? null
                        : widget.pitData.idClimbGrab,
                    items: ddsSpeed,
                    onChanged: (item) {
                      setState(() {
                        widget.pitData.idClimbGrab = item;
                        widget.onChanged(widget.pitData);
                      });
                      print("idClimbGrab: " + widget.pitData.idClimbGrab);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Time (Grip to Climb):",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  DropdownButton(
                    value: widget.pitData.idClimbSpeed == null
                        ? null
                        : widget.pitData.idClimbSpeed,
                    items: ddsSpeed,
                    onChanged: (item) {
                      setState(() {
                        widget.pitData.idClimbSpeed = item;
                        widget.onChanged(widget.pitData);
                      });
                      print("idClimbSpeed: " + widget.pitData.idClimbSpeed);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tilting?:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  Switch(
                    value: widget.pitData.flClimbTilt,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.flClimbTilt = value;
                        widget.onChanged(widget.pitData);
                      });
                    },
                  ),
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Climb Mechanism: ",
                      style: TextStyle(fontSize: widget.styleFontSize),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: widget.styleFieldTxClimbMaxWidth),
                      child: TextField(
                        controller: widget.txClimb,
                        decoration: InputDecoration(
                            hintText: 'Notes on climb mechanism'),
                        onChanged: (String text) {
                          setState(() {
                            widget.pitData.txClimb = text;
                            widget.onChanged(widget.pitData);
                          });
                        },
                      ),
                    ),
                  ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Preferred Position:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  DropdownButton(
                      value: widget.pitData.idClimbPos == null
                          ? null
                          : widget.pitData.idClimbPos,
                      items: ddsPosition,
                      onChanged: (item) {
                        setState(() {
                          widget.pitData.idClimbPos = item;
                          widget.onChanged(widget.pitData);
                        });
                        print("idClimbSpeed: " + widget.pitData.idClimbPos);
                      }),
                ],
              ),
            ]),
          ),
        ),
      );
    }
  }
}
