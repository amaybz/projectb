import 'package:flutter/material.dart';
import 'package:projectb/class/class_pitdata.dart';
import 'package:projectb/widgets/widget_headingmain.dart';


class PitScoring extends StatefulWidget {
  PitScoring({
    Key? key,
    required this.pitData,
    required this.txScoringNotes,
    this.styleFontSize = 16,
    this.styleFontSizeHeadings = 18,
    this.styleFieldTextWidth = 300,
    required this.onChanged,
  }) : super(key: key);

  final PitData pitData;
  final double styleFontSize;
  final double styleFontSizeHeadings;
  final ValueChanged<PitData> onChanged;
  final TextEditingController txScoringNotes;
  final double styleFieldTextWidth;

  @override
  _PitScoringState createState() => _PitScoringState();
}

class _PitScoringState extends State<PitScoring> {

  List<DropdownMenuItem<String>> listNodeType = [
    DropdownMenuItem(value: "1", child: Text("Pole")),
    DropdownMenuItem(value: "2", child: Text("Shelf")),
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
                headingText: "Scoring",
                //backGroundColor: Colors.green,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Score on Hybrid Node:",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  Switch(
                    value: widget.pitData.flNodeBottom!,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.flNodeBottom = value;
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
                    value: widget.pitData.flNodeMid!,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.flNodeMid = value;
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
                    value: widget.pitData.flNodeHigh!,
                    onChanged: (bool value) {
                      setState(() {
                        widget.pitData.flNodeHigh = value;
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
                    value: widget.pitData.flNodeType == null
                        ? null
                        : widget.pitData.flNodeType,
                    items: listNodeType,
                    onChanged: (item) {
                      setState(() {
                        widget.pitData.flNodeType = item as String?;
                        widget.onChanged!(widget.pitData);
                      });
                      print("flNodeType: " + widget.pitData.flNodeType!);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Notes on Scoring: ",
                    style: TextStyle(fontSize: widget.styleFontSize),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: widget.styleFieldTextWidth),
                    child: TextField(
                      controller: widget.txScoringNotes,
                      decoration: InputDecoration(
                          hintText:
                          'Notes on intake system(s)'),
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

