import 'package:flutter/material.dart';
import 'package:projectb/class/class_macthscoutingdata.dart';

import '../widgets/widget_counter.dart';
import '../widgets/widget_headingmain.dart';

class EndGame extends StatefulWidget {
  EndGame(
      {Key? key,
      required this.matchScoutingData,
      this.styleFontSize = 16,
      this.styleFontSizeHeadings = 18,
      this.styleFieldTxClimbMaxWidth = 300,
      this.styleCounterButtonHeight = 25,
      this.styleCounterButtonWidth = 30,
      this.onChanged,
      this.txClimb,
      this.onExpanded})
      : super(key: key);

  final MatchScoutingData matchScoutingData;
  final double styleFontSize;
  final double styleFontSizeHeadings;
  final double styleFieldTxClimbMaxWidth;
  final double styleCounterButtonHeight;
  final double styleCounterButtonWidth;
  final ValueChanged<MatchScoutingData>? onChanged;
  final ValueChanged<bool>? onExpanded;
  final TextEditingController? txClimb;

  @override
  _EndGameState createState() => _EndGameState();
}

class _EndGameState extends State<EndGame> {
  List<DropdownMenuItem<String>> ddsSpeed = [
    DropdownMenuItem(value: "1", child: Text("N/A")),
    DropdownMenuItem(value: "2", child: Text("Slow (> 7 Secs)")),
    DropdownMenuItem(value: "3", child: Text("Medium (3-7 Secs)")),
    DropdownMenuItem(value: "4", child: Text("Fast <3 Secs")),
  ];

  List<DropdownMenuItem<String>> ddsPosition = [
    DropdownMenuItem(value: "1", child: Text("N/A")),
    DropdownMenuItem(value: "2", child: Text("Failed")),
    DropdownMenuItem(value: "3", child: Text("Success")),
  ];

  List<DropdownMenuItem<String>> listSuccessFailNA = [
    DropdownMenuItem(value: "1", child: Text("N/A")),
    DropdownMenuItem(value: "2", child: Text("Fail")),
    DropdownMenuItem(value: "3", child: Text("Success")),
  ];

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.99,
      child: Container(
        padding: EdgeInsets.all(1.0),
        child: Column(children: <Widget>[
          HeadingMain(
            styleFontSize: widget.styleFontSizeHeadings,
            headingText: "End Game",
            //backGroundColor: Colors.green,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "Park:",
              style: TextStyle(fontSize: widget.styleFontSize),
            ),
            Switch(
                value: widget.matchScoutingData.teleFlPark!,
                onChanged: (item) {
                  setState(() {
                    widget.matchScoutingData.teleFlPark = item;
                    widget.onChanged!(widget.matchScoutingData);
                  });
                }),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Outcome:",
                style: TextStyle(fontSize: widget.styleFontSize),
              ),
              DropdownButton(
                value: widget.matchScoutingData.teleIdStageOutcome == null
                    ? null
                    : widget.matchScoutingData.teleIdStageOutcome,
                items: ddsPosition,
                onChanged: (item) {
                  setState(() {
                    widget.matchScoutingData.teleIdStageOutcome =
                        item as String?;
                    widget.onChanged!(widget.matchScoutingData);
                  });
                  print("teleIdChargeOutcome: " +
                      widget.matchScoutingData.teleIdStageOutcome!);
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Speed:", style: TextStyle(fontSize: widget.styleFontSize)),
              DropdownButton(
                value: widget.matchScoutingData.teleIdStageClimbSpeed == null
                    ? null
                    : widget.matchScoutingData.teleIdStageClimbSpeed,
                items: ddsSpeed,
                onChanged: (item) {
                  setState(() {
                    widget.matchScoutingData.teleIdStageClimbSpeed =
                        item as String?;
                    widget.onChanged!(widget.matchScoutingData);
                  });
                  print("teleIdChargeBalanceSpeed: " +
                      widget.matchScoutingData.teleIdStageClimbSpeed!);
                },
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Assist?:", style: TextStyle(fontSize: widget.styleFontSize)),
            Switch(
                value: widget.matchScoutingData.teleFlStageAssist!,
                onChanged: (item) {
                  setState(() {
                    widget.matchScoutingData.teleFlStageAssist = item;
                    widget.onChanged!(widget.matchScoutingData);
                  });
                }),
          ]),
        ]),
      ),
    );
  }
}
