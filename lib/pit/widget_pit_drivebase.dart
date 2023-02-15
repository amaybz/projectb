import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projectb/class/class_pitdata.dart';
import 'package:projectb/widgets/widget_headingmain.dart';

import '../widgets/widget_counter.dart';
import '../widgets/widget_row_heading.dart';


class PitDriveBase extends StatefulWidget {
  PitDriveBase({
    Key? key,
    required this.pitData,
    this.styleFontSize = 16,
    this.styleFontSizeHeadings = 18,
    this.styleFieldCommentWidth = 300,
    required this.txDriveNotes,
    required this.onChanged,
    required this.onExpanded,
  }) : super(key: key);

  final PitData pitData;
  final double styleFontSize;
  final double styleFontSizeHeadings;
  final ValueChanged<PitData> onChanged;
  final ValueChanged<bool> onExpanded;
  final double styleFieldCommentWidth;
  final TextEditingController? txDriveNotes;

  @override
  _PitDriveBaseState createState() => _PitDriveBaseState();
}

class _PitDriveBaseState extends State<PitDriveBase> {
  List<DropdownMenuItem<String>> listIdDriveType = [
    DropdownMenuItem(value: "1", child: Text("KOP")),
    DropdownMenuItem(value: "2", child: Text("Custom Tank")),
    DropdownMenuItem(value: "3", child: Text("Meccanum")),
    DropdownMenuItem(value: "4", child: Text("Swerve")),
  ];

  @override
  Widget build(BuildContext context) {
      return FractionallySizedBox(
        widthFactor: 0.99,
        child: Container(
          margin: const EdgeInsets.all(5.0),


          child: Container(
            padding: EdgeInsets.all(5.0),
            child: Column(children: <Widget>[
              HeadingMain(
                styleFontSize: widget.styleFontSizeHeadings,
                headingText: "Drivebase",
                //backGroundColor: Colors.green,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Driving Type:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  DropdownButton(
                    value: widget.pitData.idDriveType == null
                        ? null
                        : widget.pitData.idDriveType,
                    items: listIdDriveType,
                    onChanged: (item) {
                      setState(() {
                        widget.pitData.idDriveType = item as String?;
                        widget.onChanged(widget.pitData);
                      });
                      print("idClimbType: " + widget.pitData.idDriveType!);
                    },
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("#Wheels:"),
                CounterWidget(
                  title: "",
                  value: widget.pitData.intWheels,
                  onIncreaseStateChanged: (int value) {
                    setState(() {
                      widget.pitData.intWheels =
                          widget.pitData.intWheels! + 1;
                      widget.onChanged!(widget.pitData);
                    });
                  },
                  onDecreaseStateChanged: (int value) {
                    setState(() {
                      widget.pitData.intWheels =
                          widget.pitData.intWheels! - 1;
                      widget.onChanged!(widget.pitData);
                    });
                  },
                  onSetValue: (int value) {
                    setState(() {
                      widget.pitData.intWheels = value;
                      widget.onChanged!(widget.pitData);
                    });
                  },
                ),
              ]),
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
                        maxWidth: widget.styleFieldCommentWidth),
                    child: TextField(
                      controller: widget.txDriveNotes,
                      decoration: InputDecoration(
                          hintText:
                          'Notes on drive and control system'),
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

