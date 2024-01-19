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
    DropdownMenuItem(value: "1", child: Text("N/A")),
    DropdownMenuItem(value: "2", child: Text("Subwoofer")),
    DropdownMenuItem(value: "3", child: Text("Podium")),
    DropdownMenuItem(value: "4", child: Text("Long")),
    DropdownMenuItem(value: "5", child: Text("All")),
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
                  "Score in Amp:",
                  style: TextStyle(fontSize: widget.styleFontSize),
                ),
                Switch(
                  value: widget.pitData.flScoreAmp!,
                  onChanged: (bool value) {
                    setState(() {
                      widget.pitData.flScoreAmp = value;
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
                  "Speaker Scored From::",
                  style: TextStyle(fontSize: widget.styleFontSize),
                ),
                DropdownButton(
                  value: widget.pitData.idScoreSpeaker == null
                      ? null
                      : widget.pitData.idScoreSpeaker,
                  items: listNodeType,
                  onChanged: (item) {
                    setState(() {
                      widget.pitData.idScoreSpeaker = item as String?;
                      widget.onChanged!(widget.pitData);
                    });
                    print("idScoreSpeaker: " + widget.pitData.idScoreSpeaker!);
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Score in Trap:",
                  style: TextStyle(fontSize: widget.styleFontSize),
                ),
                Switch(
                  value: widget.pitData.flScoreTrap!,
                  onChanged: (bool value) {
                    setState(() {
                      widget.pitData.flScoreTrap = value;
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
                  constraints:
                      BoxConstraints(maxWidth: widget.styleFieldTextWidth),
                  child: TextField(
                    controller: widget.txScoringNotes,
                    decoration: InputDecoration(hintText: 'Notes on Scoring'),
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
