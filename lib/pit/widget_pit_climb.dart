import 'package:flutter/material.dart';
import 'package:projectb/class/class_pitdata.dart';
import 'package:projectb/widgets/widget_counter.dart';
import 'package:projectb/widgets/widget_headingmain.dart';

import '../widgets/widget_row_heading.dart';

class PitClimb extends StatefulWidget {
  PitClimb({
    Key? key,
    required this.pitData,
    this.styleFontSize = 16,
    this.styleFontSizeHeadings = 18,
    this.styleFieldTxShootingMaxWidth = 300,
    this.onChanged,
    this.txChargeNotes,
    this.onExpanded,
  }) : super(key: key);

  final PitData pitData;
  final double styleFontSize;
  final double styleFontSizeHeadings;
  final double styleFieldTxShootingMaxWidth;
  final ValueChanged<PitData>? onChanged;
  final TextEditingController? txChargeNotes;
  final ValueChanged<bool>? onExpanded;

  @override
  _PitClimbState createState() => _PitClimbState();
}

class _PitClimbState extends State<PitClimb> {
  List<DropdownMenuItem<String>> listClimbType = [
    DropdownMenuItem(value: "1", child: Text("NA")),
    DropdownMenuItem(value: "2", child: Text("Passive")),
    DropdownMenuItem(value: "3", child: Text("Active")),
  ];

  List<DropdownMenuItem<String>> listClimbPos = [
    DropdownMenuItem(value: "1", child: Text("NA")),
    DropdownMenuItem(value: "2", child: Text("Middle")),
    DropdownMenuItem(value: "3", child: Text("High")),
    DropdownMenuItem(value: "4", child: Text("Any")),
  ];

  @override
  Widget build(BuildContext context) {
    if (widget.pitData.flStage == false) {
      return FractionallySizedBox(
        widthFactor: 0.99,
        child: Container(
          margin: const EdgeInsets.all(5.0),
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: Column(children: <Widget>[
              HeadingMain(
                styleFontSize: widget.styleFontSize,
                headingText: "Stage",
                //backGroundColor: Colors.green,
              ),
              RowHeading(
                styleFontSize: widget.styleFontSize,
                text: "Climb Stage:",
                value: widget.pitData.flStage,
                onChange: (bool value) {
                  setState(() {
                    widget.pitData.flStage = value;
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
                styleFontSize: widget.styleFontSize,
                headingText: "Stage",
                //backGroundColor: Colors.green,
              ),
              RowHeading(
                styleFontSize: widget.styleFontSize,
                text: "Climb Stage:",
                value: widget.pitData.flStage,
                styleBackGroundColor: Colors.green,
                onChange: (bool value) {
                  setState(() {
                    widget.pitData.flStage = value;
                    widget.onChanged!(widget.pitData);
                    widget.onExpanded!(true);
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Climb Location:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  DropdownButton(
                    value: widget.pitData.idStageClimbPos == null
                        ? null
                        : widget.pitData.idStageClimbPos,
                    items: listClimbPos,
                    onChanged: (item) {
                      setState(() {
                        widget.pitData.idStageClimbPos = item as String?;
                        widget.onChanged!(widget.pitData);
                      });
                      print("idStageClimbPos: " +
                          widget.pitData.idStageClimbPos!);
                    },
                  ),
                ],
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
                    value: widget.pitData.idStageClimbType == null
                        ? null
                        : widget.pitData.idStageClimbType,
                    items: listClimbType,
                    onChanged: (item) {
                      setState(() {
                        widget.pitData.idStageClimbType = item as String?;
                        widget.onChanged!(widget.pitData);
                      });
                      print("idChargeBalanceType: " +
                          widget.pitData.idStageClimbType!);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Climb Assist?:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  Switch(
                    value: widget.pitData.flStageAssist!,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.flStageAssist = value;
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
                    "Notes: ",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: widget.styleFieldTxShootingMaxWidth),
                    child: TextField(
                      controller: widget.txChargeNotes,
                      decoration: InputDecoration(hintText: 'Climb Notes'),
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
