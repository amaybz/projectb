import 'package:flutter/material.dart';

class RatingsTab extends StatefulWidget {
  const RatingsTab({
    Key key,
    //@required this.styleImgFieldWidth,
    this.assistOtherRobot = false,
    this.workedWithAlliance = false,
    this.workedToStrategy = false,
    this.noTeamWork = false,
    this.recovered = false,
    this.onAssistOtherRobotChanged,
    this.onWorkedWithAllianceChanged,
  }) : super(key: key);

  final ValueChanged<bool> onAssistOtherRobotChanged;
  final ValueChanged<bool> onWorkedWithAllianceChanged;
  final bool assistOtherRobot;
  final bool workedWithAlliance;
  final bool workedToStrategy;
  final bool noTeamWork;
  final bool recovered;

  @override
  _RatingsTabState createState() => _RatingsTabState();
}

class _RatingsTabState extends State<RatingsTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FractionallySizedBox(
          widthFactor: 0.99,
          child: Container(
            margin: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            child: Column(children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: Colors.grey,
                ),
                child: Text(
                  "Quick Ratings",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
