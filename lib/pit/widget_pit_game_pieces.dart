import 'package:flutter/material.dart';
import 'package:projectb/class/class_pitdata.dart';
import 'package:projectb/widgets/widget_counter.dart';
import 'package:projectb/widgets/widget_headingmain.dart';

import '../widgets/widget_row_heading.dart';

class PitGamePieces extends StatefulWidget {
  PitGamePieces({
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
  _PitGamePiecesState createState() => _PitGamePiecesState();
}

class _PitGamePiecesState extends State<PitGamePieces> {
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
              headingText: "Game Pieces",
              //backGroundColor: Colors.green,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Manipulate Cones:",
                  style: TextStyle(fontSize: widget.styleFontSize),
                ),
                Switch(
                  value: widget.pitData.flCone!,
                  onChanged: (bool value) {
                    setState(() {
                      widget.pitData.flCone = value;
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
                  "Manipulate Cubes:",
                  style: TextStyle(fontSize: widget.styleFontSize),
                ),
                Switch(
                  value: widget.pitData.flCube!,
                  onChanged: (bool value) {
                    setState(() {
                      widget.pitData.flCube = value;
                      widget.onChanged!(widget.pitData);
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
                  "Best Game Piece:",
                  style: TextStyle(fontSize: widget.styleFontSize),
                ),
                DropdownButton(
                  value: widget.pitData.idObjectPreference == null
                      ? null
                      : widget.pitData.idObjectPreference,
                  items: listObjectTypes,
                  onChanged: (item) {
                    setState(() {
                      widget.pitData.idObjectPreference = item as String?;
                      widget.onChanged!(widget.pitData);
                    });
                    print("idObjectPreference: " +
                        widget.pitData.idObjectPreference!);
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
                  "Get Object from Shelf:",
                  style: TextStyle(fontSize: widget.styleFontSize),
                ),
                Switch(
                  value: widget.pitData.flObjectShelf!,
                  onChanged: (bool value) {
                    setState(() {
                      widget.pitData.flObjectShelf = value;
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
                  "Get Cone on Side:",
                  style: TextStyle(fontSize: widget.styleFontSize),
                ),
                Switch(
                  value: widget.pitData.flObjectSide!,
                  onChanged: (bool value) {
                    setState(() {
                      widget.pitData.flObjectSide = value;
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
