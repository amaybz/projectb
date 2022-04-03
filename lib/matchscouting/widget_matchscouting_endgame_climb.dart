// @dart = 2.7

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projectb/class_macthscoutingdata.dart';
import 'package:projectb/class_pitdata.dart';
import 'package:projectb/widget_counter.dart';
import 'package:projectb/widget_headingmain.dart';
import 'package:projectb/widget_row_heading.dart';
import 'package:projectb/widget_row_heading_dropdown.dart';

import '../widget_dropdown_indexed.dart';

class EndGameClimb extends StatefulWidget {
  EndGameClimb(
      {Key key,
      @required this.matchScoutingData,
      this.styleFontSize = 16,
      this.styleFontSizeHeadings = 18,
      this.styleFieldTxClimbMaxWidth = 300,
      this.onChanged,
      this.txClimb,
      this.onExpanded})
      : super(key: key);

  final MatchScoutingData matchScoutingData;
  final double styleFontSize;
  final double styleFontSizeHeadings;
  final double styleFieldTxClimbMaxWidth;
  final ValueChanged<MatchScoutingData> onChanged;
  final ValueChanged<bool> onExpanded;
  final TextEditingController txClimb;

  @override
  _EndGameClimbState createState() => _EndGameClimbState();
}

class _EndGameClimbState extends State<EndGameClimb> {
  List<DropdownMenuItem<String>> ddsSpeed = [
    DropdownMenuItem(value: "1", child: Text("NA")),
    DropdownMenuItem(value: "2", child: Text("Slow (> 7 Secs)")),
    DropdownMenuItem(value: "3", child: Text("Medium (3-7 Secs)")),
    DropdownMenuItem(value: "4", child: Text("Fast <3 Secs")),
  ];

  List<DropdownMenuItem<String>> ddsPosition = [
    DropdownMenuItem(value: "1", child: Text("NA")),
    DropdownMenuItem(value: "2", child: Text("Low")),
    DropdownMenuItem(value: "3", child: Text("Middle")),
    DropdownMenuItem(value: "4", child: Text("High")),
    DropdownMenuItem(value: "5", child: Text("Traversal")),
  ];

  List<DropdownMenuItem<String>> listSuccessFailNA = [
    DropdownMenuItem(value: "1", child: Text("NA")),
    DropdownMenuItem(value: "2", child: Text("Fail")),
    DropdownMenuItem(value: "3", child: Text("Success")),
  ];

  final List<DropDownValue> _listClimbValues = [
    DropDownValue(id: "1", value: "N/A"),
    DropDownValue(id: "2", value: "Fail"),
    DropDownValue(id: "3", value: "Success"),
  ];

  @override
  Widget build(BuildContext context) {
    if (widget.matchScoutingData.teleIdClimb == "4") {
      return FractionallySizedBox(
        widthFactor: 0.99,
        child: Container(
          margin: const EdgeInsets.all(1.0),
          child: Container(
            padding: EdgeInsets.all(1.0),
            child: Column(children: <Widget>[
              RowHeadingDropDown(
                styleFontSize: widget.styleFontSize,
                text: "Can Climb?",
                value: widget.matchScoutingData.teleIdClimb,
                listValues: _listClimbValues,
                onChange: (String value) {
                  setState(() {
                    widget.matchScoutingData.teleIdClimb = value;
                    widget.onChanged(widget.matchScoutingData);
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
          margin: const EdgeInsets.all(1.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
          ),
          child: Container(
            padding: EdgeInsets.all(1.0),
            child: Column(children: <Widget>[
              RowHeadingDropDown(
                styleFontSize: widget.styleFontSize,
                text: "Climb?",
                value: widget.matchScoutingData.teleIdClimb,
                listValues: _listClimbValues,
                styleBackGroundColor: Colors.yellow,
                onChange: (String value) {
                  setState(() {
                    widget.matchScoutingData.teleIdClimb = value;
                    widget.onChanged(widget.matchScoutingData);
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Time To Grip:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  DropdownButton(
                    value: widget.matchScoutingData.teleIdClimbGrabTime == null
                        ? null
                        : widget.matchScoutingData.teleIdClimbGrabTime,
                    items: ddsSpeed,
                    onChanged: (item) {
                      setState(() {
                        widget.matchScoutingData.teleIdClimbGrabTime = item;
                        widget.onChanged(widget.matchScoutingData);
                      });
                      print("idClimbType: " +
                          widget.matchScoutingData.teleIdClimbGrabTime);
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
                    value: widget.matchScoutingData.teleIdClimbTime == null
                        ? null
                        : widget.matchScoutingData.teleIdClimbTime,
                    items: ddsSpeed,
                    onChanged: (item) {
                      setState(() {
                        widget.matchScoutingData.teleIdClimbTime = item;
                        widget.onChanged(widget.matchScoutingData);
                      });
                      print("idClimbSpeed: " +
                          widget.matchScoutingData.teleIdClimbTime);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Outcome:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  DropdownButton(
                      value: widget.matchScoutingData.teleIdClimbOutcome == null
                          ? null
                          : widget.matchScoutingData.teleIdClimbOutcome,
                      items: listSuccessFailNA,
                      onChanged: (item) {
                        setState(() {
                          widget.matchScoutingData.teleIdClimbOutcome = item;
                          widget.onChanged(widget.matchScoutingData);
                        });
                        print("teleIdClimbPos: " +
                            widget.matchScoutingData.teleIdClimbOutcome);
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Final Position:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  DropdownButton(
                      value: widget.matchScoutingData.teleIdClimbPos == null
                          ? null
                          : widget.matchScoutingData.teleIdClimbPos,
                      items: ddsPosition,
                      onChanged: (item) {
                        setState(() {
                          widget.matchScoutingData.teleIdClimbPos = item;
                          widget.onChanged(widget.matchScoutingData);
                        });
                        print("teleIdClimbPos: " +
                            widget.matchScoutingData.teleIdClimbPos);
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Fall?:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  Switch(
                    value: widget.matchScoutingData.teleFlClimbFall,
                    onChanged: (bool value) {
                      setState(() {
                        widget.matchScoutingData.teleFlClimbFall = value;
                        widget.onChanged(widget.matchScoutingData);
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
