import 'package:flutter/material.dart';
import 'package:projectb/class/class_macthscoutingdata.dart';

import '../widgets/widget_counter.dart';
import '../widgets/widget_headingmain.dart';

class EndGame extends StatefulWidget {
  EndGame({Key? key,
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
    DropdownMenuItem(value: "1", child: Text("NA")),
    DropdownMenuItem(value: "2", child: Text("Slow (> 7 Secs)")),
    DropdownMenuItem(value: "3", child: Text("Medium (3-7 Secs)")),
    DropdownMenuItem(value: "4", child: Text("Fast <3 Secs")),
  ];

  List<DropdownMenuItem<String>> ddsPosition = [
    DropdownMenuItem(value: "1", child: Text("NA")),
    DropdownMenuItem(value: "2", child: Text("Failed")),
    DropdownMenuItem(value: "3", child: Text("Docked")),
    DropdownMenuItem(value: "4", child: Text("Engaged")),
  ];

  List<DropdownMenuItem<String>> listSuccessFailNA = [
    DropdownMenuItem(value: "1", child: Text("NA")),
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
                "Charge Station Outcome:",
                style: TextStyle(fontSize: widget.styleFontSize),
              ),
              DropdownButton(
                value: widget.matchScoutingData.teleIdChargeOutcome == null
                    ? null
                    : widget.matchScoutingData.teleIdChargeOutcome,
                items: ddsPosition,
                onChanged: (item) {
                  setState(() {
                    widget.matchScoutingData.teleIdChargeOutcome =
                    item as String?;
                    widget.onChanged!(widget.matchScoutingData);
                  });
                  print("teleIdChargeOutcome: " +
                      widget.matchScoutingData.teleIdChargeOutcome!);
                },
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Fall after T=0?:",
                style: TextStyle(fontSize: widget.styleFontSize)),
            Switch(
                value: widget.matchScoutingData.teleFlClimbFall!,
                onChanged: (item) {
                  setState(() {
                    widget.matchScoutingData.teleFlClimbFall = item;
                    widget.onChanged!(widget.matchScoutingData);
                  });
                }),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Time (Balance):",
                  style: TextStyle(fontSize: widget.styleFontSize)),
              DropdownButton(
                value: widget.matchScoutingData.teleIdChargeBalanceSpeed == null
                    ? null
                    : widget.matchScoutingData.teleIdChargeBalanceSpeed,
                items: ddsSpeed,
                onChanged: (item) {
                  setState(() {
                    widget.matchScoutingData.teleIdChargeBalanceSpeed =
                    item as String?;
                    widget.onChanged!(widget.matchScoutingData);
                  });
                  print("teleIdChargeBalanceSpeed: " +
                      widget.matchScoutingData.teleIdChargeBalanceSpeed!);
                },
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Charge Station Assist?:",
                style: TextStyle(fontSize: widget.styleFontSize)),
            Switch(
                value: widget.matchScoutingData.teleFlChargeAssist!,
                onChanged: (item) {
                  setState(() {
                    widget.matchScoutingData.teleFlChargeAssist = item;
                    widget.onChanged!(widget.matchScoutingData);
                  });
                }),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("# Robots Assisted:"),
            CounterWidget(
              styleButtonHeight: widget.styleCounterButtonHeight,
              styleButtonWidth: widget.styleCounterButtonWidth,
              title: "",
              value: widget.matchScoutingData.teleNumChargeAssist,
              onIncreaseStateChanged: (int value) {
                setState(() {
                  widget.matchScoutingData.teleNumChargeAssist =
                      widget.matchScoutingData.teleNumChargeAssist! + 1;
                  if (widget.matchScoutingData.teleNumChargeAssist! > 2) {
                    widget.matchScoutingData.teleNumChargeAssist = 2;
                  }


                  widget.onChanged!(widget.matchScoutingData);
                });
              },
              onDecreaseStateChanged: (int value) {
                setState(() {
                  widget.matchScoutingData.teleNumChargeAssist =
                      widget.matchScoutingData.teleNumChargeAssist! - 1;
                  if (widget.matchScoutingData.teleNumChargeAssist! < 0) {
                    widget.matchScoutingData.teleNumChargeAssist = 0;
                  }
                  widget.onChanged!(widget.matchScoutingData);
                });
              },
              onSetValue: (int value) {
                setState(() {
                  widget.matchScoutingData.teleNumChargeAssist = value;
                  widget.onChanged!(widget.matchScoutingData);
                });
              },
            ),
          ]),
        ]),
      ),
    );
  }
}
