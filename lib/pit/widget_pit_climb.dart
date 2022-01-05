// @dart = 2.7

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
   @required this.numClimbHeight,
    this.onExpanded
  }) : super(key: key);

  final PitData pitData;
  final double styleFontSize;
  final double styleFontSizeHeadings;
  final double styleFieldTxClimbMaxWidth;
  final ValueChanged<PitData> onChanged;
  final ValueChanged<bool> onExpanded;
  final TextEditingController txClimb;
  final TextEditingController numClimbHeight;

  @override
  _PitClimbState createState() => _PitClimbState();
}

class _PitClimbState extends State<PitClimb> {
  List<DropdownMenuItem<String>> ddsSpeed = [
    DropdownMenuItem(value: "1", child: Text("NA")),
    DropdownMenuItem(value: "2", child: Text("Slow (> 7 Secs)")),
    DropdownMenuItem(value: "3", child: Text("Medium (3-7 Secs)")),
    DropdownMenuItem(value: "4", child: Text("Fast <3 Secs")),
  ];

  List<DropdownMenuItem<String>> ddsPosition = [
    DropdownMenuItem(value: "1", child: Text("NA")),
    DropdownMenuItem(value: "2", child: Text("Any")),
    DropdownMenuItem(value: "3", child: Text("Inner")),
    DropdownMenuItem(value: "4", child: Text("Middle")),
    DropdownMenuItem(value: "5", child: Text("Outer")),
  ];

  List<DropdownMenuItem<String>> ddsIdClimbType = [
    DropdownMenuItem(value: "1", child: Text("Rigid")),
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
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("Height Above Ground (inches):"),
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: 60),
                  child: TextField(
                    controller: widget.numClimbHeight,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                        hintText: 'inchs'),
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
                children: [
                  Text(
                    "Powered Grip?:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  Switch(
                    value: widget.pitData.flClimbSecure,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.flClimbSecure = value;
                        widget.onChanged(widget.pitData);
                      });
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
                    "Climb a tilted bar?:",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Can level Generator?:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  Switch(
                    value: widget.pitData.flClimbLevel,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.flClimbLevel = value;
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
                    "Can level by self?:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  Switch(
                    value: widget.pitData.flClimbLevelSelf,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.flClimbLevelSelf = value;
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
                    "Can level with others?:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  Switch(
                    value: widget.pitData.flClimbLevelOther,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.flClimbLevelOther = value;
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
                    "Reposition while hanging:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  Switch(
                    value: widget.pitData.flClimbMove,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.flClimbMove = value;
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
                    "Buddy Climb:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  Switch(
                    value: widget.pitData.flClimbOther,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.flClimbOther = value;
                        widget.onChanged(widget.pitData);
                      });
                    },
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("#Buddy:"),
                CounterWidget(
                  title: "",
                  value: widget.pitData.numClimbOther,
                  onIncreaseStateChanged: (int value) {
                    setState(() {
                      widget.pitData.numClimbOther++;
                      widget.onChanged(widget.pitData);
                    });
                  },
                  onDecreaseStateChanged: (int value) {
                    setState(() {
                      widget.pitData.numClimbOther--;
                      widget.onChanged(widget.pitData);
                    });
                  },
                  onSetValue: (int value) {
                    setState(() {
                      widget.pitData.numClimbOther = value;
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
