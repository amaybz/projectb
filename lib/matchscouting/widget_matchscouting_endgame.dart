import 'package:flutter/material.dart';
import 'package:projectb/class_macthscoutingdata.dart';

class EndGame extends StatefulWidget {
  EndGame(
      {Key? key,
      required this.matchScoutingData,
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

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.99,
      child: Container(
        padding: EdgeInsets.all(1.0),
        child: Column(children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "Hangar:",
              style: TextStyle(fontSize: widget.styleFontSize),
            ),
            Switch(
                value: widget.matchScoutingData.teleFlHanger!,
                onChanged: (item) {
                  setState(() {
                    widget.matchScoutingData.teleFlHanger = item;
                    widget.onChanged!(widget.matchScoutingData);
                  });
                }),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Start Climb Attempt?:",
                style: TextStyle(fontSize: widget.styleFontSize),
              ),
              DropdownButton(
                value: widget.matchScoutingData.teleIdClimb == null
                    ? null
                    : widget.matchScoutingData.teleIdClimb,
                items: listSuccessFailNA,
                onChanged: (item) {
                  setState(() {
                    widget.matchScoutingData.teleIdClimb = item as String?;
                    widget.onChanged!(widget.matchScoutingData);
                  });
                  print(
                      "teleIdClimb: " + widget.matchScoutingData.teleIdClimb!);
                },
              ),
            ],
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
                    widget.matchScoutingData.teleIdClimbGrabTime =
                        item as String?;
                    widget.onChanged!(widget.matchScoutingData);
                  });
                  print("idClimbType: " +
                      widget.matchScoutingData.teleIdClimbGrabTime!);
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
                    widget.matchScoutingData.teleIdClimbTime = item as String?;
                    widget.onChanged!(widget.matchScoutingData);
                  });
                  print("idClimbSpeed: " +
                      widget.matchScoutingData.teleIdClimbTime!);
                },
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Transition?:",
                style: TextStyle(fontSize: widget.styleFontSize)),
            Switch(
                value: widget.matchScoutingData.flClimbTransition!,
                onChanged: (item) {
                  setState(() {
                    widget.matchScoutingData.flClimbTransition = item;
                    widget.onChanged!(widget.matchScoutingData);
                  });
                }),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Time (Transition):",
                  style: TextStyle(fontSize: widget.styleFontSize)),
              DropdownButton(
                value: widget.matchScoutingData.idTransitionSpeed == null
                    ? null
                    : widget.matchScoutingData.idTransitionSpeed,
                items: ddsSpeed,
                onChanged: (item) {
                  setState(() {
                    widget.matchScoutingData.idTransitionSpeed =
                        item as String?;
                    widget.onChanged!(widget.matchScoutingData);
                  });
                  print("idTransitionSpeed: " +
                      widget.matchScoutingData.idTransitionSpeed!);
                },
              ),
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
                      widget.matchScoutingData.teleIdClimbPos = item as String?;
                      widget.onChanged!(widget.matchScoutingData);
                    });
                    print("teleIdClimbPos: " +
                        widget.matchScoutingData.teleIdClimbPos!);
                  }),
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
                      widget.matchScoutingData.teleIdClimbOutcome =
                          item as String?;
                      widget.onChanged!(widget.matchScoutingData);
                    });
                    print("teleIdClimbPos: " +
                        widget.matchScoutingData.teleIdClimbOutcome!);
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Crash/Fall?:",
                style: TextStyle(fontSize: widget.styleFontSize),
              ),
              Switch(
                value: widget.matchScoutingData.teleFlClimbFall!,
                onChanged: (bool value) {
                  setState(() {
                    widget.matchScoutingData.teleFlClimbFall = value;
                    widget.onChanged!(widget.matchScoutingData);
                  });
                },
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
