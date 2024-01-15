import 'package:flutter/material.dart';
import 'package:projectb/class/class_pitdata.dart';
import 'package:projectb/widgets/widget_counter.dart';
import 'package:projectb/widgets/widget_headingmain.dart';

import '../widgets/widget_row_heading.dart';

class PitIntake extends StatefulWidget {
  PitIntake({
    Key? key,
    required this.pitData,
    this.styleFontSize = 16,
    this.styleFontSizeHeadings = 18,
    this.styleFieldTxShootingMaxWidth = 300,
    this.onChanged,
    this.txNotes,
    this.onExpanded,
  }) : super(key: key);

  final PitData pitData;
  final double styleFontSize;
  final double styleFontSizeHeadings;
  final double styleFieldTxShootingMaxWidth;
  final ValueChanged<PitData>? onChanged;
  final TextEditingController? txNotes;
  final ValueChanged<bool>? onExpanded;

  @override
  _PitIntakeState createState() => _PitIntakeState();
}

class _PitIntakeState extends State<PitIntake> {
  List<DropdownMenuItem<String>> listObjectTypes = [
    DropdownMenuItem(value: "1", child: Text("Both")),
    DropdownMenuItem(value: "2", child: Text("Cone")),
    DropdownMenuItem(value: "3", child: Text("Cube")),
    DropdownMenuItem(value: "4", child: Text("N/A")),
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
              styleFontSize: widget.styleFontSize,
              headingText: "Intake",
              //backGroundColor: Colors.green,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Manipulate Rings:",
                  style: TextStyle(fontSize: widget.styleFontSize),
                ),
                Switch(
                  value: widget.pitData.flRing!,
                  onChanged: (bool value) {
                    setState(() {
                      widget.pitData.flRing = value;
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
                  "Catch Game Piece:",
                  style: TextStyle(fontSize: widget.styleFontSize),
                ),
                Switch(
                  value: widget.pitData.flObjectCatch!,
                  onChanged: (bool value) {
                    setState(() {
                      widget.pitData.flObjectCatch = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Get Object from Floor:",
                  style: TextStyle(fontSize: widget.styleFontSize),
                ),
                Switch(
                  value: widget.pitData.flObjectFloor!,
                  onChanged: (bool value) {
                    setState(() {
                      widget.pitData.flObjectFloor = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Get Ring on Angle:",
                  style: TextStyle(fontSize: widget.styleFontSize),
                ),
                Switch(
                  value: widget.pitData.flObjectAngle!,
                  onChanged: (bool value) {
                    setState(() {
                      widget.pitData.flObjectAngle = value;
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
                  "Notes on Intake: ",
                  style: TextStyle(fontSize: widget.styleFontSize),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: widget.styleFieldTxShootingMaxWidth),
                  child: TextField(
                    controller: widget.txNotes,
                    decoration:
                        InputDecoration(hintText: 'Notes on intake system(s)'),
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
